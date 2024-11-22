# frozen_string_literal: true

module Files
  class ExavaultApiRequestLog
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # date-time - Start Time of Action
    def timestamp
      @attributes[:timestamp]
    end

    # string - Name of API Endpoint
    def endpoint
      @attributes[:endpoint]
    end

    # string - Exavault API Version
    def version
      @attributes[:version]
    end

    # string - IP of requesting client
    def request_ip
      @attributes[:request_ip]
    end

    # string - HTTP Method
    def request_method
      @attributes[:request_method]
    end

    # string - Error type, if applicable
    def error_type
      @attributes[:error_type]
    end

    # string - Error message, if applicable
    def error_message
      @attributes[:error_message]
    end

    # string - User-Agent
    def user_agent
      @attributes[:user_agent]
    end

    # int64 - HTTP Response Code
    def response_code
      @attributes[:response_code]
    end

    # boolean - `false` if HTTP Response Code is 4xx or 5xx
    def success
      @attributes[:success]
    end

    # int64 - Duration (in milliseconds)
    def duration_ms
      @attributes[:duration_ms]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `start_date`, `end_date`, `request_ip`, `request_method` or `success`. Valid field combinations are `[ start_date ]`, `[ end_date ]`, `[ request_ip ]`, `[ request_method ]`, `[ success ]`, `[ start_date, end_date ]`, `[ start_date, request_ip ]`, `[ start_date, request_method ]`, `[ start_date, success ]`, `[ end_date, request_ip ]`, `[ end_date, request_method ]`, `[ end_date, success ]`, `[ request_ip, request_method ]`, `[ request_ip, success ]`, `[ request_method, success ]`, `[ start_date, end_date, request_ip ]`, `[ start_date, end_date, request_method ]`, `[ start_date, end_date, success ]`, `[ start_date, request_ip, request_method ]`, `[ start_date, request_ip, success ]`, `[ start_date, request_method, success ]`, `[ end_date, request_ip, request_method ]`, `[ end_date, request_ip, success ]`, `[ end_date, request_method, success ]`, `[ request_ip, request_method, success ]`, `[ start_date, end_date, request_ip, request_method ]`, `[ start_date, end_date, request_ip, success ]`, `[ start_date, end_date, request_method, success ]`, `[ start_date, request_ip, request_method, success ]` or `[ end_date, request_ip, request_method, success ]`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `request_ip` and `request_method`. Valid field combinations are `[ start_date ]`, `[ end_date ]`, `[ request_ip ]`, `[ request_method ]`, `[ success ]`, `[ start_date, end_date ]`, `[ start_date, request_ip ]`, `[ start_date, request_method ]`, `[ start_date, success ]`, `[ end_date, request_ip ]`, `[ end_date, request_method ]`, `[ end_date, success ]`, `[ request_ip, request_method ]`, `[ request_ip, success ]`, `[ request_method, success ]`, `[ start_date, end_date, request_ip ]`, `[ start_date, end_date, request_method ]`, `[ start_date, end_date, success ]`, `[ start_date, request_ip, request_method ]`, `[ start_date, request_ip, success ]`, `[ start_date, request_method, success ]`, `[ end_date, request_ip, request_method ]`, `[ end_date, request_ip, success ]`, `[ end_date, request_method, success ]`, `[ request_ip, request_method, success ]`, `[ start_date, end_date, request_ip, request_method ]`, `[ start_date, end_date, request_ip, success ]`, `[ start_date, end_date, request_method, success ]`, `[ start_date, request_ip, request_method, success ]` or `[ end_date, request_ip, request_method, success ]`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

      List.new(ExavaultApiRequestLog, params) do
        Api.send_request("/exavault_api_request_logs", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `start_date`, `end_date`, `request_ip`, `request_method` or `success`. Valid field combinations are `[ start_date ]`, `[ end_date ]`, `[ request_ip ]`, `[ request_method ]`, `[ success ]`, `[ start_date, end_date ]`, `[ start_date, request_ip ]`, `[ start_date, request_method ]`, `[ start_date, success ]`, `[ end_date, request_ip ]`, `[ end_date, request_method ]`, `[ end_date, success ]`, `[ request_ip, request_method ]`, `[ request_ip, success ]`, `[ request_method, success ]`, `[ start_date, end_date, request_ip ]`, `[ start_date, end_date, request_method ]`, `[ start_date, end_date, success ]`, `[ start_date, request_ip, request_method ]`, `[ start_date, request_ip, success ]`, `[ start_date, request_method, success ]`, `[ end_date, request_ip, request_method ]`, `[ end_date, request_ip, success ]`, `[ end_date, request_method, success ]`, `[ request_ip, request_method, success ]`, `[ start_date, end_date, request_ip, request_method ]`, `[ start_date, end_date, request_ip, success ]`, `[ start_date, end_date, request_method, success ]`, `[ start_date, request_ip, request_method, success ]` or `[ end_date, request_ip, request_method, success ]`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `request_ip` and `request_method`. Valid field combinations are `[ start_date ]`, `[ end_date ]`, `[ request_ip ]`, `[ request_method ]`, `[ success ]`, `[ start_date, end_date ]`, `[ start_date, request_ip ]`, `[ start_date, request_method ]`, `[ start_date, success ]`, `[ end_date, request_ip ]`, `[ end_date, request_method ]`, `[ end_date, success ]`, `[ request_ip, request_method ]`, `[ request_ip, success ]`, `[ request_method, success ]`, `[ start_date, end_date, request_ip ]`, `[ start_date, end_date, request_method ]`, `[ start_date, end_date, success ]`, `[ start_date, request_ip, request_method ]`, `[ start_date, request_ip, success ]`, `[ start_date, request_method, success ]`, `[ end_date, request_ip, request_method ]`, `[ end_date, request_ip, success ]`, `[ end_date, request_method, success ]`, `[ request_ip, request_method, success ]`, `[ start_date, end_date, request_ip, request_method ]`, `[ start_date, end_date, request_ip, success ]`, `[ start_date, end_date, request_method, success ]`, `[ start_date, request_ip, request_method, success ]` or `[ end_date, request_ip, request_method, success ]`.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

      response, options = Api.send_request("/exavault_api_request_logs/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
