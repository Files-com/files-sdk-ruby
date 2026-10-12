# frozen_string_literal: true

module Files
  # Files::Partner is the Ruby SDK's representation of Files.com API Partner objects.
  # Each instance keeps its API field values in +attributes+.
  class Partner
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # boolean - Allow Partner Admins to change Two-Factor Authentication requirements for Partner Users.
    def allow_bypassing_2fa_policies
      @attributes[:allow_bypassing_2fa_policies]
    end

    def allow_bypassing_2fa_policies=(value)
      @attributes[:allow_bypassing_2fa_policies] = value
    end

    # string - A list of allowed IPs for this Partner. Newline delimited. Partner User IP access is allowed when the IP matches the Partner, User, or Site allowed IP lists.
    def allowed_ips
      @attributes[:allowed_ips]
    end

    def allowed_ips=(value)
      @attributes[:allowed_ips] = value
    end

    # boolean - Allow Partner Admins to change or reset credentials for users belonging to this Partner.
    def allow_credential_changes
      @attributes[:allow_credential_changes]
    end

    def allow_credential_changes=(value)
      @attributes[:allow_credential_changes] = value
    end

    # boolean - Allow Partner Admins to provide GPG keys.
    def allow_providing_gpg_keys
      @attributes[:allow_providing_gpg_keys]
    end

    def allow_providing_gpg_keys=(value)
      @attributes[:allow_providing_gpg_keys] = value
    end

    # boolean - Allow Partner Admins to create users.
    def allow_user_creation
      @attributes[:allow_user_creation]
    end

    def allow_user_creation=(value)
      @attributes[:allow_user_creation] = value
    end

    # boolean - When `true`, emails sent to Partner users are copied to the responsible User or Group.
    def cc_emails_to_responsible_party
      @attributes[:cc_emails_to_responsible_party]
    end

    def cc_emails_to_responsible_party=(value)
      @attributes[:cc_emails_to_responsible_party] = value
    end

    # array(object) - Approved Connected Sites relationships for this Partner, in both directions. Empty when this Partner has no connections. Read-only.
    def connections
      @attributes[:connections]
    end

    def connections=(value)
      @attributes[:connections] = value
    end

    # int64 - The unique ID of the Partner.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - AI Assistant Personality ID assigned to this Partner, if any. Users in the Partner inherit it unless a direct per-user assignment overrides it.
    def ai_assistant_personality_id
      @attributes[:ai_assistant_personality_id]
    end

    def ai_assistant_personality_id=(value)
      @attributes[:ai_assistant_personality_id] = value
    end

    # int64 - ID of the Workspace associated with this Partner.
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # string - The name of the Partner.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Notes about this Partner.
    def notes
      @attributes[:notes]
    end

    def notes=(value)
      @attributes[:notes] = value
    end

    # array(int64) - Array of User IDs that are Partner Admins for this Partner.
    def partner_admin_ids
      @attributes[:partner_admin_ids]
    end

    def partner_admin_ids=(value)
      @attributes[:partner_admin_ids] = value
    end

    # int64 - ID of the Partner Channel Template assigned to this Partner.
    def partner_channel_template_id
      @attributes[:partner_channel_template_id]
    end

    def partner_channel_template_id=(value)
      @attributes[:partner_channel_template_id] = value
    end

    # string - This site's role for this Partner in Connected Sites relationships. `host` is a Partner this site configured. `guest` is a Partner created by approving another site's connection request; it has no root folder and cannot hold users, permissions, or Partner Channels, or host a connection. `host_and_guest` is a configured Partner that is also the guest side of a connection. Promote a `guest` Partner by setting this to `host_and_guest` together with a `root_folder`.
    def partnership_role
      @attributes[:partnership_role]
    end

    def partnership_role=(value)
      @attributes[:partnership_role] = value
    end

    # int64 - ID of the Group responsible for this Partner.
    def responsible_group_id
      @attributes[:responsible_group_id]
    end

    def responsible_group_id=(value)
      @attributes[:responsible_group_id] = value
    end

    # int64 - ID of the User responsible for this Partner.
    def responsible_user_id
      @attributes[:responsible_user_id]
    end

    def responsible_user_id=(value)
      @attributes[:responsible_user_id] = value
    end

    # string - The root folder path for this Partner.
    def root_folder
      @attributes[:root_folder]
    end

    def root_folder=(value)
      @attributes[:root_folder] = value
    end

    # boolean - Show Partner users a simplified home page built from this Partner's Channels.
    def show_partner_channel_home_page
      @attributes[:show_partner_channel_home_page]
    end

    def show_partner_channel_home_page=(value)
      @attributes[:show_partner_channel_home_page] = value
    end

    # string - Comma-separated list of Tags for this Partner. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    def tags
      @attributes[:tags]
    end

    def tags=(value)
      @attributes[:tags] = value
    end

    # array(int64) - Array of User IDs that belong to this Partner.
    def user_ids
      @attributes[:user_ids]
    end

    def user_ids=(value)
      @attributes[:user_ids] = value
    end

    # Parameters:
    #   ai_assistant_personality_id - int64 - AI Assistant Personality ID assigned to this Partner, if any. Users in the Partner inherit it unless a direct per-user assignment overrides it.
    #   allowed_ips - string - A list of allowed IPs for this Partner. Newline delimited. Partner User IP access is allowed when the IP matches the Partner, User, or Site allowed IP lists.
    #   allow_bypassing_2fa_policies - boolean - Allow Partner Admins to change Two-Factor Authentication requirements for Partner Users.
    #   allow_credential_changes - boolean - Allow Partner Admins to change or reset credentials for users belonging to this Partner.
    #   allow_providing_gpg_keys - boolean - Allow Partner Admins to provide GPG keys.
    #   allow_user_creation - boolean - Allow Partner Admins to create users.
    #   cc_emails_to_responsible_party - boolean - When `true`, emails sent to Partner users are copied to the responsible User or Group.
    #   notes - string - Notes about this Partner.
    #   partner_channel_template_id - int64 - ID of the Partner Channel Template assigned to this Partner.
    #   responsible_group_id - int64 - ID of the Group responsible for this Partner.
    #   responsible_user_id - int64 - ID of the User responsible for this Partner.
    #   show_partner_channel_home_page - boolean - Show Partner users a simplified home page built from this Partner's Channels.
    #   tags - string - Comma-separated list of Tags for this Partner. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    #   name - string - The name of the Partner.
    #   partnership_role - string - This site's role for this Partner in Connected Sites relationships. `host` is a Partner this site configured. `guest` is a Partner created by approving another site's connection request; it has no root folder and cannot hold users, permissions, or Partner Channels, or host a connection. `host_and_guest` is a configured Partner that is also the guest side of a connection. Promote a `guest` Partner by setting this to `host_and_guest` together with a `root_folder`.
    #   root_folder - string - The root folder path for this Partner.
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

    # Returns the [response, options] pair from Files::Api.send_request.
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

    # Alias for #delete. Returns nil.
    def destroy(params = {})
      delete(params)
      nil
    end

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

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `name`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id`.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::Partner objects.
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

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Partner ID.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::Partner.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/partners/#{params[:id]}", :get, params, options) { |reply| reply.require_object("Partner") }
      Partner.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   ai_assistant_personality_id - int64 - AI Assistant Personality ID assigned to this Partner, if any. Users in the Partner inherit it unless a direct per-user assignment overrides it.
    #   allowed_ips - string - A list of allowed IPs for this Partner. Newline delimited. Partner User IP access is allowed when the IP matches the Partner, User, or Site allowed IP lists.
    #   allow_bypassing_2fa_policies - boolean - Allow Partner Admins to change Two-Factor Authentication requirements for Partner Users.
    #   allow_credential_changes - boolean - Allow Partner Admins to change or reset credentials for users belonging to this Partner.
    #   allow_providing_gpg_keys - boolean - Allow Partner Admins to provide GPG keys.
    #   allow_user_creation - boolean - Allow Partner Admins to create users.
    #   cc_emails_to_responsible_party - boolean - When `true`, emails sent to Partner users are copied to the responsible User or Group.
    #   notes - string - Notes about this Partner.
    #   partner_channel_template_id - int64 - ID of the Partner Channel Template assigned to this Partner.
    #   responsible_group_id - int64 - ID of the Group responsible for this Partner.
    #   responsible_user_id - int64 - ID of the User responsible for this Partner.
    #   show_partner_channel_home_page - boolean - Show Partner users a simplified home page built from this Partner's Channels.
    #   tags - string - Comma-separated list of Tags for this Partner. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    #   name (required) - string - The name of the Partner.
    #   root_folder (required) - string - The root folder path for this Partner.
    #   workspace_id - int64 - ID of the Workspace associated with this Partner.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::Partner.
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

    # Parameters:
    #   ai_assistant_personality_id - int64 - AI Assistant Personality ID assigned to this Partner, if any. Users in the Partner inherit it unless a direct per-user assignment overrides it.
    #   allowed_ips - string - A list of allowed IPs for this Partner. Newline delimited. Partner User IP access is allowed when the IP matches the Partner, User, or Site allowed IP lists.
    #   allow_bypassing_2fa_policies - boolean - Allow Partner Admins to change Two-Factor Authentication requirements for Partner Users.
    #   allow_credential_changes - boolean - Allow Partner Admins to change or reset credentials for users belonging to this Partner.
    #   allow_providing_gpg_keys - boolean - Allow Partner Admins to provide GPG keys.
    #   allow_user_creation - boolean - Allow Partner Admins to create users.
    #   cc_emails_to_responsible_party - boolean - When `true`, emails sent to Partner users are copied to the responsible User or Group.
    #   notes - string - Notes about this Partner.
    #   partner_channel_template_id - int64 - ID of the Partner Channel Template assigned to this Partner.
    #   responsible_group_id - int64 - ID of the Group responsible for this Partner.
    #   responsible_user_id - int64 - ID of the User responsible for this Partner.
    #   show_partner_channel_home_page - boolean - Show Partner users a simplified home page built from this Partner's Channels.
    #   tags - string - Comma-separated list of Tags for this Partner. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    #   name - string - The name of the Partner.
    #   partnership_role - string - This site's role for this Partner in Connected Sites relationships. `host` is a Partner this site configured. `guest` is a Partner created by approving another site's connection request; it has no root folder and cannot hold users, permissions, or Partner Channels, or host a connection. `host_and_guest` is a configured Partner that is also the guest side of a connection. Promote a `guest` Partner by setting this to `host_and_guest` together with a `root_folder`.
    #   root_folder - string - The root folder path for this Partner.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::Partner.
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

    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns nil.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/partners/#{params[:id]}", :delete, params, options)
      nil
    end

    # Alias for ::delete. Returns nil.
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
