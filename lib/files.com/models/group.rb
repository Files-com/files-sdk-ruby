# frozen_string_literal: true

module Files
  # Files::Group is the Ruby SDK's representation of Files.com API Group objects.
  # Each instance keeps its API field values in +attributes+.
  class Group
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

    # Group ID
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

    # Group name
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

    # A list of allowed IPs if applicable.  Newline delimited
    # @return [String, nil] the field value, or nil when absent.
    def allowed_ips
      @attributes[:allowed_ips]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def allowed_ips=(value)
      @attributes[:allowed_ips] = value
    end

    # Comma-delimited list of user IDs who are group administrators (separated by commas)
    # @return [String, nil] the field value, or nil when absent.
    def admin_ids
      @attributes[:admin_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def admin_ids=(value)
      @attributes[:admin_ids] = value
    end

    # Notes about this group
    # @return [String, nil] the field value, or nil when absent.
    def notes
      @attributes[:notes]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def notes=(value)
      @attributes[:notes] = value
    end

    # Comma-delimited list of user IDs who belong to this group (separated by commas)
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

    # Comma-delimited list of usernames who belong to this group (separated by commas)
    # @return [String, nil] the field value, or nil when absent.
    def usernames
      @attributes[:usernames]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def usernames=(value)
      @attributes[:usernames] = value
    end

    # AI Assistant Personality ID assigned to this Group, if any. Users in the Group inherit it unless a direct per-user or Partner assignment overrides it.
    # @return [Integer, nil] the field value, or nil when absent.
    def ai_assistant_personality_id
      @attributes[:ai_assistant_personality_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def ai_assistant_personality_id=(value)
      @attributes[:ai_assistant_personality_id] = value
    end

    # If true, users in this group can use FTP to login.  This will override a false value of `ftp_permission` on the user level.
    # @return [Boolean, nil] the field value, or nil when absent.
    def ftp_permission
      @attributes[:ftp_permission]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def ftp_permission=(value)
      @attributes[:ftp_permission] = value
    end

    # If true, users in this group can use SFTP to login.  This will override a false value of `sftp_permission` on the user level.
    # @return [Boolean, nil] the field value, or nil when absent.
    def sftp_permission
      @attributes[:sftp_permission]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def sftp_permission=(value)
      @attributes[:sftp_permission] = value
    end

    # If true, users in this group can use WebDAV to login.  This will override a false value of `dav_permission` on the user level.
    # @return [Boolean, nil] the field value, or nil when absent.
    def dav_permission
      @attributes[:dav_permission]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def dav_permission=(value)
      @attributes[:dav_permission] = value
    end

    # If true, users in this group can use the REST API to login.  This will override a false value of `restapi_permission` on the user level.
    # @return [Boolean, nil] the field value, or nil when absent.
    def restapi_permission
      @attributes[:restapi_permission]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def restapi_permission=(value)
      @attributes[:restapi_permission] = value
    end

    # If true, users in this group can access the S3-compatible endpoint. This will override a false value of `s3_compatible_endpoint_permission` on the user level. Defaults to false.
    # @return [Boolean, nil] the field value, or nil when absent.
    def s3_compatible_endpoint_permission
      @attributes[:s3_compatible_endpoint_permission]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def s3_compatible_endpoint_permission=(value)
      @attributes[:s3_compatible_endpoint_permission] = value
    end

    # Desktop Configuration Profile ID assigned to this Group, if any. Users in the Group inherit it unless a direct per-user assignment overrides it.
    # @return [Integer, nil] the field value, or nil when absent.
    def desktop_configuration_profile_id
      @attributes[:desktop_configuration_profile_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def desktop_configuration_profile_id=(value)
      @attributes[:desktop_configuration_profile_id] = value
    end

    # Integration Centric Profile ID assigned to this Group, if any. Users in the Group inherit it unless a direct per-user assignment overrides it.
    # @return [Integer, nil] the field value, or nil when absent.
    def integration_centric_profile_id
      @attributes[:integration_centric_profile_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def integration_centric_profile_id=(value)
      @attributes[:integration_centric_profile_id] = value
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

    # Workspace ID
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

    # Update Group
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] notes Group notes.
    # @option params [String] user_ids A list of user ids. If sent as a string, should be comma-delimited.
    # @option params [String] admin_ids A list of group admin user ids. If sent as a string, should be comma-delimited.
    # @option params [Integer] ai_assistant_personality_id AI Assistant Personality ID assigned to this Group, if any. Users in the Group inherit it unless a direct per-user or Partner assignment overrides it.
    # @option params [Boolean] ftp_permission If true, users in this group can use FTP to login.  This will override a false value of `ftp_permission` on the user level.
    # @option params [Boolean] sftp_permission If true, users in this group can use SFTP to login.  This will override a false value of `sftp_permission` on the user level.
    # @option params [Boolean] dav_permission If true, users in this group can use WebDAV to login.  This will override a false value of `dav_permission` on the user level.
    # @option params [Boolean] restapi_permission If true, users in this group can use the REST API to login.  This will override a false value of `restapi_permission` on the user level.
    # @option params [Boolean] s3_compatible_endpoint_permission If true, users in this group can access the S3-compatible endpoint. This will override a false value of `s3_compatible_endpoint_permission` on the user level. Defaults to false.
    # @option params [Integer] desktop_configuration_profile_id Desktop Configuration Profile ID assigned to this Group, if any. Users in the Group inherit it unless a direct per-user assignment overrides it.
    # @option params [Integer] integration_centric_profile_id Integration Centric Profile ID assigned to this Group, if any. Users in the Group inherit it unless a direct per-user assignment overrides it.
    # @option params [String] allowed_ips A list of allowed IPs if applicable.  Newline delimited
    # @option params [String] name Group name.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if !params[:notes].nil? and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if !params[:user_ids].nil? and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: admin_ids must be an String") if !params[:admin_ids].nil? and !params[:admin_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ai_assistant_personality_id must be an Integer") if !params[:ai_assistant_personality_id].nil? and !params[:ai_assistant_personality_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ftp_permission must be a single value, not #{params[:ftp_permission].class}") if [ Array, Hash ].any? { |klass| params[:ftp_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_permission must be a single value, not #{params[:sftp_permission].class}") if [ Array, Hash ].any? { |klass| params[:sftp_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: dav_permission must be a single value, not #{params[:dav_permission].class}") if [ Array, Hash ].any? { |klass| params[:dav_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: restapi_permission must be a single value, not #{params[:restapi_permission].class}") if [ Array, Hash ].any? { |klass| params[:restapi_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint_permission must be a single value, not #{params[:s3_compatible_endpoint_permission].class}") if [ Array, Hash ].any? { |klass| params[:s3_compatible_endpoint_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: desktop_configuration_profile_id must be an Integer") if !params[:desktop_configuration_profile_id].nil? and !params[:desktop_configuration_profile_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: integration_centric_profile_id must be an Integer") if !params[:integration_centric_profile_id].nil? and !params[:integration_centric_profile_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if !params[:allowed_ips].nil? and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/groups/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("Group") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Group
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

      response, options = Api.send_request("/groups/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = Group.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Groups
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `site_id`, `workspace_id` or `name`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `name` and `workspace_id`. Valid field combinations are `[ workspace_id, name ]`.
    # @option params [Hash] filter_prefix If set, return records where the specified field is prefixed by the supplied value. Valid fields are `name`.
    # @option params [String] ids Comma-separated list of group ids to include in results.
    # @option params [Boolean] include_parent_site_groups Include groups from the parent site.
    # @option params [Boolean] include_default_workspace_groups When scoped to a Custom Workspace, include Default Workspace groups that have permissions in that Workspace. Available to Site Administrators, and to Workspace Administrators and Folder Admins in that Workspace when the site shares its Default Workspace directory with Workspaces.
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
      raise InvalidParameterError.new("Bad parameter: ids must be an String") if !params[:ids].nil? and !params[:ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: include_parent_site_groups must be a single value, not #{params[:include_parent_site_groups].class}") if [ Array, Hash ].any? { |klass| params[:include_parent_site_groups].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: include_default_workspace_groups must be a single value, not #{params[:include_default_workspace_groups].class}") if [ Array, Hash ].any? { |klass| params[:include_default_workspace_groups].is_a?(klass) }

      list_options = options.dup
      List.new(Group, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/groups", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Group
    #
    # @param id [Integer] Group ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Group] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/groups/#{params[:id]}", :get, params, options) { |reply| reply.require_object("Group") }
      Group.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Group
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] notes Group notes.
    # @option params [String] user_ids A list of user ids. If sent as a string, should be comma-delimited.
    # @option params [String] admin_ids A list of group admin user ids. If sent as a string, should be comma-delimited.
    # @option params [Integer] ai_assistant_personality_id AI Assistant Personality ID assigned to this Group, if any. Users in the Group inherit it unless a direct per-user or Partner assignment overrides it.
    # @option params [Boolean] ftp_permission If true, users in this group can use FTP to login.  This will override a false value of `ftp_permission` on the user level.
    # @option params [Boolean] sftp_permission If true, users in this group can use SFTP to login.  This will override a false value of `sftp_permission` on the user level.
    # @option params [Boolean] dav_permission If true, users in this group can use WebDAV to login.  This will override a false value of `dav_permission` on the user level.
    # @option params [Boolean] restapi_permission If true, users in this group can use the REST API to login.  This will override a false value of `restapi_permission` on the user level.
    # @option params [Boolean] s3_compatible_endpoint_permission If true, users in this group can access the S3-compatible endpoint. This will override a false value of `s3_compatible_endpoint_permission` on the user level. Defaults to false.
    # @option params [Integer] desktop_configuration_profile_id Desktop Configuration Profile ID assigned to this Group, if any. Users in the Group inherit it unless a direct per-user assignment overrides it.
    # @option params [Integer] integration_centric_profile_id Integration Centric Profile ID assigned to this Group, if any. Users in the Group inherit it unless a direct per-user assignment overrides it.
    # @option params [String] allowed_ips A list of allowed IPs if applicable.  Newline delimited
    # @option params [String] name Required. Group name.
    # @option params [Integer] workspace_id Workspace ID
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Group] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if !params[:notes].nil? and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if !params[:user_ids].nil? and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: admin_ids must be an String") if !params[:admin_ids].nil? and !params[:admin_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ai_assistant_personality_id must be an Integer") if !params[:ai_assistant_personality_id].nil? and !params[:ai_assistant_personality_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ftp_permission must be a single value, not #{params[:ftp_permission].class}") if [ Array, Hash ].any? { |klass| params[:ftp_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_permission must be a single value, not #{params[:sftp_permission].class}") if [ Array, Hash ].any? { |klass| params[:sftp_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: dav_permission must be a single value, not #{params[:dav_permission].class}") if [ Array, Hash ].any? { |klass| params[:dav_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: restapi_permission must be a single value, not #{params[:restapi_permission].class}") if [ Array, Hash ].any? { |klass| params[:restapi_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint_permission must be a single value, not #{params[:s3_compatible_endpoint_permission].class}") if [ Array, Hash ].any? { |klass| params[:s3_compatible_endpoint_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: desktop_configuration_profile_id must be an Integer") if !params[:desktop_configuration_profile_id].nil? and !params[:desktop_configuration_profile_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: integration_centric_profile_id must be an Integer") if !params[:integration_centric_profile_id].nil? and !params[:integration_centric_profile_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if !params[:allowed_ips].nil? and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?

      response, options = Api.send_request("/groups", :post, params, options) { |reply| reply.require_object("Group") }
      Group.new(response.data, options)
    end

    # Update Group
    #
    # @param id [Integer] Group ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] notes Group notes.
    # @option params [String] user_ids A list of user ids. If sent as a string, should be comma-delimited.
    # @option params [String] admin_ids A list of group admin user ids. If sent as a string, should be comma-delimited.
    # @option params [Integer] ai_assistant_personality_id AI Assistant Personality ID assigned to this Group, if any. Users in the Group inherit it unless a direct per-user or Partner assignment overrides it.
    # @option params [Boolean] ftp_permission If true, users in this group can use FTP to login.  This will override a false value of `ftp_permission` on the user level.
    # @option params [Boolean] sftp_permission If true, users in this group can use SFTP to login.  This will override a false value of `sftp_permission` on the user level.
    # @option params [Boolean] dav_permission If true, users in this group can use WebDAV to login.  This will override a false value of `dav_permission` on the user level.
    # @option params [Boolean] restapi_permission If true, users in this group can use the REST API to login.  This will override a false value of `restapi_permission` on the user level.
    # @option params [Boolean] s3_compatible_endpoint_permission If true, users in this group can access the S3-compatible endpoint. This will override a false value of `s3_compatible_endpoint_permission` on the user level. Defaults to false.
    # @option params [Integer] desktop_configuration_profile_id Desktop Configuration Profile ID assigned to this Group, if any. Users in the Group inherit it unless a direct per-user assignment overrides it.
    # @option params [Integer] integration_centric_profile_id Integration Centric Profile ID assigned to this Group, if any. Users in the Group inherit it unless a direct per-user assignment overrides it.
    # @option params [String] allowed_ips A list of allowed IPs if applicable.  Newline delimited
    # @option params [String] name Group name.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Group] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if !params[:notes].nil? and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if !params[:user_ids].nil? and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: admin_ids must be an String") if !params[:admin_ids].nil? and !params[:admin_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ai_assistant_personality_id must be an Integer") if !params[:ai_assistant_personality_id].nil? and !params[:ai_assistant_personality_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ftp_permission must be a single value, not #{params[:ftp_permission].class}") if [ Array, Hash ].any? { |klass| params[:ftp_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_permission must be a single value, not #{params[:sftp_permission].class}") if [ Array, Hash ].any? { |klass| params[:sftp_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: dav_permission must be a single value, not #{params[:dav_permission].class}") if [ Array, Hash ].any? { |klass| params[:dav_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: restapi_permission must be a single value, not #{params[:restapi_permission].class}") if [ Array, Hash ].any? { |klass| params[:restapi_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint_permission must be a single value, not #{params[:s3_compatible_endpoint_permission].class}") if [ Array, Hash ].any? { |klass| params[:s3_compatible_endpoint_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: desktop_configuration_profile_id must be an Integer") if !params[:desktop_configuration_profile_id].nil? and !params[:desktop_configuration_profile_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: integration_centric_profile_id must be an Integer") if !params[:integration_centric_profile_id].nil? and !params[:integration_centric_profile_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if !params[:allowed_ips].nil? and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/groups/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("Group") }
      Group.new(response.data, options)
    end

    # Delete Group
    #
    # @param id [Integer] Group ID.
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

      Api.send_request("/groups/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
