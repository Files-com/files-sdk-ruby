# frozen_string_literal: true

require "digest"
require "json"

module Files
  module Transfer
    # Uploads one local file, or a caller's stream of a known size, through a Job, its parts sent concurrently.
    #
    # On the caller's thread it asks the API for parts five at a time (begin_upload, with with_direct_connection_info),
    # checks each part's instructions, sends progress and finalizes. Every API request of the upload uses one context
    # the caller's thread fixed as it began (Coordinator.api_context), updated by each grant's own options, which carry
    # any regional origin the API moved the upload to, for the requests after it. The API chooses each part's size,
    # unless the upload plans its own, as below. Parts go to cloud storage under the storage policy, or under the direct
    # policy when the first part's direct_connection_info is a valid version 1 description (server_name, addresses,
    # direct_uri and ca_pem); the parts still go to the upload_uri the API gave. A part whose instructions say
    # parallel_parts: false makes the file send one part at a time.
    #
    # An upload plans its own part sizes only when every part of the API's first answer is for one ordinary multipart
    # upload straight to Amazon S3 (UploadPlan.route) and UploadPlan can plan the file within its limits. All its parts
    # but the last then have the size UploadPlan.part_size gives, which buffer_bytes must hold before anything is read;
    # partsize and next_partsize are only recommendations, and each part keeps its offset and size through renewals,
    # retries and a resume, whatever the API recommends later. Every later part and renewal must be for that same S3
    # upload, as the first answer described it, or the upload stops before sending the part.
    #
    # Through the job's own transport, a part streams from the opened file at its offset and holds at most 64 KiB in
    # memory; through a caller's client it is read whole first, so it must fit buffer_bytes. A caller's stream is read
    # on the caller's thread, part by part in order, each part only once the buffer budget holds all reading and
    # sending it may need, and what it then holds stays held, through renewals and retries, until storage acknowledges
    # the part or the upload stops; no part is sent before its bytes are read. Each read's bytes are copied before the
    # next read, so a stream whose reads reuse one String still sends exactly what it read, and its Strings are never
    # changed. Over the job's own transport a part read in pieces keeps them apart and is sent through a 64 KiB slice
    # it holds with them; a caller's client takes one String, so a part read in pieces is copied into one, within
    # twice its bytes, after which it holds its bytes alone.
    #
    # A part counts as acknowledged only for a 2xx response with exactly one nonempty ETag, and is reported to progress,
    # on the caller's thread, once. A signed URL near its expiry is renewed before it is used, at most twice for a part;
    # one still expired after that stops the upload without being sent. A part whose URL expired after it was sent is
    # renewed and sent again only when its instructions allow retries, as one of its retries. A renewal must keep the
    # part's instructions: the reference, part number, size (the planned one, for an upload planning its own), method,
    # headers and retry rules. Before each part and
    # before finalizing, the local file must still be the one opened, with the same size and modification time.
    class UploadCoordinator < Coordinator
      STREAM_BUFFER_BYTES = 64 * 1024
      RENEWALS = 2
      ACK_FAILURE = "Transfer response did not acknowledge the part"
      # The caller's upload parameters a checkpoint keeps, when they are true, false or an Integer.
      CHECKPOINT_PARAMS = %i[mkdir_parents with_rename size].freeze

      # data holds a caller's stream's bytes for the part, from when they are read until they are given up.
      Part = Struct.new(:number, :offset, :bytesize, :granted, :grant, :fingerprint, :data, :reservation, :attempts, :renewals, :ready_at, keyword_init: true)
      # route is the grant's UploadPlan.route, only for an upload planning its own part sizes.
      Grant = Struct.new(:ref, :number, :partsize, :http_method, :url, :headers, :expires_at, :retry, :parallel, :direct, :route, keyword_init: true)

      # The opened local file. Each part reads its bytes at its own offset under a lock, so a retry sends exactly what
      # the first attempt did without keeping it in memory.
      class Source
        attr_reader :path, :size, :mtime, :identity

        def initialize(path)
          @path = path
          @file = ::File.open(path, "rb")
          @lock = Mutex.new
          stat = @file.stat
          @identity = Checkpoint.identity(stat)
          @size = stat.size
          @mtime = stat.mtime
        end

        def check!
          raise SourceChangedError unless Checkpoint.identity(@lock.synchronize { @file.stat }) == @identity
        end

        def read(offset, length)
          data = @lock.synchronize do
            @file.seek(offset)
            @file.read(length)
          end
          raise SourceChangedError, "The local file ended early during the upload" unless data && data.bytesize == length

          data
        end

        def close
          @file.close unless @file.closed?
        end
      end

      # A caller's IO of a known size, read once, in order, from where it stands: exactly size bytes, through as many
      # reads as it takes, however short each is, with read(length) alone. The coordinator asks for each part's bytes in
      # turn, on its own thread, once the buffer budget holds them, and keeps them with the part. The IO is never
      # rewound, closed or read past size.
      class StreamSource
        attr_reader :size

        def initialize(io, size)
          @io = io
          @size = size
          @position = 0
        end

        def path; end

        def mtime; end

        def identity; end

        def check!; end

        # The next part's bytes, which start at offset; the parts are read in order, never skipping one. Each read's
        # bytes are copied (String#b, which shares them until either String changes) before the next read, so an IO whose
        # reads reuse one String still gives each part exactly what it read, and the IO's Strings are never changed.
        # With whole, the part comes as one String: the first read's copy when that read gave all of it, and otherwise
        # one String of the part's size each read is appended to. Otherwise the copies are kept apart, frozen and in
        # order, as one String when a single read gave the whole part.
        def read_next(offset, length, whole: false)
          raise ArgumentError, "the upload stream is at #{@position}, not #{offset}" unless offset == @position

          pieces = []
          joined = nil
          read = 0
          while read < length
            chunk = @io.read(length - read)
            raise SourceChangedError, "The upload stream ended after #{@position + read} of its #{@size} bytes" if chunk.nil? || chunk.empty?
            raise SourceChangedError, "The upload stream gave more than the part's bytes" if chunk.bytesize > length - read

            read += chunk.bytesize
            if whole && (joined || read < length)
              joined ||= String.new(capacity: length, encoding: Encoding::BINARY)
              joined << chunk.b
            else
              pieces << chunk.b.freeze
            end
          end
          @position += length
          return (joined || pieces.first || String.new).freeze if whole

          pieces.size == 1 ? pieces.first : pieces
        end

        def close; end
      end

      # One part's bytes, read from the source as Net::HTTP streams them. Its source's errors pass through the
      # transport as they are, never taken for network errors.
      class Region
        def initialize(source, offset, length)
          @source = source
          @offset = offset
          @remaining = length
        end

        def read(length = nil, outbuf = nil)
          if @remaining.zero?
            outbuf&.clear
            return length.to_i.positive? ? nil : String.new
          end
          wanted = [ length || STREAM_BUFFER_BYTES, @remaining, STREAM_BUFFER_BYTES ].min
          data = @source.read(@offset, wanted)
          @offset += wanted
          @remaining -= wanted
          outbuf ? outbuf.replace(data) : data
        rescue StandardError => e
          raise Passthrough.new(e), cause: nil
        end
      end

      # A caller's stream's part read in pieces, sent from them in turn as Net::HTTP streams it, without joining them.
      # Each read copies a slice of at most 64 KiB of a piece, which the part holds a reservation for (held_bytes).
      class Segments
        def initialize(segments)
          @segments = segments
          @index = 0
          @offset = 0
        end

        def read(length = nil, outbuf = nil)
          segment = @segments[@index]
          if segment.nil?
            outbuf&.clear
            return length.to_i.positive? ? nil : String.new
          end
          wanted = [ length || STREAM_BUFFER_BYTES, segment.bytesize - @offset, STREAM_BUFFER_BYTES ].min
          data = segment.byteslice(@offset, wanted)
          @offset += wanted
          if @offset == segment.bytesize
            @index += 1
            @offset = 0
          end
          outbuf ? outbuf.replace(data) : data
        end
      end

      # Opens path only once the job gives the upload a file slot.
      def self.upload(job, path, destination, options, params:, progress:)
        new(job, -> { Source.new(path) }, destination, options, params: params, progress: progress).run
      end

      # Uploads exactly size bytes of the caller's io, which stays open.
      def self.upload_io(job, io, size, destination, options, params:, progress:)
        new(job, -> { StreamSource.new(io, size) }, destination, options, params: params, progress: progress).run
      end

      def self.resume(job, checkpoint, options, progress:)
        checkpoint.resuming(:upload) do |lease|
          new(job, -> { Source.new(checkpoint.local_path) }, checkpoint.path, options, params: checkpoint.state[:params].dup, progress: progress,
              checkpoint: checkpoint, lease: lease
          ).run
        end
      end

      def initialize(job, open_source, destination, options, params:, progress:, checkpoint: nil, lease: nil)
        super(job)
        @open_source = open_source
        @source = nil
        @destination = destination
        @options = Coordinator.api_context(options)
        @params = params.to_h.transform_keys(&:to_sym)
        @progress = progress
        @client = @options[:client]
        @transport = job.transport_for(@client)
        @parts = []
        @accepted = {}
        @accepted_bytes = 0
        @ref = nil
        @planned_bytes = 0
        @next_read = 0
        @file_cap = Float::INFINITY
        # For an upload planning its own part sizes, its route (UploadPlan.route) and the size of its parts but the last.
        @route = nil
        @part_size = nil
        @origin = checkpoint
        @lease = lease
        restore(checkpoint) if checkpoint
      end

      private

      # A resumed upload spends its checkpoint here, once the local file proved unchanged and before any request. A file
      # that cannot be opened, or changed, stops the transfer as it is found (stop!), so a cancellation or pause after it
      # cannot come first, and one before it leaves the checkpoint unspent.
      def open_resources
        @source = @open_source.call
        raise CheckpointError, "Bad parameter: the local file changed after the upload paused" if @origin && @source.identity != @origin.source

        @lease&.start!
        @params[:size] ||= @source.size
      rescue StandardError => e
        raise stop!(e)
      end

      def close_resources
        @source&.close
      end

      # Finalizes the upload once every part is acknowledged. Progress measures this call from here, and its rate counts
      # only the parts the call acknowledges, not those a resumed upload's checkpoint already held (accept).
      def transfer
        @started_at = Clock.now
        @start_accepted = @accepted_bytes
        pump
        raise_outcome
        finalize
      end

      # The local file must still be the one opened before the upload ends. A change found, or the finalize request's
      # failure, stops the transfer as it is met (stop!), so a cancellation or pause after it cannot come first.
      def finalize
        @source.check!
        etags = @parts.map { |part| { etag: @accepted.fetch(part.number), part: part.number } }
        params = { action: "end", etags: etags, ref: @ref, size: @source.size }
        params[:provided_mtime] = @source.mtime.to_s if @source.mtime
        Files::File.create(@destination, params, @options)
      rescue StandardError => e
        raise stop!(e)
      end

      def restore(checkpoint)
        state = checkpoint.state
        @ref = state[:ref]
        @planned_bytes = state[:planned_bytes]
        @file_cap = state[:file_cap]
        # A checkpoint without a plan of its own, as an older one, resumes with the API choosing the sizes.
        plan = state[:plan]
        if plan && plan[:mode] == :local
          @route = plan[:route]
          @part_size = plan[:partsize]
        end
        @accepted_bytes = checkpoint.completed_bytes
        state[:layout].each do |number, offset, size, granted, fingerprint|
          part = Part.new(number: number, offset: offset, bytesize: size, granted: granted, fingerprint: fingerprint, attempts: 0, renewals: 0, ready_at: 0)
          @parts << part
          if state[:etags].key?(number)
            @accepted[number] = state[:etags][number]
          else
            @renewals << part
          end
        end
      end

      # Nil before the source is open, as when a pause comes while it opens, and for a caller's stream, which cannot be
      # read again. Of an upload planning its own part sizes it keeps only the planned size and its route's digest.
      def checkpoint
        return if @source.nil? || @source.path.nil?

        layout = @parts.map { |part| [ part.number, part.offset, part.bytesize, part.granted, part.fingerprint ] }
        plan = @route ? { mode: :local, route: @route, partsize: @part_size } : { mode: :api }
        Checkpoint.new(direction: :upload, path: @destination, local_path: @source.path, total_bytes: @source.size, completed_bytes: @accepted_bytes,
                       source: @source.identity,
                       state: { ref: @ref, params: checkpoint_params, planned_bytes: @planned_bytes, file_cap: @file_cap, layout: layout, etags: @accepted.dup,
                                plan: plan }
        )
      end

      def checkpoint_params
        @params.slice(*CHECKPOINT_PARAMS).select { |_, value| value == true || value == false || value.is_a?(Integer) }
      end

      # A digest of what a part's instructions bind it to, without its URL: a renewal must give the same one. Its size is
      # the planned one, so a part the upload sized itself is not bound to the size the API recommends.
      def fingerprint(grant)
        Digest::SHA256.hexdigest(JSON.generate([ grant.ref, grant.number, planned_size(grant), grant.http_method, grant.headers.sort, grant.retry, grant.parallel ]))
      end

      # The size of a grant's part, but the last: the API's partsize, or the upload's own when it plans them.
      def planned_size(grant)
        @route ? @part_size : grant.partsize
      end

      def plan
        renew_parts
        request_grants while @stop.nil? && more_needed?
        read_parts
      rescue StandardError => e
        stop!(e)
      end

      def more_source?
        @planned_bytes < @source.size || (@source.size.zero? && @parts.empty?)
      end

      def more_needed?
        more_source? && @queue.size < (@controller ? @controller.limit : 1)
      end

      def wants_planning?
        !@renewals.empty? || more_needed? || readable?
      end

      # With the lock held: whether the next part of a caller's stream can be read now, all it may need held.
      def readable?
        part = @source.path.nil? && @parts[@next_read]
        part ? @job.budget.available?(reservation_bytes(part)) : false
      end

      # From a caller's stream: reads the next parts' bytes, in order, each only once the buffer budget holds all it may
      # need (reservation_bytes). Once read_next has returned, and with it every String of the reads it no longer keeps,
      # the part gives back all but what it holds (held_bytes).
      def read_parts
        while @stop.nil? && (part = @source.path.nil? && @parts[@next_read])
          bytes = reservation_bytes(part)
          reserved = @job.synchronize { @job.budget.available?(bytes) && (part.reservation = @job.budget.reserve(bytes)) }
          break unless reserved

          @next_read += 1
          part.data = @source.read_next(part.offset, part.bytesize, whole: @transport.serialized?)
          @job.post { @job.budget.shrink(part.reservation, held_bytes(part)) }
        end
      end

      # What a caller's stream's part holds once read: its bytes, and, kept in pieces for the job's own transport, the
      # slice Segments sends them through.
      def held_bytes(part)
        part.data.is_a?(Array) ? part.bytesize + [ part.bytesize, STREAM_BUFFER_BYTES ].min : part.bytesize
      end

      # Each part of a caller's stream is sent only once its bytes are read.
      def ready?(part)
        !@source.path.nil? || !part.data.nil?
      end

      def finished?
        !more_source? && @accepted.size == @parts.size
      end

      def request_grants
        first = (@parts.last&.number || 0) + 1
        uploads = begin_upload(first, Policy::UPLOAD_BATCH_PARTS)
        choose_plan(uploads, first) if @ref.nil?
        uploads.each_with_index do |upload, index|
          break unless more_source?

          grant = grant_from(upload, first + index)
          raise changed_instructions unless grant.route == @route

          remaining = @source.size - @planned_bytes
          size = planned_size(grant)
          raise invalid_instructions if size.zero? && remaining.positive?

          part = Part.new(number: grant.number, offset: @planned_bytes, bytesize: [ size, remaining ].min, granted: size, grant: grant,
                          fingerprint: fingerprint(grant), attempts: 0, renewals: 0, ready_at: 0
          )
          @job.budget.check!(reservation_bytes(part))
          @parts << part
          @planned_bytes += part.bytesize
          enqueue(part)
        end
      end

      # Renews the URLs of the parts that found theirs expired, before they are sent or after (renewals settle allowed
      # as retries). A part whose renewals still give an expired URL stops the upload unsent. A part keeps the bytes
      # it holds while it renews.
      def renew_parts
        while @stop.nil? && (part = @renewals.shift)
          if part.renewals >= RENEWALS
            fail_item(part, Files::APIError.new("Transfer request failed", http_status: 403))
            next
          end
          part.renewals += 1
          grant = grant_from(begin_upload(part.number, 1).first, part.number)
          unless grant.route == @route && planned_size(grant) == part.granted && fingerprint(grant) == part.fingerprint
            fail_item(part, Files::APIError.new("The renewed upload instructions changed"))
            next
          end
          part.grant = grant
          part.ready_at = 0
          enqueue(part)
        end
      end

      def begin_upload(first, count)
        result = Files::File.begin_upload(@destination, @params.merge(ref: @ref, parts: count, part: first, with_direct_connection_info: true), @options)
        grants = result.is_a?(Array) ? result : [ result ]
        raise invalid_instructions if grants.empty?

        adopt_context(grants.first)
        grants
      end

      def grant_from(upload, number)
        attributes = upload.respond_to?(:attributes) && upload.attributes.is_a?(Hash) ? upload.attributes : {}
        ref = upload.ref
        size = upload.partsize
        method = upload.http_method.to_s.upcase
        url = upload.upload_uri
        headers = attributes[:headers] || {}
        valid = ref.is_a?(String) && !ref.empty? && (@ref.nil? || ref == @ref) && upload.part_number == number &&
                size.is_a?(Integer) && size >= 0 && %w[PUT POST].include?(method) && http_url?(url) &&
                headers.is_a?(Hash) && headers.all? { |name, value| (name.is_a?(String) || name.is_a?(Symbol)) && value.is_a?(String) }
        raise invalid_instructions unless valid

        @ref ||= ref
        grant = Grant.new(ref: ref, number: number, partsize: size, http_method: method, url: url, headers: headers.transform_keys(&:to_s).freeze,
                          expires_at: StorageRetry.expires_at(url, attributes[:expires]), retry: attributes[:retry_parts] != false,
                          parallel: attributes[:parallel_parts] != false, direct: direct_server(attributes[:direct_connection_info]),
                          route: (UploadPlan.route(upload, number) if @route)
        )
        bind(grant) unless @controller
        @file_cap = 1 unless grant.parallel
        grant
      end

      # The direct server a valid version 1 direct_connection_info names, or nil.
      def direct_server(info)
        return unless info.is_a?(Hash)

        info = info.transform_keys(&:to_s)
        addresses = info["addresses"]
        valid = info["version"] == 1 && text?(info["server_name"]) && addresses.is_a?(Array) && !addresses.empty? &&
                addresses.all? { |address| text?(address) } && http_url?(info["direct_uri"]) && text?(info["ca_pem"]) &&
                info["ca_pem"].include?("BEGIN CERTIFICATE")
        info["server_name"] if valid
      end

      def bind(grant)
        host = ::URI.parse(grant.url).host
        options = @job.options
        key, policy = if @transport.serialized?
                        [ [ :upload, :client, @client.object_id ], Policy.fixed(1) ]
                      elsif !options.automatic?
                        [ [ :upload, :fixed, grant.direct || host ], Policy.fixed(options.concurrency) ]
                      elsif grant.direct
                        [ [ :upload, :direct, grant.direct ], Policy.direct_upload(max_concurrency: options.max_concurrency) ]
                      else
                        [ [ :upload, :storage, host ], Policy.storage_upload(startup: options.startup, max_concurrency: options.max_concurrency) ]
                      end
        @controller = @job.synchronize { @job.controller(key) { policy } }
      end

      def item_cap
        @file_cap
      end

      # A part read whole first holds all of its bytes.
      def whole_parts?
        @transport.serialized? || @source.path.nil?
      end

      # The bytes a part reserves before anything of it is read: a 64 KiB slice for a file's part streamed over the
      # job's own connections, and all its bytes for a part read whole. A caller's stream's part also reserves what
      # reading it may take besides, given back once it is read unless it still holds it (held_bytes): over the job's
      # own connections, the slice its pieces are sent through; for a caller's client, which takes it as one String,
      # its bytes again, for the String its pieces are copied into while a read's own String is still held.
      def reservation_bytes(part)
        return [ part.bytesize, STREAM_BUFFER_BYTES ].min unless whole_parts?
        return part.bytesize unless @source.path.nil?

        part.bytesize + (@transport.serialized? ? part.bytesize : [ part.bytesize, STREAM_BUFFER_BYTES ].min)
      end

      # The largest part buffer_bytes holds as reservation_bytes reserves it: any, for a file's part streamed over the
      # job's own connections.
      def largest_part
        limit = @job.budget.limit
        return Float::INFINITY unless whole_parts?
        return limit unless @source.path.nil?

        @transport.serialized? ? limit / 2 : limit - STREAM_BUFFER_BYTES
      end

      # From the API's first answer for the upload (uploads, from part first), before any of its parts: the upload plans
      # its own part sizes when every part the answer gives is for one and the same route and UploadPlan can plan the
      # file's size in the parts available, as the first part names them, no larger than buffer_bytes holds unless the
      # plan needs it to be (largest_part). Otherwise, and for an empty file, the API chooses them. A file no plan could
      # send within buffer_bytes is refused here (UploadPlan.part_size), before the upload keeps a size, a route or the
      # answer's reference, so a pause that came before the refusal leaves a checkpoint that plans afresh as it resumes.
      # Each choice starts from no plan, so one a resume makes, from a checkpoint paused before any reference, keeps
      # nothing of the plan it restored: however the choice ends, the upload has a route and a size together, or neither.
      def choose_plan(uploads, first)
        @route = @part_size = nil
        routes = uploads.each_with_index.map { |upload, index| UploadPlan.route(upload, first + index) }
        return unless @source.size.positive? && routes.first && routes.uniq.size == 1

        @part_size = UploadPlan.part_size(@source.size, uploads.first.attributes[:available_parts], largest_part)
        @route = routes.first if @part_size
      end

      # An expired URL is never sent; renew_parts stops the upload once a part's renewals run out.
      def expiring?(part)
        StorageRetry.expired?(part.grant.expires_at)
      end

      # The part's URL, with the grant it came from.
      def request_target(part)
        [ part.grant.url, part.grant ].freeze
      end

      def retry_allowed?(part)
        part.grant.retry
      end

      # On a worker thread, under the grant the part was admitted with (target). A caller's stream's part sends the
      # bytes it holds; a file's part is read before the send through a caller's client, or as it streams otherwise.
      # timing starts with the send.
      def attempt_item(part, target, connections, timing = nil)
        grant = target[1]
        @source.check!
        headers = { "Content-Type" => "application/octet-stream" }.merge(grant.headers)
        declared = headers.find { |name, _| name.casecmp?("content-length") }&.last
        return [ :fail, invalid_instructions ] if declared && declared != part.bytesize.to_s

        headers.delete_if { |name, _| name.casecmp?("content-length") }
        headers["Content-Length"] = part.bytesize.to_s
        body = if part.bytesize.zero?
                 String.new
               elsif @source.path.nil?
                 part.data.is_a?(Array) ? Segments.new(part.data) : part.data
               elsif whole_parts?
                 @source.read(part.offset, part.bytesize)
               else
                 Region.new(@source, part.offset, part.bytesize)
               end
        acknowledge(part, grant, @transport.perform(grant.http_method, grant.url, headers, connections, body: body, length: part.bytesize, timing: timing))
      end

      def acknowledge(part, grant, response)
        if response.status.between?(200, 299)
          etags = response.headers.fetch("etag", [])
          etag = etags.first.to_s.strip
          return [ :ok, etags.first, part.bytesize ] if etags.size == 1 && !etag.empty? && !etag.match?(/"\s*,\s*(?:W\/)?"/)

          return [ :fail, Files::APIError.new(ACK_FAILURE, http_status: response.status) ]
        end
        return [ :renew, refused(response) ] if response.status == 403 && StorageRetry.expired?(grant.expires_at)

        decision, delay = StorageRetry.classify(response.status, response.headers, response.body, truncated: response.truncated)
        case decision
        when :throttle then [ :retry, delay, :throttle, refused(response) ]
        when :retry then [ :retry, delay, :failure, refused(response) ]
        else [ :fail, refused(response) ]
        end
      end

      # With the lock held: records an acknowledged part once, drops the bytes it held, and returns its progress report:
      # total_bytes, acknowledged_bytes (every part acknowledged, a resumed upload's before its pause included),
      # part_number, part_bytes, elapsed_seconds of this call and bytes_per_second, the bytes this call acknowledged
      # over them, each part once however often it was sent, and 0.0 before any time has passed.
      def accept(part, etag)
        discard(part)
        return if @accepted.key?(part.number)

        @accepted[part.number] = etag
        @accepted_bytes += part.bytesize
        @job.count_accepted(part.bytesize)
        elapsed = Clock.now - @started_at
        { total_bytes: @source.size, acknowledged_bytes: @accepted_bytes, part_number: part.number, part_bytes: part.bytesize, elapsed_seconds: elapsed,
          bytes_per_second: elapsed.positive? ? (@accepted_bytes - @start_accepted) / elapsed : 0.0 }
      end

      # On the caller's thread. Nothing is reported after a failure or a cancellation.
      def deliver(reports)
        return unless @progress

        reports.each do |report|
          break unless @stop.nil? || @stop == :paused

          @progress.call(report)
        end
      rescue StandardError => e
        stop!(e)
      end

      def all_items
        @parts
      end

      def public_error(error)
        return Files::APIConnectionError.new("Transfer request failed (#{error.original.class})") if error.is_a?(NetworkFailure)

        error
      end

      def refused(response)
        Files::APIError.new("Transfer request failed", http_status: response.status)
      end

      def invalid_instructions
        Files::APIError.new("The upload instructions the API returned are not usable")
      end

      # For a later part of an upload planning its own part sizes that is not for its route.
      def changed_instructions
        Files::APIError.new("The upload instructions changed during the upload")
      end

      def http_url?(url)
        url.is_a?(String) && %w[http https].include?(::URI.parse(url).scheme)
      rescue ::URI::InvalidURIError
        false
      end

      def text?(value)
        value.is_a?(String) && !value.strip.empty?
      end
    end
  end
end
