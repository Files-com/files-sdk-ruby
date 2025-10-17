# frozen_string_literal: true

module Files
  class ScimLog
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - The unique ID of this SCIM request.
    def id
      @attributes[:id]
    end

    # string - The date and time when this SCIM request occurred.
    def created_at
      @attributes[:created_at]
    end

    # string - The path portion of the URL requested.
    def request_path
      @attributes[:request_path]
    end

    # string - The HTTP method used for this request.
    def request_method
      @attributes[:request_method]
    end

    # string - The HTTP response code returned for this request.
    def http_response_code
      @attributes[:http_response_code]
    end

    # string - The User-Agent header sent with the request.
    def user_agent
      @attributes[:user_agent]
    end

    # string - The JSON payload sent with the request.
    def request_json
      @attributes[:request_json]
    end

    # string - The JSON payload returned in the response.
    def response_json
      @attributes[:response_json]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)

      List.new(ScimLog, params) do
        Api.send_request("/scim_logs", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Scim Log ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/scim_logs/#{params[:id]}", :get, params, options)
      ScimLog.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
