# frozen_string_literal: true

module Files
  # Files::Request is the Ruby SDK's representation of Files.com API Request objects.
  # Each instance keeps its API field values in +attributes+.
  class Request
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

    # Request ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def id=(value)
      @attributes[:id] = value
    end

    # Folder path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def path=(value)
      @attributes[:path] = value
    end

    # Source filename, if applicable
    # @return [String, nil] the field value, or nil when absent.
    def source
      @attributes[:source]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def source=(value)
      @attributes[:source] = value
    end

    # Destination filename
    # @return [String, nil] the field value, or nil when absent.
    def destination
      @attributes[:destination]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def destination=(value)
      @attributes[:destination] = value
    end

    # ID of automation that created request
    # @return [Integer, nil] the field value, or nil when absent.
    def automation_id
      @attributes[:automation_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def automation_id=(value)
      @attributes[:automation_id] = value
    end

    # User making the request (if applicable)
    # @return [String, nil] the field value, or nil when absent.
    def user_display_name
      @attributes[:user_display_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def user_display_name=(value)
      @attributes[:user_display_name] = value
    end

    # A list of user IDs to request the file from. If sent as a string, it should be comma-delimited.
    # @return [String, nil] the field value, or nil when absent.
    def user_ids
      @attributes[:user_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def user_ids=(value)
      @attributes[:user_ids] = value
    end

    # A list of group IDs to request the file from. If sent as a string, it should be comma-delimited.
    # @return [String, nil] the field value, or nil when absent.
    def group_ids
      @attributes[:group_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def group_ids=(value)
      @attributes[:group_ids] = value
    end

    # Delete Request
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/requests/#{@attributes[:id]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Calls {#delete} and discards its response.
    # @param (see #delete)
    # @option (see #delete)
    # @raise (see #delete)
    # @return [nil]
    def destroy(params = {})
      delete(params)
      nil
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    # @raise [Files::NotImplementedError] if this record already has an id; updates are unsupported.
    def save
      if @attributes[:id]
        raise NotImplementedError.new("The Request object doesn't support updates.")
      else
        new_obj = Request.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Requests
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    # @option params [Boolean] mine Only show requests of the current user?  (Defaults to true if current user is not a site admin.)
    # @option params [String] path Path to show requests for.  If omitted, shows all paths. Send `/` to represent the root directory.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: mine must be a single value, not #{params[:mine].class}") if [ Array, Hash ].any? { |klass| params[:mine].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)

      list_options = options.dup
      List.new(Request, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/requests", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # List Requests
    #
    # @param path [String] Path to show requests for.  If omitted, shows all paths. Send `/` to represent the root directory.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    # @option params [Boolean] mine Only show requests of the current user?  (Defaults to true if current user is not a site admin.)
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.get_folder(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: mine must be a single value, not #{params[:mine].class}") if [ Array, Hash ].any? { |klass| params[:mine].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      list_options = options.dup
      List.new(Request, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/requests/folders/#{page_params[:path]}", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # Create Request
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] path Required. Folder path on which to request the file.
    # @option params [String] destination Required. Destination filename (without extension) to request.
    # @option params [String] user_ids A list of user IDs to request the file from. If sent as a string, it should be comma-delimited.
    # @option params [String] group_ids A list of group IDs to request the file from. If sent as a string, it should be comma-delimited.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Request] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if !params[:user_ids].nil? and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if !params[:group_ids].nil? and !params[:group_ids].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?

      response, options = Api.send_request("/requests", :post, params, options) { |reply| reply.require_object("Request") }
      Request.new(response.data, options)
    end

    # Delete Request
    #
    # @param id [Integer] Request ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/requests/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
