# frozen_string_literal: true

module Files
  # Files::User is the Ruby SDK's representation of Files.com API User objects.
  # Each instance keeps its API field values in +attributes+.
  class User
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

    # User ID
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

    # User's username
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

    # List of group IDs of which this user is an administrator
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def admin_group_ids
      @attributes[:admin_group_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def admin_group_ids=(value)
      @attributes[:admin_group_ids] = value
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

    # If `true`, the user can user create Bundles (aka Share Links). Use the bundle permission instead.
    # @return [Boolean, nil] the field value, or nil when absent.
    def attachments_permission
      @attributes[:attachments_permission]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def attachments_permission=(value)
      @attributes[:attachments_permission] = value
    end

    # Number of API keys associated with this user
    # @return [Integer, nil] the field value, or nil when absent.
    def api_keys_count
      @attributes[:api_keys_count]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def api_keys_count=(value)
      @attributes[:api_keys_count] = value
    end

    # Scheduled Date/Time at which user will be deactivated
    # @return [String, nil] the field value, or nil when absent.
    def authenticate_until
      @attributes[:authenticate_until]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def authenticate_until=(value)
      @attributes[:authenticate_until] = value
    end

    # How is this user authenticated?
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

    # URL holding the user's avatar
    # @return [String, nil] the field value, or nil when absent.
    def avatar_url
      @attributes[:avatar_url]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def avatar_url=(value)
      @attributes[:avatar_url] = value
    end

    # Is this a billable user record?
    # @return [Boolean, nil] the field value, or nil when absent.
    def billable
      @attributes[:billable]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def billable=(value)
      @attributes[:billable] = value
    end

    # Allow this user to perform operations on the account, payments, and invoices?
    # @return [Boolean, nil] the field value, or nil when absent.
    def billing_permission
      @attributes[:billing_permission]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def billing_permission=(value)
      @attributes[:billing_permission] = value
    end

    # Allow this user to skip site-wide IP blacklists?
    # @return [Boolean, nil] the field value, or nil when absent.
    def bypass_site_allowed_ips
      @attributes[:bypass_site_allowed_ips]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def bypass_site_allowed_ips=(value)
      @attributes[:bypass_site_allowed_ips] = value
    end

    # Exempt this user from user lifecycle rules?
    # @return [Boolean, nil] the field value, or nil when absent.
    def bypass_user_lifecycle_rules
      @attributes[:bypass_user_lifecycle_rules]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def bypass_user_lifecycle_rules=(value)
      @attributes[:bypass_user_lifecycle_rules] = value
    end

    # When this user was created
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Can the user connect with WebDAV?
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

    # Is user disabled? Disabled users cannot log in, and do not count for billing purposes. Users can be automatically disabled after an inactivity period via a Site setting or schedule to be deactivated after specific date.
    # @return [Boolean, nil] the field value, or nil when absent.
    def disabled
      @attributes[:disabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def disabled=(value)
      @attributes[:disabled] = value
    end

    # Computed property that returns true if user disabled or expired or inactive.
    # @return [Boolean, nil] the field value, or nil when absent.
    def disabled_expired_or_inactive
      @attributes[:disabled_expired_or_inactive]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def disabled_expired_or_inactive=(value)
      @attributes[:disabled_expired_or_inactive] = value
    end

    # AI Assistant Personality ID assigned directly to this user, if any.
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

    # Desktop Configuration Profile ID assigned directly to this user, if any.
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

    # Integration Centric Profile ID assigned directly to this user, if any.
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

    # User email address
    # @return [Hash, nil] the field value, or nil when absent.
    def email
      @attributes[:email]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def email=(value)
      @attributes[:email] = value
    end

    # File system layout
    # @return [String, nil] the field value, or nil when absent.
    def filesystem_layout
      @attributes[:filesystem_layout]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def filesystem_layout=(value)
      @attributes[:filesystem_layout] = value
    end

    # User's first login time
    # @return [String, nil] the field value, or nil when absent.
    def first_login_at
      @attributes[:first_login_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def first_login_at=(value)
      @attributes[:first_login_at] = value
    end

    # Can the user access with FTP/FTPS?
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

    # Comma-separated list of group IDs of which this user is a member
    # @return [String, nil] the field value, or nil when absent.
    def group_ids
      @attributes[:group_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def group_ids=(value)
      @attributes[:group_ids] = value
    end

    # Text to display to the user in the header of the UI
    # @return [String, nil] the field value, or nil when absent.
    def header_text
      @attributes[:header_text]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def header_text=(value)
      @attributes[:header_text] = value
    end

    # Preferred language
    # @return [String, nil] the field value, or nil when absent.
    def language
      @attributes[:language]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def language=(value)
      @attributes[:language] = value
    end

    # User's most recent login time via any protocol
    # @return [String, nil] the field value, or nil when absent.
    def last_login_at
      @attributes[:last_login_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_login_at=(value)
      @attributes[:last_login_at] = value
    end

    # User's most recent login time via web
    # @return [String, nil] the field value, or nil when absent.
    def last_web_login_at
      @attributes[:last_web_login_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_web_login_at=(value)
      @attributes[:last_web_login_at] = value
    end

    # User's most recent login time via FTP
    # @return [String, nil] the field value, or nil when absent.
    def last_ftp_login_at
      @attributes[:last_ftp_login_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_ftp_login_at=(value)
      @attributes[:last_ftp_login_at] = value
    end

    # User's most recent login time via SFTP
    # @return [String, nil] the field value, or nil when absent.
    def last_sftp_login_at
      @attributes[:last_sftp_login_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_sftp_login_at=(value)
      @attributes[:last_sftp_login_at] = value
    end

    # User's most recent login time via WebDAV
    # @return [String, nil] the field value, or nil when absent.
    def last_dav_login_at
      @attributes[:last_dav_login_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_dav_login_at=(value)
      @attributes[:last_dav_login_at] = value
    end

    # User's most recent login time via Desktop app
    # @return [String, nil] the field value, or nil when absent.
    def last_desktop_login_at
      @attributes[:last_desktop_login_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_desktop_login_at=(value)
      @attributes[:last_desktop_login_at] = value
    end

    # User's most recent login time via Rest API
    # @return [String, nil] the field value, or nil when absent.
    def last_restapi_login_at
      @attributes[:last_restapi_login_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_restapi_login_at=(value)
      @attributes[:last_restapi_login_at] = value
    end

    # User's most recent API use time
    # @return [String, nil] the field value, or nil when absent.
    def last_api_use_at
      @attributes[:last_api_use_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_api_use_at=(value)
      @attributes[:last_api_use_at] = value
    end

    # User's most recent activity time, which is the latest of most recent login, most recent API use, enablement, or creation
    # @return [String, nil] the field value, or nil when absent.
    def last_active_at
      @attributes[:last_active_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_active_at=(value)
      @attributes[:last_active_at] = value
    end

    # The most recent protocol and cipher used
    # @return [String, nil] the field value, or nil when absent.
    def last_protocol_cipher
      @attributes[:last_protocol_cipher]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_protocol_cipher=(value)
      @attributes[:last_protocol_cipher] = value
    end

    # Time in the future that the user will no longer be locked out if applicable
    # @return [String, nil] the field value, or nil when absent.
    def lockout_expires
      @attributes[:lockout_expires]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def lockout_expires=(value)
      @attributes[:lockout_expires] = value
    end

    # User's full name
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

    # User's company
    # @return [String, nil] the field value, or nil when absent.
    def company
      @attributes[:company]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def company=(value)
      @attributes[:company] = value
    end

    # Any internal notes on the user
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

    # Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
    # @return [Integer, nil] the field value, or nil when absent.
    def notification_daily_send_time
      @attributes[:notification_daily_send_time]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def notification_daily_send_time=(value)
      @attributes[:notification_daily_send_time] = value
    end

    # Enable integration with Office for the web?
    # @return [Boolean, nil] the field value, or nil when absent.
    def office_integration_enabled
      @attributes[:office_integration_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def office_integration_enabled=(value)
      @attributes[:office_integration_enabled] = value
    end

    # Is this user a Partner administrator?
    # @return [Boolean, nil] the field value, or nil when absent.
    def partner_admin
      @attributes[:partner_admin]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def partner_admin=(value)
      @attributes[:partner_admin] = value
    end

    # Partner ID if this user belongs to a Partner
    # @return [Integer, nil] the field value, or nil when absent.
    def partner_id
      @attributes[:partner_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def partner_id=(value)
      @attributes[:partner_id] = value
    end

    # Name of the Partner if this user belongs to a Partner
    # @return [String, nil] the field value, or nil when absent.
    def partner_name
      @attributes[:partner_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def partner_name=(value)
      @attributes[:partner_name] = value
    end

    # Last time the user's password was set
    # @return [String, nil] the field value, or nil when absent.
    def password_set_at
      @attributes[:password_set_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def password_set_at=(value)
      @attributes[:password_set_at] = value
    end

    # Number of days to allow user to use the same password
    # @return [Integer, nil] the field value, or nil when absent.
    def password_validity_days
      @attributes[:password_validity_days]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def password_validity_days=(value)
      @attributes[:password_validity_days] = value
    end

    # Primary group ID for Group Admin scoping
    # @return [Integer, nil] the field value, or nil when absent.
    def primary_group_id
      @attributes[:primary_group_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def primary_group_id=(value)
      @attributes[:primary_group_id] = value
    end

    # Number of public keys associated with this user
    # @return [Integer, nil] the field value, or nil when absent.
    def public_keys_count
      @attributes[:public_keys_count]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def public_keys_count=(value)
      @attributes[:public_keys_count] = value
    end

    # Deprecated. Use notify_on_all_site_warnings and granular failure notification preferences instead.
    # @return [Boolean, nil] the field value, or nil when absent.
    def receive_admin_alerts
      @attributes[:receive_admin_alerts]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def receive_admin_alerts=(value)
      @attributes[:receive_admin_alerts] = value
    end

    # Should the user receive site warnings via email?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_all_site_warnings
      @attributes[:notify_on_all_site_warnings]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_all_site_warnings=(value)
      @attributes[:notify_on_all_site_warnings] = value
    end

    # Should the user receive sso/scim/ldap configuration/sync failures via email?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_all_sso_failures
      @attributes[:notify_on_all_sso_failures]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_all_sso_failures=(value)
      @attributes[:notify_on_all_sso_failures] = value
    end

    # Should the user receive user security events via email?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_all_user_security_events
      @attributes[:notify_on_all_user_security_events]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_all_user_security_events=(value)
      @attributes[:notify_on_all_user_security_events] = value
    end

    # Should the user receive pending work failures via email?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_all_pending_work_failures
      @attributes[:notify_on_all_pending_work_failures]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_all_pending_work_failures=(value)
      @attributes[:notify_on_all_pending_work_failures] = value
    end

    # Should the user receive siem failures via email?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_all_siem_http_destination_failures
      @attributes[:notify_on_all_siem_http_destination_failures]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_all_siem_http_destination_failures=(value)
      @attributes[:notify_on_all_siem_http_destination_failures] = value
    end

    # Should the user receive sync failures via email?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_all_sync_failures
      @attributes[:notify_on_all_sync_failures]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_all_sync_failures=(value)
      @attributes[:notify_on_all_sync_failures] = value
    end

    # Should the user receive automation failures via email?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_all_automation_failures
      @attributes[:notify_on_all_automation_failures]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_all_automation_failures=(value)
      @attributes[:notify_on_all_automation_failures] = value
    end

    # Should the user receive expectation failures and misses via email?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_all_expectation_failures
      @attributes[:notify_on_all_expectation_failures]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_all_expectation_failures=(value)
      @attributes[:notify_on_all_expectation_failures] = value
    end

    # 2FA required setting. `use_system_setting` uses the site-wide setting, including SSO exemptions. `always_require` and `never_require` override the site-wide setting when user-level overrides are allowed.
    # @return [String, nil] the field value, or nil when absent.
    def require_2fa
      @attributes[:require_2fa]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def require_2fa=(value)
      @attributes[:require_2fa] = value
    end

    # Require user to login by specified date otherwise it will be disabled.
    # @return [String, nil] the field value, or nil when absent.
    def require_login_by
      @attributes[:require_login_by]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def require_login_by=(value)
      @attributes[:require_login_by] = value
    end

    # Is 2fa active for the user?
    # @return [Boolean, nil] the field value, or nil when absent.
    def active_2fa
      @attributes[:active_2fa]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def active_2fa=(value)
      @attributes[:active_2fa] = value
    end

    # Is a password change required upon next user login?
    # @return [Boolean, nil] the field value, or nil when absent.
    def require_password_change
      @attributes[:require_password_change]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def require_password_change=(value)
      @attributes[:require_password_change] = value
    end

    # Is user's password expired?
    # @return [Boolean, nil] the field value, or nil when absent.
    def password_expired
      @attributes[:password_expired]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def password_expired=(value)
      @attributes[:password_expired] = value
    end

    # ID of the internal Group responsible for this Partner User, overriding the Partner default.
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

    # ID of the internal User responsible for this Partner User, overriding the Partner default.
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

    # Is the user an allowed to view all (non-billing) site configuration for this site?
    # @return [Boolean, nil] the field value, or nil when absent.
    def readonly_site_admin
      @attributes[:readonly_site_admin]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def readonly_site_admin=(value)
      @attributes[:readonly_site_admin] = value
    end

    # Can this user access the Web app, Desktop app, SDKs, or REST API?  (All of these tools use the API internally, so this is one unified permission set.)
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

    # Can the user access the S3-compatible endpoint? Defaults to true.
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

    # Does this user manage it's own credentials or is it a shared/bot user?
    # @return [Boolean, nil] the field value, or nil when absent.
    def self_managed
      @attributes[:self_managed]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def self_managed=(value)
      @attributes[:self_managed] = value
    end

    # Can the user access with SFTP?
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

    # Is the user an administrator for this site?
    # @return [Boolean, nil] the field value, or nil when absent.
    def site_admin
      @attributes[:site_admin]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def site_admin=(value)
      @attributes[:site_admin] = value
    end

    # Whether the user is an administrator of their own Custom Workspace. Does not reflect administration granted through Permissions.
    # @return [Boolean, nil] the field value, or nil when absent.
    def workspace_admin
      @attributes[:workspace_admin]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def workspace_admin=(value)
      @attributes[:workspace_admin] = value
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

    # ID of the Workspace the user belongs to. 0 is the Default Workspace.
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

    # Workspace ID the user should land in by default when more than one Workspace is available.
    # @return [Integer, nil] the field value, or nil when absent.
    def default_workspace_id
      @attributes[:default_workspace_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def default_workspace_id=(value)
      @attributes[:default_workspace_id] = value
    end

    # Skip Welcome page in the UI?
    # @return [Boolean, nil] the field value, or nil when absent.
    def skip_welcome_screen
      @attributes[:skip_welcome_screen]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def skip_welcome_screen=(value)
      @attributes[:skip_welcome_screen] = value
    end

    # SSL required setting
    # @return [String, nil] the field value, or nil when absent.
    def ssl_required
      @attributes[:ssl_required]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def ssl_required=(value)
      @attributes[:ssl_required] = value
    end

    # SSO (Single Sign On) strategy ID for the user, if applicable.
    # @return [Integer, nil] the field value, or nil when absent.
    def sso_strategy_id
      @attributes[:sso_strategy_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def sso_strategy_id=(value)
      @attributes[:sso_strategy_id] = value
    end

    # Is this user managed by a SsoStrategy?
    # @return [Boolean, nil] the field value, or nil when absent.
    def externally_managed
      @attributes[:externally_managed]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def externally_managed=(value)
      @attributes[:externally_managed] = value
    end

    # Comma-separated list of Tags for this user. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
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

    # User time zone
    # @return [String, nil] the field value, or nil when absent.
    def time_zone
      @attributes[:time_zone]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def time_zone=(value)
      @attributes[:time_zone] = value
    end

    # Type(s) of 2FA methods in use, for programmatic use.  Will be either `sms`, `totp`, `webauthn`, `yubi`, `email`, or multiple values sorted alphabetically and joined by an underscore.  Does not specify whether user has more than one of a given method.
    # @return [String, nil] the field value, or nil when absent.
    def type_of_2fa
      @attributes[:type_of_2fa]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def type_of_2fa=(value)
      @attributes[:type_of_2fa] = value
    end

    # Type(s) of 2FA methods in use, formatted for displaying in the UI.  Unlike `type_of_2fa`, this value will make clear when a user has more than 1 of the same type of method.
    # @return [String, nil] the field value, or nil when absent.
    def type_of_2fa_for_display
      @attributes[:type_of_2fa_for_display]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def type_of_2fa_for_display=(value)
      @attributes[:type_of_2fa_for_display] = value
    end

    # If filesystem layout is user_root, this path is the root path the user is fixed to for all interfaces. If the filesystem layout is site_root or partner_root, this acts as a root folder only for FTP and SFTP (SFTP applicability also requires a site-wide setting to be set). For partner_root layout, this path is relative to the Partner root folder for all callers and blank opts out of an additional protocol root. In this situation, this path is not applied to the API, Desktop, or Web interface.
    # @return [String, nil] the field value, or nil when absent.
    def user_root
      @attributes[:user_root]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def user_root=(value)
      @attributes[:user_root] = value
    end

    # Home folder for FTP/SFTP. For users with the partner_root filesystem layout, this path is relative to the Partner root folder. In all other cases, it is an absolute path. Only applies to FTP and SFTP, and not any other interface.
    # @return [String, nil] the field value, or nil when absent.
    def user_home
      @attributes[:user_home]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def user_home=(value)
      @attributes[:user_home] = value
    end

    # Number of days remaining until password expires
    # @return [Integer, nil] the field value, or nil when absent.
    def days_remaining_until_password_expire
      @attributes[:days_remaining_until_password_expire]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def days_remaining_until_password_expire=(value)
      @attributes[:days_remaining_until_password_expire] = value
    end

    # Password expiration datetime
    # @return [String, nil] the field value, or nil when absent.
    def password_expire_at
      @attributes[:password_expire_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def password_expire_at=(value)
      @attributes[:password_expire_at] = value
    end

    # An image file for your user avatar.
    # @return [Hash, nil] the field value, or nil when absent.
    def avatar_file
      @attributes[:avatar_file]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def avatar_file=(value)
      @attributes[:avatar_file] = value
    end

    # If true, the avatar will be deleted.
    # @return [Boolean, nil] the field value, or nil when absent.
    def avatar_delete
      @attributes[:avatar_delete]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def avatar_delete=(value)
      @attributes[:avatar_delete] = value
    end

    # Used for changing a password on an existing user.
    # @return [String, nil] the field value, or nil when absent.
    def change_password
      @attributes[:change_password]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def change_password=(value)
      @attributes[:change_password] = value
    end

    # Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
    # @return [String, nil] the field value, or nil when absent.
    def change_password_confirmation
      @attributes[:change_password_confirmation]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def change_password_confirmation=(value)
      @attributes[:change_password_confirmation] = value
    end

    # Permission to grant on the User Root upon creation, or on the Workspace root when the User Root is blank. For the Default Workspace, a blank User Root uses the site root. `admin` on a Custom Workspace's root grants Workspace Administrator access; on a subfolder it grants Folder Admin access. Can be blank or `admin`, `full`, `read`, `write`, `list`, `read+write`, `list+write`, or `history`.
    # @return [String, nil] the field value, or nil when absent.
    def grant_permission
      @attributes[:grant_permission]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def grant_permission=(value)
      @attributes[:grant_permission] = value
    end

    # Group ID to associate this user with.
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

    # Pre-calculated hash of the user's password. If supplied, this will be used to authenticate the user on first login. Supported hash methods are MD5, SHA1, and SHA256.
    # @return [String, nil] the field value, or nil when absent.
    def imported_password_hash
      @attributes[:imported_password_hash]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def imported_password_hash=(value)
      @attributes[:imported_password_hash] = value
    end

    # User password.
    # @return [String, nil] the field value, or nil when absent.
    def password
      @attributes[:password]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def password=(value)
      @attributes[:password] = value
    end

    # Optional, but if provided, we will ensure that it matches the value sent in `password`.
    # @return [String, nil] the field value, or nil when absent.
    def password_confirmation
      @attributes[:password_confirmation]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def password_confirmation=(value)
      @attributes[:password_confirmation] = value
    end

    # Signifies that the user has read all the announcements in the UI.
    # @return [Boolean, nil] the field value, or nil when absent.
    def announcements_read
      @attributes[:announcements_read]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def announcements_read=(value)
      @attributes[:announcements_read] = value
    end

    # If true when changing authentication_method from `password` to `sso`, remove all two-factor methods. Ignored in all other cases.
    # @return [Boolean, nil] the field value, or nil when absent.
    def clear_2fa
      @attributes[:clear_2fa]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def clear_2fa=(value)
      @attributes[:clear_2fa] = value
    end

    # Required when assigning a Partner to an existing non-Partner user. If true, convert the user by assigning the partner_id provided.
    # @return [Boolean, nil] the field value, or nil when absent.
    def convert_to_partner_user
      @attributes[:convert_to_partner_user]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def convert_to_partner_user=(value)
      @attributes[:convert_to_partner_user] = value
    end

    # Unlock user who has been locked out due to failed logins
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def unlock(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/users/#{@attributes[:id]}/unlock", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Resend user welcome email
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def resend_welcome_email(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/users/#{@attributes[:id]}/resend_welcome_email", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def user_2fa_reset(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/users/#{@attributes[:id]}/2fa/reset", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Update User
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Object] avatar_file An image file for your user avatar.
    # @option params [Boolean] avatar_delete If true, the avatar will be deleted.
    # @option params [String] change_password Used for changing a password on an existing user.
    # @option params [String] change_password_confirmation Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
    # @option params [String] email User's email.
    # @option params [String] grant_permission Permission to grant on the User Root upon creation, or on the Workspace root when the User Root is blank. For the Default Workspace, a blank User Root uses the site root. `admin` on a Custom Workspace's root grants Workspace Administrator access; on a subfolder it grants Folder Admin access. Can be blank or `admin`, `full`, `read`, `write`, `list`, `read+write`, `list+write`, or `history`.
    # @option params [Integer] group_id Group ID to associate this user with.
    # @option params [String] group_ids A list of group ids to associate this user with.  Comma delimited.
    # @option params [String] imported_password_hash Pre-calculated hash of the user's password. If supplied, this will be used to authenticate the user on first login. Supported hash methods are MD5, SHA1, and SHA256.
    # @option params [String] password User password.
    # @option params [String] password_confirmation Optional, but if provided, we will ensure that it matches the value sent in `password`.
    # @option params [Boolean] announcements_read Signifies that the user has read all the announcements in the UI.
    # @option params [Integer] ai_assistant_personality_id AI Assistant Personality ID assigned directly to this user, if any.
    # @option params [String] allowed_ips A list of allowed IPs if applicable.  Newline delimited
    # @option params [Boolean] attachments_permission DEPRECATED: If `true`, the user can user create Bundles (aka Share Links). Use the bundle permission instead.
    # @option params [String] authenticate_until Scheduled Date/Time at which user will be deactivated
    # @option params [String] authentication_method How is this user authenticated?
    # @option params [Boolean] billing_permission Allow this user to perform operations on the account, payments, and invoices?
    # @option params [Boolean] bypass_user_lifecycle_rules Exempt this user from user lifecycle rules?
    # @option params [Boolean] bypass_site_allowed_ips Allow this user to skip site-wide IP blacklists?
    # @option params [Boolean] dav_permission Can the user connect with WebDAV?
    # @option params [Integer] desktop_configuration_profile_id Desktop Configuration Profile ID assigned directly to this user, if any.
    # @option params [Integer] default_workspace_id Workspace ID the user should land in by default when more than one Workspace is available.
    # @option params [Boolean] disabled Is user disabled? Disabled users cannot log in, and do not count for billing purposes. Users can be automatically disabled after an inactivity period via a Site setting or schedule to be deactivated after specific date.
    # @option params [String] filesystem_layout File system layout
    # @option params [Boolean] ftp_permission Can the user access with FTP/FTPS?
    # @option params [String] header_text Text to display to the user in the header of the UI
    # @option params [Integer] integration_centric_profile_id Integration Centric Profile ID assigned directly to this user, if any.
    # @option params [String] language Preferred language
    # @option params [Integer] notification_daily_send_time Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
    # @option params [String] name User's full name
    # @option params [String] company User's company
    # @option params [String] notes Any internal notes on the user
    # @option params [Boolean] office_integration_enabled Enable integration with Office for the web?
    # @option params [Boolean] partner_admin Is this user a Partner administrator?
    # @option params [Integer] partner_id Partner ID if this user belongs to a Partner
    # @option params [Integer] password_validity_days Number of days to allow user to use the same password
    # @option params [Integer] primary_group_id Primary group ID for Group Admin scoping
    # @option params [Boolean] readonly_site_admin Is the user an allowed to view all (non-billing) site configuration for this site?
    # @option params [Boolean] receive_admin_alerts Deprecated. Use notify_on_all_site_warnings and granular failure notification preferences instead.
    # @option params [Boolean] notify_on_all_site_warnings Should the user receive site warnings via email?
    # @option params [Boolean] notify_on_all_sso_failures Should the user receive sso/scim/ldap configuration/sync failures via email?
    # @option params [Boolean] notify_on_all_user_security_events Should the user receive user security events via email?
    # @option params [Boolean] notify_on_all_pending_work_failures Should the user receive pending work failures via email?
    # @option params [Boolean] notify_on_all_siem_http_destination_failures Should the user receive siem failures via email?
    # @option params [Boolean] notify_on_all_sync_failures Should the user receive sync failures via email?
    # @option params [Boolean] notify_on_all_automation_failures Should the user receive automation failures via email?
    # @option params [Boolean] notify_on_all_expectation_failures Should the user receive expectation failures and misses via email?
    # @option params [String] require_login_by Require user to login by specified date otherwise it will be disabled.
    # @option params [Boolean] require_password_change Is a password change required upon next user login?
    # @option params [Integer] responsible_group_id ID of the internal Group responsible for this Partner User, overriding the Partner default.
    # @option params [Integer] responsible_user_id ID of the internal User responsible for this Partner User, overriding the Partner default.
    # @option params [Boolean] restapi_permission Can this user access the Web app, Desktop app, SDKs, or REST API?  (All of these tools use the API internally, so this is one unified permission set.)
    # @option params [Boolean] s3_compatible_endpoint_permission Can the user access the S3-compatible endpoint? Defaults to true.
    # @option params [Boolean] self_managed Does this user manage it's own credentials or is it a shared/bot user?
    # @option params [Boolean] sftp_permission Can the user access with SFTP?
    # @option params [Boolean] site_admin Is the user an administrator for this site?
    # @option params [Boolean] skip_welcome_screen Skip Welcome page in the UI?
    # @option params [String] ssl_required SSL required setting
    # @option params [Integer] sso_strategy_id SSO (Single Sign On) strategy ID for the user, if applicable.
    # @option params [String] require_2fa 2FA required setting. `use_system_setting` uses the site-wide setting, including SSO exemptions. `always_require` and `never_require` override the site-wide setting when user-level overrides are allowed.
    # @option params [String] tags Comma-separated list of Tags for this user. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    # @option params [String] time_zone User time zone
    # @option params [String] user_root If filesystem layout is user_root, this path is the root path the user is fixed to for all interfaces. If the filesystem layout is site_root or partner_root, this acts as a root folder only for FTP and SFTP (SFTP applicability also requires a site-wide setting to be set). For partner_root layout, this path is relative to the Partner root folder for all callers and blank opts out of an additional protocol root. In this situation, this path is not applied to the API, Desktop, or Web interface.
    # @option params [String] user_home Home folder for FTP/SFTP. For users with the partner_root filesystem layout, this path is relative to the Partner root folder. In all other cases, it is an absolute path. Only applies to FTP and SFTP, and not any other interface.
    # @option params [Boolean] workspace_admin Whether the user is an administrator of their own Custom Workspace. Does not reflect administration granted through Permissions.
    # @option params [String] username User's username
    # @option params [Integer] workspace_id Workspace ID. Only Site Administrators can change this field. Values supplied by Workspace Administrators, Group Administrators, or other non-Site Administrators using `/user` are ignored.
    # @option params [Boolean] clear_2fa If true when changing authentication_method from `password` to `sso`, remove all two-factor methods. Ignored in all other cases.
    # @option params [Boolean] convert_to_partner_user Required when assigning a Partner to an existing non-Partner user. If true, convert the user by assigning the partner_id provided.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: avatar_delete must be a single value, not #{params[:avatar_delete].class}") if [ Array, Hash ].any? { |klass| params[:avatar_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: change_password must be an String") if !params[:change_password].nil? and !params[:change_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: change_password_confirmation must be an String") if !params[:change_password_confirmation].nil? and !params[:change_password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if !params[:email].nil? and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: grant_permission must be an String") if !params[:grant_permission].nil? and !params[:grant_permission].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if !params[:group_ids].nil? and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: imported_password_hash must be an String") if !params[:imported_password_hash].nil? and !params[:imported_password_hash].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_confirmation must be an String") if !params[:password_confirmation].nil? and !params[:password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: announcements_read must be a single value, not #{params[:announcements_read].class}") if [ Array, Hash ].any? { |klass| params[:announcements_read].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ai_assistant_personality_id must be an Integer") if !params[:ai_assistant_personality_id].nil? and !params[:ai_assistant_personality_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if !params[:allowed_ips].nil? and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: attachments_permission must be a single value, not #{params[:attachments_permission].class}") if [ Array, Hash ].any? { |klass| params[:attachments_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: authenticate_until must be an String") if !params[:authenticate_until].nil? and !params[:authenticate_until].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if !params[:authentication_method].nil? and !params[:authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: billing_permission must be a single value, not #{params[:billing_permission].class}") if [ Array, Hash ].any? { |klass| params[:billing_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bypass_user_lifecycle_rules must be a single value, not #{params[:bypass_user_lifecycle_rules].class}") if [ Array, Hash ].any? { |klass| params[:bypass_user_lifecycle_rules].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bypass_site_allowed_ips must be a single value, not #{params[:bypass_site_allowed_ips].class}") if [ Array, Hash ].any? { |klass| params[:bypass_site_allowed_ips].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: dav_permission must be a single value, not #{params[:dav_permission].class}") if [ Array, Hash ].any? { |klass| params[:dav_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: desktop_configuration_profile_id must be an Integer") if !params[:desktop_configuration_profile_id].nil? and !params[:desktop_configuration_profile_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: default_workspace_id must be an Integer") if !params[:default_workspace_id].nil? and !params[:default_workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: disabled must be a single value, not #{params[:disabled].class}") if [ Array, Hash ].any? { |klass| params[:disabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: filesystem_layout must be an String") if !params[:filesystem_layout].nil? and !params[:filesystem_layout].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ftp_permission must be a single value, not #{params[:ftp_permission].class}") if [ Array, Hash ].any? { |klass| params[:ftp_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: header_text must be an String") if !params[:header_text].nil? and !params[:header_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: integration_centric_profile_id must be an Integer") if !params[:integration_centric_profile_id].nil? and !params[:integration_centric_profile_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if !params[:language].nil? and !params[:language].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notification_daily_send_time must be an Integer") if !params[:notification_daily_send_time].nil? and !params[:notification_daily_send_time].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company must be an String") if !params[:company].nil? and !params[:company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if !params[:notes].nil? and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: office_integration_enabled must be a single value, not #{params[:office_integration_enabled].class}") if [ Array, Hash ].any? { |klass| params[:office_integration_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: partner_admin must be a single value, not #{params[:partner_admin].class}") if [ Array, Hash ].any? { |klass| params[:partner_admin].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if !params[:partner_id].nil? and !params[:partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password_validity_days must be an Integer") if !params[:password_validity_days].nil? and !params[:password_validity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: primary_group_id must be an Integer") if !params[:primary_group_id].nil? and !params[:primary_group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: readonly_site_admin must be a single value, not #{params[:readonly_site_admin].class}") if [ Array, Hash ].any? { |klass| params[:readonly_site_admin].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: receive_admin_alerts must be a single value, not #{params[:receive_admin_alerts].class}") if [ Array, Hash ].any? { |klass| params[:receive_admin_alerts].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_site_warnings must be a single value, not #{params[:notify_on_all_site_warnings].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_site_warnings].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_sso_failures must be a single value, not #{params[:notify_on_all_sso_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_sso_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_user_security_events must be a single value, not #{params[:notify_on_all_user_security_events].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_user_security_events].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_pending_work_failures must be a single value, not #{params[:notify_on_all_pending_work_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_pending_work_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_siem_http_destination_failures must be a single value, not #{params[:notify_on_all_siem_http_destination_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_siem_http_destination_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_sync_failures must be a single value, not #{params[:notify_on_all_sync_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_sync_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_automation_failures must be a single value, not #{params[:notify_on_all_automation_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_automation_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_expectation_failures must be a single value, not #{params[:notify_on_all_expectation_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_expectation_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: require_login_by must be an String") if !params[:require_login_by].nil? and !params[:require_login_by].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: require_password_change must be a single value, not #{params[:require_password_change].class}") if [ Array, Hash ].any? { |klass| params[:require_password_change].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: responsible_group_id must be an Integer") if !params[:responsible_group_id].nil? and !params[:responsible_group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: responsible_user_id must be an Integer") if !params[:responsible_user_id].nil? and !params[:responsible_user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: restapi_permission must be a single value, not #{params[:restapi_permission].class}") if [ Array, Hash ].any? { |klass| params[:restapi_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint_permission must be a single value, not #{params[:s3_compatible_endpoint_permission].class}") if [ Array, Hash ].any? { |klass| params[:s3_compatible_endpoint_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: self_managed must be a single value, not #{params[:self_managed].class}") if [ Array, Hash ].any? { |klass| params[:self_managed].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_permission must be a single value, not #{params[:sftp_permission].class}") if [ Array, Hash ].any? { |klass| params[:sftp_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: site_admin must be a single value, not #{params[:site_admin].class}") if [ Array, Hash ].any? { |klass| params[:site_admin].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_welcome_screen must be a single value, not #{params[:skip_welcome_screen].class}") if [ Array, Hash ].any? { |klass| params[:skip_welcome_screen].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ssl_required must be an String") if !params[:ssl_required].nil? and !params[:ssl_required].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sso_strategy_id must be an Integer") if !params[:sso_strategy_id].nil? and !params[:sso_strategy_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: require_2fa must be an String") if !params[:require_2fa].nil? and !params[:require_2fa].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: tags must be an String") if !params[:tags].nil? and !params[:tags].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: time_zone must be an String") if !params[:time_zone].nil? and !params[:time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_root must be an String") if !params[:user_root].nil? and !params[:user_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_home must be an String") if !params[:user_home].nil? and !params[:user_home].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_admin must be a single value, not #{params[:workspace_admin].class}") if [ Array, Hash ].any? { |klass| params[:workspace_admin].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: username must be an String") if !params[:username].nil? and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: clear_2fa must be a single value, not #{params[:clear_2fa].class}") if [ Array, Hash ].any? { |klass| params[:clear_2fa].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: convert_to_partner_user must be a single value, not #{params[:convert_to_partner_user].class}") if [ Array, Hash ].any? { |klass| params[:convert_to_partner_user].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/users/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("User") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete User
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] new_owner_id Provide a User ID here to transfer ownership of certain resources such as Automations and Share Links (Bundles) to that new user.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: new_owner_id must be an Integer") if !params[:new_owner_id].nil? and !params[:new_owner_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/users/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = User.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Users
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `site_id`, `workspace_id`, `company`, `name`, `disabled`, `authenticate_until`, `username`, `email`, `site_admin`, `last_desktop_login_at`, `last_login_at`, `password_validity_days` or `ssl_required`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `username`, `name`, `email`, `company`, `site_admin`, `password_validity_days`, `ssl_required`, `last_login_at`, `authenticate_until`, `not_site_admin`, `disabled`, `partner_id`, `primary_group_id` or `workspace_id`. Valid field combinations are `[ site_admin, username ]`, `[ not_site_admin, username ]`, `[ workspace_id, username ]`, `[ company, name ]`, `[ workspace_id, name ]`, `[ workspace_id, email ]`, `[ workspace_id, company ]`, `[ workspace_id, site_admin ]`, `[ workspace_id, not_site_admin ]`, `[ workspace_id, disabled ]`, `[ workspace_id, partner_id ]`, `[ workspace_id, site_admin, username ]`, `[ workspace_id, not_site_admin, username ]`, `[ workspace_id, disabled, username ]`, `[ workspace_id, partner_id, username ]` or `[ workspace_id, company, name ]`.
    # @option params [Hash] filter_gt If set, return records where the specified field is greater than the supplied value. Valid fields are `password_validity_days`, `last_login_at` or `authenticate_until`.
    # @option params [Hash] filter_gteq If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `password_validity_days`, `last_login_at` or `authenticate_until`.
    # @option params [Hash] filter_prefix If set, return records where the specified field is prefixed by the supplied value. Valid fields are `username`, `name`, `email` or `company`. Valid field combinations are `[ company, name ]`.
    # @option params [Hash] filter_lt If set, return records where the specified field is less than the supplied value. Valid fields are `password_validity_days`, `last_login_at` or `authenticate_until`.
    # @option params [Hash] filter_lteq If set, return records where the specified field is less than or equal the supplied value. Valid fields are `password_validity_days`, `last_login_at` or `authenticate_until`.
    # @option params [String] ids comma-separated list of User IDs
    # @option params [Boolean] include_parent_site_users Include users from the parent site.
    # @option params [Boolean] include_default_workspace_users When scoped to a Custom Workspace, include Default Workspace users who have permissions in that Workspace. Available to Site Administrators, and to Workspace Administrators and Folder Admins in that Workspace when the site shares its Default Workspace directory with Workspaces.
    # @option params [String] search Searches for partial matches of name, username, or email.
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
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if !params[:filter_gt].nil? and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if !params[:filter_gteq].nil? and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if !params[:filter_prefix].nil? and !params[:filter_prefix].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if !params[:filter_lt].nil? and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if !params[:filter_lteq].nil? and !params[:filter_lteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: ids must be an String") if !params[:ids].nil? and !params[:ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: include_parent_site_users must be a single value, not #{params[:include_parent_site_users].class}") if [ Array, Hash ].any? { |klass| params[:include_parent_site_users].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: include_default_workspace_users must be a single value, not #{params[:include_default_workspace_users].class}") if [ Array, Hash ].any? { |klass| params[:include_default_workspace_users].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: search must be an String") if !params[:search].nil? and !params[:search].is_a?(String)

      list_options = options.dup
      List.new(User, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/users", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show User
    #
    # @param id [Integer] User ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::User] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/users/#{params[:id]}", :get, params, options) { |reply| reply.require_object("User") }
      User.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create User
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Object] avatar_file An image file for your user avatar.
    # @option params [Boolean] avatar_delete If true, the avatar will be deleted.
    # @option params [String] change_password Used for changing a password on an existing user.
    # @option params [String] change_password_confirmation Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
    # @option params [String] email User's email.
    # @option params [String] grant_permission Permission to grant on the User Root upon creation, or on the Workspace root when the User Root is blank. For the Default Workspace, a blank User Root uses the site root. `admin` on a Custom Workspace's root grants Workspace Administrator access; on a subfolder it grants Folder Admin access. Can be blank or `admin`, `full`, `read`, `write`, `list`, `read+write`, `list+write`, or `history`.
    # @option params [Integer] group_id Group ID to associate this user with.
    # @option params [String] group_ids A list of group ids to associate this user with.  Comma delimited.
    # @option params [String] imported_password_hash Pre-calculated hash of the user's password. If supplied, this will be used to authenticate the user on first login. Supported hash methods are MD5, SHA1, and SHA256.
    # @option params [String] password User password.
    # @option params [String] password_confirmation Optional, but if provided, we will ensure that it matches the value sent in `password`.
    # @option params [Boolean] announcements_read Signifies that the user has read all the announcements in the UI.
    # @option params [Integer] ai_assistant_personality_id AI Assistant Personality ID assigned directly to this user, if any.
    # @option params [String] allowed_ips A list of allowed IPs if applicable.  Newline delimited
    # @option params [Boolean] attachments_permission DEPRECATED: If `true`, the user can user create Bundles (aka Share Links). Use the bundle permission instead.
    # @option params [String] authenticate_until Scheduled Date/Time at which user will be deactivated
    # @option params [String] authentication_method How is this user authenticated?
    # @option params [Boolean] billing_permission Allow this user to perform operations on the account, payments, and invoices?
    # @option params [Boolean] bypass_user_lifecycle_rules Exempt this user from user lifecycle rules?
    # @option params [Boolean] bypass_site_allowed_ips Allow this user to skip site-wide IP blacklists?
    # @option params [Boolean] dav_permission Can the user connect with WebDAV?
    # @option params [Integer] desktop_configuration_profile_id Desktop Configuration Profile ID assigned directly to this user, if any.
    # @option params [Integer] default_workspace_id Workspace ID the user should land in by default when more than one Workspace is available.
    # @option params [Boolean] disabled Is user disabled? Disabled users cannot log in, and do not count for billing purposes. Users can be automatically disabled after an inactivity period via a Site setting or schedule to be deactivated after specific date.
    # @option params [String] filesystem_layout File system layout
    # @option params [Boolean] ftp_permission Can the user access with FTP/FTPS?
    # @option params [String] header_text Text to display to the user in the header of the UI
    # @option params [Integer] integration_centric_profile_id Integration Centric Profile ID assigned directly to this user, if any.
    # @option params [String] language Preferred language
    # @option params [Integer] notification_daily_send_time Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
    # @option params [String] name User's full name
    # @option params [String] company User's company
    # @option params [String] notes Any internal notes on the user
    # @option params [Boolean] office_integration_enabled Enable integration with Office for the web?
    # @option params [Boolean] partner_admin Is this user a Partner administrator?
    # @option params [Integer] partner_id Partner ID if this user belongs to a Partner
    # @option params [Integer] password_validity_days Number of days to allow user to use the same password
    # @option params [Integer] primary_group_id Primary group ID for Group Admin scoping
    # @option params [Boolean] readonly_site_admin Is the user an allowed to view all (non-billing) site configuration for this site?
    # @option params [Boolean] receive_admin_alerts Deprecated. Use notify_on_all_site_warnings and granular failure notification preferences instead.
    # @option params [Boolean] notify_on_all_site_warnings Should the user receive site warnings via email?
    # @option params [Boolean] notify_on_all_sso_failures Should the user receive sso/scim/ldap configuration/sync failures via email?
    # @option params [Boolean] notify_on_all_user_security_events Should the user receive user security events via email?
    # @option params [Boolean] notify_on_all_pending_work_failures Should the user receive pending work failures via email?
    # @option params [Boolean] notify_on_all_siem_http_destination_failures Should the user receive siem failures via email?
    # @option params [Boolean] notify_on_all_sync_failures Should the user receive sync failures via email?
    # @option params [Boolean] notify_on_all_automation_failures Should the user receive automation failures via email?
    # @option params [Boolean] notify_on_all_expectation_failures Should the user receive expectation failures and misses via email?
    # @option params [String] require_login_by Require user to login by specified date otherwise it will be disabled.
    # @option params [Boolean] require_password_change Is a password change required upon next user login?
    # @option params [Integer] responsible_group_id ID of the internal Group responsible for this Partner User, overriding the Partner default.
    # @option params [Integer] responsible_user_id ID of the internal User responsible for this Partner User, overriding the Partner default.
    # @option params [Boolean] restapi_permission Can this user access the Web app, Desktop app, SDKs, or REST API?  (All of these tools use the API internally, so this is one unified permission set.)
    # @option params [Boolean] s3_compatible_endpoint_permission Can the user access the S3-compatible endpoint? Defaults to true.
    # @option params [Boolean] self_managed Does this user manage it's own credentials or is it a shared/bot user?
    # @option params [Boolean] sftp_permission Can the user access with SFTP?
    # @option params [Boolean] site_admin Is the user an administrator for this site?
    # @option params [Boolean] skip_welcome_screen Skip Welcome page in the UI?
    # @option params [String] ssl_required SSL required setting
    # @option params [Integer] sso_strategy_id SSO (Single Sign On) strategy ID for the user, if applicable.
    # @option params [String] require_2fa 2FA required setting. `use_system_setting` uses the site-wide setting, including SSO exemptions. `always_require` and `never_require` override the site-wide setting when user-level overrides are allowed.
    # @option params [String] tags Comma-separated list of Tags for this user. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    # @option params [String] time_zone User time zone
    # @option params [String] user_root If filesystem layout is user_root, this path is the root path the user is fixed to for all interfaces. If the filesystem layout is site_root or partner_root, this acts as a root folder only for FTP and SFTP (SFTP applicability also requires a site-wide setting to be set). For partner_root layout, this path is relative to the Partner root folder for all callers and blank opts out of an additional protocol root. In this situation, this path is not applied to the API, Desktop, or Web interface.
    # @option params [String] user_home Home folder for FTP/SFTP. For users with the partner_root filesystem layout, this path is relative to the Partner root folder. In all other cases, it is an absolute path. Only applies to FTP and SFTP, and not any other interface.
    # @option params [Boolean] workspace_admin Whether the user is an administrator of their own Custom Workspace. Does not reflect administration granted through Permissions.
    # @option params [String] username Required. User's username
    # @option params [Integer] workspace_id ID of the Workspace the user belongs to. 0 is the Default Workspace.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::User] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: avatar_delete must be a single value, not #{params[:avatar_delete].class}") if [ Array, Hash ].any? { |klass| params[:avatar_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: change_password must be an String") if !params[:change_password].nil? and !params[:change_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: change_password_confirmation must be an String") if !params[:change_password_confirmation].nil? and !params[:change_password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if !params[:email].nil? and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: grant_permission must be an String") if !params[:grant_permission].nil? and !params[:grant_permission].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if !params[:group_ids].nil? and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: imported_password_hash must be an String") if !params[:imported_password_hash].nil? and !params[:imported_password_hash].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_confirmation must be an String") if !params[:password_confirmation].nil? and !params[:password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: announcements_read must be a single value, not #{params[:announcements_read].class}") if [ Array, Hash ].any? { |klass| params[:announcements_read].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ai_assistant_personality_id must be an Integer") if !params[:ai_assistant_personality_id].nil? and !params[:ai_assistant_personality_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if !params[:allowed_ips].nil? and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: attachments_permission must be a single value, not #{params[:attachments_permission].class}") if [ Array, Hash ].any? { |klass| params[:attachments_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: authenticate_until must be an String") if !params[:authenticate_until].nil? and !params[:authenticate_until].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if !params[:authentication_method].nil? and !params[:authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: billing_permission must be a single value, not #{params[:billing_permission].class}") if [ Array, Hash ].any? { |klass| params[:billing_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bypass_user_lifecycle_rules must be a single value, not #{params[:bypass_user_lifecycle_rules].class}") if [ Array, Hash ].any? { |klass| params[:bypass_user_lifecycle_rules].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bypass_site_allowed_ips must be a single value, not #{params[:bypass_site_allowed_ips].class}") if [ Array, Hash ].any? { |klass| params[:bypass_site_allowed_ips].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: dav_permission must be a single value, not #{params[:dav_permission].class}") if [ Array, Hash ].any? { |klass| params[:dav_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: desktop_configuration_profile_id must be an Integer") if !params[:desktop_configuration_profile_id].nil? and !params[:desktop_configuration_profile_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: default_workspace_id must be an Integer") if !params[:default_workspace_id].nil? and !params[:default_workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: disabled must be a single value, not #{params[:disabled].class}") if [ Array, Hash ].any? { |klass| params[:disabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: filesystem_layout must be an String") if !params[:filesystem_layout].nil? and !params[:filesystem_layout].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ftp_permission must be a single value, not #{params[:ftp_permission].class}") if [ Array, Hash ].any? { |klass| params[:ftp_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: header_text must be an String") if !params[:header_text].nil? and !params[:header_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: integration_centric_profile_id must be an Integer") if !params[:integration_centric_profile_id].nil? and !params[:integration_centric_profile_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if !params[:language].nil? and !params[:language].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notification_daily_send_time must be an Integer") if !params[:notification_daily_send_time].nil? and !params[:notification_daily_send_time].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company must be an String") if !params[:company].nil? and !params[:company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if !params[:notes].nil? and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: office_integration_enabled must be a single value, not #{params[:office_integration_enabled].class}") if [ Array, Hash ].any? { |klass| params[:office_integration_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: partner_admin must be a single value, not #{params[:partner_admin].class}") if [ Array, Hash ].any? { |klass| params[:partner_admin].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if !params[:partner_id].nil? and !params[:partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password_validity_days must be an Integer") if !params[:password_validity_days].nil? and !params[:password_validity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: primary_group_id must be an Integer") if !params[:primary_group_id].nil? and !params[:primary_group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: readonly_site_admin must be a single value, not #{params[:readonly_site_admin].class}") if [ Array, Hash ].any? { |klass| params[:readonly_site_admin].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: receive_admin_alerts must be a single value, not #{params[:receive_admin_alerts].class}") if [ Array, Hash ].any? { |klass| params[:receive_admin_alerts].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_site_warnings must be a single value, not #{params[:notify_on_all_site_warnings].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_site_warnings].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_sso_failures must be a single value, not #{params[:notify_on_all_sso_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_sso_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_user_security_events must be a single value, not #{params[:notify_on_all_user_security_events].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_user_security_events].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_pending_work_failures must be a single value, not #{params[:notify_on_all_pending_work_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_pending_work_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_siem_http_destination_failures must be a single value, not #{params[:notify_on_all_siem_http_destination_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_siem_http_destination_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_sync_failures must be a single value, not #{params[:notify_on_all_sync_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_sync_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_automation_failures must be a single value, not #{params[:notify_on_all_automation_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_automation_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_expectation_failures must be a single value, not #{params[:notify_on_all_expectation_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_expectation_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: require_login_by must be an String") if !params[:require_login_by].nil? and !params[:require_login_by].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: require_password_change must be a single value, not #{params[:require_password_change].class}") if [ Array, Hash ].any? { |klass| params[:require_password_change].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: responsible_group_id must be an Integer") if !params[:responsible_group_id].nil? and !params[:responsible_group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: responsible_user_id must be an Integer") if !params[:responsible_user_id].nil? and !params[:responsible_user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: restapi_permission must be a single value, not #{params[:restapi_permission].class}") if [ Array, Hash ].any? { |klass| params[:restapi_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint_permission must be a single value, not #{params[:s3_compatible_endpoint_permission].class}") if [ Array, Hash ].any? { |klass| params[:s3_compatible_endpoint_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: self_managed must be a single value, not #{params[:self_managed].class}") if [ Array, Hash ].any? { |klass| params[:self_managed].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_permission must be a single value, not #{params[:sftp_permission].class}") if [ Array, Hash ].any? { |klass| params[:sftp_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: site_admin must be a single value, not #{params[:site_admin].class}") if [ Array, Hash ].any? { |klass| params[:site_admin].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_welcome_screen must be a single value, not #{params[:skip_welcome_screen].class}") if [ Array, Hash ].any? { |klass| params[:skip_welcome_screen].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ssl_required must be an String") if !params[:ssl_required].nil? and !params[:ssl_required].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sso_strategy_id must be an Integer") if !params[:sso_strategy_id].nil? and !params[:sso_strategy_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: require_2fa must be an String") if !params[:require_2fa].nil? and !params[:require_2fa].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: tags must be an String") if !params[:tags].nil? and !params[:tags].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: time_zone must be an String") if !params[:time_zone].nil? and !params[:time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_root must be an String") if !params[:user_root].nil? and !params[:user_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_home must be an String") if !params[:user_home].nil? and !params[:user_home].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_admin must be a single value, not #{params[:workspace_admin].class}") if [ Array, Hash ].any? { |klass| params[:workspace_admin].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: username must be an String") if !params[:username].nil? and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: username") if params[:username].nil?

      response, options = Api.send_request("/users", :post, params, options) { |reply| reply.require_object("User") }
      User.new(response.data, options)
    end

    # Unlock user who has been locked out due to failed logins
    #
    # @param id [Integer] User ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.unlock(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/users/#{params[:id]}/unlock", :post, params, options)
      nil
    end

    # Resend user welcome email
    #
    # @param id [Integer] User ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.resend_welcome_email(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/users/#{params[:id]}/resend_welcome_email", :post, params, options)
      nil
    end

    # Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
    #
    # @param id [Integer] User ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.user_2fa_reset(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/users/#{params[:id]}/2fa/reset", :post, params, options)
      nil
    end

    # Update User
    #
    # @param id [Integer] User ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Object] avatar_file An image file for your user avatar.
    # @option params [Boolean] avatar_delete If true, the avatar will be deleted.
    # @option params [String] change_password Used for changing a password on an existing user.
    # @option params [String] change_password_confirmation Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
    # @option params [String] email User's email.
    # @option params [String] grant_permission Permission to grant on the User Root upon creation, or on the Workspace root when the User Root is blank. For the Default Workspace, a blank User Root uses the site root. `admin` on a Custom Workspace's root grants Workspace Administrator access; on a subfolder it grants Folder Admin access. Can be blank or `admin`, `full`, `read`, `write`, `list`, `read+write`, `list+write`, or `history`.
    # @option params [Integer] group_id Group ID to associate this user with.
    # @option params [String] group_ids A list of group ids to associate this user with.  Comma delimited.
    # @option params [String] imported_password_hash Pre-calculated hash of the user's password. If supplied, this will be used to authenticate the user on first login. Supported hash methods are MD5, SHA1, and SHA256.
    # @option params [String] password User password.
    # @option params [String] password_confirmation Optional, but if provided, we will ensure that it matches the value sent in `password`.
    # @option params [Boolean] announcements_read Signifies that the user has read all the announcements in the UI.
    # @option params [Integer] ai_assistant_personality_id AI Assistant Personality ID assigned directly to this user, if any.
    # @option params [String] allowed_ips A list of allowed IPs if applicable.  Newline delimited
    # @option params [Boolean] attachments_permission DEPRECATED: If `true`, the user can user create Bundles (aka Share Links). Use the bundle permission instead.
    # @option params [String] authenticate_until Scheduled Date/Time at which user will be deactivated
    # @option params [String] authentication_method How is this user authenticated?
    # @option params [Boolean] billing_permission Allow this user to perform operations on the account, payments, and invoices?
    # @option params [Boolean] bypass_user_lifecycle_rules Exempt this user from user lifecycle rules?
    # @option params [Boolean] bypass_site_allowed_ips Allow this user to skip site-wide IP blacklists?
    # @option params [Boolean] dav_permission Can the user connect with WebDAV?
    # @option params [Integer] desktop_configuration_profile_id Desktop Configuration Profile ID assigned directly to this user, if any.
    # @option params [Integer] default_workspace_id Workspace ID the user should land in by default when more than one Workspace is available.
    # @option params [Boolean] disabled Is user disabled? Disabled users cannot log in, and do not count for billing purposes. Users can be automatically disabled after an inactivity period via a Site setting or schedule to be deactivated after specific date.
    # @option params [String] filesystem_layout File system layout
    # @option params [Boolean] ftp_permission Can the user access with FTP/FTPS?
    # @option params [String] header_text Text to display to the user in the header of the UI
    # @option params [Integer] integration_centric_profile_id Integration Centric Profile ID assigned directly to this user, if any.
    # @option params [String] language Preferred language
    # @option params [Integer] notification_daily_send_time Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
    # @option params [String] name User's full name
    # @option params [String] company User's company
    # @option params [String] notes Any internal notes on the user
    # @option params [Boolean] office_integration_enabled Enable integration with Office for the web?
    # @option params [Boolean] partner_admin Is this user a Partner administrator?
    # @option params [Integer] partner_id Partner ID if this user belongs to a Partner
    # @option params [Integer] password_validity_days Number of days to allow user to use the same password
    # @option params [Integer] primary_group_id Primary group ID for Group Admin scoping
    # @option params [Boolean] readonly_site_admin Is the user an allowed to view all (non-billing) site configuration for this site?
    # @option params [Boolean] receive_admin_alerts Deprecated. Use notify_on_all_site_warnings and granular failure notification preferences instead.
    # @option params [Boolean] notify_on_all_site_warnings Should the user receive site warnings via email?
    # @option params [Boolean] notify_on_all_sso_failures Should the user receive sso/scim/ldap configuration/sync failures via email?
    # @option params [Boolean] notify_on_all_user_security_events Should the user receive user security events via email?
    # @option params [Boolean] notify_on_all_pending_work_failures Should the user receive pending work failures via email?
    # @option params [Boolean] notify_on_all_siem_http_destination_failures Should the user receive siem failures via email?
    # @option params [Boolean] notify_on_all_sync_failures Should the user receive sync failures via email?
    # @option params [Boolean] notify_on_all_automation_failures Should the user receive automation failures via email?
    # @option params [Boolean] notify_on_all_expectation_failures Should the user receive expectation failures and misses via email?
    # @option params [String] require_login_by Require user to login by specified date otherwise it will be disabled.
    # @option params [Boolean] require_password_change Is a password change required upon next user login?
    # @option params [Integer] responsible_group_id ID of the internal Group responsible for this Partner User, overriding the Partner default.
    # @option params [Integer] responsible_user_id ID of the internal User responsible for this Partner User, overriding the Partner default.
    # @option params [Boolean] restapi_permission Can this user access the Web app, Desktop app, SDKs, or REST API?  (All of these tools use the API internally, so this is one unified permission set.)
    # @option params [Boolean] s3_compatible_endpoint_permission Can the user access the S3-compatible endpoint? Defaults to true.
    # @option params [Boolean] self_managed Does this user manage it's own credentials or is it a shared/bot user?
    # @option params [Boolean] sftp_permission Can the user access with SFTP?
    # @option params [Boolean] site_admin Is the user an administrator for this site?
    # @option params [Boolean] skip_welcome_screen Skip Welcome page in the UI?
    # @option params [String] ssl_required SSL required setting
    # @option params [Integer] sso_strategy_id SSO (Single Sign On) strategy ID for the user, if applicable.
    # @option params [String] require_2fa 2FA required setting. `use_system_setting` uses the site-wide setting, including SSO exemptions. `always_require` and `never_require` override the site-wide setting when user-level overrides are allowed.
    # @option params [String] tags Comma-separated list of Tags for this user. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    # @option params [String] time_zone User time zone
    # @option params [String] user_root If filesystem layout is user_root, this path is the root path the user is fixed to for all interfaces. If the filesystem layout is site_root or partner_root, this acts as a root folder only for FTP and SFTP (SFTP applicability also requires a site-wide setting to be set). For partner_root layout, this path is relative to the Partner root folder for all callers and blank opts out of an additional protocol root. In this situation, this path is not applied to the API, Desktop, or Web interface.
    # @option params [String] user_home Home folder for FTP/SFTP. For users with the partner_root filesystem layout, this path is relative to the Partner root folder. In all other cases, it is an absolute path. Only applies to FTP and SFTP, and not any other interface.
    # @option params [Boolean] workspace_admin Whether the user is an administrator of their own Custom Workspace. Does not reflect administration granted through Permissions.
    # @option params [String] username User's username
    # @option params [Integer] workspace_id Workspace ID. Only Site Administrators can change this field. Values supplied by Workspace Administrators, Group Administrators, or other non-Site Administrators using `/user` are ignored.
    # @option params [Boolean] clear_2fa If true when changing authentication_method from `password` to `sso`, remove all two-factor methods. Ignored in all other cases.
    # @option params [Boolean] convert_to_partner_user Required when assigning a Partner to an existing non-Partner user. If true, convert the user by assigning the partner_id provided.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::User] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: avatar_delete must be a single value, not #{params[:avatar_delete].class}") if [ Array, Hash ].any? { |klass| params[:avatar_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: change_password must be an String") if !params[:change_password].nil? and !params[:change_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: change_password_confirmation must be an String") if !params[:change_password_confirmation].nil? and !params[:change_password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if !params[:email].nil? and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: grant_permission must be an String") if !params[:grant_permission].nil? and !params[:grant_permission].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if !params[:group_ids].nil? and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: imported_password_hash must be an String") if !params[:imported_password_hash].nil? and !params[:imported_password_hash].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_confirmation must be an String") if !params[:password_confirmation].nil? and !params[:password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: announcements_read must be a single value, not #{params[:announcements_read].class}") if [ Array, Hash ].any? { |klass| params[:announcements_read].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ai_assistant_personality_id must be an Integer") if !params[:ai_assistant_personality_id].nil? and !params[:ai_assistant_personality_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if !params[:allowed_ips].nil? and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: attachments_permission must be a single value, not #{params[:attachments_permission].class}") if [ Array, Hash ].any? { |klass| params[:attachments_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: authenticate_until must be an String") if !params[:authenticate_until].nil? and !params[:authenticate_until].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if !params[:authentication_method].nil? and !params[:authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: billing_permission must be a single value, not #{params[:billing_permission].class}") if [ Array, Hash ].any? { |klass| params[:billing_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bypass_user_lifecycle_rules must be a single value, not #{params[:bypass_user_lifecycle_rules].class}") if [ Array, Hash ].any? { |klass| params[:bypass_user_lifecycle_rules].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bypass_site_allowed_ips must be a single value, not #{params[:bypass_site_allowed_ips].class}") if [ Array, Hash ].any? { |klass| params[:bypass_site_allowed_ips].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: dav_permission must be a single value, not #{params[:dav_permission].class}") if [ Array, Hash ].any? { |klass| params[:dav_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: desktop_configuration_profile_id must be an Integer") if !params[:desktop_configuration_profile_id].nil? and !params[:desktop_configuration_profile_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: default_workspace_id must be an Integer") if !params[:default_workspace_id].nil? and !params[:default_workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: disabled must be a single value, not #{params[:disabled].class}") if [ Array, Hash ].any? { |klass| params[:disabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: filesystem_layout must be an String") if !params[:filesystem_layout].nil? and !params[:filesystem_layout].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ftp_permission must be a single value, not #{params[:ftp_permission].class}") if [ Array, Hash ].any? { |klass| params[:ftp_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: header_text must be an String") if !params[:header_text].nil? and !params[:header_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: integration_centric_profile_id must be an Integer") if !params[:integration_centric_profile_id].nil? and !params[:integration_centric_profile_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if !params[:language].nil? and !params[:language].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notification_daily_send_time must be an Integer") if !params[:notification_daily_send_time].nil? and !params[:notification_daily_send_time].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company must be an String") if !params[:company].nil? and !params[:company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if !params[:notes].nil? and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: office_integration_enabled must be a single value, not #{params[:office_integration_enabled].class}") if [ Array, Hash ].any? { |klass| params[:office_integration_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: partner_admin must be a single value, not #{params[:partner_admin].class}") if [ Array, Hash ].any? { |klass| params[:partner_admin].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if !params[:partner_id].nil? and !params[:partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password_validity_days must be an Integer") if !params[:password_validity_days].nil? and !params[:password_validity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: primary_group_id must be an Integer") if !params[:primary_group_id].nil? and !params[:primary_group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: readonly_site_admin must be a single value, not #{params[:readonly_site_admin].class}") if [ Array, Hash ].any? { |klass| params[:readonly_site_admin].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: receive_admin_alerts must be a single value, not #{params[:receive_admin_alerts].class}") if [ Array, Hash ].any? { |klass| params[:receive_admin_alerts].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_site_warnings must be a single value, not #{params[:notify_on_all_site_warnings].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_site_warnings].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_sso_failures must be a single value, not #{params[:notify_on_all_sso_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_sso_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_user_security_events must be a single value, not #{params[:notify_on_all_user_security_events].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_user_security_events].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_pending_work_failures must be a single value, not #{params[:notify_on_all_pending_work_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_pending_work_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_siem_http_destination_failures must be a single value, not #{params[:notify_on_all_siem_http_destination_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_siem_http_destination_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_sync_failures must be a single value, not #{params[:notify_on_all_sync_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_sync_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_automation_failures must be a single value, not #{params[:notify_on_all_automation_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_automation_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_all_expectation_failures must be a single value, not #{params[:notify_on_all_expectation_failures].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_all_expectation_failures].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: require_login_by must be an String") if !params[:require_login_by].nil? and !params[:require_login_by].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: require_password_change must be a single value, not #{params[:require_password_change].class}") if [ Array, Hash ].any? { |klass| params[:require_password_change].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: responsible_group_id must be an Integer") if !params[:responsible_group_id].nil? and !params[:responsible_group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: responsible_user_id must be an Integer") if !params[:responsible_user_id].nil? and !params[:responsible_user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: restapi_permission must be a single value, not #{params[:restapi_permission].class}") if [ Array, Hash ].any? { |klass| params[:restapi_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint_permission must be a single value, not #{params[:s3_compatible_endpoint_permission].class}") if [ Array, Hash ].any? { |klass| params[:s3_compatible_endpoint_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: self_managed must be a single value, not #{params[:self_managed].class}") if [ Array, Hash ].any? { |klass| params[:self_managed].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_permission must be a single value, not #{params[:sftp_permission].class}") if [ Array, Hash ].any? { |klass| params[:sftp_permission].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: site_admin must be a single value, not #{params[:site_admin].class}") if [ Array, Hash ].any? { |klass| params[:site_admin].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_welcome_screen must be a single value, not #{params[:skip_welcome_screen].class}") if [ Array, Hash ].any? { |klass| params[:skip_welcome_screen].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ssl_required must be an String") if !params[:ssl_required].nil? and !params[:ssl_required].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sso_strategy_id must be an Integer") if !params[:sso_strategy_id].nil? and !params[:sso_strategy_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: require_2fa must be an String") if !params[:require_2fa].nil? and !params[:require_2fa].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: tags must be an String") if !params[:tags].nil? and !params[:tags].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: time_zone must be an String") if !params[:time_zone].nil? and !params[:time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_root must be an String") if !params[:user_root].nil? and !params[:user_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_home must be an String") if !params[:user_home].nil? and !params[:user_home].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_admin must be a single value, not #{params[:workspace_admin].class}") if [ Array, Hash ].any? { |klass| params[:workspace_admin].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: username must be an String") if !params[:username].nil? and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: clear_2fa must be a single value, not #{params[:clear_2fa].class}") if [ Array, Hash ].any? { |klass| params[:clear_2fa].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: convert_to_partner_user must be a single value, not #{params[:convert_to_partner_user].class}") if [ Array, Hash ].any? { |klass| params[:convert_to_partner_user].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/users/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("User") }
      User.new(response.data, options)
    end

    # Delete User
    #
    # @param id [Integer] User ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] new_owner_id Provide a User ID here to transfer ownership of certain resources such as Automations and Share Links (Bundles) to that new user.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: new_owner_id must be an Integer") if !params[:new_owner_id].nil? and !params[:new_owner_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/users/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
