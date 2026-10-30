# frozen_string_literal: true

module Files
  # Files::ScimLog is the Ruby SDK's representation of Files.com API ScimLog objects.
  # Each instance keeps its API field values in +attributes+.
  class ScimLog
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # The unique ID of this SCIM request.
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # The date and time when this SCIM request occurred.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # The path portion of the URL requested.
    # @return [String, nil] the field value, or nil when absent.
    def request_path
      @attributes[:request_path]
    end

    # The HTTP method used for this request.
    # @return [String, nil] the field value, or nil when absent.
    def request_method
      @attributes[:request_method]
    end

    # The HTTP response code returned for this request.
    # @return [String, nil] the field value, or nil when absent.
    def http_response_code
      @attributes[:http_response_code]
    end

    # The User-Agent header sent with the request.
    # @return [String, nil] the field value, or nil when absent.
    def user_agent
      @attributes[:user_agent]
    end

    # The JSON payload sent with the request.
    # @return [String, nil] the field value, or nil when absent.
    def request_json
      @attributes[:request_json]
    end

    # The JSON payload returned in the response.
    # @return [String, nil] the field value, or nil when absent.
    def response_json
      @attributes[:response_json]
    end

    # List Scim Logs
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)

      list_options = options.dup
      List.new(ScimLog, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/scim_logs", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Scim Log
    #
    # @param id [Integer] Scim Log ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ScimLog] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/scim_logs/#{params[:id]}", :get, params, options) { |reply| reply.require_object("ScimLog") }
      ScimLog.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
