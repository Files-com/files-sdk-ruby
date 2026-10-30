# frozen_string_literal: true

module Files
  # Files::SsoStrategy is the Ruby SDK's representation of Files.com API SsoStrategy objects.
  # Each instance keeps its API field values in +attributes+.
  class SsoStrategy
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

    # SSO Protocol
    # @return [String, nil] the field value, or nil when absent.
    def protocol
      @attributes[:protocol]
    end

    # Provider name
    # @return [String, nil] the field value, or nil when absent.
    def provider
      @attributes[:provider]
    end

    # Custom label for the SSO provider on the login page.
    # @return [String, nil] the field value, or nil when absent.
    def label
      @attributes[:label]
    end

    # URL holding a custom logo for the SSO provider on the login page.
    # @return [String, nil] the field value, or nil when absent.
    def logo_url
      @attributes[:logo_url]
    end

    # ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Is strategy enabled?  This may become automatically set to `false` after a high number and duration of failures.
    # @return [Boolean, nil] the field value, or nil when absent.
    def enabled
      @attributes[:enabled]
    end

    # Count of users with this SSO Strategy
    # @return [Integer, nil] the field value, or nil when absent.
    def user_count
      @attributes[:user_count]
    end

    # Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
    # @return [String, nil] the field value, or nil when absent.
    def saml_provider_cert_fingerprint
      @attributes[:saml_provider_cert_fingerprint]
    end

    # Identity provider issuer url
    # @return [String, nil] the field value, or nil when absent.
    def saml_provider_issuer_url
      @attributes[:saml_provider_issuer_url]
    end

    # Custom identity provider metadata
    # @return [String, nil] the field value, or nil when absent.
    def saml_provider_metadata_content
      @attributes[:saml_provider_metadata_content]
    end

    # Metadata URL for the SAML identity provider
    # @return [String, nil] the field value, or nil when absent.
    def saml_provider_metadata_url
      @attributes[:saml_provider_metadata_url]
    end

    # Identity provider SLO endpoint
    # @return [String, nil] the field value, or nil when absent.
    def saml_provider_slo_target_url
      @attributes[:saml_provider_slo_target_url]
    end

    # Identity provider SSO endpoint if saml_provider_metadata_url is not available.
    # @return [String, nil] the field value, or nil when absent.
    def saml_provider_sso_target_url
      @attributes[:saml_provider_sso_target_url]
    end

    # SCIM authentication type.
    # @return [String, nil] the field value, or nil when absent.
    def scim_authentication_method
      @attributes[:scim_authentication_method]
    end

    # SCIM username.
    # @return [String, nil] the field value, or nil when absent.
    def scim_username
      @attributes[:scim_username]
    end

    # SCIM OAuth Access Token. Only returned when the token is first issued or reset.
    # @return [String, nil] the field value, or nil when absent.
    def scim_oauth_access_token
      @attributes[:scim_oauth_access_token]
    end

    # SCIM OAuth Access Token Expiration Time.
    # @return [String, nil] the field value, or nil when absent.
    def scim_oauth_access_token_expires_at
      @attributes[:scim_oauth_access_token_expires_at]
    end

    # Subdomain or domain name for your auth provider.   Example: `https://[subdomain].okta.com/`
    # @return [String, nil] the field value, or nil when absent.
    def subdomain
      @attributes[:subdomain]
    end

    # Auto-provision users?
    # @return [Boolean, nil] the field value, or nil when absent.
    def provision_users
      @attributes[:provision_users]
    end

    # Auto-provision group membership based on group memberships on the SSO side?
    # @return [Boolean, nil] the field value, or nil when absent.
    def provision_groups
      @attributes[:provision_groups]
    end

    # Auto-deprovision users?
    # @return [Boolean, nil] the field value, or nil when absent.
    def deprovision_users
      @attributes[:deprovision_users]
    end

    # Auto-deprovision group membership based on group memberships on the SSO side?
    # @return [Boolean, nil] the field value, or nil when absent.
    def deprovision_groups
      @attributes[:deprovision_groups]
    end

    # Method used for deprovisioning users.
    # @return [String, nil] the field value, or nil when absent.
    def deprovision_behavior
      @attributes[:deprovision_behavior]
    end

    # Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
    # @return [String, nil] the field value, or nil when absent.
    def provision_group_default
      @attributes[:provision_group_default]
    end

    # Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
    # @return [String, nil] the field value, or nil when absent.
    def provision_group_exclusion
      @attributes[:provision_group_exclusion]
    end

    # Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
    # @return [String, nil] the field value, or nil when absent.
    def provision_group_inclusion
      @attributes[:provision_group_inclusion]
    end

    # Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
    # @return [String, nil] the field value, or nil when absent.
    def provision_group_required
      @attributes[:provision_group_required]
    end

    # Comma-separated list of group names whose members will be created with email_signup authentication.
    # @return [String, nil] the field value, or nil when absent.
    def provision_email_signup_groups
      @attributes[:provision_email_signup_groups]
    end

    # Comma-separated list of group names used to grant or remove Read-Only Site Admin access for users on this SSO provider. When this list is nonempty and a directory sync changes a user's group membership, membership in at least one listed group grants this access; membership in none removes it, including access granted manually. Directory syncs include SCIM requests from any provider on the site, LDAP syncs, and sign-ins that set the user's groups from the identity provider. Membership changes made any other way, including through the web app, API, SDKs, or CLI, do not affect administrator access.
    # @return [String, nil] the field value, or nil when absent.
    def provision_readonly_site_admin_groups
      @attributes[:provision_readonly_site_admin_groups]
    end

    # Comma-separated list of group names used to grant or remove Site Admin access for users on this SSO provider. When this list is nonempty and a directory sync changes a user's group membership, membership in at least one listed group grants this access; membership in none removes it, including access granted manually. Directory syncs include SCIM requests from any provider on the site, LDAP syncs, and sign-ins that set the user's groups from the identity provider. Membership changes made any other way, including through the web app, API, SDKs, or CLI, do not affect administrator access.
    # @return [String, nil] the field value, or nil when absent.
    def provision_site_admin_groups
      @attributes[:provision_site_admin_groups]
    end

    # Comma-separated list of group names whose members will be provisioned as Group Admins.
    # @return [String, nil] the field value, or nil when absent.
    def provision_group_admin_groups
      @attributes[:provision_group_admin_groups]
    end

    #
    # @return [Boolean, nil] the field value, or nil when absent.
    def provision_attachments_permission
      @attributes[:provision_attachments_permission]
    end

    # Auto-provisioned users get WebDAV permission?
    # @return [Boolean, nil] the field value, or nil when absent.
    def provision_dav_permission
      @attributes[:provision_dav_permission]
    end

    # Auto-provisioned users get FTP permission?
    # @return [Boolean, nil] the field value, or nil when absent.
    def provision_ftp_permission
      @attributes[:provision_ftp_permission]
    end

    # Auto-provisioned users get SFTP permission?
    # @return [Boolean, nil] the field value, or nil when absent.
    def provision_sftp_permission
      @attributes[:provision_sftp_permission]
    end

    # Default time zone for auto provisioned users.
    # @return [String, nil] the field value, or nil when absent.
    def provision_time_zone
      @attributes[:provision_time_zone]
    end

    # Default company for auto provisioned users.
    # @return [String, nil] the field value, or nil when absent.
    def provision_company
      @attributes[:provision_company]
    end

    # 2FA required setting for auto provisioned users. `use_system_setting` uses the site-wide setting, including SSO exemptions. `always_require` and `never_require` override the site-wide setting when user-level overrides are allowed.
    # @return [String, nil] the field value, or nil when absent.
    def provision_require_2fa
      @attributes[:provision_require_2fa]
    end

    # File System layout to use for auto provisioned users.
    # @return [String, nil] the field value, or nil when absent.
    def provision_filesystem_layout
      @attributes[:provision_filesystem_layout]
    end

    # URL-friendly, unique identifier for Azure SAML configuration
    # @return [String, nil] the field value, or nil when absent.
    def provider_identifier
      @attributes[:provider_identifier]
    end

    # Base DN for looking up users in LDAP server
    # @return [String, nil] the field value, or nil when absent.
    def ldap_base_dn
      @attributes[:ldap_base_dn]
    end

    # Domain name that will be appended to LDAP usernames
    # @return [String, nil] the field value, or nil when absent.
    def ldap_domain
      @attributes[:ldap_domain]
    end

    # Should this strategy be displayed on the login page?
    # @return [Boolean, nil] the field value, or nil when absent.
    def display_on_login_page
      @attributes[:display_on_login_page]
    end

    # LDAP host
    # @return [String, nil] the field value, or nil when absent.
    def ldap_host
      @attributes[:ldap_host]
    end

    # LDAP backup host
    # @return [String, nil] the field value, or nil when absent.
    def ldap_host_2
      @attributes[:ldap_host_2]
    end

    # LDAP backup host
    # @return [String, nil] the field value, or nil when absent.
    def ldap_host_3
      @attributes[:ldap_host_3]
    end

    # LDAP port
    # @return [Integer, nil] the field value, or nil when absent.
    def ldap_port
      @attributes[:ldap_port]
    end

    # Use LDAP server settings for scheduled provisioning while using this SSO provider for authentication?
    # @return [Boolean, nil] the field value, or nil when absent.
    def ldap_provisioning_enabled
      @attributes[:ldap_provisioning_enabled]
    end

    # Use secure LDAP?
    # @return [Boolean, nil] the field value, or nil when absent.
    def ldap_secure
      @attributes[:ldap_secure]
    end

    # How to validate the LDAP server certificate. `require_match` validates the certificate chain and hostname; `allow_any` disables certificate validation.
    # @return [String, nil] the field value, or nil when absent.
    def ldap_server_certificate
      @attributes[:ldap_server_certificate]
    end

    # LDAP server type
    # @return [String, nil] the field value, or nil when absent.
    def ldap_type
      @attributes[:ldap_type]
    end

    # Username for signing in to LDAP server.
    # @return [String, nil] the field value, or nil when absent.
    def ldap_username
      @attributes[:ldap_username]
    end

    # LDAP username field
    # @return [String, nil] the field value, or nil when absent.
    def ldap_username_field
      @attributes[:ldap_username_field]
    end

    # Synchronize provisioning data with the SSO remote server
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def sync(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/sso_strategies/#{@attributes[:id]}/sync", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # List SSO Strategies
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)

      list_options = options.dup
      List.new(SsoStrategy, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/sso_strategies", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show SSO Strategy
    #
    # @param id [Integer] Sso Strategy ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::SsoStrategy] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/sso_strategies/#{params[:id]}", :get, params, options) { |reply| reply.require_object("SsoStrategy") }
      SsoStrategy.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Synchronize provisioning data with the SSO remote server
    #
    # @param id [Integer] Sso Strategy ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.sync(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/sso_strategies/#{params[:id]}/sync", :post, params, options)
      nil
    end
  end
end
