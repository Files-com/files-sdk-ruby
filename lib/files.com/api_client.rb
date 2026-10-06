# frozen_string_literal: true

module Files
  class ApiClient
    attr_accessor :conn

    def initialize(conn = nil)
      self.conn = conn || self.class.default_conn
      @system_profiler = SystemProfiler.new
      @last_request_metrics = nil
    end

    def self.active_client
      Thread.current[:files_api_client] || default_client
    end

    # net_http_persistent does not support streaming downloads with faraday when directly downloading from S3
    # falling back to net_http.
    def self.download_client
      Thread.current[:files_api_client_download_client] ||= ApiClient.new(download_conn)
    end

    def self.download_conn
      Thread.current[:files_api_client_download_conn] ||= build_default_conn(force_net_http: true)
    end

    def self.default_client
      Thread.current[:files_api_client_default_client] ||= ApiClient.new(default_conn)
    end

    def self.default_conn
      Thread.current[:files_api_client_default_conn] ||= build_default_conn
    end

    def self.build_default_conn(force_net_http: false)
      conn = Faraday.new do |builder|
        if Gem::Version.new(Faraday::VERSION) < Gem::Version.new("2.0.0") && defined?(Faraday::Request::Multipart)
          begin
            # Raise LoadError if not available in Faraday version 1.x
            Faraday::Request::Multipart # rubocop:disable Lint/Void
            builder.use Faraday::Request::Multipart
          rescue LoadError
            builder.request :multipart
          end
        else
          builder.request :multipart
        end
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::RaiseError

        if Gem.win_platform? || RUBY_PLATFORM == "java" || force_net_http
          builder.adapter :net_http
        else
          builder.adapter :net_http_persistent
        end
      end

      conn.proxy = Files.proxy if Files.proxy
      conn.ssl.verify = true

      conn
    end

    def self.should_retry?(error, num_retries)
      return false if num_retries >= Files.max_network_retries
      return true if error.is_a?(Faraday::TimeoutError)
      return true if error.is_a?(Faraday::ConnectionFailed)
      return true if error.is_a?(Faraday::ServerError)
      return true if error.is_a?(Faraday::ClientError) and error.response_status == 405

      false
    end

    def self.sleep_time(num_retries)
      sleep_seconds = [
        Files.initial_network_retry_delay * (2**(num_retries - 1)),
        Files.max_network_retry_delay
      ].min
      sleep_seconds *= (0.5 * (1 + rand))
      [ Files.initial_network_retry_delay, sleep_seconds ].max
    end

    def request
      @last_response = nil
      old_files_api_client = Thread.current[:files_api_client]
      Thread.current[:files_api_client] = self

      begin
        res = yield
        [ res, @last_response ]
      ensure
        Thread.current[:files_api_client] = old_files_api_client
      end
    end

    def execute_request(method, path, base_url: nil, api_key: nil, session_id: nil, workspace_id: nil, headers: {}, params: {})
      base_url ||= Files.base_url
      if api_key.nil?
        session_id ||= Files.session_id
      else
        session_id = nil
      end
      workspace_id = Files.workspace_id if workspace_id.nil?

      if session_id and session_id != ""
        check_session_id!(session_id)
      elsif path !~ /^\/sessions/ # TODO: automate this to refer to any unauthenticated endpoint
        api_key ||= Files.api_key
        check_api_key!(api_key)
      end

      body = nil
      query_params = nil
      case method.to_s.downcase.to_sym
      when :get, :head, :delete
        query_params = params
      else
        body = params
      end

      headers = request_headers(api_key, session_id, method, workspace_id).update(headers)
      url = api_url(path, base_url)

      context = RequestLogContext.new
      context.api_key      = api_key
      context.body         = body
      context.method       = method
      context.path         = path
      context.query_params = query_params if query_params
      context.session_id   = session_id

      http_resp = execute_request_with_rescues(base_url, context) do
        conn.run_request(method, url, body, headers) do |req|
          req.options.open_timeout = Files.open_timeout
          req.options.timeout = Files.read_timeout
          req.params = query_params unless query_params.nil?
        end
      end

      begin
        resp = Response.from_faraday_response(http_resp)
      rescue JSON::ParserError
        raise unreadable_response_error(http_resp), cause: nil
      end

      @last_response = resp
      [ resp, api_key, session_id ]
    end

    def remote_request(method, url, headers = {}, body = nil)
      context = RequestLogContext.new
      context.method       = method
      context.path         = "[transfer]"
      Util.log_debug("Transfer request", method: method, url: url)

      execute_request_with_rescues(Files.base_url, context, skip_body_logging: true, is_transfer: true) do
        conn.run_request(method, url, body, headers) do |req|
          req.options.open_timeout = Files.open_timeout
          req.options.timeout = Files.read_timeout
          yield(req) if block_given?
        end
      end
    end

    def stream_download(uri, io, range)
      if conn.adapter == Faraday::Adapter::NetHttp
        stream_download_with_net_http(URI(uri), io, range)
      else
        response = remote_request(:get, uri)
        io.fulfill_content_length(response.content_length) if io.respond_to?(:fulfill_content_length)
        io.write(response.body)
      end
    end

    # Writes the body of a signed transfer URL to io as it arrives.
    #
    # Any failure while the response is open is raised only after Net::HTTP has
    # let go of the connection. The Net::HTTP bundled with Ruby 3.0 retries a GET
    # when an IOError or EOFError escapes the response block, which would write
    # the body into io a second time.
    private def stream_download_with_net_http(uri, io, range)
      request = Net::HTTP::Get.new(uri)
      request["Range"] = "bytes=#{range[0]}-#{range[1]}" unless range.empty?

      failure = nil
      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(request) do |response|
          write_download_body(response, io)
        rescue StandardError => e
          failure = e
          break
        end
      end
      raise failure if failure
    end

    private def write_download_body(response, io)
      reject_unsuccessful_download(response, io)
      io.fulfill_content_length(response.content_length) if io.respond_to?(:fulfill_content_length)

      expected_bytes = expected_download_bytes(response)
      received_bytes = 0
      response.read_body do |chunk|
        io.ready! if io.respond_to?(:ready!)
        write_download_chunk(io, chunk)
        received_bytes += chunk.bytesize
      end
      return if expected_bytes.nil? || received_bytes == expected_bytes

      raise EOFError, "Transfer response ended after #{received_bytes} of #{expected_bytes} bytes"
    end

    # How many bytes read_body must yield, when the response says. Content-Length
    # counts bytes on the wire, which read_body yields unchanged unless the body is
    # chunked or Net::HTTP decompresses it. Net::HTTP quietly accepts a
    # fixed-length body that stops short, and the version bundled with Ruby 3.0
    # has no ignore_eof= to change that, so write_download_body counts the bytes.
    private def expected_download_bytes(response)
      response.content_length unless response.chunked? || decompressed_by_net_http?(response)
    end

    # Net::HTTP decompresses a gzip or deflate body as it reads it, but never a
    # range. Ask before reading: decompressing removes the Content-Encoding.
    private def decompressed_by_net_http?(response)
      response.decode_content && !response.key?("content-range") &&
      %w[gzip x-gzip deflate].include?(response["content-encoding"]&.downcase)
    end

    private def reject_unsuccessful_download(response, io)
      response.error! unless response.is_a?(Net::HTTPSuccess)
    rescue Net::HTTPExceptions => e
      close_destination_after_failure(io, e)
      raise
    end

    private def write_download_chunk(io, chunk)
      io << chunk
    rescue StandardError => e
      close_destination_after_failure(io, e)
      raise
    end

    # A refused transfer or a failing destination closes the destination, as it
    # always has. Connection failures and short bodies leave it open so the caller
    # can retry. Pipe readers learn why the download failed before the pipe
    # closes, and a failure to close never replaces the download's own error.
    private def close_destination_after_failure(io, failure)
      io.do_set_error(failure) if io.respond_to?(:do_set_error)
      io.close
    rescue StandardError => e
      Util.log_debug("Download destination close error", error_type: e.class, error_message: e.message)
    end

    def cursor
      @last_response.http_headers["x-files-cursor"]
    end

    private def api_url(url = "", base_url = nil)
      uri        = Addressable::URI.new
      uri.host   = Addressable::URI.parse(base_url).host
      uri.port   = Addressable::URI.parse(base_url).port
      uri.path   = "/api/rest/v1#{Files::URI.normalized_path(url)}"
      uri.scheme = Addressable::URI.parse(base_url).scheme

      uri.to_s
    end

    private def check_api_key!(api_key)
      raise AuthenticationError, "No Files.com API key provided. Set your API key using \"Files.api_key = <API-KEY>\". You can generate API keys from the Files.com's web interface. " unless api_key
      raise AuthenticationError, "Your API key must be a string" unless api_key.is_a?(String)

      return unless api_key =~ /\s/

      raise AuthenticationError, "Your API key is invalid (it contains whitespace)"
    end

    private def check_session_id!(session_id)
      return unless session_id =~ /\s/

      raise AuthenticationError, "The provided Session ID is invalid (it contains whitespace)"
    end

    def execute_request_with_rescues(base_url, context, skip_body_logging: false, is_transfer: false)
      num_retries = 0
      begin
        request_start = Time.now
        log_request(context, num_retries, no_body: skip_body_logging)
        resp = yield
        log_response(context, request_start, resp.status, resp.body, no_body: skip_body_logging)
      rescue StandardError => e
        error_context = context

        if e.respond_to?(:response) && e.response
          error_context = context
          log_response(error_context, request_start,
                       e.response[:status], e.response[:body], no_body: skip_body_logging
          )
        else
          log_response_error(error_context, request_start, e)
        end

        if self.class.should_retry?(e, num_retries)
          num_retries += 1
          sleep self.class.sleep_time(num_retries)
          retry
        end

        Util.log_debug("Transfer error details", error_message: e.message) if is_transfer

        case e
        when Faraday::ClientError, Faraday::ServerError
          if (error_response = api_error_response(e.response))
            handle_error_response(error_response, error_context, is_transfer: is_transfer)
          else
            handle_network_error(e, error_context, num_retries, base_url, is_transfer: is_transfer)
          end
        else
          raise e.exception("Transfer request failed (#{e.class})"), cause: nil if is_transfer

          raise
        end
      end

      resp
    end

    # A successful response whose body is not JSON gave the SDK no usable
    # answer. The body stays available as http_body but is left out of the
    # message, and the parser error, which quotes it, is not kept as the cause.
    private def unreadable_response_error(http_resp)
      APIConnectionError.new("The Files.com API returned a response that is not valid JSON (HTTP response code was #{http_resp.status})",
        http_status: http_resp.status, http_headers: http_resp.headers, http_body: http_resp.body
      )
    end

    private def format_app_info(info)
      str = info[:name]
      str = "#{str}/#{info[:version]}" unless info[:version].nil?
      str = "#{str} (#{info[:url]})" unless info[:url].nil?
      str
    end

    # A failed response carrying a Files.com error object: a JSON object with an
    # error message or type. Any other body, JSON or not, is not an answer the
    # SDK can use.
    private def api_error_response(http_resp)
      return unless http_resp

      resp = Response.from_faraday_hash(http_resp)
      error_object = resp.data
      resp if error_object.is_a?(Hash) && (error_object[:error] || error_object[:errors] || error_object[:type])
    rescue JSON::ParserError
      nil
    end

    private def handle_error_response(resp, context, is_transfer: false)
      error = specific_api_error(resp, context, is_transfer: is_transfer)

      error.response = resp
      raise error, cause: nil if is_transfer

      raise error
    end

    private def specific_api_error(resp, _context, is_transfer: false)
      error_data = error_details(resp.data)
      message = if is_transfer
                  "Transfer request failed"
                elsif error_data[:message].is_a?(String)
                  without_url_credentials(error_data[:message])
                else
                  "The Files.com API returned an error without a message (HTTP response code was #{resp.http_status})"
                end
      Util.log_error("API error", status: resp.http_status, error_message: message)

      api_error_class(resp.data[:type]).new(message,
        http_body: resp.http_body,
        http_headers: resp.http_headers,
        http_status: resp.http_status,
        json_body: resp.data,
        code: error_data[:code] || resp.http_status
      )
    end

    # Where a scheme-qualified URL starts. A scheme begins at the first letter of
    # a run of scheme characters, and only a run's first character can start
    # one, so each run is read a bounded number of times however long it is.
    URL_START = /(?<![a-z0-9+.-])[0-9+.-]*+[a-z][a-z0-9+.-]*+:\/\//i
    private_constant :URL_START

    # A URL in server text, with the apostrophe that opens it if it is quoted.
    # Before its query or fragment, a URL ends at whitespace, a character that
    # cannot appear in a URL, or where the next URL starts, so each URL in a
    # list is redacted on its own. Apostrophes can appear in a URL, so they stay
    # part of it. A query or fragment runs to the end of the text around it.
    URL_IN_TEXT = /(?<opening>'?)(?<url>#{URL_START}(?:(?!'?#{URL_START})[^\s"<>?#])*+(?:[?#][^\s"<>]*)?)/i
    private_constant :URL_IN_TEXT

    # Server text can quote a URL whose user info, query or fragment is a
    # credential, such as a signed transfer URL. Error messages and logs below
    # DEBUG keep where the URL points and drop those parts; the raw response
    # fields keep them.
    private def without_url_credentials(text)
      text.gsub(URL_IN_TEXT) do
        opening, url = Regexp.last_match.captures
        closing = opening.empty? ? "" : closing_quote(url)
        "#{opening}#{without_credentials(url.delete_suffix(closing))}#{closing}"
      end
    end

    # The apostrophe that closes a URL quoted with apostrophes, with any
    # punctuation after it, or "" when the URL does not end that way.
    private def closing_quote(url)
      quote = url.rindex("'")
      quote && url[quote..].match?(/\A'[.,;:!?)]*\z/) ? url[quote..] : ""
    end

    # The authority, which may be empty, ends at the first "/", "?" or "#";
    # only an "@" inside it marks user info.
    private def without_credentials(url)
      scheme, _, rest = url.partition("://")
      authority, separator, path = rest.partition(/[\/?#]/)
      authority = "[redacted]@#{authority.rpartition('@').last}" if authority.include?("@")
      path = "#{separator}#{path}"
      credentials_at = path.index(/[?#]/)
      path = "#{path[0...credentials_at]}?[redacted]" if credentials_at
      "#{scheme}://#{authority}#{path}"
    end

    # The message and code in an error object's "error" or "errors" field, which
    # holds a message, an object with a message and code, or a list of either.
    private def error_details(error_object)
      details = error_object[:error] || error_object[:errors]
      details = details.first if details.is_a?(Array)
      details = { message: details } if details.is_a?(String)
      details.is_a?(Hash) ? details : {}
    end

    # The APIError subclass an error type names, such as NotFoundError for
    # "not-found" or LockoutRegionMismatchError for
    # "not-authenticated/lockout-region-mismatch". Any other type is an APIError.
    private def api_error_class(type)
      return APIError unless type.is_a?(String)

      name = type.split("/").last.to_s.split("-").map(&:capitalize).join
      error_class = Files.const_get("#{name}Error", false)
      error_class.is_a?(Class) && error_class < APIError ? error_class : APIError
    rescue NameError
      APIError
    end

    private def handle_network_error(error, _context, num_retries, base_url = nil, is_transfer: false)
      base_url ||= Files.base_url

      error_message = if is_transfer
                        error.class.name
                      else
                        error.message.empty? ? error.response[:body] : error.message
                      end

      Util.log_error("Network error", error_message: error_message)
      message = "Could not connect to Files.com at URL #{base_url}. Please check your internet connection and try again. If this problem persists, you should check Files.com's service status at https://status.files.com, or contact your primary account representative."
      message += " Request was retried #{num_retries} times." if num_retries > 0
      message += "\n\n(Network error: #{error_message})"

      raise APIConnectionError, message, cause: nil if is_transfer

      raise APIConnectionError, message
    end

    private def request_headers(api_key, session_id, _method, workspace_id)
      user_agent = "Files.com Ruby SDK v#{Files::VERSION}"
      user_agent += " #{format_app_info(Files.app_info)}" unless Files.app_info.nil?

      headers = {
        "User-Agent" => user_agent,
        "Content-Type" => "application/x-www-form-urlencoded",
      }

      if Files.default_headers.is_a?(Proc)
        proc_headers = Files.default_headers.call
        headers.merge!(proc_headers) if proc_headers.is_a?(Hash)
      end

      headers.merge!(Files.default_headers) if Files.default_headers.is_a?(Hash)

      headers["X-FilesAPI-Key"] = api_key if api_key
      headers["X-FilesAPI-Auth"] = session_id if session_id
      headers["Accept-Language"] = Files.language if Files.language
      workspace_id = workspace_id.to_s
      headers["X-Files-Workspace-Id"] = workspace_id unless workspace_id.empty?

      user_agent = @system_profiler.user_agent
      begin
        headers.update("X-Files-Client-User-Agent" => JSON.generate(user_agent))
      rescue StandardError => e
        headers.update(
          "X-Files-Client-Raw-User-Agent" => user_agent.inspect,
          error: "#{e} (#{e.class})"
        )
      end

      headers
    end

    private def log_request(context, num_retries, no_body: false)
      Util.log_info("Request", method: context.method, num_retries: num_retries, path: context.path)
      Util.log_debug("Request details", body: context.body, query_params: context.query_params) unless no_body
    end

    private def log_response(context, request_start, status, body, no_body: false)
      Util.log_info("Response", elapsed: Time.now - request_start, method: context.method, path: context.path, status: status)
      Util.log_debug("Response details", body: body) unless no_body
    end

    private def log_response_error(context, request_start, error)
      Util.log_error("Error", elapsed: Time.now - request_start, error_type: error.class, method: context.method, path: context.path)
      Util.log_debug("Error details", error_message: error.message)
    end

    class RequestLogContext
      attr_accessor :body, :api_key, :method, :path, :query_params, :session_id
    end
  end
end
