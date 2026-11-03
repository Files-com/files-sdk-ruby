# frozen_string_literal: true

module Files
  module Transfer
    # A storage response: its status, its headers as lowercase names each with its values, and its body: what the
    # success handler returned, or at most the first 64 KiB of any other response, with truncated true when that
    # response had more.
    StorageResponse = Struct.new(:status, :headers, :body, :truncated, keyword_init: true) do
      def header(name)
        headers.fetch(name, []).first
      end
    end

    # Sends a job's content requests with Net::HTTP over connections each worker thread owns, reused for its next
    # request to the same origin. It never follows a redirect or retries by itself, verifies TLS certificates and host
    # names, and uses Files.proxy, or the proxy environment variables without it, with Files.open_timeout and
    # Files.read_timeout (for each read and each write) as they were when the job began. It carries no Files.com
    # credentials: a signed URL is its own authority.
    class HttpTransport
      ERROR_BODY_BYTES = 64 * 1024
      KEEP_ALIVE_SECONDS = 30
      RETRYABLE_ERRORS = [ IOError, SystemCallError, SocketError, Timeout::Error, Net::ProtocolError, Net::HTTPBadResponse ].freeze

      # Whether client sends requests just as this transport does: the SDK's own ApiClient with no request handling or
      # logging of its own (ApiClient#default_transfer_behavior?), over a connection ApiClient.build_default_conn made
      # with this transport's own proxy, its user and password included, or, as this transport, with none, and with
      # nothing about it changed since (ApiClient.unchanged_default_conn?). Any other client, such as one made after
      # Files.proxy changed, keeps its connection and its settings, such as a minimum TLS version, an adapter
      # configuration block or its proxy, its remote_request and its logging for the transfer, one request at a time,
      # through ClientTransport.
      def compatible?(client)
        return false unless client.respond_to?(:default_transfer_behavior?) && client.default_transfer_behavior?

        ApiClient.unchanged_default_conn?(client.conn, @proxy_identity)
      end

      def initialize
        proxy = Files.proxy
        @proxy_identity = ApiClient.proxy_identity(proxy)
        @proxy = @proxy_identity && Faraday::ProxyOptions.from(proxy)
        @open_timeout = Files.open_timeout
        @read_timeout = Files.read_timeout
      end

      def serialized?
        false
      end

      # Sends one request on the calling thread over its connections, a Hash that thread owns, and returns its
      # StorageResponse. body is a String, or an object whose read(length, buffer) gives length bytes in all, streamed
      # without holding them. With a block, a 2xx response is passed to it with its body unread, and what it returns is
      # the response's body; the block reads it as it arrives. An error from the block is raised as it is, unless it is a
      # network error, which is raised, as one before the response, as a NetworkFailure. timing, when given, is told as
      # the send starts (connection setup included), as the response headers arrive, and once the block, or the read of
      # any other response's body, has finished.
      def perform(method, url, headers, connections, body: nil, length: nil, timing: nil, &on_success)
        uri = ::URI.parse(url)
        request = Net::HTTPGenericRequest.new(method.to_s.upcase, !body.nil?, true, uri.request_uri, headers)
        if body.is_a?(String)
          request.body = body
        elsif body
          request.body_stream = body
          request.content_length = length
        end
        result = nil
        timing&.sending
        connection(uri, connections).request(request) do |response|
          timing&.headers
          kept, truncated = on_success && response.is_a?(Net::HTTPSuccess) ? [ on_success.call(response), false ] : limited_body(response)
          timing&.body
          result = StorageResponse.new(status: response.code.to_i, headers: response.to_hash, body: kept, truncated: truncated)
        end
        result
      rescue OpenSSL::SSL::SSLError => e
        drop(connections, uri)
        raise NetworkFailure.new(e, retryable: false), cause: nil
      rescue *RETRYABLE_ERRORS => e
        drop(connections, uri)
        raise NetworkFailure.new(e), cause: nil
      end

      def close_all(connections)
        connections.each_value { |http| finish(http) }
        connections.clear
      end

      private def connection(uri, connections)
        key = [ uri.scheme, uri.hostname, uri.port ]
        http = connections[key]
        return http if http&.started?

        http = build_http(uri)
        http.start
        connections[key] = http
      end

      private def build_http(uri)
        http = if @proxy
                 Net::HTTP.new(uri.hostname, uri.port, @proxy.uri.hostname, @proxy.uri.port, @proxy.user, @proxy.password)
               else
                 Net::HTTP.new(uri.hostname, uri.port)
               end
        http.use_ssl = uri.scheme == "https"
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER if http.use_ssl?
        http.open_timeout = @open_timeout
        http.read_timeout = @read_timeout
        http.write_timeout = @read_timeout
        http.max_retries = 0
        http.keep_alive_timeout = KEEP_ALIVE_SECONDS
        http
      end

      # The first ERROR_BODY_BYTES of a response's body, which is read to its end, and whether it had more.
      private def limited_body(response)
        kept = String.new(encoding: Encoding::BINARY)
        truncated = false
        response.read_body do |chunk|
          room = ERROR_BODY_BYTES - kept.bytesize
          truncated ||= chunk.bytesize > room
          kept << chunk.byteslice(0, room) if room.positive?
        end
        [ kept, truncated ]
      end

      private def drop(connections, uri)
        finish(connections.delete([ uri.scheme, uri.hostname, uri.port ])) if uri
      end

      private def finish(http)
        http.finish if http&.started?
      rescue IOError, SystemCallError
        nil
      end
    end

    # Sends a transfer's content requests through the caller's own client, which HttpTransport cannot stand in for:
    # one with its own adapter, middleware, request handling (an overridden remote_request), logger, or connection
    # settings, such as a minimum TLS version or an adapter configuration block. Each request goes through the client's
    # remote_request exactly once (ApiClient.single_attempt), so the client's hooks, logging, settings and errors still
    # apply while every retry stays the transfer's own, counted and admitted like any other. It sends one request at a
    # time, since such a client may not be safe to share between threads, and whole-String bodies, since its adapter
    # may not stream them.
    #
    # A response a success handler reads is streamed to it as it arrives, through Faraday's on_data, so nothing of it is
    # held here beyond what the handler keeps; any other response keeps its first 64 KiB, and says whether it had more.
    # The handler runs in a Fiber of its own, with the client ApiClient#request made active for the thread that sent the
    # request, so what it calls, such as a caller's progress callback, makes its SDK calls with it. A download relies
    # on that streaming, so
    # it goes through a client only when the client's adapter is one that streams (streams?), and refuses any other
    # before it requests or writes anything; an upload's responses are small, and any adapter carries them. A 2xx
    # response such an adapter still read whole is refused, never handed on. A body shorter than its headers said is a
    # network failure, as through HttpTransport. The job's diagnostics say when a transfer uses it.
    class ClientTransport
      # The adapters a download relies on to stream: as their pinned versions, faraday-net_http 3.0 and
      # faraday-net_http_persistent 2.1, do, each saves a response's status and headers in env, then hands on each chunk
      # of its body to on_data as Net::HTTP reads it, holding none of it, with any options or configuration block given.
      STREAMING_ADAPTERS = %w[Faraday::Adapter::NetHttp Faraday::Adapter::NetHttpPersistent].freeze
      NOT_STREAMING = "The download client's adapter cannot stream a response through Faraday's on_data, so an adaptive download " \
                      "cannot keep it within buffer_bytes; give the client Faraday's net_http or net_http_persistent adapter, or " \
                      "download without transfer:"
      ADAPTER_BUFFERED = "The download client's adapter did not stream the response through Faraday's on_data, so the transfer cannot " \
                         "keep it within buffer_bytes; give the client an adapter that streams, or download without transfer:"

      # Whether client's adapter is exactly one of STREAMING_ADAPTERS, so a download can go through it.
      def self.streams?(client)
        conn = client.respond_to?(:conn) ? client.conn : nil
        conn.is_a?(Faraday::Connection) && STREAMING_ADAPTERS.include?(conn.builder.adapter&.name)
      end

      # A streamed 2xx response the client hands over, given to a success handler as HttpTransport gives it a
      # Net::HTTPResponse; its body arrives through a Reader's Fiber.
      class ClientResponse
        attr_reader :code

        def initialize(status, headers)
          @code = status.to_s
          @headers = headers
        end

        def [](name)
          @headers.fetch(name.to_s.downcase, []).first
        end

        def key?(name)
          @headers.key?(name.to_s.downcase)
        end

        def to_hash
          @headers
        end

        def content_length
          value = self["content-length"]
          value&.match?(/\A\d+\z/) ? value.to_i : nil
        end

        def chunked?
          self["transfer-encoding"].to_s.downcase.include?("chunked")
        end

        def read_body
          while (chunk = Fiber.yield)
            yield chunk
          end
        end
      end

      # Faraday's on_data for one request. It runs a success handler in a Fiber that waits for each chunk as it arrives,
      # and keeps the first 64 KiB of any other response.
      class Reader
        def initialize(on_success, timing)
          @on_success = on_success
          @timing = timing
          @fiber = nil
          @result = nil
          @kept = String.new(encoding: Encoding::BINARY)
          @truncated = false
          @streamed = false
        end

        def streamed?
          @streamed
        end

        # Whether a response other than a success had more than the bytes kept.
        def truncated?
          @truncated
        end

        # A chunk, the bytes so far and, since Faraday 2.5, the request's env, which holds the response's status and
        # headers before its first chunk.
        def call(chunk, _received, env = nil)
          unless @streamed
            @streamed = true
            @timing&.headers
            raise BufferLimitError, ADAPTER_BUFFERED if env.nil? || env.status.nil?

            start(env.status.to_i, env.response_headers)
          end
          if @fiber
            @fiber.resume(chunk.b) if @fiber.alive? && !chunk.empty?
          else
            room = HttpTransport::ERROR_BODY_BYTES - @kept.bytesize
            @truncated ||= chunk.bytesize > room
            @kept << chunk.b.byteslice(0, room) if room.positive?
          end
        end

        # After the response: what the success handler returned once it read the end of the body, or the bytes kept.
        def result
          @fiber.resume(nil) while @fiber&.alive?
          @fiber ? @result : @kept
        end

        # The handler's Fiber would not see the client ApiClient#request made active on this thread, since Thread#[] is
        # per Fiber, so that client is made active in it too.
        private def start(status, headers)
          return unless status.between?(200, 299)

          response = ClientResponse.new(status, ClientTransport.names(headers))
          client = Thread.current[:files_api_client]
          @fiber = Fiber.new do
            Thread.current[:files_api_client] = client
            @result = @on_success.call(response)
          end
          @fiber.resume
        end
      end

      # Lowercase header names, each with its value; Faraday joins a repeated header's values with ", ".
      def self.names(headers)
        (headers || {}).each_with_object({}) { |(name, value), all| all[name.to_s.downcase] = [ value.to_s ] }
      end

      def initialize(client)
        @client = client
        @lock = Mutex.new
        @open_timeout = Files.open_timeout
        @read_timeout = Files.read_timeout
      end

      def serialized?
        true
      end

      # As HttpTransport#perform, through the client's remote_request.
      def perform(method, url, headers, _connections, body: nil, length: nil, timing: nil, &on_success)
        raise ArgumentError, "a client transfer sends a String body of #{length} bytes" unless body.nil? || body.is_a?(String)

        @lock.synchronize do
          reader = on_success && Reader.new(on_success, timing)
          timing&.sending
          begin
            response = ApiClient.single_attempt do
              @client.remote_request(method.to_s.downcase.to_sym, url, headers, body) do |request|
                request.options.open_timeout = @open_timeout
                request.options.timeout = @read_timeout
                request.options.on_data = reader.method(:call).to_proc if reader
              end
            end
            timing&.headers
            respond(reader, response.status, response.headers, response.body).tap { timing&.body }
          rescue Faraday::SSLError => e
            raise NetworkFailure.new(e, retryable: false), cause: nil
          rescue Faraday::Error => e
            raise NetworkFailure.new(e), cause: nil unless e.response

            timing&.headers
            respond(reader, e.response[:status], e.response[:headers], e.response[:body]).tap { timing&.body }
          end
        end
      rescue IOError => e
        raise NetworkFailure.new(e), cause: nil
      end

      def close_all(_connections); end

      # A success handler gets only a streamed body: a 2xx response the adapter read whole has already been held, so it
      # is refused rather than handed on. Any other response keeps its first 64 KiB, and says whether it had more.
      private def respond(reader, status, headers, body)
        names = ClientTransport.names(headers)
        status = status.to_i
        if reader&.streamed?
          kept = reader.result
          truncated = reader.truncated?
        elsif reader && status.between?(200, 299)
          raise BufferLimitError, ADAPTER_BUFFERED
        else
          body = body.to_s
          kept = body.byteslice(0, HttpTransport::ERROR_BODY_BYTES).b
          truncated = body.bytesize > HttpTransport::ERROR_BODY_BYTES
        end
        StorageResponse.new(status: status, headers: names, body: kept, truncated: truncated)
      end
    end
  end
end
