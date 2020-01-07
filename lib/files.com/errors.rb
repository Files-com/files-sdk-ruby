# frozen_string_literal: true

module Files
  class Error < StandardError
    attr_accessor :response

    attr_reader :code
    attr_reader :http_body
    attr_reader :http_headers
    attr_reader :http_status
    attr_reader :json_body
    attr_reader :message
    attr_reader :request_id

    def initialize(message = nil, http_status: nil, http_body: nil, json_body: nil, http_headers: nil, code: nil)
      @message = message
      @http_status = http_status
      @http_body = http_body
      @http_headers = http_headers || {}
      @json_body = json_body
      @code = code
    end

    def to_s
      "#{@http_status.nil? ? "" : "[HTTP #{@http_status}] "}#{@message}"
    end
  end

  class APIError < Error; end
  class AuthenticationError < Error; end
  class ConnectionError < Error; end
  class InvalidRequestError < Error; end
  class NotImplementedError < Error; end
  class PermissionError < Error; end
  class TooManyRequestsError < Error; end
  class ValidationError < Error; end

  class InvalidParameterError < InvalidRequestError; end
  class MissingParameterError < InvalidRequestError; end
end
