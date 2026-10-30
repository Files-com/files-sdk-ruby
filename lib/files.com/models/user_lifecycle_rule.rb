# frozen_string_literal: true

module Files
  # Files::UserLifecycleRule is the Ruby SDK's representation of Files.com API UserLifecycleRule objects.
  # Each instance keeps its API field values in +attributes+.
  class UserLifecycleRule
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

    # User Lifecycle Rule ID
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

    # User authentication method for which the rule will apply. Use `all_non_sso` to target every non-SSO authentication method with one rule.
    # @return [String, nil] the field value, or nil when absent.
    def authentication_method
      @attributes[:authentication_method]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def authentication_method=(value)
      @attributes[:authentication_method] = value
    end

    # Array of Group IDs to which the rule applies. If empty or not set, the rule applies to all users.
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

    # Action to take on inactive users (disable or delete)
    # @return [String, nil] the field value, or nil when absent.
    def action
      @attributes[:action]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def action=(value)
      @attributes[:action] = value
    end

    # Number of days of inactivity before the rule applies
    # @return [Integer, nil] the field value, or nil when absent.
    def inactivity_days
      @attributes[:inactivity_days]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def inactivity_days=(value)
      @attributes[:inactivity_days] = value
    end

    # If true, the rule will apply to folder admins.
    # @return [Boolean, nil] the field value, or nil when absent.
    def include_folder_admins
      @attributes[:include_folder_admins]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def include_folder_admins=(value)
      @attributes[:include_folder_admins] = value
    end

    # If true, the rule includes Site Administrators, who always belong to the Default Workspace. Can only be enabled when `workspace_id` is `0`.
    # @return [Boolean, nil] the field value, or nil when absent.
    def include_site_admins
      @attributes[:include_site_admins]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def include_site_admins=(value)
      @attributes[:include_site_admins] = value
    end

    # If true, a Default Workspace rule also applies to users in all Custom Workspaces. Can only be enabled when `workspace_id` is `0`.
    # @return [Boolean, nil] the field value, or nil when absent.
    def apply_to_all_workspaces
      @attributes[:apply_to_all_workspaces]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def apply_to_all_workspaces=(value)
      @attributes[:apply_to_all_workspaces] = value
    end

    # User Lifecycle Rule name
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def name=(value)
      @attributes[:name] = value
    end

    # If true, users will be emailed before the rule disables or deletes them.
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_users
      @attributes[:notify_users]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_users=(value)
      @attributes[:notify_users] = value
    end

    # If provided, only users belonging to Partners with this tag at the Partner level will be affected by the rule. Tags must only contain lowercase letters, numbers, and hyphens.
    # @return [String, nil] the field value, or nil when absent.
    def partner_tag
      @attributes[:partner_tag]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def partner_tag=(value)
      @attributes[:partner_tag] = value
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

    # Workspace whose users the rule applies to. `0` means the Default Workspace. A Custom Workspace rule applies only to users who belong to that Workspace, regardless of access granted to other users.
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # State of the users to apply the rule to (inactive or disabled)
    # @return [String, nil] the field value, or nil when absent.
    def user_state
      @attributes[:user_state]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def user_state=(value)
      @attributes[:user_state] = value
    end

    # If provided, only users with this tag will be affected by the rule. Tags must only contain lowercase letters, numbers, and hyphens.
    # @return [String, nil] the field value, or nil when absent.
    def user_tag
      @attributes[:user_tag]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def user_tag=(value)
      @attributes[:user_tag] = value
    end

    # Update User Lifecycle Rule
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] action Action to take on inactive users (disable or delete)
    # @option params [Boolean] apply_to_all_workspaces If true, a Default Workspace rule also applies to users in all Custom Workspaces. Can only be enabled when `workspace_id` is `0`.
    # @option params [String] authentication_method User authentication method for which the rule will apply. Use `all_non_sso` to target every non-SSO authentication method with one rule.
    # @option params [Array<Integer>] group_ids Array of Group IDs to which the rule applies. If empty or not set, the rule applies to all users.
    # @option params [Integer] inactivity_days Number of days of inactivity before the rule applies
    # @option params [Boolean] include_site_admins If true, the rule includes Site Administrators, who always belong to the Default Workspace. Can only be enabled when `workspace_id` is `0`.
    # @option params [Boolean] include_folder_admins If true, the rule will apply to folder admins.
    # @option params [String] name User Lifecycle Rule name
    # @option params [Boolean] notify_users If true, users will be emailed before the rule disables or deletes them.
    # @option params [String] partner_tag If provided, only users belonging to Partners with this tag at the Partner level will be affected by the rule. Tags must only contain lowercase letters, numbers, and hyphens.
    # @option params [String] user_state State of the users to apply the rule to (inactive or disabled)
    # @option params [String] user_tag If provided, only users with this tag will be affected by the rule. Tags must only contain lowercase letters, numbers, and hyphens.
    # @option params [Integer] workspace_id Workspace whose users the rule applies to. `0` means the Default Workspace. A Custom Workspace rule applies only to users who belong to that Workspace, regardless of access granted to other users.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if !params[:action].nil? and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: apply_to_all_workspaces must be a single value, not #{params[:apply_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:apply_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if !params[:authentication_method].nil? and !params[:authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an Array") if !params[:group_ids].nil? and !params[:group_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: inactivity_days must be an Integer") if !params[:inactivity_days].nil? and !params[:inactivity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: include_site_admins must be a single value, not #{params[:include_site_admins].class}") if [ Array, Hash ].any? { |klass| params[:include_site_admins].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: include_folder_admins must be a single value, not #{params[:include_folder_admins].class}") if [ Array, Hash ].any? { |klass| params[:include_folder_admins].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notify_users must be a single value, not #{params[:notify_users].class}") if [ Array, Hash ].any? { |klass| params[:notify_users].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: partner_tag must be an String") if !params[:partner_tag].nil? and !params[:partner_tag].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_state must be an String") if !params[:user_state].nil? and !params[:user_state].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_tag must be an String") if !params[:user_tag].nil? and !params[:user_tag].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/user_lifecycle_rules/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("UserLifecycleRule") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete User Lifecycle Rule
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

      response, options = Api.send_request("/user_lifecycle_rules/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = UserLifecycleRule.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List User Lifecycle Rules
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `site_id` and `workspace_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id`.
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

      list_options = options.dup
      List.new(UserLifecycleRule, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/user_lifecycle_rules", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show User Lifecycle Rule
    #
    # @param id [Integer] User Lifecycle Rule ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::UserLifecycleRule] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/user_lifecycle_rules/#{params[:id]}", :get, params, options) { |reply| reply.require_object("UserLifecycleRule") }
      UserLifecycleRule.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create User Lifecycle Rule
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] action Action to take on inactive users (disable or delete)
    # @option params [Boolean] apply_to_all_workspaces If true, a Default Workspace rule also applies to users in all Custom Workspaces. Can only be enabled when `workspace_id` is `0`.
    # @option params [String] authentication_method User authentication method for which the rule will apply. Use `all_non_sso` to target every non-SSO authentication method with one rule.
    # @option params [Array<Integer>] group_ids Array of Group IDs to which the rule applies. If empty or not set, the rule applies to all users.
    # @option params [Integer] inactivity_days Number of days of inactivity before the rule applies
    # @option params [Boolean] include_site_admins If true, the rule includes Site Administrators, who always belong to the Default Workspace. Can only be enabled when `workspace_id` is `0`.
    # @option params [Boolean] include_folder_admins If true, the rule will apply to folder admins.
    # @option params [String] name User Lifecycle Rule name
    # @option params [Boolean] notify_users If true, users will be emailed before the rule disables or deletes them.
    # @option params [String] partner_tag If provided, only users belonging to Partners with this tag at the Partner level will be affected by the rule. Tags must only contain lowercase letters, numbers, and hyphens.
    # @option params [String] user_state State of the users to apply the rule to (inactive or disabled)
    # @option params [String] user_tag If provided, only users with this tag will be affected by the rule. Tags must only contain lowercase letters, numbers, and hyphens.
    # @option params [Integer] workspace_id Workspace whose users the rule applies to. `0` means the Default Workspace. A Custom Workspace rule applies only to users who belong to that Workspace, regardless of access granted to other users.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::UserLifecycleRule] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: action must be an String") if !params[:action].nil? and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: apply_to_all_workspaces must be a single value, not #{params[:apply_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:apply_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if !params[:authentication_method].nil? and !params[:authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an Array") if !params[:group_ids].nil? and !params[:group_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: inactivity_days must be an Integer") if !params[:inactivity_days].nil? and !params[:inactivity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: include_site_admins must be a single value, not #{params[:include_site_admins].class}") if [ Array, Hash ].any? { |klass| params[:include_site_admins].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: include_folder_admins must be a single value, not #{params[:include_folder_admins].class}") if [ Array, Hash ].any? { |klass| params[:include_folder_admins].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notify_users must be a single value, not #{params[:notify_users].class}") if [ Array, Hash ].any? { |klass| params[:notify_users].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: partner_tag must be an String") if !params[:partner_tag].nil? and !params[:partner_tag].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_state must be an String") if !params[:user_state].nil? and !params[:user_state].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_tag must be an String") if !params[:user_tag].nil? and !params[:user_tag].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)

      response, options = Api.send_request("/user_lifecycle_rules", :post, params, options) { |reply| reply.require_object("UserLifecycleRule") }
      UserLifecycleRule.new(response.data, options)
    end

    # Update User Lifecycle Rule
    #
    # @param id [Integer] User Lifecycle Rule ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] action Action to take on inactive users (disable or delete)
    # @option params [Boolean] apply_to_all_workspaces If true, a Default Workspace rule also applies to users in all Custom Workspaces. Can only be enabled when `workspace_id` is `0`.
    # @option params [String] authentication_method User authentication method for which the rule will apply. Use `all_non_sso` to target every non-SSO authentication method with one rule.
    # @option params [Array<Integer>] group_ids Array of Group IDs to which the rule applies. If empty or not set, the rule applies to all users.
    # @option params [Integer] inactivity_days Number of days of inactivity before the rule applies
    # @option params [Boolean] include_site_admins If true, the rule includes Site Administrators, who always belong to the Default Workspace. Can only be enabled when `workspace_id` is `0`.
    # @option params [Boolean] include_folder_admins If true, the rule will apply to folder admins.
    # @option params [String] name User Lifecycle Rule name
    # @option params [Boolean] notify_users If true, users will be emailed before the rule disables or deletes them.
    # @option params [String] partner_tag If provided, only users belonging to Partners with this tag at the Partner level will be affected by the rule. Tags must only contain lowercase letters, numbers, and hyphens.
    # @option params [String] user_state State of the users to apply the rule to (inactive or disabled)
    # @option params [String] user_tag If provided, only users with this tag will be affected by the rule. Tags must only contain lowercase letters, numbers, and hyphens.
    # @option params [Integer] workspace_id Workspace whose users the rule applies to. `0` means the Default Workspace. A Custom Workspace rule applies only to users who belong to that Workspace, regardless of access granted to other users.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::UserLifecycleRule] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if !params[:action].nil? and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: apply_to_all_workspaces must be a single value, not #{params[:apply_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:apply_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if !params[:authentication_method].nil? and !params[:authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an Array") if !params[:group_ids].nil? and !params[:group_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: inactivity_days must be an Integer") if !params[:inactivity_days].nil? and !params[:inactivity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: include_site_admins must be a single value, not #{params[:include_site_admins].class}") if [ Array, Hash ].any? { |klass| params[:include_site_admins].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: include_folder_admins must be a single value, not #{params[:include_folder_admins].class}") if [ Array, Hash ].any? { |klass| params[:include_folder_admins].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notify_users must be a single value, not #{params[:notify_users].class}") if [ Array, Hash ].any? { |klass| params[:notify_users].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: partner_tag must be an String") if !params[:partner_tag].nil? and !params[:partner_tag].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_state must be an String") if !params[:user_state].nil? and !params[:user_state].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_tag must be an String") if !params[:user_tag].nil? and !params[:user_tag].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/user_lifecycle_rules/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("UserLifecycleRule") }
      UserLifecycleRule.new(response.data, options)
    end

    # Delete User Lifecycle Rule
    #
    # @param id [Integer] User Lifecycle Rule ID.
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

      Api.send_request("/user_lifecycle_rules/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
