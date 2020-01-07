# frozen_string_literal: true

module Files
  class Plan
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Plan ID
    def id
      @attributes[:id]
    end

    # boolean - Are advanced behaviors included in plan?
    def advanced_behaviors
      @attributes[:advanced_behaviors]
    end

    # boolean - Is advanced antivirus included in plan?
    def antivirus_advanced
      @attributes[:antivirus_advanced]
    end

    # boolean - Is basic antivirus included in plan?
    def antivirus_basic
      @attributes[:antivirus_basic]
    end

    # int64 - How many audit hours included in plan?
    def audit_hours
      @attributes[:audit_hours]
    end

    # boolean - Is google authentication included in plan?
    def auth_google
      @attributes[:auth_google]
    end

    # boolean - Is oauth included in plan?
    def auth_oauth
      @attributes[:auth_oauth]
    end

    # boolean - Is custom oauth included in plan?
    def auth_oauth_custom
      @attributes[:auth_oauth_custom]
    end

    # int64 - Number of SSO, 2FA, Desktop users included in plan
    def auth_user_count
      @attributes[:auth_user_count]
    end

    # boolean - Are automations included in plan?
    def automations
      @attributes[:automations]
    end

    # boolean - If true all usernames can be used, otherwise usernames must be unique
    def custom_namespace
      @attributes[:custom_namespace]
    end

    # boolean - Custom SMTP support?
    def custom_smtp
      @attributes[:custom_smtp]
    end

    # boolean - Offers dedicated ip?
    def dedicated_ip
      @attributes[:dedicated_ip]
    end

    # int64 - Number of dedicated IPs
    def dedicated_ips
      @attributes[:dedicated_ips]
    end

    # object - Results of comparing with a different Plan
    def differences
      @attributes[:differences]
    end

    # boolean - Custom domain(s)?
    def domain
      @attributes[:domain]
    end

    # int64 - Number of custom domains
    def domain_count
      @attributes[:domain_count]
    end

    # boolean - Does the plan include E-Mail inboxes?
    def email_inboxes
      @attributes[:email_inboxes]
    end

    # boolean - Supports extended folder permissions like viewing history?
    def extended_folder_permissions
      @attributes[:extended_folder_permissions]
    end

    # boolean - Can log preservation be extended?
    def extended_log_retention
      @attributes[:extended_log_retention]
    end

    # int64 - Number of free developer accounts
    def free_developer_accounts
      @attributes[:free_developer_accounts]
    end

    # boolean - Supports connections via FTP, SFTP, and WebDAV?
    def ftp_sftp_webdav
      @attributes[:ftp_sftp_webdav]
    end

    # boolean - Full text search enabled?
    def full_text_search
      @attributes[:full_text_search]
    end

    # boolean - Global acceleration enabled?
    def global_acceleration
      @attributes[:global_acceleration]
    end

    # boolean - Support for GPG encryption?
    def gpg
      @attributes[:gpg]
    end

    # boolean - Group admin functionality enabled?
    def group_admins_enabled
      @attributes[:group_admins_enabled]
    end

    # boolean - Group notifications functionality enabled?
    def group_notifications
      @attributes[:group_notifications]
    end

    # boolean - Support for HIPAA regulation?
    def hipaa
      @attributes[:hipaa]
    end

    # boolean - HTML branding available?
    def html_branding
      @attributes[:html_branding]
    end

    # boolean - LDAP integration enabled?
    def ldap
      @attributes[:ldap]
    end

    # boolean - Does the plan offer any legal flexibility?
    def legal_flexibility
      @attributes[:legal_flexibility]
    end

    # int64 - Max number of files in a folder
    def max_folder_size
      @attributes[:max_folder_size]
    end

    # int64 - Maximum individual file size
    def max_individual_file_size
      @attributes[:max_individual_file_size]
    end

    # string - Plan name
    def name
      @attributes[:name]
    end

    # boolean - Are nested groups enabled?
    def nested_groups
      @attributes[:nested_groups]
    end

    # int64 - Number of previews available
    def preview_page_limit
      @attributes[:preview_page_limit]
    end

    # int64 - Number of storage regions included
    def regions_included
      @attributes[:regions_included]
    end

    # boolean - Remote sync with FTP available?
    def remote_sync_ftp
      @attributes[:remote_sync_ftp]
    end

    # int64 - Number of hours between remote sync
    def remote_sync_interval
      @attributes[:remote_sync_interval]
    end

    # boolean - Are other forms of remote sync available?
    def remote_sync_other
      @attributes[:remote_sync_other]
    end

    # boolean - Can sync to s3 bucket?
    def remote_sync_s3
      @attributes[:remote_sync_s3]
    end

    # boolean - 2FA support enabled?
    def require_2fa
      @attributes[:require_2fa]
    end

    # array - Site attributes which require upgrade
    def site_fields_requiring_upgrade
      @attributes[:site_fields_requiring_upgrade]
    end

    # string - Priority of customer support
    def support_level
      @attributes[:support_level]
    end

    # string - Usage cost per GB of overage
    def usage_cost
      @attributes[:usage_cost]
    end

    # string - Usage included per month, in GB
    def usage_included
      @attributes[:usage_included]
    end

    # int64 - # of users included.  0 or -1 mean unlimited.
    def users
      @attributes[:users]
    end

    # boolean - Watermark enabled?
    def watermark_documents
      @attributes[:watermark_documents]
    end

    # boolean - Watermark enabled?
    def watermark_images
      @attributes[:watermark_images]
    end

    # boolean - Webhooks enabled?
    def webhooks
      @attributes[:webhooks]
    end

    # boolean - Webhook SNS integration enabled?
    def webhooks_sns
      @attributes[:webhooks_sns]
    end

    # boolean - Whitelabel site?
    def whitelabel
      @attributes[:whitelabel]
    end

    # string - Activation cost (upfront)
    def activation_cost
      @attributes[:activation_cost]
    end

    # string - Price annually
    def annually
      @attributes[:annually]
    end

    # string - Currency
    def currency
      @attributes[:currency]
    end

    # string - Price monthly
    def monthly
      @attributes[:monthly]
    end

    # string - Cost per additional user
    def user_cost
      @attributes[:user_cost]
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   currency - string - Currency.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: currency must be an String") if params.dig(:currency) and !params.dig(:currency).is_a?(String)

      response, options = Api.send_request("/plans", :get, params, options)
      response.data.map { |object| Plan.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
