# frozen_string_literal: true

module Files
  # Files::History is the Ruby SDK's representation of Files.com API History objects.
  # Each instance keeps its API field values in +attributes+.
  class History
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

    # Action ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Action occurrence date/time
    # @return [String, nil] the field value, or nil when absent.
    def when
      @attributes[:when]
    end

    # The destination path for this action, if applicable
    # @return [String, nil] the field value, or nil when absent.
    def destination
      @attributes[:destination]
    end

    # Friendly displayed output
    # @return [String, nil] the field value, or nil when absent.
    def display
      @attributes[:display]
    end

    # IP Address that performed this action
    # @return [String, nil] the field value, or nil when absent.
    def ip
      @attributes[:ip]
    end

    # The source path for this action, if applicable
    # @return [String, nil] the field value, or nil when absent.
    def source
      @attributes[:source]
    end

    # Targets
    # @return [Hash, nil] the field value, or nil when absent.
    def targets
      @attributes[:targets]
    end

    # User ID
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # Username
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # true if this change was performed by a user on a parent site.
    # @return [Boolean, nil] the field value, or nil when absent.
    def user_is_from_parent_site
      @attributes[:user_is_from_parent_site]
    end

    # Type of action
    # @return [String, nil] the field value, or nil when absent.
    def action
      @attributes[:action]
    end

    # Failure type.  If action was a user login or session failure, why did it fail?
    # @return [String, nil] the field value, or nil when absent.
    def failure_type
      @attributes[:failure_type]
    end

    # Interface on which this action occurred.
    # @return [String, nil] the field value, or nil when absent.
    def interface
      @attributes[:interface]
    end

    # List history for specific file
    #
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] start_at Leave blank or set to a date/time to filter earlier entries.
    # @option params [String] end_at Leave blank or set to a date/time to filter later entries.
    # @option params [String] display Display format. Leave blank or set to `full` or `parent`.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list_for_file(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if !params[:start_at].nil? and !params[:start_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if !params[:end_at].nil? and !params[:end_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: display must be an String") if !params[:display].nil? and !params[:display].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      list_options = options.dup
      List.new(Action, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/history/files/#{page_params[:path]}", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # List history for specific folder
    #
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] start_at Leave blank or set to a date/time to filter earlier entries.
    # @option params [String] end_at Leave blank or set to a date/time to filter later entries.
    # @option params [String] display Display format. Leave blank or set to `full` or `parent`.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list_for_folder(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if !params[:start_at].nil? and !params[:start_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if !params[:end_at].nil? and !params[:end_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: display must be an String") if !params[:display].nil? and !params[:display].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      list_options = options.dup
      List.new(Action, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/history/folders/#{page_params[:path]}", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # List history for specific user
    #
    # @param user_id [Integer] User ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] start_at Leave blank or set to a date/time to filter earlier entries.
    # @option params [String] end_at Leave blank or set to a date/time to filter later entries.
    # @option params [String] display Display format. Leave blank or set to `full` or `parent`.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list_for_user(user_id, params = {}, options = {})
      params = (params || {}).dup
      params[:user_id] = user_id
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if !params[:start_at].nil? and !params[:start_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if !params[:end_at].nil? and !params[:end_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: display must be an String") if !params[:display].nil? and !params[:display].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: user_id") if params[:user_id].nil?

      list_options = options.dup
      List.new(Action, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/history/users/#{page_params[:user_id]}", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # List site login history
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] start_at Leave blank or set to a date/time to filter earlier entries.
    # @option params [String] end_at Leave blank or set to a date/time to filter later entries.
    # @option params [String] display Display format. Leave blank or set to `full` or `parent`.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list_logins(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if !params[:start_at].nil? and !params[:start_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if !params[:end_at].nil? and !params[:end_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: display must be an String") if !params[:display].nil? and !params[:display].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)

      list_options = options.dup
      List.new(Action, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/history/login", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # List site full action history
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] start_at Leave blank or set to a date/time to filter earlier entries.
    # @option params [String] end_at Leave blank or set to a date/time to filter later entries.
    # @option params [String] display Display format. Leave blank or set to `full` or `parent`.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `user_id`, `folder` or `path`. Valid field combinations are `[  ]`, `[ path ]`, `[ path ]` or `[ path ]`.
    # @option params [Hash] filter_prefix If set, return records where the specified field is prefixed by the supplied value. Valid fields are `path`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if !params[:start_at].nil? and !params[:start_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if !params[:end_at].nil? and !params[:end_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: display must be an String") if !params[:display].nil? and !params[:display].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if !params[:filter_prefix].nil? and !params[:filter_prefix].is_a?(Hash)

      list_options = options.dup
      List.new(Action, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/history", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
