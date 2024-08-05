# frozen_string_literal: true

module Files
  class PublicHostingRequestLog
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # date-time - Start Time of Action
    def timestamp
      @attributes[:timestamp]
    end

    # string - IP Address of Public Hosting Client
    def remote_ip
      @attributes[:remote_ip]
    end

    # string - IP Address of Public Hosting Server
    def server_ip
      @attributes[:server_ip]
    end

    # string - HTTP Request Hostname
    def hostname
      @attributes[:hostname]
    end

    # string - HTTP Request Path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # int64 - HTTP Response Code
    def response_code
      @attributes[:responseCode]
    end

    # boolean - Whether SFTP Action was successful.
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
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `start_date`, `end_date`, `path`, `remote_ip` or `success`. Valid field combinations are `[ start_date ]`, `[ end_date ]`, `[ path ]`, `[ remote_ip ]`, `[ success ]`, `[ start_date, end_date ]`, `[ start_date, path ]`, `[ start_date, remote_ip ]`, `[ start_date, success ]`, `[ end_date, path ]`, `[ end_date, remote_ip ]`, `[ end_date, success ]`, `[ path, remote_ip ]`, `[ path, success ]`, `[ remote_ip, success ]`, `[ start_date, end_date, path ]`, `[ start_date, end_date, remote_ip ]`, `[ start_date, end_date, success ]`, `[ start_date, path, remote_ip ]`, `[ start_date, path, success ]`, `[ start_date, remote_ip, success ]`, `[ end_date, path, remote_ip ]`, `[ end_date, path, success ]`, `[ end_date, remote_ip, success ]`, `[ path, remote_ip, success ]`, `[ start_date, end_date, path, remote_ip ]`, `[ start_date, end_date, path, success ]`, `[ start_date, end_date, remote_ip, success ]`, `[ start_date, path, remote_ip, success ]` or `[ end_date, path, remote_ip, success ]`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `path`. Valid field combinations are `[ start_date ]`, `[ end_date ]`, `[ path ]`, `[ remote_ip ]`, `[ success ]`, `[ start_date, end_date ]`, `[ start_date, path ]`, `[ start_date, remote_ip ]`, `[ start_date, success ]`, `[ end_date, path ]`, `[ end_date, remote_ip ]`, `[ end_date, success ]`, `[ path, remote_ip ]`, `[ path, success ]`, `[ remote_ip, success ]`, `[ start_date, end_date, path ]`, `[ start_date, end_date, remote_ip ]`, `[ start_date, end_date, success ]`, `[ start_date, path, remote_ip ]`, `[ start_date, path, success ]`, `[ start_date, remote_ip, success ]`, `[ end_date, path, remote_ip ]`, `[ end_date, path, success ]`, `[ end_date, remote_ip, success ]`, `[ path, remote_ip, success ]`, `[ start_date, end_date, path, remote_ip ]`, `[ start_date, end_date, path, success ]`, `[ start_date, end_date, remote_ip, success ]`, `[ start_date, path, remote_ip, success ]` or `[ end_date, path, remote_ip, success ]`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

      List.new(PublicHostingRequestLog, params) do
        Api.send_request("/public_hosting_request_logs", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
