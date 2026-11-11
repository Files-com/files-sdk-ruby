# frozen_string_literal: true

require "openssl"

module Files
  module Transfer
    # Downloads one remote file through a Job, in ranges fetched concurrently when storage binds a version.
    #
    # Its API requests, the download URL's lookup and its renewals, use the context the caller's thread fixed from the
    # record's options as the download began (Coordinator.api_context), carried on as a lookup moves to a regional
    # origin. Its content requests go through ApiClient.download_client as the caller's thread resolves it when the
    # download begins: over the job's own connections when that client is the SDK's own with its default connection
    # unchanged, otherwise through the client itself, one request at a time, its responses streamed (see
    # ClientTransport); a client whose adapter cannot stream is refused before anything is requested or written. On the
    # caller's thread it first asks for the opening range (8 MiB, or a quarter of buffer_bytes when that is less) with
    # Accept-Encoding: identity. A 206 with a strong ETag and an exact Content-Range and Content-Length binds the
    # download to that version: every later range is requested with If-Match and must come back as a 206 with the
    # exact Content-Range, total, length and ETag, and a 412, or a whole response with any other ETag, stops it with
    # VersionChangedError before anything of it is written. Ranges complete in any order, each read straight into one
    # String of its length, wait in memory within buffer_bytes, and are written to the destination in order on the
    # caller's thread, which progress, when given, is then called on. A range is on the network, for its controller,
    # until its whole body has arrived and been checked. Every request, the opening one and a proof included, waits
    # while a throttle's Retry-After holds its destination back for the job (Holds), and publishes one it gets before
    # its request permit is given back. A range goes to the URL it was admitted for, even once that has been renewed,
    # and a 403 for it is judged by that URL's own expiry, or by storage's word that it expired.
    #
    # Without a strong ETag, storage's whole response is streamed instead, as one request. A retry of it starts again
    # from the first byte: the destination, a local file or an IO that can seek back, is truncated to where it started
    # only as the retry's first bytes are written; any other IO gets the failure instead of the same bytes twice. A
    # cancellation or pause keeps what was written. Bytes are written exactly as stored, never decompressed.
    #
    # A resumed download first checks, before it sends or changes anything, that its destination is the same one and
    # still holds exactly the bytes it wrote, by reading them back, a slice at a time charged to buffer_bytes, and
    # comparing their SHA-256 digest; a destination that cannot give them back refuses the resume. Anything after those
    # bytes stays until storage's response has proved its version: until the first new bytes are written, or, when every
    # byte was written before the pause, until storage answers for the file's last byte with that version.
    #
    # A response carrying X-Files-Frontend-App came from the Files.com web app, not storage, and stops the download
    # with FrontendResponseError before any of it is written. A refused transfer or a failed write closes a caller's
    # IO, as without transfer:; other failures leave it open, holding what was written.
    class DownloadCoordinator < Coordinator
      RENEWALS = 2
      MISMATCH = "Transfer response did not match the request"
      EXPIRED = "The download URL the API returned has expired, and renewing it did not give one still valid"
      # The most of a resumed destination's bytes read back at once to check them; never more than a range.
      VERIFY_CHUNK_BYTES = 1024 * 1024
      ControlStop = Class.new(StandardError)

      Piece = Struct.new(:number, :offset, :bytesize, :reservation, :attempts, :renewals, :ready_at, :data, :generation, keyword_init: true)

      # A SHA-256 digest of the next bytes of io, read chunk bytes at a time, into one buffer when io takes one, or false
      # when io ends before them.
      def self.digest_of(io, bytes, chunk)
        digest = OpenSSL::Digest.new('SHA256')
        buffer = String.new(capacity: chunk, encoding: Encoding::BINARY) if takes_buffer?(io)
        remaining = bytes
        while remaining.positive?
          wanted = [ remaining, chunk ].min
          data = buffer ? io.read(wanted, buffer) : io.read(wanted)
          return false if data.nil? || data.empty?

          digest.update(data)
          remaining -= data.bytesize
        end
        digest
      end

      # Whether io's read and pread take a buffer to read into, as an IO's, a StringIO's and a Tempfile's do.
      def self.takes_buffer?(io)
        io.is_a?(::IO) || io.is_a?(StringIO) || (defined?(::Tempfile) && io.is_a?(::Tempfile))
      end

      # The local file download_file opened, or reopened to resume. It can always start over. A restart or resume only
      # positions it: what they drop is truncated as the next bytes are written, or as the download completes.
      class FileSink
        attr_reader :path

        def initialize(file, path)
          @file = file
          @path = path
          @pending = nil
        end

        def write(data)
          settle!
          @file.write(data)
        end

        def restartable?
          true
        end

        def restart!
          @pending = 0
        end

        def verifiable?
          true
        end

        def identity
          Checkpoint.identity(@file.stat, contents: false)
        end

        def holds?(bytes)
          @file.size >= bytes
        end

        # A digest of the file's first bytes, read chunk bytes at a time, or false when it is shorter.
        def prefix_digest(bytes, chunk)
          @file.rewind
          DownloadCoordinator.digest_of(@file, bytes, chunk)
        end

        # Writing continues after the first bytes; what follows them is dropped only as the next bytes are written.
        def resume_at!(bytes)
          @file.seek(bytes)
          @pending = bytes
        end

        # Drops what a restart or resume left after where writing continues.
        def settle!
          return unless @pending

          @file.truncate(@pending)
          @file.seek(@pending)
          @pending = nil
        end

        def close
          @file.close unless @file.closed?
        end

        def close_after_failure(_error); end
      end

      # The caller's IO, which stays open. It can start over only when it reports its position and can seek back and
      # truncate there, which it does as the next bytes are written, or as the download completes.
      class IoSink
        attr_reader :start

        def initialize(io, start: :current)
          @io = io
          @start = start == :current ? position : start
          @pending = false
        end

        def path
          nil
        end

        def write(data)
          settle!
          @io << data
        end

        def position
          @io.pos if @io.respond_to?(:pos)
        rescue IOError, SystemCallError, NotImplementedError
          nil
        end

        def restartable?
          !@start.nil? && @io.respond_to?(:seek) && @io.respond_to?(:truncate)
        end

        def restart!
          @pending = true
        end

        def settle!
          return unless @pending

          @io.seek(@start)
          @io.truncate(@start)
          @pending = false
        end

        # Whether a resume could check the bytes written: only when the IO said where they begin.
        def verifiable?
          !@start.nil?
        end

        # The IO object itself, never a number another object could reuse.
        def identity
          [ :io, @io, @start ]
        end

        def matches?(io)
          io.equal?(@io)
        end

        def holds?(bytes)
          !@start.nil? && position == @start + bytes
        end

        # A digest of the bytes written from start, read back chunk bytes at a time without moving where the IO writes
        # next: from a StringIO's string, with pread, by seeking back and reading, or, for a File it cannot read, from its
        # path while that is still the same file. A Tempfile and other delegators read back as what they delegate to.
        # false when it holds fewer bytes; nil when it cannot give them back at all.
        def prefix_digest(bytes, chunk)
          return if @start.nil?
          return string_digest(bytes, chunk) if @io.is_a?(StringIO)

          digest = read_back_digest(bytes, chunk)
          digest.nil? ? path_digest(bytes, chunk) : digest
        end

        def resume_at!(_bytes); end

        def close; end

        private def string_digest(bytes, chunk)
          string = @io.string
          return false if string.bytesize < @start + bytes

          digest = OpenSSL::Digest.new('SHA256')
          (0...bytes).step(chunk) { |offset| digest.update(string.byteslice(@start + offset, [ chunk, bytes - offset ].min)) }
          digest
        end

        private def read_back_digest(bytes, chunk)
          if @io.respond_to?(:pread)
            pread_digest(bytes, chunk)
          elsif @io.respond_to?(:seek) && @io.respond_to?(:read)
            seek_digest(bytes, chunk)
          end
        rescue IOError, SystemCallError, NotImplementedError
          nil
        end

        private def pread_digest(bytes, chunk)
          digest = OpenSSL::Digest.new('SHA256')
          buffer = String.new(capacity: chunk, encoding: Encoding::BINARY) if DownloadCoordinator.takes_buffer?(@io)
          offset = 0
          while offset < bytes
            wanted = [ bytes - offset, chunk ].min
            data = buffer ? @io.pread(wanted, @start + offset, buffer) : @io.pread(wanted, @start + offset)
            return false if data.empty?

            digest.update(data)
            offset += data.bytesize
          end
          digest
        rescue EOFError
          false
        end

        private def seek_digest(bytes, chunk)
          resume_from = @io.pos
          begin
            @io.seek(@start)
            DownloadCoordinator.digest_of(@io, bytes, chunk)
          ensure
            @io.seek(resume_from)
          end
        end

        private def path_digest(bytes, chunk)
          return unless @io.respond_to?(:path) && @io.respond_to?(:stat) && @io.path

          ::File.open(@io.path, "rb") do |file|
            next unless Checkpoint.identity(file.stat, contents: false) == Checkpoint.identity(@io.stat, contents: false)

            file.seek(@start)
            DownloadCoordinator.digest_of(file, bytes, chunk)
          end
        rescue IOError, SystemCallError
          nil
        end

        # Pipe readers learn why the download failed before the pipe closes, and a failure to close never replaces the
        # download's own error.
        def close_after_failure(error)
          @io.do_set_error(error) if @io.respond_to?(:do_set_error)
          @io.close
        rescue StandardError
          nil
        end
      end

      # Opens local_path only once the job gives the download a file slot.
      def self.download_file(job, file, local_path, progress: nil)
        new(job, file, -> { FileSink.new(::File.open(local_path, "wb"), local_path) }, progress: progress).run
      end

      def self.download_content(job, file, io, progress: nil)
        new(job, file, -> { IoSink.new(io) }, progress: progress).run
      end

      def self.resume(job, checkpoint, destination, options, progress: nil)
        checkpoint.resuming(:download) do |lease|
          remote = Files::File.new(checkpoint.path, options)
          open_sink = if checkpoint.local_path
                        -> { FileSink.new(::File.open(checkpoint.local_path, "r+b"), checkpoint.local_path) }
                      else
                        _, io, start = checkpoint.sink
                        raise CheckpointError, "Bad parameter: resume the download into the IO it paused in" unless destination.equal?(io)

                        -> { IoSink.new(destination, start: start) }
                      end
          new(job, remote, open_sink, checkpoint: checkpoint, lease: lease, progress: progress).run
        end
      end

      # Fixes, on the caller's thread, the file's path and any download URL its record holds, the API context from its
      # options, and the transport for its content requests, which refuses a client whose adapter cannot stream.
      def initialize(job, file, open_sink, checkpoint: nil, lease: nil, progress: nil)
        super(job)
        @path = Checkpoint.frozen(file.path)
        @download_uri = Checkpoint.frozen(file.download_uri)
        @options = Coordinator.api_context(file.options)
        @open_sink = open_sink
        @sink = nil
        @lease = lease
        @progress = progress
        @transport = job.transport_for(Files::ApiClient.download_client, download: true)
        @range_bytes = [ Policy::DOWNLOAD_RANGE_BYTES, job.options.buffer_bytes / 4 ].min
        @mode = :probe
        @written = 0
        @counted = 0
        @digest = OpenSSL::Digest.new('SHA256')
        @total = nil
        @version = nil
        @generation = 0
        @open = {}
        @next_number = 0
        @next_write = 0
        @refusals = {}.compare_by_identity
        @write_failure = nil
        @origin = checkpoint
        return unless checkpoint&.version

        @written = checkpoint.completed_bytes
        @counted = @written
        @version = checkpoint.version
        @total = checkpoint.total_bytes
      end

      private

      # A destination that cannot be opened, or a resume's that changed or cannot be checked, stops the transfer as it is
      # found (stop!), so a cancellation or pause after it cannot come first, and one before it leaves the checkpoint
      # unspent and the destination as it was.
      def open_resources
        @sink = @open_sink.call
        resume_sink(@origin) if @origin
      rescue StandardError => e
        raise stop!(e)
      end

      def close_resources
        @sink&.close
      end

      # Before anything is sent or written: the destination must still be the one the paused download wrote to,
      # holding exactly the bytes it wrote, read back a slice at a time into scratch the buffer budget holds, and
      # compared by digest; one that cannot give them back refuses. A pause or cancellation while it waits for that
      # budget leaves the checkpoint unspent. Only then is the checkpoint spent. An unbound download starts its
      # destination over instead, as its first new bytes are written.
      def resume_sink(checkpoint)
        changed = @sink.path ? "Bad parameter: the local file changed after the download paused" : "Bad parameter: the IO changed after the download paused"
        raise CheckpointError, changed unless @sink.identity == checkpoint.sink

        if checkpoint.state[:restart]
          @lease&.start!
          return restart_sink
        end

        completed = checkpoint.completed_bytes
        raise CheckpointError, changed unless @sink.holds?(completed)

        chunk = [ VERIFY_CHUNK_BYTES, @range_bytes ].min
        scratch = reserve(chunk)
        begin
          digest = @sink.prefix_digest(completed, chunk)
        ensure
          release(scratch)
        end
        raise CheckpointError, "Bad parameter: the bytes already downloaded cannot be read back to check them" if digest.nil?
        raise CheckpointError, changed unless digest && digest.hexdigest == checkpoint.state[:digest]

        @lease&.start!
        @digest = digest
        @sink.resume_at!(completed)
      end

      # The download, from its URL's lookup to its last write. Any error on the way is raised only when it came before
      # any cancellation or pause (Coordinator#run), and a cancellation or pause, such as one from the last progress
      # call, is raised in place of a success.
      def transfer
        @url = @download_uri || load_url
        raise stop!(Files::APIError.new("The download URL the API returned is not usable")) unless http_url?(@url)

        @current = [ @url, @generation, StorageRetry.expires_at(@url) ].freeze
        @started_at = Clock.now
        @start_written = @written
        # Every byte of a resumed download was written before its pause: storage proves its version with its last byte.
        @mode = :proof if @version && @written >= @total
        if fetch_head == :bound
          bind
          @next_offset = @written
          pump
        end
        @job.synchronize { observe_stops }
        raise_outcome
        @sink.settle!
        nil
      end

      # A refused transfer or a failed write that ended the download first closes a caller's IO.
      def after_failure(error)
        @sink&.close_after_failure(error) if closes_destination?(error)
      end

      # The opening range, or the whole response, on the caller's thread, with its own retries and renewals, each
      # request under one of the job's request permits and only once no throttle holds its destination back. A
      # throttle it gets holds the destination back for every transfer of the job, from before its permit is given back
      # (fetch_once). An expired URL is renewed before it is sent, at most twice; a renewal after storage refused an
      # expired URL, or said it expired (StorageRetry.expired_response?), counts as a retry and as one of those two.
      # Returns :bound when ranges remain, or :done. What ends it stops the transfer as it is found (stop!, refusal).
      def fetch_head
        attempts = 0
        renewals = 0
        loop do
          check_control!
          if StorageRetry.expired?(@current[2])
            raise stop!(Files::APIError.new(EXPIRED, http_status: 403)) if renewals >= RENEWALS

            renewals += 1
            renew_url
            next
          end
          begin
            result = fetch_once
          rescue NetworkFailure => e
            raise stop!(e.original) unless e.retryable? && attempts < @max_retries && (@written == @attempt_start || @sink.restartable?)

            attempts += 1
            retry_head(StorageRetry::RETRY_DELAY)
            restart_sink unless @written == @attempt_start
            next
          rescue Passthrough => e
            raise stop!(e.error) unless e.error.is_a?(ControlStop)

            # A cancellation or pause keeps what was written; a resumed unbound download starts over.
            check_control!
            raise Files::Error, "The transfer stopped"
          end
          next @mode = :whole if result == :unbound
          return result if result.is_a?(Symbol)

          response = result
          raise refusal(FrontendResponseError.new) if StorageRetry.frontend?(response.headers)
          return :done if response.status == 416 && @written.zero? && response.header("content-range").to_s.strip == "bytes */0"
          raise refusal(VersionChangedError.new) if response.status == 412

          said_expired = StorageRetry.expired_response?(response.status, response.body, truncated: response.truncated)
          decision, delay = if said_expired || (response.status == 403 && StorageRetry.expired?(@current[2]))
                              [ :renew, 0.0 ]
                            else
                              StorageRetry.classify(response.status, response.headers, response.body, truncated: response.truncated)
                            end
          raise refusal(refused(response)) if decision == :refuse || attempts >= @max_retries

          # Storage said the URL expired while the expiry it states is still to come, or it states none: the check
          # before the next send would not renew it, so it is renewed here, within the same renewals.
          renew_now = said_expired && !StorageRetry.expired?(@current[2])
          raise refusal(refused(response)) if renew_now && renewals >= RENEWALS

          attempts += 1
          retry_head(delay)
          next unless renew_now

          renewals += 1
          renew_url
        end
      end

      def retry_head(delay)
        @job.synchronize { @job.count_retry }
        wait_before_retry(delay)
      end

      # One request for the head, under a request permit it holds only while the request is in flight: the opening
      # range, the whole file, or, for a proof, the file's last byte. A throttle it gets holds the destination back as
      # the permit is given back, under the same lock, so a request waiting for the permit is never sent before it.
      def fetch_once
        @attempt_start = @written
        headers = { "Accept-Encoding" => "identity" }
        unless @mode == :whole
          first = @mode == :proof ? @total - 1 : @written
          headers["Range"] = "bytes=#{first}-#{@mode == :proof ? first : first + @range_bytes - 1}"
        end
        headers["If-Match"] = @version if @version
        reservation = reserve(@mode == :proof ? 1 : @range_bytes) unless @mode == :whole
        begin
          check_control! unless @job.acquire_request(@control, @url) == :running
          begin
            outcome = nil
            response = @transport.perform(:get, @url, headers, @connections) { |http| outcome = head_response(http) }
            throttle = head_throttle(response)
          ensure
            @job.release_request(@url, throttle)
          end
          return response unless response.status.between?(200, 299)

          case outcome[0]
          when :bound, :complete
            _, data, total, etag = outcome
            @version ||= etag if outcome[0] == :bound
            @total = total
            write!(data)
            wrote(data.bytesize)
            @written < @total ? :bound : :done
          when :streamed, :proven then :done
          else :unbound
          end
        ensure
          release(reservation)
        end
      end

      # The seconds a head response's throttle holds its destination back, as fetch_head classifies it, or nil: never
      # for a success, nor for the web app's response, which fetch_head refuses instead.
      def head_throttle(response)
        return if response.status.between?(200, 299) || StorageRetry.frontend?(response.headers)

        decision, delay = StorageRetry.classify(response.status, response.headers, response.body, truncated: response.truncated)
        delay if decision == :throttle
      end

      # Inside the response, before anything of it is written.
      def head_response(http)
        raise refusal(FrontendResponseError.new) if http.key?(StorageRetry::FRONTEND_HEADER)

        case http.code
        when "206"
          raise refusal(mismatch) if @mode == :whole

          first, last, total = content_range(http["content-range"])
          return proof(http, first, last, total) if @mode == :proof

          length = last && (last - first + 1)
          unless first == @written && length && last < total && length == [ @range_bytes, total - first ].min && http.content_length == length &&
                 (@total.nil? || total == @total)
            raise refusal(mismatch)
          end

          etag = http["etag"]
          raise refusal(VersionChangedError.new) if @version && etag && etag != @version
          return [ :bound, read_exact(http, length), total, etag || @version ] if @version || strong?(etag)
          return [ :complete, read_exact(http, length), total ] if first.zero? && last == total - 1

          [ :unbound ]
        when "200"
          # A download bound to a version takes a whole response only of that version, and never as its proof.
          raise refusal(VersionChangedError.new) if @version && http["etag"] != @version
          raise refusal(mismatch) if @mode == :proof

          stream_whole(http)
          [ :streamed ]
        else
          raise refusal(mismatch)
        end
      end

      # A resumed download's proof that storage still has its version: the file's last byte, answered 206 under
      # If-Match with the exact Content-Range and length and no other ETag. Nothing of it is written.
      def proof(http, first, last, total)
        raise refusal(mismatch) unless first == @total - 1 && last == first && total == @total && http.content_length == 1

        etag = http["etag"]
        raise refusal(VersionChangedError.new) if etag && etag != @version

        read_exact(http, 1)
        [ :proven ]
      end

      # A whole response, written as it arrives from its first byte.
      def stream_whole(http)
        raise refusal(mismatch) if @written.positive? && !@sink.restartable?

        restart_sink if @written.positive?
        expected = http.chunked? ? nil : http.content_length
        received = 0
        http.read_body do |chunk|
          raise Passthrough.new(ControlStop.new), cause: nil unless @control.nil? || @control.state == :running

          begin
            write!(chunk)
            wrote(chunk.bytesize)
          rescue StandardError => e
            raise Passthrough.new(e), cause: nil
          end
          received += chunk.bytesize
        end
        raise EOFError, "Transfer response ended after #{received} of #{expected} bytes" if expected && received != expected

        @total = received
      end

      # Starts the destination over, just before a request that writes it from the first byte again.
      def restart_sink
        @sink.restart!
        @written = 0
        @digest = OpenSSL::Digest.new('SHA256')
      end

      def bind
        host = ::URI.parse(@url).host
        options = @job.options
        key, policy = if @transport.serialized?
                        [ [ :download, :client, host ], Policy.fixed(1) ]
                      elsif options.automatic?
                        [ [ :download, host ], Policy.download(max_concurrency: options.max_concurrency) ]
                      else
                        [ [ :download, :fixed, host ], Policy.fixed(options.concurrency) ]
                      end
        @controller = @job.synchronize { @job.controller(key) { policy } }
      end

      def plan
        renew_pieces
        while @stop.nil? && @next_offset < @total && @queue.size < @controller.limit
          length = [ @range_bytes, @total - @next_offset ].min
          piece = Piece.new(number: @next_number, offset: @next_offset, bytesize: length, attempts: 0, renewals: 0, ready_at: 0, generation: @generation)
          @open[piece.number] = piece
          enqueue(piece)
          @next_offset += length
          @next_number += 1
        end
      rescue StandardError => e
        stop!(e)
      end

      def wants_planning?
        !@renewals.empty? || (@next_offset < @total && @queue.size < @controller.limit)
      end

      def finished?
        @next_offset >= @total && @open.empty?
      end

      # Renews the URL once for the ranges that found theirs expired, then sends them again. A range that already
      # used a newer URL just goes again. A range whose renewals still give an expired URL stops the download unsent.
      def renew_pieces
        pieces = @renewals.dup
        @renewals.clear
        current = pieces.select { |piece| piece.generation >= @generation }
        exhausted = current.find { |piece| piece.renewals >= RENEWALS }
        if exhausted
          fail_item(exhausted, refusal(Files::APIError.new("Transfer request failed", http_status: 403)))
        elsif !current.empty?
          current.each { |piece| piece.renewals += 1 }
          renew_url
        end
        pieces.each do |piece|
          next if piece.equal?(exhausted)

          piece.ready_at = 0
          enqueue(piece)
        end
      end

      # The new target, its URL, generation and expiry, is made whole and then published as one reference, so an
      # attempt that looks at it for a newer generation never sees part of it beside part of the target before it.
      def renew_url
        url = load_url
        raise stop!(Files::APIError.new("The download URL the API returned is not usable")) unless http_url?(url)

        target = [ url, @generation + 1, StorageRetry.expires_at(url) ].freeze
        @url, @generation = target
        @current = target
      end

      # The download URL the API gives for the file now, asked with the context the download began with; the answer's
      # own context, such as the regional origin a lockout region mismatch moved it to, carries on to the lookups after.
      # The lookup's failure stops the transfer as it arrives (stop!).
      def load_url
        remote = begin
          Files::File.download(@path, {}, @options)
        rescue StandardError => e
          raise stop!(e)
        end
        adopt_context(remote)
        remote.download_uri
      end

      def reservation_bytes(piece)
        piece.bytesize
      end

      # An expired URL is never sent; renew_pieces stops the download once a range's renewals run out.
      def expiring?(piece)
        return false unless StorageRetry.expired?(@current[2])

        piece.generation = @generation
        true
      end

      # Every range goes to the URL the download has now, with its generation and expiry.
      def request_target(_piece)
        @current
      end

      # On a worker thread, to the URL and generation the range was admitted for (target), even when the URL has been
      # renewed since. A 403 renews it when that URL's own expiry has passed, or when a newer URL has been published
      # since, and a 400 or 403 when storage says the URL expired (StorageRetry.expired_response?); any other 403
      # refuses it. timing starts with the send and ends once the range's whole body has arrived and been checked; the
      # range's bytes are charged to the buffer budget already, and read straight into one String of its length.
      def attempt_item(piece, target, connections, timing = nil)
        url, generation, expires_at = target
        piece.generation = generation
        headers = { "Range" => "bytes=#{piece.offset}-#{piece.offset + piece.bytesize - 1}", "Accept-Encoding" => "identity", "If-Match" => @version }
        response = @transport.perform(:get, url, headers, connections, timing: timing) { |http| range_body(http, piece) }
        return [ :ok, response.body, piece.bytesize ] if response.status.between?(200, 299)
        return [ :fail, refusal(FrontendResponseError.new) ] if StorageRetry.frontend?(response.headers)
        return [ :fail, refusal(VersionChangedError.new) ] if response.status == 412
        return [ :renew, refusal(refused(response)) ] if response.status == 403 && (StorageRetry.expired?(expires_at) || generation < @current[1])
        return [ :renew, refusal(refused(response)) ] if StorageRetry.expired_response?(response.status, response.body, truncated: response.truncated)

        decision, delay = StorageRetry.classify(response.status, response.headers, response.body, truncated: response.truncated)
        case decision
        when :throttle then [ :retry, delay, :throttle, refusal(refused(response)) ]
        when :retry then [ :retry, delay, :failure, refusal(refused(response)) ]
        else [ :fail, refusal(refused(response)) ]
        end
      end

      def range_body(http, piece)
        raise refusal(FrontendResponseError.new) if http.key?(StorageRetry::FRONTEND_HEADER)
        raise refusal(mismatch) unless http.code == "206"

        first, last, total = content_range(http["content-range"])
        raise refusal(mismatch) unless first == piece.offset && last == piece.offset + piece.bytesize - 1 && total == @total && http.content_length == piece.bytesize

        etag = http["etag"]
        raise refusal(VersionChangedError.new) if etag && etag != @version

        read_exact(http, piece.bytesize)
      end

      def read_exact(http, length)
        data = String.new(capacity: length, encoding: Encoding::BINARY)
        http.read_body do |chunk|
          raise refusal(mismatch) if data.bytesize + chunk.bytesize > length

          data << chunk
        end
        raise EOFError, "Transfer response ended after #{data.bytesize} of #{length} bytes" if data.bytesize < length

        data
      end

      # With the lock held: keeps a range until the ones before it are written.
      def accept(piece, data)
        piece.data = data
        piece
      end

      # On the caller's thread: writes the ranges that are next in order. They are still written after a pause, so
      # its checkpoint keeps them, but not after a failure or cancellation.
      def deliver(_completed)
        while @stop.nil? || @stop == :paused
          piece = @open[@next_write]
          break unless piece&.data

          write!(piece.data)
          @open.delete(piece.number)
          @job.post { discard(piece) }
          @next_write += 1
          wrote(piece.bytesize)
        end
      rescue StandardError => e
        stop!(e)
      end

      # On the caller's thread, after bytes were written: counts those not written before, and reports progress with
      # total_bytes (nil until known), written_bytes, elapsed_seconds of this call and bytes_per_second, its written
      # bytes over them. Anything progress raises stops the transfer as it is raised (stop!).
      def wrote(bytes)
        @written += bytes
        if @written > @counted
          fresh = @written - @counted
          @counted = @written
          @job.synchronize { @job.count_accepted(fresh) }
        end
        return unless @progress

        elapsed = Clock.now - @started_at
        begin
          @progress.call({ total_bytes: @total, written_bytes: @written, elapsed_seconds: elapsed,
                           bytes_per_second: elapsed.positive? ? [ @written - @start_written, 0 ].max / elapsed : 0.0 }
          )
        rescue StandardError => e
          raise stop!(e)
        end
      end

      def all_items
        @open.values
      end

      # A range is on the network until its whole body has arrived and been checked.
      def measured_through_body?
        true
      end

      # Keeps a digest of the bytes written, so resuming can tell they are unchanged, never the bytes themselves. nil
      # before the destination is open, as when a pause comes while it opens, and when resuming could neither start
      # over nor check those bytes.
      def checkpoint
        return if @sink.nil?

        state = {}
        if @version.nil?
          return unless @sink.restartable?

          state = { restart: true }
        else
          return unless @sink.verifiable? && @digest

          state = { digest: @digest.hexdigest }
        end
        Checkpoint.new(direction: :download, path: @path, local_path: @sink.path, total_bytes: @total, completed_bytes: @version ? @written : 0,
                       sink: @sink.identity, version: @version, state: state
        )
      end

      def check_control!
        @job.synchronize { observe_stops }
        raise_outcome
      end

      def wait_before_retry(seconds)
        deadline = Clock.now + seconds
        @job.synchronize do
          loop do
            observe_stops
            remaining = deadline - Clock.now
            break if @stop || !remaining.positive?

            @job.wait(remaining)
          end
        end
        raise_outcome
      end

      # Waits for the buffer budget to hold bytes on the caller's thread, unless the transfer stops first.
      def reserve(bytes)
        @job.synchronize do
          loop do
            observe_stops
            break if @stop
            return @job.budget.reserve(bytes) if @job.budget.available?(bytes)

            @job.wait
          end
        end
        raise_outcome
      end

      def release(reservation)
        @job.post { @job.budget.release(reservation) } if reservation
      end

      # On the caller's thread. A failed write stops the transfer as it fails (stop!).
      def write!(data)
        @sink.write(data)
        @digest&.update(data)
      rescue StandardError => e
        @write_failure = e
        raise stop!(e)
      end

      # Marks error as the kind that closes a caller's IO: storage refused, or answered something other than asked. On
      # the caller's thread, where it always ends the transfer, it also stops it as it is found (stop!); a worker's goes
      # back through its request's outcome instead.
      def refusal(error)
        @job.synchronize { @refusals[error] = true }
        Thread.current.equal?(@thread) ? stop!(error) : error
      end

      def closes_destination?(error)
        error.equal?(@write_failure) || @job.synchronize { @refusals.key?(error) }
      end

      def public_error(error)
        error.is_a?(NetworkFailure) ? error.original : error
      end

      def refused(response)
        Files::APIError.new("Transfer request failed", http_status: response.status)
      end

      def mismatch
        Files::APIError.new(MISMATCH)
      end

      def strong?(etag)
        etag.is_a?(String) && etag.match?(/\A"[^"]*"\z/)
      end

      def content_range(value)
        match = value.to_s.match(/\Abytes (\d+)-(\d+)\/(\d+)\z/)
        match ? match.captures.map(&:to_i) : []
      end

      def http_url?(url)
        url.is_a?(String) && %w[http https].include?(::URI.parse(url).scheme)
      rescue ::URI::InvalidURIError
        false
      end
    end
  end
end
