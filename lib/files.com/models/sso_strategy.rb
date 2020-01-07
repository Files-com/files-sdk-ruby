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

    # int64 - ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
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

    # string - Subdomain
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

    # boolean - Auto-provisioned users get Sharing permission?
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

    # string - Password for scim integration if using basic auth
    def scim_password
      @attributes[:scim_password]
    end

    def scim_password=(value)
      @attributes[:scim_password] = value
    end

    # Parameters:
    #   provider (required) - string - One of the following: google, auth0, okta, atlassian, azure, box, dropbox, slack, ubuntu, onelogin, saml
    #   subdomain - string - Subdomain or domain name for your auth provider.   Example: `https://[subdomain].okta.com/`
    #   client_id - string - OAuth Client ID for your auth provider.
    #   client_secret - string - OAuth Client Secret for your auth provider.
    #   saml_provider_metadata_url - string - Metadata URL for the SAML identity provider
    #   saml_provider_cert_fingerprint - string - Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
    #   saml_provider_issuer_url - string - Identity provider issuer url
    #   saml_provider_slo_target_url - string - Identity provider SLO endpoint
    #   saml_provider_sso_target_url - string - Identity provider SSO endpoint if saml_provider_metadata_url is not available.
    #   scim_authentication_method - string - The authentication method to use when using scim provisioning
    #   scim_password - string - Password for scim integration if using basic auth
    #   scim_username - string - Username for scim integration
    #   protocol - string - SSO Protocol
    #   provision_users - boolean - Auto-provision users?
    #   provision_groups - boolean - Auto-provision group memberships?
    #   provision_group_default - string - Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
    #   provision_group_exclusion - string - Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
    #   provision_group_inclusion - string - Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
    #   provision_group_required - string - Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
    #   provision_attachments_permission - boolean - Provisioned users to get sharing permission?
    #   provision_dav_permission - boolean - Provisioned users to get WebDAV permission?
    #   provision_ftp_permission - boolean - Provisioned users to get FTP permission?
    #   provision_sftp_permission - boolean - Provisioned users to get SFTP permission?
    #   provision_time_zone - string - Default timezone to use for provisioned users
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: provider must be an String") if params.dig(:provider) and !params.dig(:provider).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subdomain must be an String") if params.dig(:subdomain) and !params.dig(:subdomain).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: client_id must be an String") if params.dig(:client_id) and !params.dig(:client_id).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: client_secret must be an String") if params.dig(:client_secret) and !params.dig(:client_secret).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_metadata_url must be an String") if params.dig(:saml_provider_metadata_url) and !params.dig(:saml_provider_metadata_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_cert_fingerprint must be an String") if params.dig(:saml_provider_cert_fingerprint) and !params.dig(:saml_provider_cert_fingerprint).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_issuer_url must be an String") if params.dig(:saml_provider_issuer_url) and !params.dig(:saml_provider_issuer_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_slo_target_url must be an String") if params.dig(:saml_provider_slo_target_url) and !params.dig(:saml_provider_slo_target_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_sso_target_url must be an String") if params.dig(:saml_provider_sso_target_url) and !params.dig(:saml_provider_sso_target_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_authentication_method must be an String") if params.dig(:scim_authentication_method) and !params.dig(:scim_authentication_method).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_password must be an String") if params.dig(:scim_password) and !params.dig(:scim_password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_username must be an String") if params.dig(:scim_username) and !params.dig(:scim_username).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: protocol must be an String") if params.dig(:protocol) and !params.dig(:protocol).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_default must be an String") if params.dig(:provision_group_default) and !params.dig(:provision_group_default).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_exclusion must be an String") if params.dig(:provision_group_exclusion) and !params.dig(:provision_group_exclusion).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_inclusion must be an String") if params.dig(:provision_group_inclusion) and !params.dig(:provision_group_inclusion).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_required must be an String") if params.dig(:provision_group_required) and !params.dig(:provision_group_required).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_time_zone must be an String") if params.dig(:provision_time_zone) and !params.dig(:provision_time_zone).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: provider") unless params.dig(:provider)

      Api.send_request("/sso_strategies/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/sso_strategies/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = SsoStrategy.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/sso_strategies", :get, params, options)
      response.data.map { |object| SsoStrategy.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - integer - Sso Strategy ID.
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

    # Parameters:
    #   provider (required) - string - One of the following: google, auth0, okta, atlassian, azure, box, dropbox, slack, ubuntu, onelogin, saml
    #   subdomain - string - Subdomain or domain name for your auth provider.   Example: `https://[subdomain].okta.com/`
    #   client_id - string - OAuth Client ID for your auth provider.
    #   client_secret - string - OAuth Client Secret for your auth provider.
    #   saml_provider_metadata_url - string - Metadata URL for the SAML identity provider
    #   saml_provider_cert_fingerprint - string - Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
    #   saml_provider_issuer_url - string - Identity provider issuer url
    #   saml_provider_slo_target_url - string - Identity provider SLO endpoint
    #   saml_provider_sso_target_url - string - Identity provider SSO endpoint if saml_provider_metadata_url is not available.
    #   scim_authentication_method - string - The authentication method to use when using scim provisioning
    #   scim_password - string - Password for scim integration if using basic auth
    #   scim_username - string - Username for scim integration
    #   protocol - string - SSO Protocol
    #   provision_users - boolean - Auto-provision users?
    #   provision_groups - boolean - Auto-provision group memberships?
    #   provision_group_default - string - Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
    #   provision_group_exclusion - string - Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
    #   provision_group_inclusion - string - Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
    #   provision_group_required - string - Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
    #   provision_attachments_permission - boolean - Provisioned users to get sharing permission?
    #   provision_dav_permission - boolean - Provisioned users to get WebDAV permission?
    #   provision_ftp_permission - boolean - Provisioned users to get FTP permission?
    #   provision_sftp_permission - boolean - Provisioned users to get SFTP permission?
    #   provision_time_zone - string - Default timezone to use for provisioned users
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: provider must be an String") if params.dig(:provider) and !params.dig(:provider).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subdomain must be an String") if params.dig(:subdomain) and !params.dig(:subdomain).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: client_id must be an String") if params.dig(:client_id) and !params.dig(:client_id).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: client_secret must be an String") if params.dig(:client_secret) and !params.dig(:client_secret).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_metadata_url must be an String") if params.dig(:saml_provider_metadata_url) and !params.dig(:saml_provider_metadata_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_cert_fingerprint must be an String") if params.dig(:saml_provider_cert_fingerprint) and !params.dig(:saml_provider_cert_fingerprint).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_issuer_url must be an String") if params.dig(:saml_provider_issuer_url) and !params.dig(:saml_provider_issuer_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_slo_target_url must be an String") if params.dig(:saml_provider_slo_target_url) and !params.dig(:saml_provider_slo_target_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_sso_target_url must be an String") if params.dig(:saml_provider_sso_target_url) and !params.dig(:saml_provider_sso_target_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_authentication_method must be an String") if params.dig(:scim_authentication_method) and !params.dig(:scim_authentication_method).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_password must be an String") if params.dig(:scim_password) and !params.dig(:scim_password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_username must be an String") if params.dig(:scim_username) and !params.dig(:scim_username).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: protocol must be an String") if params.dig(:protocol) and !params.dig(:protocol).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_default must be an String") if params.dig(:provision_group_default) and !params.dig(:provision_group_default).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_exclusion must be an String") if params.dig(:provision_group_exclusion) and !params.dig(:provision_group_exclusion).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_inclusion must be an String") if params.dig(:provision_group_inclusion) and !params.dig(:provision_group_inclusion).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_required must be an String") if params.dig(:provision_group_required) and !params.dig(:provision_group_required).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_time_zone must be an String") if params.dig(:provision_time_zone) and !params.dig(:provision_time_zone).is_a?(String)
      raise MissingParameterError.new("Parameter missing: provider") unless params.dig(:provider)

      response, options = Api.send_request("/sso_strategies", :post, params, options)
      SsoStrategy.new(response.data, options)
    end

    # Parameters:
    #   provider (required) - string - One of the following: google, auth0, okta, atlassian, azure, box, dropbox, slack, ubuntu, onelogin, saml
    #   subdomain - string - Subdomain or domain name for your auth provider.   Example: `https://[subdomain].okta.com/`
    #   client_id - string - OAuth Client ID for your auth provider.
    #   client_secret - string - OAuth Client Secret for your auth provider.
    #   saml_provider_metadata_url - string - Metadata URL for the SAML identity provider
    #   saml_provider_cert_fingerprint - string - Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
    #   saml_provider_issuer_url - string - Identity provider issuer url
    #   saml_provider_slo_target_url - string - Identity provider SLO endpoint
    #   saml_provider_sso_target_url - string - Identity provider SSO endpoint if saml_provider_metadata_url is not available.
    #   scim_authentication_method - string - The authentication method to use when using scim provisioning
    #   scim_password - string - Password for scim integration if using basic auth
    #   scim_username - string - Username for scim integration
    #   protocol - string - SSO Protocol
    #   provision_users - boolean - Auto-provision users?
    #   provision_groups - boolean - Auto-provision group memberships?
    #   provision_group_default - string - Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
    #   provision_group_exclusion - string - Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
    #   provision_group_inclusion - string - Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
    #   provision_group_required - string - Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
    #   provision_attachments_permission - boolean - Provisioned users to get sharing permission?
    #   provision_dav_permission - boolean - Provisioned users to get WebDAV permission?
    #   provision_ftp_permission - boolean - Provisioned users to get FTP permission?
    #   provision_sftp_permission - boolean - Provisioned users to get SFTP permission?
    #   provision_time_zone - string - Default timezone to use for provisioned users
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: provider must be an String") if params.dig(:provider) and !params.dig(:provider).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subdomain must be an String") if params.dig(:subdomain) and !params.dig(:subdomain).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: client_id must be an String") if params.dig(:client_id) and !params.dig(:client_id).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: client_secret must be an String") if params.dig(:client_secret) and !params.dig(:client_secret).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_metadata_url must be an String") if params.dig(:saml_provider_metadata_url) and !params.dig(:saml_provider_metadata_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_cert_fingerprint must be an String") if params.dig(:saml_provider_cert_fingerprint) and !params.dig(:saml_provider_cert_fingerprint).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_issuer_url must be an String") if params.dig(:saml_provider_issuer_url) and !params.dig(:saml_provider_issuer_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_slo_target_url must be an String") if params.dig(:saml_provider_slo_target_url) and !params.dig(:saml_provider_slo_target_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: saml_provider_sso_target_url must be an String") if params.dig(:saml_provider_sso_target_url) and !params.dig(:saml_provider_sso_target_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_authentication_method must be an String") if params.dig(:scim_authentication_method) and !params.dig(:scim_authentication_method).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_password must be an String") if params.dig(:scim_password) and !params.dig(:scim_password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: scim_username must be an String") if params.dig(:scim_username) and !params.dig(:scim_username).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: protocol must be an String") if params.dig(:protocol) and !params.dig(:protocol).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_default must be an String") if params.dig(:provision_group_default) and !params.dig(:provision_group_default).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_exclusion must be an String") if params.dig(:provision_group_exclusion) and !params.dig(:provision_group_exclusion).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_inclusion must be an String") if params.dig(:provision_group_inclusion) and !params.dig(:provision_group_inclusion).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_group_required must be an String") if params.dig(:provision_group_required) and !params.dig(:provision_group_required).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provision_time_zone must be an String") if params.dig(:provision_time_zone) and !params.dig(:provision_time_zone).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: provider") unless params.dig(:provider)

      response, options = Api.send_request("/sso_strategies/#{params[:id]}", :patch, params, options)
      SsoStrategy.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/sso_strategies/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
