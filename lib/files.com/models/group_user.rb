# frozen_string_literal: true

module Files
  # Files::GroupUser is the Ruby SDK's representation of Files.com API GroupUser objects.
  # Each instance keeps its API field values in +attributes+.
  class GroupUser
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

    # Group name
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

    # Is this user an administrator of this group?
    # @return [Boolean, nil] the field value, or nil when absent.
    def admin
      @attributes[:admin]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def admin=(value)
      @attributes[:admin] = value
    end

    # Username of the user
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

    # Group User ID.
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

    # Update Group User
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] group_id Required. Group ID to add user to.
    # @option params [Integer] user_id Required. User ID to add to group.
    # @option params [Boolean] admin Is the user a group administrator?
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: admin must be a single value, not #{params[:admin].class}") if [ Array, Hash ].any? { |klass| params[:admin].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: group_id") if params[:group_id].nil?
      raise MissingParameterError.new("Parameter missing: user_id") if params[:user_id].nil?

      response, options = Api.send_request("/group_users/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("GroupUser") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Group User
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] group_id Required. Group ID from which to remove user.
    # @option params [Integer] user_id Required. User ID to remove from group.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: group_id") if params[:group_id].nil?
      raise MissingParameterError.new("Parameter missing: user_id") if params[:user_id].nil?

      response, options = Api.send_request("/group_users/#{@attributes[:id]}", :delete, params, @options)
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
    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = GroupUser.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Group Users
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Integer] group_id Group ID. If provided, returns memberships of this group. Requires a Site Administrator, a Read-only Administrator, a Workspace Administrator for the group's workspace, or a Group Administrator of this group.
    # @option params [Integer] user_id User ID.  If provided, will return group_users of this user.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)

      list_options = options.dup
      List.new(GroupUser, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/group_users", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Create Group User
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] group_id Required. Group ID to add user to.
    # @option params [Integer] user_id Required. User ID to add to group.
    # @option params [Boolean] admin Is the user a group administrator?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::GroupUser] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: admin must be a single value, not #{params[:admin].class}") if [ Array, Hash ].any? { |klass| params[:admin].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: group_id") if params[:group_id].nil?
      raise MissingParameterError.new("Parameter missing: user_id") if params[:user_id].nil?

      response, options = Api.send_request("/group_users", :post, params, options) { |reply| reply.require_object("GroupUser") }
      GroupUser.new(response.data, options)
    end

    # Update Group User
    #
    # @param id [Integer] Group User ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] group_id Required. Group ID to add user to.
    # @option params [Integer] user_id Required. User ID to add to group.
    # @option params [Boolean] admin Is the user a group administrator?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::GroupUser] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: admin must be a single value, not #{params[:admin].class}") if [ Array, Hash ].any? { |klass| params[:admin].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: group_id") if params[:group_id].nil?
      raise MissingParameterError.new("Parameter missing: user_id") if params[:user_id].nil?

      response, options = Api.send_request("/group_users/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("GroupUser") }
      GroupUser.new(response.data, options)
    end

    # Delete Group User
    #
    # @param id [Integer] Group User ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] group_id Required. Group ID from which to remove user.
    # @option params [Integer] user_id Required. User ID to remove from group.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: group_id") if params[:group_id].nil?
      raise MissingParameterError.new("Parameter missing: user_id") if params[:user_id].nil?

      Api.send_request("/group_users/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
