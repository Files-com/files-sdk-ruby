# frozen_string_literal: true

module Files
  module Transfer
    # What adaptive transfers share: their Options, one Controller for each kind of destination with the request limit
    # it sets, the request permits, the buffer budget, the file slots, how long a throttle holds each destination back
    # (Holds), whichever transfer, transport or controller met it, and the worker threads that send content requests.
    #
    # A Hash or true given as transfer: makes a Job for that one call, closed before it returns. Pass a Job instead to
    # share it between calls, from any threads: transfers to the same storage then share one controller and what it
    # learned, every transfer counts against one buffer_bytes and one request limit (a fixed concurrency, or
    # max_concurrency, or 64), and at most max_files run at once. Close it when they are done, or use Job.open with a
    # block.
    class Job
      CLOSE_WAIT_SECONDS = 5
      MAX_NOTES = 64
      # The longest a waiting transfer sleeps before it looks at its deadlines again, so a long Retry-After is waited
      # out in steps, and a cancellation or pause still ends the wait at once.
      MAX_WAIT_SECONDS = 60.0

      attr_reader :options, :budget, :transport

      def self.open(**options)
        job = new(**options)
        return job unless block_given?

        finished = false
        begin
          result = yield job
          finished = true
          result
        ensure
          job.close(strict: finished)
        end
      end

      # Runs the block with the Job transfer names: transfer itself, or a new Job closed afterwards.
      def self.using(transfer)
        return yield(transfer) if transfer.is_a?(Job)

        job = new(Options.from(transfer))
        finished = false
        begin
          result = yield job
          finished = true
          result
        ensure
          job.close(strict: finished)
        end
      end

      def initialize(options = nil, **keywords)
        @options = Options.from(options || keywords)
        @lock = Mutex.new
        @changed = ConditionVariable.new
        @work_ready = ConditionVariable.new
        @controllers = {}
        @budget = ByteBudget.new(@options.buffer_bytes)
        @files = FileSlots.new(@options.max_files)
        @requests = RequestPermits.new(@options.automatic? ? (@options.max_concurrency || Policy::DEFAULT_MAX) : @options.concurrency)
        @holds = Holds.new
        @running = 0
        @tasks = []
        @workers = []
        @idle = 0
        @closed = false
        @transport = HttpTransport.new
        @client_transports = {}.compare_by_identity
        @notes = []
        @started_at = Clock.now
        @accepted_bytes = 0
        @retries = 0
        @options.control&.subscribe(self)
      end

      def control
        @options.control
      end

      def closed?
        @closed
      end

      # Bytes held right now for parts waiting to be sent or written.
      def held_bytes
        @lock.synchronize { @budget.held }
      end

      # A snapshot of how the job's transfers ran:
      #
      # accepted_bytes:: Bytes storage acknowledged (uploads) or that were received for writing (downloads), each
      #                  counted once however often its request was sent.
      # elapsed_seconds:: Seconds since the job began.
      # goodput_bytes_per_second:: accepted_bytes over elapsed_seconds.
      # retries:: Requests sent again after a failure, a throttle or an expired URL.
      # requests:: Content requests in flight now, of at most request_limit.
      # held_bytes:: Bytes held now for parts waiting to be sent or written.
      # controllers:: Each controller's key, policy, phase, limit, attempts admitted against it (admitted) and on the
      #               network (inflight), epoch, judged_windows and ineligible_windows (windows closed without judging,
      #               because too few requests were on the network) and decisions.
      # throttled:: Each origin a throttle's Retry-After holds back now (Holds), with the seconds left.
      # notes:: How transfers ran, such as a caller's client carrying them one request at a time.
      #
      # It holds no URLs or credentials: a controller's key names only the kind of destination and its host, and a
      # throttled origin only its scheme, host and port.
      def diagnostics
        @lock.synchronize do
          elapsed = Clock.now - @started_at
          {
            accepted_bytes: @accepted_bytes,
            elapsed_seconds: elapsed,
            goodput_bytes_per_second: elapsed.positive? ? @accepted_bytes / elapsed : 0.0,
            retries: @retries,
            requests: @requests.used,
            request_limit: @requests.limit,
            controllers: @controllers.map { |key, controller| controller.snapshot.merge(key: key, decisions: controller.decisions) },
            held_bytes: @budget.held,
            throttled: @holds.to_h,
            notes: @notes.dup
          }
        end
      end

      # Stops the job: transfers still running on it stop with an error, and it waits for them and the requests they
      # have in flight, at most five seconds in all. Returns true once nothing is left running. When something still is,
      # it raises Files::Error; with strict: false, as when a transfer on its own Job has already failed, it returns
      # false instead and what is left finishes in the background.
      def close(strict: true)
        deadline = Clock.now + CLOSE_WAIT_SECONDS
        workers = @lock.synchronize do
          unless @closed
            @closed = true
            @work_ready.broadcast
            @changed.broadcast
          end
          loop do
            remaining = deadline - Clock.now
            break if @running.zero? || !remaining.positive?

            @changed.wait(@lock, remaining)
          end
          @workers.dup
        end
        @options.control&.unsubscribe(self)
        workers.each { |worker| worker.join([ deadline - Clock.now, 0 ].max) }
        live = workers.count(&:alive?)
        running = @lock.synchronize { @running }
        return true if live.zero? && running.zero?
        return false unless strict

        raise Files::Error, "The transfer job closed with #{running} transfers and #{live} requests still running after #{CLOSE_WAIT_SECONDS} seconds"
      end

      # Called by the control after it changes.
      def wake
        @lock.synchronize { @changed.broadcast }
      end

      def synchronize(&block)
        @lock.synchronize(&block)
      end

      # With the lock held: waits for a change, at most seconds when given, and never more than MAX_WAIT_SECONDS at a
      # time when given; the caller looks at its deadline again after it.
      def wait(seconds = nil)
        @changed.wait(@lock, seconds && [ seconds, MAX_WAIT_SECONDS ].min)
      end

      # With the lock held: wakes everything waiting for a change.
      def signal
        @changed.broadcast
      end

      # Runs the block under the lock and wakes everything waiting.
      def post
        @lock.synchronize do
          yield
          @changed.broadcast
        end
      end

      # With the lock held: the controller for key, made from the policy the block returns the first time.
      def controller(key)
        @controllers[key] ||= Controller.new(yield)
      end

      # The transport for a transfer's content requests through client, which the caller's thread resolved: the job's
      # own only when client is the SDK's own kind with its default connection unchanged and the job's own proxy
      # (HttpTransport#compatible?), otherwise client itself, one request at a time. A download refuses, with
      # BufferLimitError, a client whose adapter is not one it relies on to stream a response (ClientTransport.streams?),
      # before it sends a content request or writes anything.
      def transport_for(client, download: false)
        return @transport if @transport.compatible?(client)
        raise BufferLimitError, ClientTransport::NOT_STREAMING if download && !ClientTransport.streams?(client)

        @lock.synchronize do
          @client_transports[client] ||= begin
            note("A caller's client with its own connection or request handling sends this job's content requests, one request at a time")
            ClientTransport.new(client)
          end
        end
      end

      # With the lock held.
      def note(message)
        @notes.shift if @notes.size >= MAX_NOTES
        @notes << message.dup.freeze
      end

      # Waits for a file slot: returns :running once the caller has one, or control's :cancelled or :paused. Nothing of
      # the transfer is opened before it.
      def acquire_file(control)
        acquire(@files, control) { @running += 1 }
      end

      def release_file
        post do
          @files.give
          @running -= 1
        end
      end

      # Waits, on a transfer's own thread, for a request permit for a request that thread sends itself to url, once no
      # throttle holds url's destination back: returns :running once it holds one, or control's :cancelled or :paused as
      # soon as it stops. Give it back with release_request.
      def acquire_request(control, url)
        acquire(@requests, control, Holds.destination(url))
      end

      # Gives back a permit acquire_request took. A throttle the request met, when seconds is given, holds url's
      # destination back first, under the same lock and in the same order as a worker's request (Coordinator#launch),
      # so nothing waiting for the permit is sent before that hold.
      def release_request(url = nil, seconds = nil)
        post do
          hold(url, seconds) if seconds
          @requests.give
        end
      end

      # With the lock held: takes a request permit for a worker's request when one is free.
      def take_request
        @requests.take
      end

      # With the lock held: gives a worker's request permit back and wakes everything waiting for one.
      def give_request
        @requests.give
        @changed.broadcast
      end

      # With the lock held: holds url's destination back for seconds, a throttle's Retry-After, from every new request
      # and retry of the job's transfers, unless it already is for longer, and wakes everything waiting.
      def hold(url, seconds)
        @holds.hold(Holds.destination(url), seconds)
        @changed.broadcast
      end

      # With the lock held: the monotonic time until which a throttle holds url's destination back, or nil.
      def held_until(url)
        @holds.deadline(Holds.destination(url))
      end

      # With the lock held: counts bytes accepted for the first time.
      def count_accepted(bytes)
        @accepted_bytes += bytes
      end

      # With the lock held: counts a request about to be sent again.
      def count_retry
        @retries += 1
      end

      # Takes one of slots, once no throttle holds destination, when given, back; a cancellation or pause ends the wait.
      private def acquire(slots, control, destination = nil)
        @lock.synchronize do
          loop do
            raise Files::Error, "The transfer job is closed" if @closed

            state = control&.state || :running
            return state unless state == :running

            held = destination && @holds.deadline(destination)
            if held.nil? && slots.take
              yield if block_given?
              return :running
            end
            wait(held && [ held - Clock.now, 0.001 ].max)
          end
        end
      end

      # With the lock held: runs work on a worker thread, which passes it the connections that thread owns.
      def submit(&work)
        raise Files::Error, "The transfer job is closed" if @closed

        @tasks << work
        if @tasks.size > @idle
          spawn_worker
        else
          @work_ready.signal
        end
      end

      private def spawn_worker
        @workers << Thread.new do
          Thread.current.report_on_exception = false
          connections = {}
          begin
            while (work = next_task)
              work.call(connections)
            end
          ensure
            @transport.close_all(connections)
          end
        end
      end

      private def next_task
        @lock.synchronize do
          @idle += 1
          @work_ready.wait(@lock) while @tasks.empty? && !@closed
          @idle -= 1
          @tasks.shift
        end
      end
    end

    # The loop one transfer runs on its caller's thread. It takes a file slot before it opens anything, plans work and
    # calls the API there, with the context it fixed as it began (api_context), admits each part or range when it is
    # ready and its controller's limit, its own cap, any throttle holding its destination back (Holds), the job's
    # request permits and the buffer budget allow, hands the request to a worker and settles what comes back:
    # acknowledgements, retries (each a new admission, its buffer kept), renewals and failures. Each attempt goes to
    # the target fixed as it was admitted (request_target), whatever is renewed after. The transport tells the
    # controller when each request's send starts and when it is answered, and the worker gives back its permit as the
    # request ends, publishing a throttle's Retry-After for that target's destination to the job under the same lock,
    # so nothing waiting for the permit is sent before the hold. Bytes held for an item are given back to the buffer
    # budget only when they are dropped. Callbacks and writes to the caller's
    # destination happen only on the caller's thread. The first failure, cancellation or pause, in the order they
    # happened, whichever thread saw it, stops admissions; it then waits for the requests in flight, releases everything
    # it holds and raises that first one, finalizing nothing. An error the caller's thread meets itself, from opening
    # the source or destination and checking a resume's through an API request's, a callback's or a refused request's,
    # is ordered the same way: recorded as SDK code there recognizes it (stop!), and in any case before it is raised
    # (arbitrate), so a cancellation or pause made after it never replaces it, and one made before it is raised instead.
    class Coordinator
      # What a transport calls as a request's send starts, as its response headers arrive and once its response body
      # has been read and checked. An upload's attempt is answered as its response headers arrive, after its own body
      # went; a download's (through_body) once its whole body has arrived and been checked, before any of it is written.
      Timing = Struct.new(:controller, :attempt, :through_body) do
        def sending
          controller.sending(attempt)
        end

        def headers
          controller.answered(attempt) unless through_body
        end

        def body
          controller.answered(attempt)
        end
      end

      # The API options every API request of one transfer starts with, resolved on the caller's thread as
      # Api.send_request and ApiClient#execute_request would resolve them for a request sent now, from frozen copies of
      # the caller's options: the client (options[:client] or the thread's active client), the credential (an options
      # API key; otherwise an options session ID or session, saved first if it has no ID, or Files.session_id, when not
      # empty; otherwise Files.api_key, or none at all), the origin (options[:base_url] or Files.base_url), the
      # region_http_pairs (the options' own, checked, or the client's), the workspace (options[:workspace_id], or the
      # client's, "" for none) and, as request_settings, copies of the library-wide default headers, language, app info,
      # timeouts and region policy and handler (ApiClient.transfer_settings). A later change to the caller's options,
      # even in place, to the thread's client or to any of those settings cannot change what the transfer's API requests
      # send; adopt_context carries what an API request resolved, such as a regional origin, to those after it.
      def self.api_context(options)
        context = (options || {}).to_h.transform_values { |value| Checkpoint.frozen(value) }
        if (session = context.delete(:session))
          session.save unless session.id
          context[:session_id] = Checkpoint.frozen(session.id)
        end
        client = context[:client] = Files::File.client(context)
        if context[:api_key].nil?
          session_id = context[:session_id].nil? ? Checkpoint.frozen(Files.session_id) : context[:session_id]
          if session_id.nil? || session_id == ""
            context[:api_key] = Checkpoint.frozen(Files.api_key)
          else
            context[:session_id] = session_id
          end
        end
        context[:base_url] ||= Checkpoint.frozen(Files.base_url)
        if context[:region_http_pairs]
          context[:region_http_pairs] = Util.checked_region_http_pairs(context[:region_http_pairs])
        elsif client.respond_to?(:region_http_pairs)
          context[:region_http_pairs] = client.region_http_pairs
        end
        context[:workspace_id] = client.resolved_workspace_id if context[:workspace_id].nil? && client.respond_to?(:resolved_workspace_id)
        context[:request_settings] = ApiClient.transfer_settings
        context
      end

      def initialize(job)
        @job = job
        @control = job.control
        @max_retries = Files.max_network_retries
        @transport = job.transport
        @inbox = []
        @queue = []
        @renewals = []
        @completed = []
        @inflight = 0
        @stop = nil
        @controller = nil
        @connections = {}
        @origin = nil
        @lease = nil
        # The caller's thread, which runs the transfer.
        @thread = Thread.current
      end

      # Opens the source or destination, checking a resume's, and transfers, once it holds a file slot. An error on the
      # way is raised only when it came before any cancellation or pause, and then has its say on the destination
      # (after_failure); otherwise the first of those is raised, with a resume's unspent checkpoint when it stopped
      # before it started.
      def run
        state = @job.acquire_file(@control)
        raise CancelledError if state == :cancelled
        raise PausedError, @origin if state == :paused

        begin
          begin
            open_resources
            transfer
          rescue StandardError => e
            error = arbitrate(e)
            after_failure(error)
            raise if error.equal?(e)

            raise error, cause: nil
          end
        ensure
          begin
            drain
          ensure
            begin
              close_resources
            ensure
              @job.release_file
            end
          end
        end
      end

      private

      def pump
        loop do
          plan if @stop.nil?
          completed, done = @job.synchronize { await }
          deliver(completed)
          return if done
        end
      end

      # With the lock held: returns what was accepted for deliver, and whether the transfer is done.
      def await
        loop do
          observe_stops
          completed = @completed.shift(@completed.size)
          return [ completed, false ] unless completed.empty?

          if @stop
            release_waiting
            return [ [], true ] if @inflight.zero?
          else
            return [ [], true ] if finished?

            admit
            return [ [], false ] if wants_planning?
          end
          @job.wait(wait_seconds)
        end
      end

      def observe_control
        return unless @control

        if @control.cancelled?
          @stop ||= CancelledError.new
        elsif @control.paused?
          @stop ||= :paused
        end
      end

      # With the lock held: records every stop seen so far, oldest first: what the workers sent back, then a
      # cancellation or pause and the job's closing. Every path that records a stop calls it first.
      def observe_stops
        settle_inbox
        observe_control
        @stop ||= Files::Error.new("The transfer job was closed") if @job.closed?
      end

      # With the lock held: settles what the workers sent back, in the order they sent it. A request that ended after
      # the control had already stopped the transfer is settled after that stop, and one that ended before it, before,
      # so the first of a failure and a cancellation or pause wins.
      def settle_inbox
        @inbox.shift(@inbox.size).each do |item, outcome, after_stop|
          observe_control if after_stop
          settle(item, outcome)
        end
      end

      # Whether the control has stopped the transfer, as a worker's request ends.
      def stopped?
        !@control.nil? && @control.state != :running
      end

      # With the lock held. Nothing is admitted while a throttle's Retry-After holds its destination back, whichever of
      # the job's transfers met it. Due items are admitted in queue order, but one waiting for buffer bytes the budget
      # cannot give yet lets a later item that already holds its own, such as a retry keeping its bytes, go ahead of it:
      # that takes nothing more from the budget, and gives its bytes back once it ends. No later item needing new bytes
      # passes the one waiting.
      def admit
        now = Clock.now
        waiting = false
        while (item = @queue.find { |queued| queued.ready_at <= now && (!waiting || queued.reservation) })
          break if @controller.admitted >= @controller.limit || @inflight >= item_cap

          if expiring?(item)
            @queue.delete(item)
            @renewals << item
            next
          end
          target = request_target(item)
          break unless ready?(item) && @job.held_until(target[0]).nil?

          bytes = item.reservation ? 0 : reservation_bytes(item)
          unless @job.budget.available?(bytes)
            waiting = true
            next
          end
          break unless @job.take_request

          item.reservation ||= @job.budget.reserve(bytes)
          @queue.delete(item)
          launch(item, target)
        end
      end

      # With the lock held and a request permit taken for item, which goes to target, the request_target it was admitted
      # for, whatever is renewed before its worker sends it. The attempt counts against the controller's limit from now,
      # but the transport measures it only from its send until it is answered; the worker gives the permit back as soon
      # as the request ends, its response read, before its outcome is settled here, and publishes a throttle's
      # Retry-After for target's destination to the job first, so it holds that destination back for every transfer at
      # once.
      def launch(item, target)
        controller = @controller
        attempt = controller.admit
        timing = Timing.new(controller, attempt, measured_through_body?)
        @job.submit do |connections|
          outcome = [ :fail, Files::Error.new("The transfer worker stopped") ]
          begin
            outcome = attempt_item(item, target, connections, timing)
          rescue Passthrough => e
            outcome = [ :fail, e.error ]
          rescue NetworkFailure => e
            outcome = e.retryable? ? [ :retry, StorageRetry::RETRY_DELAY, :failure, e ] : [ :fail, e ]
          rescue StandardError => e
            outcome = [ :fail, e ]
          ensure
            begin
              measure(controller, attempt, outcome)
            ensure
              @job.post do
                @job.hold(target[0], outcome[1]) if outcome[0] == :retry && outcome[2] == :throttle
                @job.give_request
                @inbox << [ item, outcome, stopped? ]
              end
            end
          end
        end
        @inflight += 1
      end

      # On the worker's thread, as its request ends.
      def measure(controller, attempt, outcome)
        case outcome[0]
        when :ok then controller.finish_attempt(attempt, :success, bytes: outcome[2])
        when :retry then controller.finish_attempt(attempt, outcome[2], retry_after: outcome[2] == :throttle ? outcome[1] : nil)
        else controller.finish_attempt(attempt, :ignored)
        end
      end

      # With the lock held. outcome is [:ok, value, bytes], [:retry, seconds, :failure or :throttle, error],
      # [:renew, error] or [:fail, error]. A retry, and a renewal of a URL that expired after the request was sent,
      # each count against the item's retries and need it to allow them. Wakes everything waiting, since settling can
      # release bytes another transfer waits for.
      def settle(item, outcome)
        @inflight -= 1
        case outcome[0]
        when :ok
          entry = accept(item, outcome[1])
          @completed << entry if entry
        when :retry
          _, delay, _signal, error = outcome
          if again?(item)
            item.ready_at = Clock.now + delay
            enqueue(item)
          else
            give_up(item, error)
          end
        when :renew
          again?(item) ? @renewals << item : give_up(item, outcome[1])
        else
          give_up(item, outcome[1])
        end
        @job.signal
      end

      # With the lock held: whether item may be sent again, counting it when it may.
      def again?(item)
        return false unless @stop.nil? && retry_allowed?(item) && item.attempts < @max_retries

        item.attempts += 1
        @job.count_retry
        true
      end

      def enqueue(item)
        @queue.insert(@queue.bsearch_index { |queued| queued.number > item.number } || @queue.size, item)
      end

      # With the lock held.
      def give_up(item, error)
        discard(item)
        @stop ||= public_error(error)
        @job.signal
      end

      # On the caller's thread: gives item up for error, after every stop recorded before it.
      def fail_item(item, error)
        @job.synchronize do
          observe_stops
          give_up(item, error)
        end
      end

      # Records a failure on the caller's thread, as SDK code there recognizes it, after every stop recorded before it:
      # the workers' failures sent back earlier, and a cancellation or pause that came first. Returns error, to raise.
      def stop!(error)
        @job.synchronize do
          observe_stops
          @stop ||= public_error(error)
          @job.signal
        end
        error
      end

      # With the lock held: drops what item holds and gives its bytes back to the buffer budget, together, so the
      # budget never counts less than is held.
      def discard(item)
        item.data = nil if item.respond_to?(:data=)
        @job.budget.release(item.reservation)
      end

      def release_waiting
        (@queue + @renewals).each { |item| discard(item) }
        @queue.clear
        @renewals.clear
        @job.signal
      end

      # With the lock held: how long to wait at most: until the next retry is due or a throttle holding back the
      # destination of a waiting item has passed.
      def wait_seconds
        now = Clock.now
        deadlines = @queue.map(&:ready_at)
        deadlines.concat(@queue.map { |item| request_target(item)[0] }.uniq.filter_map { |url| @job.held_until(url) })
        pending = deadlines.select { |at| at > now }.min
        pending && [ pending - now, 0.001 ].max
      end

      # Waits for the requests in flight, however the transfer ended, and releases what it holds.
      def drain
        @job.synchronize do
          @stop ||= :aborted unless @inflight.zero?
          until @inflight.zero?
            settle_inbox
            @job.wait if @inflight.positive?
          end
          @inbox.clear
          all_items.each { |item| discard(item) }
          @job.signal
        end
        @job.transport.close_all(@connections)
      end

      def raise_outcome
        case @stop
        when nil then nil
        when :paused then raise PausedError, pause_checkpoint
        else raise @stop
        end
      end

      # A resume paused before it started gives back the checkpoint it was given, still usable; any other transfer its
      # own, none while its source or destination is not yet open (checkpoint).
      def pause_checkpoint
        @lease && !@lease.started? ? @origin : checkpoint
      end

      # On the caller's thread, for an error that ended the transfer there, from opening its source or destination to
      # its last request: records it after every stop recorded before it, a cancellation or pause the control already
      # holds included, unless stop! recorded it already as SDK code recognized it, and returns the first of them,
      # which the transfer raises. Nothing recorded later replaces it, and an error raise_outcome raised is that first
      # stop already.
      def arbitrate(error)
        first = @job.synchronize do
          observe_stops
          @stop ||= public_error(error)
        end
        return error if first.equal?(error) || (first == :paused && error.is_a?(PausedError))

        first == :paused ? PausedError.new(pause_checkpoint) : first
      end

      # Carries the context an API request resolved, such as the regional origin a lockout region mismatch moved it to,
      # to the transfer's API requests after it. What it leaves unset stays as the transfer began.
      def adopt_context(record)
        options = record.respond_to?(:options) ? record.options : nil
        @options = @options.merge(options.compact).merge(client: @options[:client]) if options.is_a?(Hash)
      end

      # Opens the transfer's source or destination, once it holds a file slot.
      def open_resources; end

      # Closes what open_resources opened, however the transfer ended.
      def close_resources; end

      # What the transfer does with its destination once error, the first stop, ended it, before what it holds is
      # released.
      def after_failure(_error); end

      # Where item's request goes now, frozen, its URL first, whose destination a throttle may hold back. An admitted
      # attempt keeps the one it was admitted for (launch), is sent there by attempt_item and holds back its destination.
      def request_target(_item)
        [ nil ].freeze
      end

      def item_cap
        Float::INFINITY
      end

      # Whether an attempt is on the network until its response body has been read and checked, as a download's is, or
      # only until its response headers arrive, as an upload's is.
      def measured_through_body?
        false
      end

      # Whether item can be sent: queued items are admitted in order, so one that is not stops admission there.
      def ready?(_item)
        true
      end

      def wants_planning?
        !@renewals.empty?
      end

      def expiring?(_item)
        false
      end

      def retry_allowed?(_item)
        true
      end

      def public_error(error)
        error
      end
    end
  end
end
