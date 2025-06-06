# frozen_string_literal: true

module Files
  class User
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - User ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - User's username
    def username
      @attributes[:username]
    end

    def username=(value)
      @attributes[:username] = value
    end

    # array(int64) - List of group IDs of which this user is an administrator
    def admin_group_ids
      @attributes[:admin_group_ids]
    end

    def admin_group_ids=(value)
      @attributes[:admin_group_ids] = value
    end

    # string - A list of allowed IPs if applicable.  Newline delimited
    def allowed_ips
      @attributes[:allowed_ips]
    end

    def allowed_ips=(value)
      @attributes[:allowed_ips] = value
    end

    # boolean - If `true`, the user can user create Bundles (aka Share Links). Use the bundle permission instead.
    def attachments_permission
      @attributes[:attachments_permission]
    end

    def attachments_permission=(value)
      @attributes[:attachments_permission] = value
    end

    # int64 - Number of API keys associated with this user
    def api_keys_count
      @attributes[:api_keys_count]
    end

    def api_keys_count=(value)
      @attributes[:api_keys_count] = value
    end

    # date-time - Scheduled Date/Time at which user will be deactivated
    def authenticate_until
      @attributes[:authenticate_until]
    end

    def authenticate_until=(value)
      @attributes[:authenticate_until] = value
    end

    # string - How is this user authenticated?
    def authentication_method
      @attributes[:authentication_method]
    end

    def authentication_method=(value)
      @attributes[:authentication_method] = value
    end

    # string - URL holding the user's avatar
    def avatar_url
      @attributes[:avatar_url]
    end

    def avatar_url=(value)
      @attributes[:avatar_url] = value
    end

    # boolean - Is this a billable user record?
    def billable
      @attributes[:billable]
    end

    def billable=(value)
      @attributes[:billable] = value
    end

    # boolean - Allow this user to perform operations on the account, payments, and invoices?
    def billing_permission
      @attributes[:billing_permission]
    end

    def billing_permission=(value)
      @attributes[:billing_permission] = value
    end

    # boolean - Allow this user to skip site-wide IP blacklists?
    def bypass_site_allowed_ips
      @attributes[:bypass_site_allowed_ips]
    end

    def bypass_site_allowed_ips=(value)
      @attributes[:bypass_site_allowed_ips] = value
    end

    # boolean - Exempt this user from user lifecycle rules?
    def bypass_user_lifecycle_rules
      @attributes[:bypass_user_lifecycle_rules]
    end

    def bypass_user_lifecycle_rules=(value)
      @attributes[:bypass_user_lifecycle_rules] = value
    end

    # date-time - When this user was created
    def created_at
      @attributes[:created_at]
    end

    # boolean - Can the user connect with WebDAV?
    def dav_permission
      @attributes[:dav_permission]
    end

    def dav_permission=(value)
      @attributes[:dav_permission] = value
    end

    # boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes. Users can be automatically disabled after an inactivity period via a Site setting or schedule to be deactivated after specific date.
    def disabled
      @attributes[:disabled]
    end

    def disabled=(value)
      @attributes[:disabled] = value
    end

    # boolean - Computed property that returns true if user disabled or expired or inactive.
    def disabled_expired_or_inactive
      @attributes[:disabled_expired_or_inactive]
    end

    def disabled_expired_or_inactive=(value)
      @attributes[:disabled_expired_or_inactive] = value
    end

    # email - User email address
    def email
      @attributes[:email]
    end

    def email=(value)
      @attributes[:email] = value
    end

    # date-time - User's first login time
    def first_login_at
      @attributes[:first_login_at]
    end

    def first_login_at=(value)
      @attributes[:first_login_at] = value
    end

    # boolean - Can the user access with FTP/FTPS?
    def ftp_permission
      @attributes[:ftp_permission]
    end

    def ftp_permission=(value)
      @attributes[:ftp_permission] = value
    end

    # string - Comma-separated list of group IDs of which this user is a member
    def group_ids
      @attributes[:group_ids]
    end

    def group_ids=(value)
      @attributes[:group_ids] = value
    end

    # string - Text to display to the user in the header of the UI
    def header_text
      @attributes[:header_text]
    end

    def header_text=(value)
      @attributes[:header_text] = value
    end

    # string - Preferred language
    def language
      @attributes[:language]
    end

    def language=(value)
      @attributes[:language] = value
    end

    # date-time - User's most recent login time via any protocol
    def last_login_at
      @attributes[:last_login_at]
    end

    def last_login_at=(value)
      @attributes[:last_login_at] = value
    end

    # date-time - User's most recent login time via web
    def last_web_login_at
      @attributes[:last_web_login_at]
    end

    def last_web_login_at=(value)
      @attributes[:last_web_login_at] = value
    end

    # date-time - User's most recent login time via FTP
    def last_ftp_login_at
      @attributes[:last_ftp_login_at]
    end

    def last_ftp_login_at=(value)
      @attributes[:last_ftp_login_at] = value
    end

    # date-time - User's most recent login time via SFTP
    def last_sftp_login_at
      @attributes[:last_sftp_login_at]
    end

    def last_sftp_login_at=(value)
      @attributes[:last_sftp_login_at] = value
    end

    # date-time - User's most recent login time via WebDAV
    def last_dav_login_at
      @attributes[:last_dav_login_at]
    end

    def last_dav_login_at=(value)
      @attributes[:last_dav_login_at] = value
    end

    # date-time - User's most recent login time via Desktop app
    def last_desktop_login_at
      @attributes[:last_desktop_login_at]
    end

    def last_desktop_login_at=(value)
      @attributes[:last_desktop_login_at] = value
    end

    # date-time - User's most recent login time via Rest API
    def last_restapi_login_at
      @attributes[:last_restapi_login_at]
    end

    def last_restapi_login_at=(value)
      @attributes[:last_restapi_login_at] = value
    end

    # date-time - User's most recent API use time
    def last_api_use_at
      @attributes[:last_api_use_at]
    end

    def last_api_use_at=(value)
      @attributes[:last_api_use_at] = value
    end

    # date-time - User's most recent activity time, which is the latest of most recent login, most recent API use, enablement, or creation
    def last_active_at
      @attributes[:last_active_at]
    end

    def last_active_at=(value)
      @attributes[:last_active_at] = value
    end

    # string - The most recent protocol and cipher used
    def last_protocol_cipher
      @attributes[:last_protocol_cipher]
    end

    def last_protocol_cipher=(value)
      @attributes[:last_protocol_cipher] = value
    end

    # date-time - Time in the future that the user will no longer be locked out if applicable
    def lockout_expires
      @attributes[:lockout_expires]
    end

    def lockout_expires=(value)
      @attributes[:lockout_expires] = value
    end

    # string - User's full name
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - User's company
    def company
      @attributes[:company]
    end

    def company=(value)
      @attributes[:company] = value
    end

    # string - Any internal notes on the user
    def notes
      @attributes[:notes]
    end

    def notes=(value)
      @attributes[:notes] = value
    end

    # int64 - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
    def notification_daily_send_time
      @attributes[:notification_daily_send_time]
    end

    def notification_daily_send_time=(value)
      @attributes[:notification_daily_send_time] = value
    end

    # boolean - Enable integration with Office for the web?
    def office_integration_enabled
      @attributes[:office_integration_enabled]
    end

    def office_integration_enabled=(value)
      @attributes[:office_integration_enabled] = value
    end

    # date-time - Last time the user's password was set
    def password_set_at
      @attributes[:password_set_at]
    end

    def password_set_at=(value)
      @attributes[:password_set_at] = value
    end

    # int64 - Number of days to allow user to use the same password
    def password_validity_days
      @attributes[:password_validity_days]
    end

    def password_validity_days=(value)
      @attributes[:password_validity_days] = value
    end

    # int64 - Number of public keys associated with this user
    def public_keys_count
      @attributes[:public_keys_count]
    end

    def public_keys_count=(value)
      @attributes[:public_keys_count] = value
    end

    # boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
    def receive_admin_alerts
      @attributes[:receive_admin_alerts]
    end

    def receive_admin_alerts=(value)
      @attributes[:receive_admin_alerts] = value
    end

    # string - 2FA required setting
    def require_2fa
      @attributes[:require_2fa]
    end

    def require_2fa=(value)
      @attributes[:require_2fa] = value
    end

    # date-time - Require user to login by specified date otherwise it will be disabled.
    def require_login_by
      @attributes[:require_login_by]
    end

    def require_login_by=(value)
      @attributes[:require_login_by] = value
    end

    # boolean - Is 2fa active for the user?
    def active_2fa
      @attributes[:active_2fa]
    end

    def active_2fa=(value)
      @attributes[:active_2fa] = value
    end

    # boolean - Is a password change required upon next user login?
    def require_password_change
      @attributes[:require_password_change]
    end

    def require_password_change=(value)
      @attributes[:require_password_change] = value
    end

    # boolean - Is user's password expired?
    def password_expired
      @attributes[:password_expired]
    end

    def password_expired=(value)
      @attributes[:password_expired] = value
    end

    # boolean - Is the user an allowed to view all (non-billing) site configuration for this site?
    def readonly_site_admin
      @attributes[:readonly_site_admin]
    end

    def readonly_site_admin=(value)
      @attributes[:readonly_site_admin] = value
    end

    # boolean - Can this user access the Web app, Desktop app, SDKs, or REST API?  (All of these tools use the API internally, so this is one unified permission set.)
    def restapi_permission
      @attributes[:restapi_permission]
    end

    def restapi_permission=(value)
      @attributes[:restapi_permission] = value
    end

    # boolean - Does this user manage it's own credentials or is it a shared/bot user?
    def self_managed
      @attributes[:self_managed]
    end

    def self_managed=(value)
      @attributes[:self_managed] = value
    end

    # boolean - Can the user access with SFTP?
    def sftp_permission
      @attributes[:sftp_permission]
    end

    def sftp_permission=(value)
      @attributes[:sftp_permission] = value
    end

    # boolean - Is the user an administrator for this site?
    def site_admin
      @attributes[:site_admin]
    end

    def site_admin=(value)
      @attributes[:site_admin] = value
    end

    # int64 - Site ID
    def site_id
      @attributes[:site_id]
    end

    def site_id=(value)
      @attributes[:site_id] = value
    end

    # boolean - Skip Welcome page in the UI?
    def skip_welcome_screen
      @attributes[:skip_welcome_screen]
    end

    def skip_welcome_screen=(value)
      @attributes[:skip_welcome_screen] = value
    end

    # string - SSL required setting
    def ssl_required
      @attributes[:ssl_required]
    end

    def ssl_required=(value)
      @attributes[:ssl_required] = value
    end

    # int64 - SSO (Single Sign On) strategy ID for the user, if applicable.
    def sso_strategy_id
      @attributes[:sso_strategy_id]
    end

    def sso_strategy_id=(value)
      @attributes[:sso_strategy_id] = value
    end

    # boolean - Is the user subscribed to the newsletter?
    def subscribe_to_newsletter
      @attributes[:subscribe_to_newsletter]
    end

    def subscribe_to_newsletter=(value)
      @attributes[:subscribe_to_newsletter] = value
    end

    # boolean - Is this user managed by a SsoStrategy?
    def externally_managed
      @attributes[:externally_managed]
    end

    def externally_managed=(value)
      @attributes[:externally_managed] = value
    end

    # string - User time zone
    def time_zone
      @attributes[:time_zone]
    end

    def time_zone=(value)
      @attributes[:time_zone] = value
    end

    # string - Type(s) of 2FA methods in use, for programmatic use.  Will be either `sms`, `totp`, `webauthn`, `yubi`, `email`, or multiple values sorted alphabetically and joined by an underscore.  Does not specify whether user has more than one of a given method.
    def type_of_2fa
      @attributes[:type_of_2fa]
    end

    def type_of_2fa=(value)
      @attributes[:type_of_2fa] = value
    end

    # string - Type(s) of 2FA methods in use, formatted for displaying in the UI.  Unlike `type_of_2fa`, this value will make clear when a user has more than 1 of the same type of method.
    def type_of_2fa_for_display
      @attributes[:type_of_2fa_for_display]
    end

    def type_of_2fa_for_display=(value)
      @attributes[:type_of_2fa_for_display] = value
    end

    # string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set).  Note that this is not used for API, Desktop, or Web interface.
    def user_root
      @attributes[:user_root]
    end

    def user_root=(value)
      @attributes[:user_root] = value
    end

    # string - Home folder for FTP/SFTP.  Note that this is not used for API, Desktop, or Web interface.
    def user_home
      @attributes[:user_home]
    end

    def user_home=(value)
      @attributes[:user_home] = value
    end

    # int64 - Number of days remaining until password expires
    def days_remaining_until_password_expire
      @attributes[:days_remaining_until_password_expire]
    end

    def days_remaining_until_password_expire=(value)
      @attributes[:days_remaining_until_password_expire] = value
    end

    # date-time - Password expiration datetime
    def password_expire_at
      @attributes[:password_expire_at]
    end

    def password_expire_at=(value)
      @attributes[:password_expire_at] = value
    end

    # file - An image file for your user avatar.
    def avatar_file
      @attributes[:avatar_file]
    end

    def avatar_file=(value)
      @attributes[:avatar_file] = value
    end

    # boolean - If true, the avatar will be deleted.
    def avatar_delete
      @attributes[:avatar_delete]
    end

    def avatar_delete=(value)
      @attributes[:avatar_delete] = value
    end

    # string - Used for changing a password on an existing user.
    def change_password
      @attributes[:change_password]
    end

    def change_password=(value)
      @attributes[:change_password] = value
    end

    # string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
    def change_password_confirmation
      @attributes[:change_password_confirmation]
    end

    def change_password_confirmation=(value)
      @attributes[:change_password_confirmation] = value
    end

    # string - Permission to grant on the User Root upon user creation. Can be blank or `full`, `read`, `write`, `list`, `read+write`, or `list+write`
    def grant_permission
      @attributes[:grant_permission]
    end

    def grant_permission=(value)
      @attributes[:grant_permission] = value
    end

    # int64 - Group ID to associate this user with.
    def group_id
      @attributes[:group_id]
    end

    def group_id=(value)
      @attributes[:group_id] = value
    end

    # string - Pre-calculated hash of the user's password. If supplied, this will be used to authenticate the user on first login. Supported hash methods are MD5, SHA1, and SHA256.
    def imported_password_hash
      @attributes[:imported_password_hash]
    end

    def imported_password_hash=(value)
      @attributes[:imported_password_hash] = value
    end

    # string - User password.
    def password
      @attributes[:password]
    end

    def password=(value)
      @attributes[:password] = value
    end

    # string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
    def password_confirmation
      @attributes[:password_confirmation]
    end

    def password_confirmation=(value)
      @attributes[:password_confirmation] = value
    end

    # boolean - Signifies that the user has read all the announcements in the UI.
    def announcements_read
      @attributes[:announcements_read]
    end

    def announcements_read=(value)
      @attributes[:announcements_read] = value
    end

    # Unlock user who has been locked out due to failed logins
    def unlock(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/users/#{@attributes[:id]}/unlock", :post, params, @options)
    end

    # Resend user welcome email
    def resend_welcome_email(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/users/#{@attributes[:id]}/resend_welcome_email", :post, params, @options)
    end

    # Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
    def user_2fa_reset(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/users/#{@attributes[:id]}/2fa/reset", :post, params, @options)
    end

    # Parameters:
    #   avatar_file - file - An image file for your user avatar.
    #   avatar_delete - boolean - If true, the avatar will be deleted.
    #   change_password - string - Used for changing a password on an existing user.
    #   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
    #   email - string - User's email.
    #   grant_permission - string - Permission to grant on the User Root upon user creation. Can be blank or `full`, `read`, `write`, `list`, `read+write`, or `list+write`
    #   group_id - int64 - Group ID to associate this user with.
    #   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
    #   imported_password_hash - string - Pre-calculated hash of the user's password. If supplied, this will be used to authenticate the user on first login. Supported hash methods are MD5, SHA1, and SHA256.
    #   password - string - User password.
    #   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
    #   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
    #   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
    #   attachments_permission - boolean - DEPRECATED: If `true`, the user can user create Bundles (aka Share Links). Use the bundle permission instead.
    #   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
    #   authentication_method - string - How is this user authenticated?
    #   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
    #   bypass_user_lifecycle_rules - boolean - Exempt this user from user lifecycle rules?
    #   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
    #   dav_permission - boolean - Can the user connect with WebDAV?
    #   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes. Users can be automatically disabled after an inactivity period via a Site setting or schedule to be deactivated after specific date.
    #   ftp_permission - boolean - Can the user access with FTP/FTPS?
    #   header_text - string - Text to display to the user in the header of the UI
    #   language - string - Preferred language
    #   notification_daily_send_time - int64 - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
    #   name - string - User's full name
    #   company - string - User's company
    #   notes - string - Any internal notes on the user
    #   office_integration_enabled - boolean - Enable integration with Office for the web?
    #   password_validity_days - int64 - Number of days to allow user to use the same password
    #   readonly_site_admin - boolean - Is the user an allowed to view all (non-billing) site configuration for this site?
    #   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
    #   require_login_by - string - Require user to login by specified date otherwise it will be disabled.
    #   require_password_change - boolean - Is a password change required upon next user login?
    #   restapi_permission - boolean - Can this user access the Web app, Desktop app, SDKs, or REST API?  (All of these tools use the API internally, so this is one unified permission set.)
    #   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
    #   sftp_permission - boolean - Can the user access with SFTP?
    #   site_admin - boolean - Is the user an administrator for this site?
    #   skip_welcome_screen - boolean - Skip Welcome page in the UI?
    #   ssl_required - string - SSL required setting
    #   sso_strategy_id - int64 - SSO (Single Sign On) strategy ID for the user, if applicable.
    #   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
    #   require_2fa - string - 2FA required setting
    #   time_zone - string - User time zone
    #   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set).  Note that this is not used for API, Desktop, or Web interface.
    #   user_home - string - Home folder for FTP/SFTP.  Note that this is not used for API, Desktop, or Web interface.
    #   username - string - User's username
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: change_password must be an String") if params[:change_password] and !params[:change_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: change_password_confirmation must be an String") if params[:change_password_confirmation] and !params[:change_password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: grant_permission must be an String") if params[:grant_permission] and !params[:grant_permission].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params[:group_id] and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params[:group_ids] and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: imported_password_hash must be an String") if params[:imported_password_hash] and !params[:imported_password_hash].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_confirmation must be an String") if params[:password_confirmation] and !params[:password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if params[:allowed_ips] and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authenticate_until must be an String") if params[:authenticate_until] and !params[:authenticate_until].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if params[:authentication_method] and !params[:authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: header_text must be an String") if params[:header_text] and !params[:header_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if params[:language] and !params[:language].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notification_daily_send_time must be an Integer") if params[:notification_daily_send_time] and !params[:notification_daily_send_time].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company must be an String") if params[:company] and !params[:company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params[:notes] and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_validity_days must be an Integer") if params[:password_validity_days] and !params[:password_validity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: require_login_by must be an String") if params[:require_login_by] and !params[:require_login_by].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl_required must be an String") if params[:ssl_required] and !params[:ssl_required].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sso_strategy_id must be an Integer") if params[:sso_strategy_id] and !params[:sso_strategy_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: require_2fa must be an String") if params[:require_2fa] and !params[:require_2fa].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: time_zone must be an String") if params[:time_zone] and !params[:time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_root must be an String") if params[:user_root] and !params[:user_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_home must be an String") if params[:user_home] and !params[:user_home].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/users/#{@attributes[:id]}", :patch, params, @options)
    end

    # Parameters:
    #   new_owner_id - int64 - Provide a User ID here to transfer ownership of certain resources such as Automations and Share Links (Bundles) to that new user.
    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: new_owner_id must be an Integer") if params[:new_owner_id] and !params[:new_owner_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/users/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = User.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `site_id`, `authenticate_until`, `email`, `last_desktop_login_at`, `last_login_at`, `name`, `company`, `password_validity_days`, `ssl_required`, `username` or `site_admin`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `username`, `name`, `email`, `company`, `site_admin`, `password_validity_days`, `ssl_required`, `last_login_at`, `authenticate_until` or `not_site_admin`. Valid field combinations are `[ site_admin, username ]`, `[ not_site_admin, username ]` or `[ company, name ]`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `password_validity_days`, `last_login_at` or `authenticate_until`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `password_validity_days`, `last_login_at` or `authenticate_until`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `username`, `name`, `email` or `company`. Valid field combinations are `[ company, name ]`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `password_validity_days`, `last_login_at` or `authenticate_until`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `password_validity_days`, `last_login_at` or `authenticate_until`.
    #   ids - string - comma-separated list of User IDs
    #   include_parent_site_users - boolean - Include users from the parent site.
    #   search - string - Searches for partial matches of name, username, or email.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: ids must be an String") if params[:ids] and !params[:ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: search must be an String") if params[:search] and !params[:search].is_a?(String)

      List.new(User, params) do
        Api.send_request("/users", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - User ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/users/#{params[:id]}", :get, params, options)
      User.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   avatar_file - file - An image file for your user avatar.
    #   avatar_delete - boolean - If true, the avatar will be deleted.
    #   change_password - string - Used for changing a password on an existing user.
    #   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
    #   email - string - User's email.
    #   grant_permission - string - Permission to grant on the User Root upon user creation. Can be blank or `full`, `read`, `write`, `list`, `read+write`, or `list+write`
    #   group_id - int64 - Group ID to associate this user with.
    #   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
    #   imported_password_hash - string - Pre-calculated hash of the user's password. If supplied, this will be used to authenticate the user on first login. Supported hash methods are MD5, SHA1, and SHA256.
    #   password - string - User password.
    #   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
    #   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
    #   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
    #   attachments_permission - boolean - DEPRECATED: If `true`, the user can user create Bundles (aka Share Links). Use the bundle permission instead.
    #   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
    #   authentication_method - string - How is this user authenticated?
    #   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
    #   bypass_user_lifecycle_rules - boolean - Exempt this user from user lifecycle rules?
    #   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
    #   dav_permission - boolean - Can the user connect with WebDAV?
    #   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes. Users can be automatically disabled after an inactivity period via a Site setting or schedule to be deactivated after specific date.
    #   ftp_permission - boolean - Can the user access with FTP/FTPS?
    #   header_text - string - Text to display to the user in the header of the UI
    #   language - string - Preferred language
    #   notification_daily_send_time - int64 - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
    #   name - string - User's full name
    #   company - string - User's company
    #   notes - string - Any internal notes on the user
    #   office_integration_enabled - boolean - Enable integration with Office for the web?
    #   password_validity_days - int64 - Number of days to allow user to use the same password
    #   readonly_site_admin - boolean - Is the user an allowed to view all (non-billing) site configuration for this site?
    #   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
    #   require_login_by - string - Require user to login by specified date otherwise it will be disabled.
    #   require_password_change - boolean - Is a password change required upon next user login?
    #   restapi_permission - boolean - Can this user access the Web app, Desktop app, SDKs, or REST API?  (All of these tools use the API internally, so this is one unified permission set.)
    #   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
    #   sftp_permission - boolean - Can the user access with SFTP?
    #   site_admin - boolean - Is the user an administrator for this site?
    #   skip_welcome_screen - boolean - Skip Welcome page in the UI?
    #   ssl_required - string - SSL required setting
    #   sso_strategy_id - int64 - SSO (Single Sign On) strategy ID for the user, if applicable.
    #   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
    #   require_2fa - string - 2FA required setting
    #   time_zone - string - User time zone
    #   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set).  Note that this is not used for API, Desktop, or Web interface.
    #   user_home - string - Home folder for FTP/SFTP.  Note that this is not used for API, Desktop, or Web interface.
    #   username (required) - string - User's username
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: change_password must be an String") if params[:change_password] and !params[:change_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: change_password_confirmation must be an String") if params[:change_password_confirmation] and !params[:change_password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: grant_permission must be an String") if params[:grant_permission] and !params[:grant_permission].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params[:group_id] and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params[:group_ids] and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: imported_password_hash must be an String") if params[:imported_password_hash] and !params[:imported_password_hash].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_confirmation must be an String") if params[:password_confirmation] and !params[:password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if params[:allowed_ips] and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authenticate_until must be an String") if params[:authenticate_until] and !params[:authenticate_until].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if params[:authentication_method] and !params[:authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: header_text must be an String") if params[:header_text] and !params[:header_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if params[:language] and !params[:language].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notification_daily_send_time must be an Integer") if params[:notification_daily_send_time] and !params[:notification_daily_send_time].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company must be an String") if params[:company] and !params[:company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params[:notes] and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_validity_days must be an Integer") if params[:password_validity_days] and !params[:password_validity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: require_login_by must be an String") if params[:require_login_by] and !params[:require_login_by].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl_required must be an String") if params[:ssl_required] and !params[:ssl_required].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sso_strategy_id must be an Integer") if params[:sso_strategy_id] and !params[:sso_strategy_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: require_2fa must be an String") if params[:require_2fa] and !params[:require_2fa].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: time_zone must be an String") if params[:time_zone] and !params[:time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_root must be an String") if params[:user_root] and !params[:user_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_home must be an String") if params[:user_home] and !params[:user_home].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise MissingParameterError.new("Parameter missing: username") unless params[:username]

      response, options = Api.send_request("/users", :post, params, options)
      User.new(response.data, options)
    end

    # Unlock user who has been locked out due to failed logins
    def self.unlock(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/users/#{params[:id]}/unlock", :post, params, options)
      nil
    end

    # Resend user welcome email
    def self.resend_welcome_email(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/users/#{params[:id]}/resend_welcome_email", :post, params, options)
      nil
    end

    # Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
    def self.user_2fa_reset(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/users/#{params[:id]}/2fa/reset", :post, params, options)
      nil
    end

    # Parameters:
    #   avatar_file - file - An image file for your user avatar.
    #   avatar_delete - boolean - If true, the avatar will be deleted.
    #   change_password - string - Used for changing a password on an existing user.
    #   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
    #   email - string - User's email.
    #   grant_permission - string - Permission to grant on the User Root upon user creation. Can be blank or `full`, `read`, `write`, `list`, `read+write`, or `list+write`
    #   group_id - int64 - Group ID to associate this user with.
    #   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
    #   imported_password_hash - string - Pre-calculated hash of the user's password. If supplied, this will be used to authenticate the user on first login. Supported hash methods are MD5, SHA1, and SHA256.
    #   password - string - User password.
    #   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
    #   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
    #   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
    #   attachments_permission - boolean - DEPRECATED: If `true`, the user can user create Bundles (aka Share Links). Use the bundle permission instead.
    #   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
    #   authentication_method - string - How is this user authenticated?
    #   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
    #   bypass_user_lifecycle_rules - boolean - Exempt this user from user lifecycle rules?
    #   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
    #   dav_permission - boolean - Can the user connect with WebDAV?
    #   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes. Users can be automatically disabled after an inactivity period via a Site setting or schedule to be deactivated after specific date.
    #   ftp_permission - boolean - Can the user access with FTP/FTPS?
    #   header_text - string - Text to display to the user in the header of the UI
    #   language - string - Preferred language
    #   notification_daily_send_time - int64 - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
    #   name - string - User's full name
    #   company - string - User's company
    #   notes - string - Any internal notes on the user
    #   office_integration_enabled - boolean - Enable integration with Office for the web?
    #   password_validity_days - int64 - Number of days to allow user to use the same password
    #   readonly_site_admin - boolean - Is the user an allowed to view all (non-billing) site configuration for this site?
    #   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
    #   require_login_by - string - Require user to login by specified date otherwise it will be disabled.
    #   require_password_change - boolean - Is a password change required upon next user login?
    #   restapi_permission - boolean - Can this user access the Web app, Desktop app, SDKs, or REST API?  (All of these tools use the API internally, so this is one unified permission set.)
    #   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
    #   sftp_permission - boolean - Can the user access with SFTP?
    #   site_admin - boolean - Is the user an administrator for this site?
    #   skip_welcome_screen - boolean - Skip Welcome page in the UI?
    #   ssl_required - string - SSL required setting
    #   sso_strategy_id - int64 - SSO (Single Sign On) strategy ID for the user, if applicable.
    #   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
    #   require_2fa - string - 2FA required setting
    #   time_zone - string - User time zone
    #   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set).  Note that this is not used for API, Desktop, or Web interface.
    #   user_home - string - Home folder for FTP/SFTP.  Note that this is not used for API, Desktop, or Web interface.
    #   username - string - User's username
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: change_password must be an String") if params[:change_password] and !params[:change_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: change_password_confirmation must be an String") if params[:change_password_confirmation] and !params[:change_password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: grant_permission must be an String") if params[:grant_permission] and !params[:grant_permission].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params[:group_id] and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params[:group_ids] and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: imported_password_hash must be an String") if params[:imported_password_hash] and !params[:imported_password_hash].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_confirmation must be an String") if params[:password_confirmation] and !params[:password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if params[:allowed_ips] and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authenticate_until must be an String") if params[:authenticate_until] and !params[:authenticate_until].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if params[:authentication_method] and !params[:authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: header_text must be an String") if params[:header_text] and !params[:header_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if params[:language] and !params[:language].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notification_daily_send_time must be an Integer") if params[:notification_daily_send_time] and !params[:notification_daily_send_time].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company must be an String") if params[:company] and !params[:company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params[:notes] and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_validity_days must be an Integer") if params[:password_validity_days] and !params[:password_validity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: require_login_by must be an String") if params[:require_login_by] and !params[:require_login_by].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl_required must be an String") if params[:ssl_required] and !params[:ssl_required].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sso_strategy_id must be an Integer") if params[:sso_strategy_id] and !params[:sso_strategy_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: require_2fa must be an String") if params[:require_2fa] and !params[:require_2fa].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: time_zone must be an String") if params[:time_zone] and !params[:time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_root must be an String") if params[:user_root] and !params[:user_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_home must be an String") if params[:user_home] and !params[:user_home].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/users/#{params[:id]}", :patch, params, options)
      User.new(response.data, options)
    end

    # Parameters:
    #   new_owner_id - int64 - Provide a User ID here to transfer ownership of certain resources such as Automations and Share Links (Bundles) to that new user.
    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: new_owner_id must be an Integer") if params[:new_owner_id] and !params[:new_owner_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/users/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
