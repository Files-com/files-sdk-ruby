# frozen_string_literal: true

module Files
  # Files::Permission is the Ruby SDK's representation of Files.com API Permission objects.
  # Each instance keeps its API field values in +attributes+.
  class Permission
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

    # Permission ID
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

    # User ID
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def user_id=(value)
      @attributes[:user_id] = value
    end

    # Username (if applicable)
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def username=(value)
      @attributes[:username] = value
    end

    # Group ID
    # @return [Integer, nil] the field value, or nil when absent.
    def group_id
      @attributes[:group_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def group_id=(value)
      @attributes[:group_id] = value
    end

    # Group name (if applicable)
    # @return [String, nil] the field value, or nil when absent.
    def group_name
      @attributes[:group_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def group_name=(value)
      @attributes[:group_name] = value
    end

    # Group IDs when this Permission requires membership in every listed group.
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def group_ids
      @attributes[:group_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def group_ids=(value)
      @attributes[:group_ids] = value
    end

    # Group names when this permission requires multiple groups
    # @return [Array<String>, nil] the field value, or nil when absent.
    def group_names
      @attributes[:group_names]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def group_names=(value)
      @attributes[:group_names] = value
    end

    # Partner ID (if applicable)
    # @return [Integer, nil] the field value, or nil when absent.
    def partner_id
      @attributes[:partner_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def partner_id=(value)
      @attributes[:partner_id] = value
    end

    # Partner name (if applicable)
    # @return [String, nil] the field value, or nil when absent.
    def partner_name
      @attributes[:partner_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def partner_name=(value)
      @attributes[:partner_name] = value
    end

    # Permission type.  See the table referenced in the documentation for an explanation of each permission.
    # @return [String, nil] the field value, or nil when absent.
    def permission
      @attributes[:permission]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def permission=(value)
      @attributes[:permission] = value
    end

    # Whether this Permission applies to subfolders. Must be true for `admin` Permissions.
    # @return [Boolean, nil] the field value, or nil when absent.
    def recursive
      @attributes[:recursive]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def recursive=(value)
      @attributes[:recursive] = value
    end

    # Site ID
    # @return [Integer, nil] the field value, or nil when absent.
    def site_id
      @attributes[:site_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def site_id=(value)
      @attributes[:site_id] = value
    end

    # Delete Permission
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

      response, options = Api.send_request("/permissions/#{@attributes[:id]}", :delete, params, @options)
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
        raise NotImplementedError.new("The Permission object doesn't support updates.")
      else
        new_obj = Permission.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Permissions
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `site_id`, `group_id`, `path`, `user_id`, `partner_id` or `id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `path`, `group_id`, `partner_id` or `user_id`. Valid field combinations are `[ group_id, path ]`, `[ partner_id, path ]`, `[ user_id, path ]`, `[ user_id, group_id ]`, `[ user_id, group_id, path ]`, `[ user_id, group_id, partner_id ]` or `[ user_id, group_id, partner_id, path ]`.
    # @option params [Hash] filter_prefix If set, return records where the specified field is prefixed by the supplied value. Valid fields are `path`.
    # @option params [String] path Permission path.  If provided, will scope all permissions(including upward) to this path.
    # @option params [Boolean] include_groups If searching by user or group, also include user's permissions that are inherited from its groups?
    # @option params [String] group_id
    # @option params [String] partner_id
    # @option params [String] user_id
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if !params[:filter_prefix].nil? and !params[:filter_prefix].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: include_groups must be a single value, not #{params[:include_groups].class}") if [ Array, Hash ].any? { |klass| params[:include_groups].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: group_id must be an String") if !params[:group_id].nil? and !params[:group_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: partner_id must be an String") if !params[:partner_id].nil? and !params[:partner_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_id must be an String") if !params[:user_id].nil? and !params[:user_id].is_a?(String)

      list_options = options.dup
      List.new(Permission, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/permissions", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Create Permission
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] path Required. Folder path
    # @option params [Integer] group_id Group ID. Provide `group_name` or `group_id`
    # @option params [String] group_ids Group IDs when the Permission requires membership in every listed group. If sent as a string, it should be comma-delimited.
    # @option params [String] permission Permission type.  Can be `admin`, `full`, `readonly`, `writeonly`, `list`, or `history`
    # @option params [Boolean] recursive Apply to subfolders recursively? Must be true for `admin` Permissions.
    # @option params [Integer] partner_id Partner ID if this Permission belongs to a partner.
    # @option params [Integer] user_id User ID.  Provide `username` or `user_id`
    # @option params [String] username User username.  Provide `username` or `user_id`
    # @option params [String] group_name Group name.  Provide `group_name` or `group_id`
    # @option params [Integer] site_id Site ID. If not provided, will default to current site. Used when creating a permission for a child site.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Permission] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if !params[:group_ids].nil? and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission must be an String") if !params[:permission].nil? and !params[:permission].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if !params[:partner_id].nil? and !params[:partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if !params[:username].nil? and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_name must be an String") if !params[:group_name].nil? and !params[:group_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: site_id must be an Integer") if !params[:site_id].nil? and !params[:site_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/permissions", :post, params, options) { |reply| reply.require_object("Permission") }
      Permission.new(response.data, options)
    end

    # Delete Permission
    #
    # @param id [Integer] Permission ID.
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

      Api.send_request("/permissions/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
