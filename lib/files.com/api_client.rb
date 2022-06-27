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
        if defined? Faraday::Request::Multipart
          builder.use Faraday::Request::Multipart
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

    def execute_request(method, path, base_url: nil, api_key: nil, session_id: nil, headers: {}, params: {})
      base_url ||= Files.base_url
      session_id ||= Files.session_id

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

      headers = request_headers(api_key, session_id, method).update(headers)
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
        raise general_api_error(http_resp.status, http_resp.body)
      end

      @last_response = resp
      [ resp, api_key, session_id ]
    end

    def remote_request(method, url, headers = {}, body = nil)
      context = RequestLogContext.new
      context.method       = method
      context.path         = url

      execute_request_with_rescues(Files.base_url, context, true) do
        conn.run_request(method, url, body, headers) do |req|
          req.options.open_timeout = Files.open_timeout
          req.options.timeout = Files.read_timeout
          yield(req) if block_given?
        end
      end
    end

    def stream_download(uri, io, range)
      if conn.adapter == Faraday::Adapter::NetHttp
        uri = URI(uri)
        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          request = Net::HTTP::Get.new uri
          request["RANGE"] = "bytes=#{range[0]}-#{range[1]}" unless range.empty?
          http.request request do |response|
            io.fulfill_content_length(response.content_length) if io.respond_to?(:fulfill_content_length)
            response.read_body do |chunk|
              response.error! if response.code.to_i >= 300
              io.ready! if io.respond_to?(:ready!)
              io << chunk
            rescue => e
              io.set_error(e)  if io.respond_to?(:set_error)
              io.close
            end
          end
        end
      else
        response = remote_request(:get, uri)
        io.fulfill_content_length(response.content_length) if io.respond_to?(:fulfill_content_length)
        io.write(response.body)
      end
    end

    def cursor
      @last_response.http_headers["x-files-cursor"]
    end

    private def api_url(url = "", base_url = nil)
      uri        = Addressable::URI.new
      uri.host   = Addressable::URI.parse(base_url).host
      uri.path   = "/api/rest/v1" + Files::URI.normalized_path(url)
      uri.scheme = Addressable::URI.parse(base_url).scheme

      uri.to_s
    end

    private def check_api_key!(api_key)
      unless api_key
        raise AuthenticationError, "No Files.com API key provided. " \
          'Set your API key using "Files.api_key = <API-KEY>". ' \
          "You can generate API keys from the Files.com's web interface. "
      end

      return unless api_key =~ /\s/

      raise AuthenticationError, "Your API key is invalid (it contains whitespace)"
    end

    private def check_session_id!(session_id)
      return unless session_id =~ /\s/

      raise AuthenticationError, "The provided Session ID is invalid (it contains whitespace)"
    end

    def execute_request_with_rescues(base_url, context, skip_body_logging = false)
      num_retries = 0
      begin
        request_start = Time.now
        log_request(context, num_retries, skip_body_logging)
        resp = yield
        log_response(context, request_start, resp.status, resp.body, skip_body_logging)
      rescue StandardError => e
        error_context = context

        if e.respond_to?(:response) && e.response
          error_context = context
          log_response(error_context, request_start,
                       e.response[:status], e.response[:body], skip_body_logging
          )
        else
          log_response_error(error_context, request_start, e)
        end

        if self.class.should_retry?(e, num_retries)
          num_retries += 1
          sleep self.class.sleep_time(num_retries)
          retry
        end

        case e
        when Faraday::ClientError
          if e.response
            handle_error_response(e.response, error_context)
          else
            handle_network_error(e, error_context, num_retries, base_url)
          end

        else
          raise
        end
      end

      resp
    end

    private def general_api_error(status, body)
      APIError.new("Unexpected response object from API: #{body.inspect} (HTTP response code was #{status})", http_status: status, http_body: body)
    end

    private def format_app_info(info)
      str = info[:name]
      str = "#{str}/#{info[:version]}" unless info[:version].nil?
      str = "#{str} (#{info[:url]})" unless info[:url].nil?
      str
    end

    private def handle_error_response(http_resp, context)
      begin
        resp = Response.from_faraday_hash(http_resp)
        error_data = resp.data[:error] || resp.data[:errors]
        error_data = error_data.first if error_data.is_a?(Array)
        error_data = { message: error_data } if error_data.is_a?(String)

        raise Error, "Unknown error" unless error_data
      rescue JSON::ParserError, Error
        raise general_api_error(http_resp[:status], http_resp[:body])
      end

      error = specific_api_error(resp, error_data, context)

      error.response = resp
      raise(error)
    end

    private def specific_api_error(resp, error_data, _context)
      Util.log_error("API error", status: resp.http_status, error_message: error_data[:message])

      opts = {
        http_body: resp.http_body,
        http_headers: resp.http_headers,
        http_status: resp.http_status,
        json_body: resp.data,
        code: error_data[:code] || resp.http_status,
      }

      return APIError.new(error_data[:message], opts) unless resp&.data&.dig(:type)

      begin
        error_class = Files.const_get(resp.data[:type].split("/").map { |piece| piece.split("-").map(&:capitalize).join('') + 'Error' }.join("::"))
        error_class.new(error_data[:message], opts)
      rescue NameError
        APIError.new(error_data[:message], opts)
      end
    end

    private def handle_network_error(error, context, num_retries, base_url = nil)
      base_url ||= Files.base_url

      Util.log_error("Network error", error_message: error.message, request_id: context.request_id)
      message = "Could not connect to Files.com at URL #{base_url}. Please check your internet connection and try again. If this problem persists, you should check Files.com's service status at https://status.files.com, or contact your primary account representative."
      message += " Request was retried #{num_retries} times." if num_retries > 0
      message += "\n\n(Network error: #{error.message})"

      raise APIConnectionError, message
    end

    private def request_headers(api_key, session_id, _method)
      user_agent = "Files.com Ruby SDK v#{Files::VERSION}"
      user_agent += " " + format_app_info(Files.app_info) unless Files.app_info.nil?

      headers = {
        "User-Agent" => user_agent,
        "Content-Type" => "application/x-www-form-urlencoded",
      }
      headers["X-FilesAPI-Key"] = api_key if api_key
      headers["X-FilesAPI-Auth"] = session_id if session_id

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

    private def log_request(context, num_retries, no_body = false)
      Util.log_info("Request", method: context.method, num_retries: num_retries, path: context.path)
      Util.log_debug("Request details", body: context.body, query_params: context.query_params) unless no_body
    end

    private def log_response(context, request_start, status, body, no_body = false)
      Util.log_info("Response", elapsed: Time.now - request_start, method: context.method, path: context.path, status: status)
      Util.log_debug("Response details", body: body) unless no_body
    end

    private def log_response_error(context, request_start, error)
      Util.log_error("Error", elapsed: Time.now - request_start, error_message: error.message, method: context.method, path: context.path)
    end

    class RequestLogContext
      attr_accessor :body, :api_key, :method, :path, :query_params, :session_id
    end
  end
end
