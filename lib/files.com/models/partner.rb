# frozen_string_literal: true

module Files
  # Files::Partner is the Ruby SDK's representation of Files.com API Partner objects.
  # Each instance keeps its API field values in +attributes+.
  class Partner
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

    # Allow Partner Admins to change Two-Factor Authentication requirements for Partner Users.
    # @return [Boolean, nil] the field value, or nil when absent.
    def allow_bypassing_2fa_policies
      @attributes[:allow_bypassing_2fa_policies]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def allow_bypassing_2fa_policies=(value)
      @attributes[:allow_bypassing_2fa_policies] = value
    end

    # A list of allowed IPs for this Partner. Newline delimited. Partner User IP access is allowed when the IP matches the Partner, User, or Site allowed IP lists.
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

    # Allow Partner Admins to change or reset credentials for users belonging to this Partner.
    # @return [Boolean, nil] the field value, or nil when absent.
    def allow_credential_changes
      @attributes[:allow_credential_changes]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def allow_credential_changes=(value)
      @attributes[:allow_credential_changes] = value
    end

    # Allow Partner Admins to provide GPG keys.
    # @return [Boolean, nil] the field value, or nil when absent.
    def allow_providing_gpg_keys
      @attributes[:allow_providing_gpg_keys]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def allow_providing_gpg_keys=(value)
      @attributes[:allow_providing_gpg_keys] = value
    end

    # Allow Partner Admins to create users.
    # @return [Boolean, nil] the field value, or nil when absent.
    def allow_user_creation
      @attributes[:allow_user_creation]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def allow_user_creation=(value)
      @attributes[:allow_user_creation] = value
    end

    # When `true`, emails sent to Partner users are copied to the responsible User or Group.
    # @return [Boolean, nil] the field value, or nil when absent.
    def cc_emails_to_responsible_party
      @attributes[:cc_emails_to_responsible_party]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def cc_emails_to_responsible_party=(value)
      @attributes[:cc_emails_to_responsible_party] = value
    end

    # Approved Connected Sites relationships for this Partner, in both directions. Empty when this Partner has no connections. Read-only.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def connections
      @attributes[:connections]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Hash>, nil] the new field value.
    # @return [Array<Hash>, nil] the assigned value.
    def connections=(value)
      @attributes[:connections] = value
    end

    # The unique ID of the Partner.
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

    # AI Assistant Personality ID assigned to this Partner, if any. Users in the Partner inherit it unless a direct per-user assignment overrides it.
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

    # ID of the Workspace associated with this Partner.
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

    # The name of the Partner.
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

    # Notes about this Partner.
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

    # Array of User IDs that are Partner Admins for this Partner.
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def partner_admin_ids
      @attributes[:partner_admin_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def partner_admin_ids=(value)
      @attributes[:partner_admin_ids] = value
    end

    # ID of the Partner Channel Template assigned to this Partner.
    # @return [Integer, nil] the field value, or nil when absent.
    def partner_channel_template_id
      @attributes[:partner_channel_template_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def partner_channel_template_id=(value)
      @attributes[:partner_channel_template_id] = value
    end

    # This site's role for this Partner in Connected Sites relationships. `host` is a Partner this site configured. `guest` is a Partner created by approving another site's connection request; it has no root folder and cannot hold users, permissions, or Partner Channels, or host a connection. `host_and_guest` is a configured Partner that is also the guest side of a connection. Promote a `guest` Partner by setting this to `host_and_guest` together with a `root_folder`.
    # @return [String, nil] the field value, or nil when absent.
    def partnership_role
      @attributes[:partnership_role]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def partnership_role=(value)
      @attributes[:partnership_role] = value
    end

    # ID of the Group responsible for this Partner.
    # @return [Integer, nil] the field value, or nil when absent.
    def responsible_group_id
      @attributes[:responsible_group_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def responsible_group_id=(value)
      @attributes[:responsible_group_id] = value
    end

    # ID of the User responsible for this Partner.
    # @return [Integer, nil] the field value, or nil when absent.
    def responsible_user_id
      @attributes[:responsible_user_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def responsible_user_id=(value)
      @attributes[:responsible_user_id] = value
    end

    # The root folder path for this Partner.
    # @return [String, nil] the field value, or nil when absent.
    def root_folder
      @attributes[:root_folder]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def root_folder=(value)
      @attributes[:root_folder] = value
    end

    # Show Partner users a simplified home page built from this Partner's Channels.
    # @return [Boolean, nil] the field value, or nil when absent.
    def show_partner_channel_home_page
      @attributes[:show_partner_channel_home_page]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def show_partner_channel_home_page=(value)
      @attributes[:show_partner_channel_home_page] = value
    end

    # Comma-separated list of Tags for this Partner. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    # @return [String, nil] the field value, or nil when absent.
    def tags
      @attributes[:tags]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def tags=(value)
      @attributes[:tags] = value
    end

    # Array of User IDs that belong to this Partner.
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def user_ids
      @attributes[:user_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def user_ids=(value)
      @attributes[:user_ids] = value
    end

    # Update Partner
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] ai_assistant_personality_id AI Assistant Personality ID assigned to this Partner, if any. Users in the Partner inherit it unless a direct per-user assignment overrides it.
    # @option params [String] allowed_ips A list of allowed IPs for this Partner. Newline delimited. Partner User IP access is allowed when the IP matches the Partner, User, or Site allowed IP lists.
    # @option params [Boolean] allow_bypassing_2fa_policies Allow Partner Admins to change Two-Factor Authentication requirements for Partner Users.
    # @option params [Boolean] allow_credential_changes Allow Partner Admins to change or reset credentials for users belonging to this Partner.
    # @option params [Boolean] allow_providing_gpg_keys Allow Partner Admins to provide GPG keys.
    # @option params [Boolean] allow_user_creation Allow Partner Admins to create users.
    # @option params [Boolean] cc_emails_to_responsible_party When `true`, emails sent to Partner users are copied to the responsible User or Group.
    # @option params [String] notes Notes about this Partner.
    # @option params [Integer] partner_channel_template_id ID of the Partner Channel Template assigned to this Partner.
    # @option params [Integer] responsible_group_id ID of the Group responsible for this Partner.
    # @option params [Integer] responsible_user_id ID of the User responsible for this Partner.
    # @option params [Boolean] show_partner_channel_home_page Show Partner users a simplified home page built from this Partner's Channels.
    # @option params [String] tags Comma-separated list of Tags for this Partner. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    # @option params [String] name The name of the Partner.
    # @option params [String] partnership_role This site's role for this Partner in Connected Sites relationships. `host` is a Partner this site configured. `guest` is a Partner created by approving another site's connection request; it has no root folder and cannot hold users, permissions, or Partner Channels, or host a connection. `host_and_guest` is a configured Partner that is also the guest side of a connection. Promote a `guest` Partner by setting this to `host_and_guest` together with a `root_folder`.
    # @option params [String] root_folder The root folder path for this Partner.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ai_assistant_personality_id must be an Integer") if !params[:ai_assistant_personality_id].nil? and !params[:ai_assistant_personality_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if !params[:allowed_ips].nil? and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allow_bypassing_2fa_policies must be a single value, not #{params[:allow_bypassing_2fa_policies].class}") if [ Array, Hash ].any? { |klass| params[:allow_bypassing_2fa_policies].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allow_credential_changes must be a single value, not #{params[:allow_credential_changes].class}") if [ Array, Hash ].any? { |klass| params[:allow_credential_changes].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allow_providing_gpg_keys must be a single value, not #{params[:allow_providing_gpg_keys].class}") if [ Array, Hash ].any? { |klass| params[:allow_providing_gpg_keys].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allow_user_creation must be a single value, not #{params[:allow_user_creation].class}") if [ Array, Hash ].any? { |klass| params[:allow_user_creation].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: cc_emails_to_responsible_party must be a single value, not #{params[:cc_emails_to_responsible_party].class}") if [ Array, Hash ].any? { |klass| params[:cc_emails_to_responsible_party].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if !params[:notes].nil? and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: partner_channel_template_id must be an Integer") if !params[:partner_channel_template_id].nil? and !params[:partner_channel_template_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: responsible_group_id must be an Integer") if !params[:responsible_group_id].nil? and !params[:responsible_group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: responsible_user_id must be an Integer") if !params[:responsible_user_id].nil? and !params[:responsible_user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: show_partner_channel_home_page must be a single value, not #{params[:show_partner_channel_home_page].class}") if [ Array, Hash ].any? { |klass| params[:show_partner_channel_home_page].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: tags must be an String") if !params[:tags].nil? and !params[:tags].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: partnership_role must be an String") if !params[:partnership_role].nil? and !params[:partnership_role].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: root_folder must be an String") if !params[:root_folder].nil? and !params[:root_folder].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/partners/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("Partner") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Partner
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

      response, options = Api.send_request("/partners/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = Partner.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Partners
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `name`.
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
      List.new(Partner, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/partners", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Partner
    #
    # @param id [Integer] Partner ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Partner] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/partners/#{params[:id]}", :get, params, options) { |reply| reply.require_object("Partner") }
      Partner.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Partner
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] ai_assistant_personality_id AI Assistant Personality ID assigned to this Partner, if any. Users in the Partner inherit it unless a direct per-user assignment overrides it.
    # @option params [String] allowed_ips A list of allowed IPs for this Partner. Newline delimited. Partner User IP access is allowed when the IP matches the Partner, User, or Site allowed IP lists.
    # @option params [Boolean] allow_bypassing_2fa_policies Allow Partner Admins to change Two-Factor Authentication requirements for Partner Users.
    # @option params [Boolean] allow_credential_changes Allow Partner Admins to change or reset credentials for users belonging to this Partner.
    # @option params [Boolean] allow_providing_gpg_keys Allow Partner Admins to provide GPG keys.
    # @option params [Boolean] allow_user_creation Allow Partner Admins to create users.
    # @option params [Boolean] cc_emails_to_responsible_party When `true`, emails sent to Partner users are copied to the responsible User or Group.
    # @option params [String] notes Notes about this Partner.
    # @option params [Integer] partner_channel_template_id ID of the Partner Channel Template assigned to this Partner.
    # @option params [Integer] responsible_group_id ID of the Group responsible for this Partner.
    # @option params [Integer] responsible_user_id ID of the User responsible for this Partner.
    # @option params [Boolean] show_partner_channel_home_page Show Partner users a simplified home page built from this Partner's Channels.
    # @option params [String] tags Comma-separated list of Tags for this Partner. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    # @option params [String] name Required. The name of the Partner.
    # @option params [String] root_folder Required. The root folder path for this Partner.
    # @option params [Integer] workspace_id ID of the Workspace associated with this Partner.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Partner] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: ai_assistant_personality_id must be an Integer") if !params[:ai_assistant_personality_id].nil? and !params[:ai_assistant_personality_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if !params[:allowed_ips].nil? and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allow_bypassing_2fa_policies must be a single value, not #{params[:allow_bypassing_2fa_policies].class}") if [ Array, Hash ].any? { |klass| params[:allow_bypassing_2fa_policies].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allow_credential_changes must be a single value, not #{params[:allow_credential_changes].class}") if [ Array, Hash ].any? { |klass| params[:allow_credential_changes].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allow_providing_gpg_keys must be a single value, not #{params[:allow_providing_gpg_keys].class}") if [ Array, Hash ].any? { |klass| params[:allow_providing_gpg_keys].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allow_user_creation must be a single value, not #{params[:allow_user_creation].class}") if [ Array, Hash ].any? { |klass| params[:allow_user_creation].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: cc_emails_to_responsible_party must be a single value, not #{params[:cc_emails_to_responsible_party].class}") if [ Array, Hash ].any? { |klass| params[:cc_emails_to_responsible_party].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if !params[:notes].nil? and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: partner_channel_template_id must be an Integer") if !params[:partner_channel_template_id].nil? and !params[:partner_channel_template_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: responsible_group_id must be an Integer") if !params[:responsible_group_id].nil? and !params[:responsible_group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: responsible_user_id must be an Integer") if !params[:responsible_user_id].nil? and !params[:responsible_user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: show_partner_channel_home_page must be a single value, not #{params[:show_partner_channel_home_page].class}") if [ Array, Hash ].any? { |klass| params[:show_partner_channel_home_page].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: tags must be an String") if !params[:tags].nil? and !params[:tags].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: root_folder must be an String") if !params[:root_folder].nil? and !params[:root_folder].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?
      raise MissingParameterError.new("Parameter missing: root_folder") if params[:root_folder].nil?

      response, options = Api.send_request("/partners", :post, params, options) { |reply| reply.require_object("Partner") }
      Partner.new(response.data, options)
    end

    # Update Partner
    #
    # @param id [Integer] Partner ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] ai_assistant_personality_id AI Assistant Personality ID assigned to this Partner, if any. Users in the Partner inherit it unless a direct per-user assignment overrides it.
    # @option params [String] allowed_ips A list of allowed IPs for this Partner. Newline delimited. Partner User IP access is allowed when the IP matches the Partner, User, or Site allowed IP lists.
    # @option params [Boolean] allow_bypassing_2fa_policies Allow Partner Admins to change Two-Factor Authentication requirements for Partner Users.
    # @option params [Boolean] allow_credential_changes Allow Partner Admins to change or reset credentials for users belonging to this Partner.
    # @option params [Boolean] allow_providing_gpg_keys Allow Partner Admins to provide GPG keys.
    # @option params [Boolean] allow_user_creation Allow Partner Admins to create users.
    # @option params [Boolean] cc_emails_to_responsible_party When `true`, emails sent to Partner users are copied to the responsible User or Group.
    # @option params [String] notes Notes about this Partner.
    # @option params [Integer] partner_channel_template_id ID of the Partner Channel Template assigned to this Partner.
    # @option params [Integer] responsible_group_id ID of the Group responsible for this Partner.
    # @option params [Integer] responsible_user_id ID of the User responsible for this Partner.
    # @option params [Boolean] show_partner_channel_home_page Show Partner users a simplified home page built from this Partner's Channels.
    # @option params [String] tags Comma-separated list of Tags for this Partner. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    # @option params [String] name The name of the Partner.
    # @option params [String] partnership_role This site's role for this Partner in Connected Sites relationships. `host` is a Partner this site configured. `guest` is a Partner created by approving another site's connection request; it has no root folder and cannot hold users, permissions, or Partner Channels, or host a connection. `host_and_guest` is a configured Partner that is also the guest side of a connection. Promote a `guest` Partner by setting this to `host_and_guest` together with a `root_folder`.
    # @option params [String] root_folder The root folder path for this Partner.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Partner] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ai_assistant_personality_id must be an Integer") if !params[:ai_assistant_personality_id].nil? and !params[:ai_assistant_personality_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if !params[:allowed_ips].nil? and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allow_bypassing_2fa_policies must be a single value, not #{params[:allow_bypassing_2fa_policies].class}") if [ Array, Hash ].any? { |klass| params[:allow_bypassing_2fa_policies].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allow_credential_changes must be a single value, not #{params[:allow_credential_changes].class}") if [ Array, Hash ].any? { |klass| params[:allow_credential_changes].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allow_providing_gpg_keys must be a single value, not #{params[:allow_providing_gpg_keys].class}") if [ Array, Hash ].any? { |klass| params[:allow_providing_gpg_keys].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allow_user_creation must be a single value, not #{params[:allow_user_creation].class}") if [ Array, Hash ].any? { |klass| params[:allow_user_creation].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: cc_emails_to_responsible_party must be a single value, not #{params[:cc_emails_to_responsible_party].class}") if [ Array, Hash ].any? { |klass| params[:cc_emails_to_responsible_party].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if !params[:notes].nil? and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: partner_channel_template_id must be an Integer") if !params[:partner_channel_template_id].nil? and !params[:partner_channel_template_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: responsible_group_id must be an Integer") if !params[:responsible_group_id].nil? and !params[:responsible_group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: responsible_user_id must be an Integer") if !params[:responsible_user_id].nil? and !params[:responsible_user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: show_partner_channel_home_page must be a single value, not #{params[:show_partner_channel_home_page].class}") if [ Array, Hash ].any? { |klass| params[:show_partner_channel_home_page].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: tags must be an String") if !params[:tags].nil? and !params[:tags].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: partnership_role must be an String") if !params[:partnership_role].nil? and !params[:partnership_role].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: root_folder must be an String") if !params[:root_folder].nil? and !params[:root_folder].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/partners/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("Partner") }
      Partner.new(response.data, options)
    end

    # Delete Partner
    #
    # @param id [Integer] Partner ID.
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

      Api.send_request("/partners/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
