# frozen_string_literal: true

module Files
  class SsoStrategy
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - SSO Protocol
    def protocol
      @attributes[:protocol]
    end

    def protocol=(value)
      @attributes[:protocol] = value
    end

    # string - Provider name
    def provider
      @attributes[:provider]
    end

    def provider=(value)
      @attributes[:provider] = value
    end

    # string - Custom label for the SSO provider on the login page.
    def label
      @attributes[:label]
    end

    def label=(value)
      @attributes[:label] = value
    end

    # string - URL holding a custom logo for the SSO provider on the login page.
    def logo_url
      @attributes[:logo_url]
    end

    def logo_url=(value)
      @attributes[:logo_url] = value
    end

    # int64 - ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Count of users with this SSO Strategy
    def user_count
      @attributes[:user_count]
    end

    def user_count=(value)
      @attributes[:user_count] = value
    end

    # string - Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
    def saml_provider_cert_fingerprint
      @attributes[:saml_provider_cert_fingerprint]
    end

    def saml_provider_cert_fingerprint=(value)
      @attributes[:saml_provider_cert_fingerprint] = value
    end

    # string - Identity provider issuer url
    def saml_provider_issuer_url
      @attributes[:saml_provider_issuer_url]
    end

    def saml_provider_issuer_url=(value)
      @attributes[:saml_provider_issuer_url] = value
    end

    # string - Custom identity provider metadata
    def saml_provider_metadata_content
      @attributes[:saml_provider_metadata_content]
    end

    def saml_provider_metadata_content=(value)
      @attributes[:saml_provider_metadata_content] = value
    end

    # string - Metadata URL for the SAML identity provider
    def saml_provider_metadata_url
      @attributes[:saml_provider_metadata_url]
    end

    def saml_provider_metadata_url=(value)
      @attributes[:saml_provider_metadata_url] = value
    end

    # string - Identity provider SLO endpoint
    def saml_provider_slo_target_url
      @attributes[:saml_provider_slo_target_url]
    end

    def saml_provider_slo_target_url=(value)
      @attributes[:saml_provider_slo_target_url] = value
    end

    # string - Identity provider SSO endpoint if saml_provider_metadata_url is not available.
    def saml_provider_sso_target_url
      @attributes[:saml_provider_sso_target_url]
    end

    def saml_provider_sso_target_url=(value)
      @attributes[:saml_provider_sso_target_url] = value
    end

    # string - SCIM authentication type.
    def scim_authentication_method
      @attributes[:scim_authentication_method]
    end

    def scim_authentication_method=(value)
      @attributes[:scim_authentication_method] = value
    end

    # string - SCIM username.
    def scim_username
      @attributes[:scim_username]
    end

    def scim_username=(value)
      @attributes[:scim_username] = value
    end

    # string - SCIM OAuth Access Token.
    def scim_oauth_access_token
      @attributes[:scim_oauth_access_token]
    end

    def scim_oauth_access_token=(value)
      @attributes[:scim_oauth_access_token] = value
    end

    # string - SCIM OAuth Access Token Expiration Time.
    def scim_oauth_access_token_expires_at
      @attributes[:scim_oauth_access_token_expires_at]
    end

    def scim_oauth_access_token_expires_at=(value)
      @attributes[:scim_oauth_access_token_expires_at] = value
    end

    # string - Subdomain or domain name for your auth provider.   Example: `https://[subdomain].okta.com/`
    def subdomain
      @attributes[:subdomain]
    end

    def subdomain=(value)
      @attributes[:subdomain] = value
    end

    # boolean - Auto-provision users?
    def provision_users
      @attributes[:provision_users]
    end

    def provision_users=(value)
      @attributes[:provision_users] = value
    end

    # boolean - Auto-provision group membership based on group memberships on the SSO side?
    def provision_groups
      @attributes[:provision_groups]
    end

    def provision_groups=(value)
      @attributes[:provision_groups] = value
    end

    # boolean - Auto-deprovision users?
    def deprovision_users
      @attributes[:deprovision_users]
    end

    def deprovision_users=(value)
      @attributes[:deprovision_users] = value
    end

    # boolean - Auto-deprovision group membership based on group memberships on the SSO side?
    def deprovision_groups
      @attributes[:deprovision_groups]
    end

    def deprovision_groups=(value)
      @attributes[:deprovision_groups] = value
    end

    # string - Method used for deprovisioning users.
    def deprovision_behavior
      @attributes[:deprovision_behavior]
    end

    def deprovision_behavior=(value)
      @attributes[:deprovision_behavior] = value
    end

    # string - Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
    def provision_group_default
      @attributes[:provision_group_default]
    end

    def provision_group_default=(value)
      @attributes[:provision_group_default] = value
    end

    # string - Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
    def provision_group_exclusion
      @attributes[:provision_group_exclusion]
    end

    def provision_group_exclusion=(value)
      @attributes[:provision_group_exclusion] = value
    end

    # string - Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
    def provision_group_inclusion
      @attributes[:provision_group_inclusion]
    end

    def provision_group_inclusion=(value)
      @attributes[:provision_group_inclusion] = value
    end

    # string - Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
    def provision_group_required
      @attributes[:provision_group_required]
    end

    def provision_group_required=(value)
      @attributes[:provision_group_required] = value
    end

    # string - Comma-separated list of group names whose members will be created with email_signup authentication.
    def provision_email_signup_groups
      @attributes[:provision_email_signup_groups]
    end

    def provision_email_signup_groups=(value)
      @attributes[:provision_email_signup_groups] = value
    end

    # string - Comma-separated list of group names whose members will be created as Read-Only Site Admins.
    def provision_readonly_site_admin_groups
      @attributes[:provision_readonly_site_admin_groups]
    end

    def provision_readonly_site_admin_groups=(value)
      @attributes[:provision_readonly_site_admin_groups] = value
    end

    # string - Comma-separated list of group names whose members will be created as Site Admins.
    def provision_site_admin_groups
      @attributes[:provision_site_admin_groups]
    end

    def provision_site_admin_groups=(value)
      @attributes[:provision_site_admin_groups] = value
    end

    # string - Comma-separated list of group names whose members will be provisioned as Group Admins.
    def provision_group_admin_groups
      @attributes[:provision_group_admin_groups]
    end

    def provision_group_admin_groups=(value)
      @attributes[:provision_group_admin_groups] = value
    end

    # boolean
    def provision_attachments_permission
      @attributes[:provision_attachments_permission]
    end

    def provision_attachments_permission=(value)
      @attributes[:provision_attachments_permission] = value
    end

    # boolean - Auto-provisioned users get WebDAV permission?
    def provision_dav_permission
      @attributes[:provision_dav_permission]
    end

    def provision_dav_permission=(value)
      @attributes[:provision_dav_permission] = value
    end

    # boolean - Auto-provisioned users get FTP permission?
    def provision_ftp_permission
      @attributes[:provision_ftp_permission]
    end

    def provision_ftp_permission=(value)
      @attributes[:provision_ftp_permission] = value
    end

    # boolean - Auto-provisioned users get SFTP permission?
    def provision_sftp_permission
      @attributes[:provision_sftp_permission]
    end

    def provision_sftp_permission=(value)
      @attributes[:provision_sftp_permission] = value
    end

    # string - Default time zone for auto provisioned users.
    def provision_time_zone
      @attributes[:provision_time_zone]
    end

    def provision_time_zone=(value)
      @attributes[:provision_time_zone] = value
    end

    # string - Default company for auto provisioned users.
    def provision_company
      @attributes[:provision_company]
    end

    def provision_company=(value)
      @attributes[:provision_company] = value
    end

    # string - 2FA required setting for auto provisioned users. `use_system_setting` uses the site-wide setting, including SSO exemptions. `always_require` and `never_require` override the site-wide setting when user-level overrides are allowed.
    def provision_require_2fa
      @attributes[:provision_require_2fa]
    end

    def provision_require_2fa=(value)
      @attributes[:provision_require_2fa] = value
    end

    # string - File System layout to use for auto provisioned users.
    def provision_filesystem_layout
      @attributes[:provision_filesystem_layout]
    end

    def provision_filesystem_layout=(value)
      @attributes[:provision_filesystem_layout] = value
    end

    # string - URL-friendly, unique identifier for Azure SAML configuration
    def provider_identifier
      @attributes[:provider_identifier]
    end

    def provider_identifier=(value)
      @attributes[:provider_identifier] = value
    end

    # string - Base DN for looking up users in LDAP server
    def ldap_base_dn
      @attributes[:ldap_base_dn]
    end

    def ldap_base_dn=(value)
      @attributes[:ldap_base_dn] = value
    end

    # string - Domain name that will be appended to LDAP usernames
    def ldap_domain
      @attributes[:ldap_domain]
    end

    def ldap_domain=(value)
      @attributes[:ldap_domain] = value
    end

    # boolean - Is strategy enabled?  This may become automatically set to `false` after a high number and duration of failures.
    def enabled
      @attributes[:enabled]
    end

    def enabled=(value)
      @attributes[:enabled] = value
    end

    # boolean - Should this strategy be displayed on the login page?
    def display_on_login_page
      @attributes[:display_on_login_page]
    end

    def display_on_login_page=(value)
      @attributes[:display_on_login_page] = value
    end

    # string - LDAP host
    def ldap_host
      @attributes[:ldap_host]
    end

    def ldap_host=(value)
      @attributes[:ldap_host] = value
    end

    # string - LDAP backup host
    def ldap_host_2
      @attributes[:ldap_host_2]
    end

    def ldap_host_2=(value)
      @attributes[:ldap_host_2] = value
    end

    # string - LDAP backup host
    def ldap_host_3
      @attributes[:ldap_host_3]
    end

    def ldap_host_3=(value)
      @attributes[:ldap_host_3] = value
    end

    # int64 - LDAP port
    def ldap_port
      @attributes[:ldap_port]
    end

    def ldap_port=(value)
      @attributes[:ldap_port] = value
    end

    # boolean - Use LDAP server settings for scheduled provisioning while using this SSO provider for authentication?
    def ldap_provisioning_enabled
      @attributes[:ldap_provisioning_enabled]
    end

    def ldap_provisioning_enabled=(value)
      @attributes[:ldap_provisioning_enabled] = value
    end

    # boolean - Use secure LDAP?
    def ldap_secure
      @attributes[:ldap_secure]
    end

    def ldap_secure=(value)
      @attributes[:ldap_secure] = value
    end

    # string - LDAP server type
    def ldap_type
      @attributes[:ldap_type]
    end

    def ldap_type=(value)
      @attributes[:ldap_type] = value
    end

    # string - Username for signing in to LDAP server.
    def ldap_username
      @attributes[:ldap_username]
    end

    def ldap_username=(value)
      @attributes[:ldap_username] = value
    end

    # string - LDAP username field
    def ldap_username_field
      @attributes[:ldap_username_field]
    end

    def ldap_username_field=(value)
      @attributes[:ldap_username_field] = value
    end

    # string - OAuth Client ID for your auth provider.
    def client_id
      @attributes[:client_id]
    end

    def client_id=(value)
      @attributes[:client_id] = value
    end

    # string - OAuth Client Secret for your auth provider.
    def client_secret
      @attributes[:client_secret]
    end

    def client_secret=(value)
      @attributes[:client_secret] = value
    end

    # string - Password for signing in to LDAP server.
    def ldap_password
      @attributes[:ldap_password]
    end

    def ldap_password=(value)
      @attributes[:ldap_password] = value
    end

    # boolean - If true, the logo will be deleted.
    def logo_delete
      @attributes[:logo_delete]
    end

    def logo_delete=(value)
      @attributes[:logo_delete] = value
    end

    # file - A logo to display on the login page.
    def logo_file
      @attributes[:logo_file]
    end

    def logo_file=(value)
      @attributes[:logo_file] = value
    end

    # boolean - If true, perform a reset on SCIM OAuth access token
    def reset_scim_oauth_access_token
      @attributes[:reset_scim_oauth_access_token]
    end

    def reset_scim_oauth_access_token=(value)
      @attributes[:reset_scim_oauth_access_token] = value
    end

    # string - SCIM password applicable to basic authentication.
    def scim_password
      @attributes[:scim_password]
    end

    def scim_password=(value)
      @attributes[:scim_password] = value
    end

    # Synchronize provisioning data with the SSO remote server
    def sync(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/sso_strategies/#{@attributes[:id]}/sync", :post, params, @options)
    end

    # Parameters:
    #   client_id - string - OAuth Client ID for your auth provider.
    #   client_secret - string - OAuth Client Secret for your auth provider.
    #   ldap_password - string - Password for signing in to LDAP server.
    #   logo_delete - boolean - If true, the logo will be deleted.
    #   logo_file - file - A logo to display on the login page.
    #   reset_scim_oauth_access_token - boolean - If true, perform a reset on SCIM OAuth access token
    #   scim_password - string - SCIM password applicable to basic authentication.
    #   deprovision_behavior - string - Method used for deprovisioning users.
    #   deprovision_groups - boolean - Auto-deprovision group membership based on group memberships on the SSO side?
    #   deprovision_users - boolean - Auto-deprovision users?
    #   display_on_login_page - boolean - Should this strategy be displayed on the login page?
    #   enabled - boolean - Is strategy enabled?  This may become automatically set to `false` after a high number and duration of failures.
    #   label - string - Custom label for the SSO provider on the login page.
    #   ldap_base_dn - string - Base DN for looking up users in LDAP server
    #   ldap_domain - string - Domain name that will be appended to LDAP usernames
    #   ldap_host - string - LDAP host
    #   ldap_host_2 - string - LDAP backup host
    #   ldap_host_3 - string - LDAP backup host
    #   ldap_port - int64 - LDAP port
    #   ldap_provisioning_enabled - boolean - Use LDAP server settings for scheduled provisioning while using this SSO provider for authentication?
    #   ldap_secure - boolean - Use secure LDAP?
    #   ldap_type - string - LDAP server type
    #   ldap_username - string - Username for signing in to LDAP server.
    #   ldap_username_field - string - LDAP username field
    #   protocol - string - SSO Protocol
    #   provider - string - Provider name
    #   provider_identifier - string - URL-friendly, unique identifier for Azure SAML configuration
    #   provision_company - string - Default company for auto provisioned users.
    #   provision_dav_permission - boolean - Auto-provisioned users get WebDAV permission?
    #   provision_email_signup_groups - string - Comma-separated list of group names whose members will be created with email_signup authentication.
    #   provision_filesystem_layout - string - File System layout to use for auto provisioned users.
    #   provision_ftp_permission - boolean - Auto-provisioned users get FTP permission?
    #   provision_group_admin_groups - string - Comma-separated list of group names whose members will be provisioned as Group Admins.
    #   provision_group_default - string - Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
    #   provision_group_exclusion - string - Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
    #   provision_group_inclusion - string - Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
    #   provision_group_required - string - Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
    #   provision_groups - boolean - Auto-provision group membership based on group memberships on the SSO side?
    #   provision_readonly_site_admin_groups - string - Comma-separated list of group names whose members will be created as Read-Only Site Admins.
    #   provision_require_2fa - string - 2FA required setting for auto provisioned users. `use_system_setting` uses the site-wide setting, including SSO exemptions. `always_require` and `never_require` override the site-wide setting when user-level overrides are allowed.
    #   provision_sftp_permission - boolean - Auto-provisioned users get SFTP permission?
    #   provision_site_admin_groups - string - Comma-separated list of group names whose members will be created as Site Admins.
    #   provision_time_zone - string - Default time zone for auto provisioned users.
    #   provision_users - boolean - Auto-provision users?
    #   saml_provider_cert_fingerprint - string - Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
    #   saml_provider_issuer_url - string - Identity provider issuer url
    #   saml_provider_metadata_content - string - Custom identity provider metadata
    #   saml_provider_metadata_url - string - Metadata URL for the SAML identity provider
    #   saml_provider_slo_target_url - string - Identity provider SLO endpoint
    #   saml_provider_sso_target_url - string - Identity provider SSO endpoint if saml_provider_metadata_url is not available.
    #   scim_authentication_method - string - SCIM authentication type.
    #   scim_oauth_access_token_expires_at - string - SCIM OAuth Access Token Expiration Time.
    #   scim_username - string - SCIM username.
    #   subdomain - string - Subdomain or domain name for your auth provider.   Example: `https://[subdomain].okta.com/`
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: client_id must be an String") if params[:client_id] and !params[:client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: client_secret must be an String") if params[:client_secret] and !params[:client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_password must be an String") if params[:ldap_password] and !params[:ldap_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_password must be an String") if params[:scim_password] and !params[:scim_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: deprovision_behavior must be an String") if params[:deprovision_behavior] and !params[:deprovision_behavior].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: label must be an String") if params[:label] and !params[:label].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_base_dn must be an String") if params[:ldap_base_dn] and !params[:ldap_base_dn].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_domain must be an String") if params[:ldap_domain] and !params[:ldap_domain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host must be an String") if params[:ldap_host] and !params[:ldap_host].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host_2 must be an String") if params[:ldap_host_2] and !params[:ldap_host_2].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host_3 must be an String") if params[:ldap_host_3] and !params[:ldap_host_3].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_port must be an Integer") if params[:ldap_port] and !params[:ldap_port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ldap_type must be an String") if params[:ldap_type] and !params[:ldap_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_username must be an String") if params[:ldap_username] and !params[:ldap_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_username_field must be an String") if params[:ldap_username_field] and !params[:ldap_username_field].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: protocol must be an String") if params[:protocol] and !params[:protocol].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provider must be an String") if params[:provider] and !params[:provider].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provider_identifier must be an String") if params[:provider_identifier] and !params[:provider_identifier].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_company must be an String") if params[:provision_company] and !params[:provision_company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_email_signup_groups must be an String") if params[:provision_email_signup_groups] and !params[:provision_email_signup_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_filesystem_layout must be an String") if params[:provision_filesystem_layout] and !params[:provision_filesystem_layout].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_admin_groups must be an String") if params[:provision_group_admin_groups] and !params[:provision_group_admin_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_default must be an String") if params[:provision_group_default] and !params[:provision_group_default].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_exclusion must be an String") if params[:provision_group_exclusion] and !params[:provision_group_exclusion].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_inclusion must be an String") if params[:provision_group_inclusion] and !params[:provision_group_inclusion].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_required must be an String") if params[:provision_group_required] and !params[:provision_group_required].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_readonly_site_admin_groups must be an String") if params[:provision_readonly_site_admin_groups] and !params[:provision_readonly_site_admin_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_require_2fa must be an String") if params[:provision_require_2fa] and !params[:provision_require_2fa].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_site_admin_groups must be an String") if params[:provision_site_admin_groups] and !params[:provision_site_admin_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_time_zone must be an String") if params[:provision_time_zone] and !params[:provision_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_cert_fingerprint must be an String") if params[:saml_provider_cert_fingerprint] and !params[:saml_provider_cert_fingerprint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_issuer_url must be an String") if params[:saml_provider_issuer_url] and !params[:saml_provider_issuer_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_metadata_content must be an String") if params[:saml_provider_metadata_content] and !params[:saml_provider_metadata_content].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_metadata_url must be an String") if params[:saml_provider_metadata_url] and !params[:saml_provider_metadata_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_slo_target_url must be an String") if params[:saml_provider_slo_target_url] and !params[:saml_provider_slo_target_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_sso_target_url must be an String") if params[:saml_provider_sso_target_url] and !params[:saml_provider_sso_target_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_authentication_method must be an String") if params[:scim_authentication_method] and !params[:scim_authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_oauth_access_token_expires_at must be an String") if params[:scim_oauth_access_token_expires_at] and !params[:scim_oauth_access_token_expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_username must be an String") if params[:scim_username] and !params[:scim_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subdomain must be an String") if params[:subdomain] and !params[:subdomain].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/sso_strategies/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/sso_strategies/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = SsoStrategy.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)

      List.new(SsoStrategy, params) do
        Api.send_request("/sso_strategies", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Sso Strategy ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/sso_strategies/#{params[:id]}", :get, params, options)
      SsoStrategy.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   client_id - string - OAuth Client ID for your auth provider.
    #   client_secret - string - OAuth Client Secret for your auth provider.
    #   ldap_password - string - Password for signing in to LDAP server.
    #   logo_delete - boolean - If true, the logo will be deleted.
    #   logo_file - file - A logo to display on the login page.
    #   reset_scim_oauth_access_token - boolean - If true, perform a reset on SCIM OAuth access token
    #   scim_password - string - SCIM password applicable to basic authentication.
    #   deprovision_behavior - string - Method used for deprovisioning users.
    #   deprovision_groups - boolean - Auto-deprovision group membership based on group memberships on the SSO side?
    #   deprovision_users - boolean - Auto-deprovision users?
    #   display_on_login_page - boolean - Should this strategy be displayed on the login page?
    #   enabled - boolean - Is strategy enabled?  This may become automatically set to `false` after a high number and duration of failures.
    #   label - string - Custom label for the SSO provider on the login page.
    #   ldap_base_dn - string - Base DN for looking up users in LDAP server
    #   ldap_domain - string - Domain name that will be appended to LDAP usernames
    #   ldap_host - string - LDAP host
    #   ldap_host_2 - string - LDAP backup host
    #   ldap_host_3 - string - LDAP backup host
    #   ldap_port - int64 - LDAP port
    #   ldap_provisioning_enabled - boolean - Use LDAP server settings for scheduled provisioning while using this SSO provider for authentication?
    #   ldap_secure - boolean - Use secure LDAP?
    #   ldap_type - string - LDAP server type
    #   ldap_username - string - Username for signing in to LDAP server.
    #   ldap_username_field - string - LDAP username field
    #   protocol - string - SSO Protocol
    #   provider - string - Provider name
    #   provider_identifier - string - URL-friendly, unique identifier for Azure SAML configuration
    #   provision_company - string - Default company for auto provisioned users.
    #   provision_dav_permission - boolean - Auto-provisioned users get WebDAV permission?
    #   provision_email_signup_groups - string - Comma-separated list of group names whose members will be created with email_signup authentication.
    #   provision_filesystem_layout - string - File System layout to use for auto provisioned users.
    #   provision_ftp_permission - boolean - Auto-provisioned users get FTP permission?
    #   provision_group_admin_groups - string - Comma-separated list of group names whose members will be provisioned as Group Admins.
    #   provision_group_default - string - Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
    #   provision_group_exclusion - string - Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
    #   provision_group_inclusion - string - Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
    #   provision_group_required - string - Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
    #   provision_groups - boolean - Auto-provision group membership based on group memberships on the SSO side?
    #   provision_readonly_site_admin_groups - string - Comma-separated list of group names whose members will be created as Read-Only Site Admins.
    #   provision_require_2fa - string - 2FA required setting for auto provisioned users. `use_system_setting` uses the site-wide setting, including SSO exemptions. `always_require` and `never_require` override the site-wide setting when user-level overrides are allowed.
    #   provision_sftp_permission - boolean - Auto-provisioned users get SFTP permission?
    #   provision_site_admin_groups - string - Comma-separated list of group names whose members will be created as Site Admins.
    #   provision_time_zone - string - Default time zone for auto provisioned users.
    #   provision_users - boolean - Auto-provision users?
    #   saml_provider_cert_fingerprint - string - Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
    #   saml_provider_issuer_url - string - Identity provider issuer url
    #   saml_provider_metadata_content - string - Custom identity provider metadata
    #   saml_provider_metadata_url - string - Metadata URL for the SAML identity provider
    #   saml_provider_slo_target_url - string - Identity provider SLO endpoint
    #   saml_provider_sso_target_url - string - Identity provider SSO endpoint if saml_provider_metadata_url is not available.
    #   scim_authentication_method - string - SCIM authentication type.
    #   scim_oauth_access_token_expires_at - string - SCIM OAuth Access Token Expiration Time.
    #   scim_username - string - SCIM username.
    #   subdomain - string - Subdomain or domain name for your auth provider.   Example: `https://[subdomain].okta.com/`
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: client_id must be an String") if params[:client_id] and !params[:client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: client_secret must be an String") if params[:client_secret] and !params[:client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_password must be an String") if params[:ldap_password] and !params[:ldap_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_password must be an String") if params[:scim_password] and !params[:scim_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: deprovision_behavior must be an String") if params[:deprovision_behavior] and !params[:deprovision_behavior].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: label must be an String") if params[:label] and !params[:label].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_base_dn must be an String") if params[:ldap_base_dn] and !params[:ldap_base_dn].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_domain must be an String") if params[:ldap_domain] and !params[:ldap_domain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host must be an String") if params[:ldap_host] and !params[:ldap_host].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host_2 must be an String") if params[:ldap_host_2] and !params[:ldap_host_2].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host_3 must be an String") if params[:ldap_host_3] and !params[:ldap_host_3].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_port must be an Integer") if params[:ldap_port] and !params[:ldap_port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ldap_type must be an String") if params[:ldap_type] and !params[:ldap_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_username must be an String") if params[:ldap_username] and !params[:ldap_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_username_field must be an String") if params[:ldap_username_field] and !params[:ldap_username_field].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: protocol must be an String") if params[:protocol] and !params[:protocol].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provider must be an String") if params[:provider] and !params[:provider].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provider_identifier must be an String") if params[:provider_identifier] and !params[:provider_identifier].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_company must be an String") if params[:provision_company] and !params[:provision_company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_email_signup_groups must be an String") if params[:provision_email_signup_groups] and !params[:provision_email_signup_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_filesystem_layout must be an String") if params[:provision_filesystem_layout] and !params[:provision_filesystem_layout].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_admin_groups must be an String") if params[:provision_group_admin_groups] and !params[:provision_group_admin_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_default must be an String") if params[:provision_group_default] and !params[:provision_group_default].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_exclusion must be an String") if params[:provision_group_exclusion] and !params[:provision_group_exclusion].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_inclusion must be an String") if params[:provision_group_inclusion] and !params[:provision_group_inclusion].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_required must be an String") if params[:provision_group_required] and !params[:provision_group_required].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_readonly_site_admin_groups must be an String") if params[:provision_readonly_site_admin_groups] and !params[:provision_readonly_site_admin_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_require_2fa must be an String") if params[:provision_require_2fa] and !params[:provision_require_2fa].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_site_admin_groups must be an String") if params[:provision_site_admin_groups] and !params[:provision_site_admin_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_time_zone must be an String") if params[:provision_time_zone] and !params[:provision_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_cert_fingerprint must be an String") if params[:saml_provider_cert_fingerprint] and !params[:saml_provider_cert_fingerprint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_issuer_url must be an String") if params[:saml_provider_issuer_url] and !params[:saml_provider_issuer_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_metadata_content must be an String") if params[:saml_provider_metadata_content] and !params[:saml_provider_metadata_content].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_metadata_url must be an String") if params[:saml_provider_metadata_url] and !params[:saml_provider_metadata_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_slo_target_url must be an String") if params[:saml_provider_slo_target_url] and !params[:saml_provider_slo_target_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_sso_target_url must be an String") if params[:saml_provider_sso_target_url] and !params[:saml_provider_sso_target_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_authentication_method must be an String") if params[:scim_authentication_method] and !params[:scim_authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_oauth_access_token_expires_at must be an String") if params[:scim_oauth_access_token_expires_at] and !params[:scim_oauth_access_token_expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_username must be an String") if params[:scim_username] and !params[:scim_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subdomain must be an String") if params[:subdomain] and !params[:subdomain].is_a?(String)

      response, options = Api.send_request("/sso_strategies", :post, params, options)
      SsoStrategy.new(response.data, options)
    end

    # Synchronize provisioning data with the SSO remote server
    def self.sync(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/sso_strategies/#{params[:id]}/sync", :post, params, options)
      nil
    end

    # Parameters:
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)

      response, options = Api.send_request("/sso_strategies/create_export", :post, params, options)
      Export.new(response.data, options)
    end

    # Parameters:
    #   client_id - string - OAuth Client ID for your auth provider.
    #   client_secret - string - OAuth Client Secret for your auth provider.
    #   ldap_password - string - Password for signing in to LDAP server.
    #   logo_delete - boolean - If true, the logo will be deleted.
    #   logo_file - file - A logo to display on the login page.
    #   reset_scim_oauth_access_token - boolean - If true, perform a reset on SCIM OAuth access token
    #   scim_password - string - SCIM password applicable to basic authentication.
    #   deprovision_behavior - string - Method used for deprovisioning users.
    #   deprovision_groups - boolean - Auto-deprovision group membership based on group memberships on the SSO side?
    #   deprovision_users - boolean - Auto-deprovision users?
    #   display_on_login_page - boolean - Should this strategy be displayed on the login page?
    #   enabled - boolean - Is strategy enabled?  This may become automatically set to `false` after a high number and duration of failures.
    #   label - string - Custom label for the SSO provider on the login page.
    #   ldap_base_dn - string - Base DN for looking up users in LDAP server
    #   ldap_domain - string - Domain name that will be appended to LDAP usernames
    #   ldap_host - string - LDAP host
    #   ldap_host_2 - string - LDAP backup host
    #   ldap_host_3 - string - LDAP backup host
    #   ldap_port - int64 - LDAP port
    #   ldap_provisioning_enabled - boolean - Use LDAP server settings for scheduled provisioning while using this SSO provider for authentication?
    #   ldap_secure - boolean - Use secure LDAP?
    #   ldap_type - string - LDAP server type
    #   ldap_username - string - Username for signing in to LDAP server.
    #   ldap_username_field - string - LDAP username field
    #   protocol - string - SSO Protocol
    #   provider - string - Provider name
    #   provider_identifier - string - URL-friendly, unique identifier for Azure SAML configuration
    #   provision_company - string - Default company for auto provisioned users.
    #   provision_dav_permission - boolean - Auto-provisioned users get WebDAV permission?
    #   provision_email_signup_groups - string - Comma-separated list of group names whose members will be created with email_signup authentication.
    #   provision_filesystem_layout - string - File System layout to use for auto provisioned users.
    #   provision_ftp_permission - boolean - Auto-provisioned users get FTP permission?
    #   provision_group_admin_groups - string - Comma-separated list of group names whose members will be provisioned as Group Admins.
    #   provision_group_default - string - Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
    #   provision_group_exclusion - string - Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
    #   provision_group_inclusion - string - Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
    #   provision_group_required - string - Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
    #   provision_groups - boolean - Auto-provision group membership based on group memberships on the SSO side?
    #   provision_readonly_site_admin_groups - string - Comma-separated list of group names whose members will be created as Read-Only Site Admins.
    #   provision_require_2fa - string - 2FA required setting for auto provisioned users. `use_system_setting` uses the site-wide setting, including SSO exemptions. `always_require` and `never_require` override the site-wide setting when user-level overrides are allowed.
    #   provision_sftp_permission - boolean - Auto-provisioned users get SFTP permission?
    #   provision_site_admin_groups - string - Comma-separated list of group names whose members will be created as Site Admins.
    #   provision_time_zone - string - Default time zone for auto provisioned users.
    #   provision_users - boolean - Auto-provision users?
    #   saml_provider_cert_fingerprint - string - Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
    #   saml_provider_issuer_url - string - Identity provider issuer url
    #   saml_provider_metadata_content - string - Custom identity provider metadata
    #   saml_provider_metadata_url - string - Metadata URL for the SAML identity provider
    #   saml_provider_slo_target_url - string - Identity provider SLO endpoint
    #   saml_provider_sso_target_url - string - Identity provider SSO endpoint if saml_provider_metadata_url is not available.
    #   scim_authentication_method - string - SCIM authentication type.
    #   scim_oauth_access_token_expires_at - string - SCIM OAuth Access Token Expiration Time.
    #   scim_username - string - SCIM username.
    #   subdomain - string - Subdomain or domain name for your auth provider.   Example: `https://[subdomain].okta.com/`
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: client_id must be an String") if params[:client_id] and !params[:client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: client_secret must be an String") if params[:client_secret] and !params[:client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_password must be an String") if params[:ldap_password] and !params[:ldap_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_password must be an String") if params[:scim_password] and !params[:scim_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: deprovision_behavior must be an String") if params[:deprovision_behavior] and !params[:deprovision_behavior].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: label must be an String") if params[:label] and !params[:label].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_base_dn must be an String") if params[:ldap_base_dn] and !params[:ldap_base_dn].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_domain must be an String") if params[:ldap_domain] and !params[:ldap_domain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host must be an String") if params[:ldap_host] and !params[:ldap_host].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host_2 must be an String") if params[:ldap_host_2] and !params[:ldap_host_2].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host_3 must be an String") if params[:ldap_host_3] and !params[:ldap_host_3].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_port must be an Integer") if params[:ldap_port] and !params[:ldap_port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ldap_type must be an String") if params[:ldap_type] and !params[:ldap_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_username must be an String") if params[:ldap_username] and !params[:ldap_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_username_field must be an String") if params[:ldap_username_field] and !params[:ldap_username_field].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: protocol must be an String") if params[:protocol] and !params[:protocol].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provider must be an String") if params[:provider] and !params[:provider].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provider_identifier must be an String") if params[:provider_identifier] and !params[:provider_identifier].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_company must be an String") if params[:provision_company] and !params[:provision_company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_email_signup_groups must be an String") if params[:provision_email_signup_groups] and !params[:provision_email_signup_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_filesystem_layout must be an String") if params[:provision_filesystem_layout] and !params[:provision_filesystem_layout].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_admin_groups must be an String") if params[:provision_group_admin_groups] and !params[:provision_group_admin_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_default must be an String") if params[:provision_group_default] and !params[:provision_group_default].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_exclusion must be an String") if params[:provision_group_exclusion] and !params[:provision_group_exclusion].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_inclusion must be an String") if params[:provision_group_inclusion] and !params[:provision_group_inclusion].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_required must be an String") if params[:provision_group_required] and !params[:provision_group_required].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_readonly_site_admin_groups must be an String") if params[:provision_readonly_site_admin_groups] and !params[:provision_readonly_site_admin_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_require_2fa must be an String") if params[:provision_require_2fa] and !params[:provision_require_2fa].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_site_admin_groups must be an String") if params[:provision_site_admin_groups] and !params[:provision_site_admin_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_time_zone must be an String") if params[:provision_time_zone] and !params[:provision_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_cert_fingerprint must be an String") if params[:saml_provider_cert_fingerprint] and !params[:saml_provider_cert_fingerprint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_issuer_url must be an String") if params[:saml_provider_issuer_url] and !params[:saml_provider_issuer_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_metadata_content must be an String") if params[:saml_provider_metadata_content] and !params[:saml_provider_metadata_content].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_metadata_url must be an String") if params[:saml_provider_metadata_url] and !params[:saml_provider_metadata_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_slo_target_url must be an String") if params[:saml_provider_slo_target_url] and !params[:saml_provider_slo_target_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_sso_target_url must be an String") if params[:saml_provider_sso_target_url] and !params[:saml_provider_sso_target_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_authentication_method must be an String") if params[:scim_authentication_method] and !params[:scim_authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_oauth_access_token_expires_at must be an String") if params[:scim_oauth_access_token_expires_at] and !params[:scim_oauth_access_token_expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_username must be an String") if params[:scim_username] and !params[:scim_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subdomain must be an String") if params[:subdomain] and !params[:subdomain].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/sso_strategies/#{params[:id]}", :patch, params, options)
      SsoStrategy.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/sso_strategies/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
