# frozen_string_literal: true

module Files
  class Response
    attr_accessor :data, :http_body, :http_headers, :http_status

    def self.from_faraday_hash(http_resp)
      resp = new
      resp.data = JSON.parse(http_resp[:body], symbolize_names: true) if http_resp[:status] != 204
      resp.http_body = http_resp[:body]
      resp.http_headers = http_resp[:headers]
      resp.http_status = http_resp[:status]
      resp
    end

    def self.from_faraday_response(http_resp)
      resp = new
      resp.data = JSON.parse(http_resp.body, symbolize_names: true) if http_resp.status != 204
      resp.http_body = http_resp.body
      resp.http_headers = http_resp.headers
      resp.http_status = http_resp.status
      resp
    end

    # The error for a successful response that is not what its operation
    # promises, such as JSON null where a list belongs. It carries this
    # response for inspection, but its message leaves out the body.
    def unexpected_shape_error(expected)
      error = APIConnectionError.new("The Files.com API returned something other than #{expected} (HTTP response code was #{http_status})",
        http_status: http_status, http_headers: http_headers, http_body: http_body
      )
      error.response = self
      error
    end

    # Raises unexpected_shape_error unless the body is a JSON object, as an
    # operation that returns one +model+ promises.
    def require_object(model)
      raise unexpected_shape_error("a #{model} object") unless data.is_a?(Hash)
    end

    # Raises unexpected_shape_error unless the body is a JSON list of objects,
    # as an operation that returns +model+ records promises. An empty list is
    # fine.
    def require_list(model)
      raise unexpected_shape_error("a list of #{model} objects") unless data.is_a?(Array) && data.all?(Hash)
    end
  end
end
