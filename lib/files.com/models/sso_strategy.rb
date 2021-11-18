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

    # string - Provider name
    def provider
      @attributes[:provider]
    end

    # string - Custom label for the SSO provider on the login page.
    def label
      @attributes[:label]
    end

    # string - URL holding a custom logo for the SSO provider on the login page.
    def logo_url
      @attributes[:logo_url]
    end

    # int64 - ID
    def id
      @attributes[:id]
    end

    # string - Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
    def saml_provider_cert_fingerprint
      @attributes[:saml_provider_cert_fingerprint]
    end

    # string - Identity provider issuer url
    def saml_provider_issuer_url
      @attributes[:saml_provider_issuer_url]
    end

    # string - Custom identity provider metadata
    def saml_provider_metadata_content
      @attributes[:saml_provider_metadata_content]
    end

    # string - Metadata URL for the SAML identity provider
    def saml_provider_metadata_url
      @attributes[:saml_provider_metadata_url]
    end

    # string - Identity provider SLO endpoint
    def saml_provider_slo_target_url
      @attributes[:saml_provider_slo_target_url]
    end

    # string - Identity provider SSO endpoint if saml_provider_metadata_url is not available.
    def saml_provider_sso_target_url
      @attributes[:saml_provider_sso_target_url]
    end

    # string - SCIM authentication type.
    def scim_authentication_method
      @attributes[:scim_authentication_method]
    end

    # string - SCIM username.
    def scim_username
      @attributes[:scim_username]
    end

    # string - SCIM OAuth Access Token.
    def scim_oauth_access_token
      @attributes[:scim_oauth_access_token]
    end

    # string - SCIM OAuth Access Token Expiration Time.
    def scim_oauth_access_token_expires_at
      @attributes[:scim_oauth_access_token_expires_at]
    end

    # string - Subdomain
    def subdomain
      @attributes[:subdomain]
    end

    # boolean - Auto-provision users?
    def provision_users
      @attributes[:provision_users]
    end

    # boolean - Auto-provision group membership based on group memberships on the SSO side?
    def provision_groups
      @attributes[:provision_groups]
    end

    # boolean - Auto-deprovision users?
    def deprovision_users
      @attributes[:deprovision_users]
    end

    # boolean - Auto-deprovision group membership based on group memberships on the SSO side?
    def deprovision_groups
      @attributes[:deprovision_groups]
    end

    # string - Method used for deprovisioning users.
    def deprovision_behavior
      @attributes[:deprovision_behavior]
    end

    # string - Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
    def provision_group_default
      @attributes[:provision_group_default]
    end

    # string - Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
    def provision_group_exclusion
      @attributes[:provision_group_exclusion]
    end

    # string - Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
    def provision_group_inclusion
      @attributes[:provision_group_inclusion]
    end

    # string - Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
    def provision_group_required
      @attributes[:provision_group_required]
    end

    # string - Comma-separated list of group names whose members will be created with email_signup authentication.
    def provision_email_signup_groups
      @attributes[:provision_email_signup_groups]
    end

    # string - Comma-separated list of group names whose members will be created as Site Admins.
    def provision_site_admin_groups
      @attributes[:provision_site_admin_groups]
    end

    # boolean - DEPRECATED: Auto-provisioned users get Sharing permission. Use a Group with the Bundle permission instead.
    def provision_attachments_permission
      @attributes[:provision_attachments_permission]
    end

    # boolean - Auto-provisioned users get WebDAV permission?
    def provision_dav_permission
      @attributes[:provision_dav_permission]
    end

    # boolean - Auto-provisioned users get FTP permission?
    def provision_ftp_permission
      @attributes[:provision_ftp_permission]
    end

    # boolean - Auto-provisioned users get SFTP permission?
    def provision_sftp_permission
      @attributes[:provision_sftp_permission]
    end

    # string - Default time zone for auto provisioned users.
    def provision_time_zone
      @attributes[:provision_time_zone]
    end

    # string - Default company for auto provisioned users.
    def provision_company
      @attributes[:provision_company]
    end

    # string - Base DN for looking up users in LDAP server
    def ldap_base_dn
      @attributes[:ldap_base_dn]
    end

    # string - Domain name that will be appended to LDAP usernames
    def ldap_domain
      @attributes[:ldap_domain]
    end

    # boolean - Is strategy enabled?
    def enabled
      @attributes[:enabled]
    end

    # string - LDAP host
    def ldap_host
      @attributes[:ldap_host]
    end

    # string - LDAP backup host
    def ldap_host_2
      @attributes[:ldap_host_2]
    end

    # string - LDAP backup host
    def ldap_host_3
      @attributes[:ldap_host_3]
    end

    # int64 - LDAP port
    def ldap_port
      @attributes[:ldap_port]
    end

    # boolean - Use secure LDAP?
    def ldap_secure
      @attributes[:ldap_secure]
    end

    # string - Username for signing in to LDAP server.
    def ldap_username
      @attributes[:ldap_username]
    end

    # string - LDAP username field
    def ldap_username_field
      @attributes[:ldap_username_field]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)

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
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/sso_strategies/#{params[:id]}", :get, params, options)
      SsoStrategy.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
