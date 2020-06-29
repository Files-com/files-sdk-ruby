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

    # array - List of group IDs of which this user is an administrator
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

    # boolean - Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
    def attachments_permission
      @attributes[:attachments_permission]
    end

    def attachments_permission=(value)
      @attributes[:attachments_permission] = value
    end

    # int64 - Number of api keys associated with this user
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

    # boolean - Exempt this user from being disabled based on inactivity?
    def bypass_inactive_disable
      @attributes[:bypass_inactive_disable]
    end

    def bypass_inactive_disable=(value)
      @attributes[:bypass_inactive_disable] = value
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

    # boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
    def disabled
      @attributes[:disabled]
    end

    def disabled=(value)
      @attributes[:disabled] = value
    end

    # email - User email address
    def email
      @attributes[:email]
    end

    def email=(value)
      @attributes[:email] = value
    end

    # boolean - Can the user access with FTP/FTPS?
    def ftp_permission
      @attributes[:ftp_permission]
    end

    def ftp_permission=(value)
      @attributes[:ftp_permission] = value
    end

    # array - Comma-separated list of group IDs of which this user is a member
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

    # date-time - User's last login time
    def last_login_at
      @attributes[:last_login_at]
    end

    def last_login_at=(value)
      @attributes[:last_login_at] = value
    end

    # string - The last protocol and cipher used
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

    # boolean - Is 2fa required to sign in?
    def require_2fa
      @attributes[:require_2fa]
    end

    def require_2fa=(value)
      @attributes[:require_2fa] = value
    end

    # boolean - Is a password change required upon next user login?
    def require_password_change
      @attributes[:require_password_change]
    end

    def require_password_change=(value)
      @attributes[:require_password_change] = value
    end

    # boolean - Can this user access the REST API?
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

    # string - Type(s) of 2FA methods in use.  Will be either `sms`, `totp`, `u2f`, `yubi`, or multiple values sorted alphabetically and joined by an underscore.
    def type_of_2fa
      @attributes[:type_of_2fa]
    end

    def type_of_2fa=(value)
      @attributes[:type_of_2fa] = value
    end

    # string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
    def user_root
      @attributes[:user_root]
    end

    def user_root=(value)
      @attributes[:user_root] = value
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

    # string - Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
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
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/users/#{@attributes[:id]}/unlock", :post, params, @options)
    end

    # Resend user welcome email
    def resend_welcome_email(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/users/#{@attributes[:id]}/resend_welcome_email", :post, params, @options)
    end

    # Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
    def user_2fa_reset(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/users/#{@attributes[:id]}/2fa/reset", :post, params, @options)
    end

    # Parameters:
    #   avatar_file - file - An image file for your user avatar.
    #   avatar_delete - boolean - If true, the avatar will be deleted.
    #   change_password - string - Used for changing a password on an existing user.
    #   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
    #   email - string - User's email.
    #   grant_permission - string - Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
    #   group_id - int64 - Group ID to associate this user with.
    #   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
    #   password - string - User password.
    #   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
    #   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
    #   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
    #   attachments_permission - boolean - Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
    #   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
    #   authentication_method - string - How is this user authenticated?
    #   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
    #   bypass_inactive_disable - boolean - Exempt this user from being disabled based on inactivity?
    #   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
    #   dav_permission - boolean - Can the user connect with WebDAV?
    #   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
    #   ftp_permission - boolean - Can the user access with FTP/FTPS?
    #   header_text - string - Text to display to the user in the header of the UI
    #   language - string - Preferred language
    #   notification_daily_send_time - int64 - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
    #   name - string - User's full name
    #   notes - string - Any internal notes on the user
    #   password_validity_days - int64 - Number of days to allow user to use the same password
    #   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
    #   require_password_change - boolean - Is a password change required upon next user login?
    #   restapi_permission - boolean - Can this user access the REST API?
    #   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
    #   sftp_permission - boolean - Can the user access with SFTP?
    #   site_admin - boolean - Is the user an administrator for this site?
    #   skip_welcome_screen - boolean - Skip Welcome page in the UI?
    #   ssl_required - string - SSL required setting
    #   sso_strategy_id - int64 - SSO (Single Sign On) strategy ID for the user, if applicable.
    #   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
    #   time_zone - string - User time zone
    #   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
    #   username - string - User's username
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: change_password must be an String") if params.dig(:change_password) and !params.dig(:change_password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: change_password_confirmation must be an String") if params.dig(:change_password_confirmation) and !params.dig(:change_password_confirmation).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params.dig(:email) and !params.dig(:email).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: grant_permission must be an String") if params.dig(:grant_permission) and !params.dig(:grant_permission).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params.dig(:group_id) and !params.dig(:group_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params.dig(:group_ids) and !params.dig(:group_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params.dig(:password) and !params.dig(:password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_confirmation must be an String") if params.dig(:password_confirmation) and !params.dig(:password_confirmation).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if params.dig(:allowed_ips) and !params.dig(:allowed_ips).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authenticate_until must be an String") if params.dig(:authenticate_until) and !params.dig(:authenticate_until).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if params.dig(:authentication_method) and !params.dig(:authentication_method).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: header_text must be an String") if params.dig(:header_text) and !params.dig(:header_text).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if params.dig(:language) and !params.dig(:language).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notification_daily_send_time must be an Integer") if params.dig(:notification_daily_send_time) and !params.dig(:notification_daily_send_time).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params.dig(:notes) and !params.dig(:notes).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_validity_days must be an Integer") if params.dig(:password_validity_days) and !params.dig(:password_validity_days).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ssl_required must be an String") if params.dig(:ssl_required) and !params.dig(:ssl_required).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sso_strategy_id must be an Integer") if params.dig(:sso_strategy_id) and !params.dig(:sso_strategy_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: time_zone must be an String") if params.dig(:time_zone) and !params.dig(:time_zone).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_root must be an String") if params.dig(:user_root) and !params.dig(:user_root).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params.dig(:username) and !params.dig(:username).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/users/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/users/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = User.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   page - int64 - Current page number.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   q[username] - string - List users matching username.
    #   q[email] - string - List users matching email.
    #   q[notes] - string - List users matching notes field.
    #   q[admin] - string - If `true`, list only admin users.
    #   q[allowed_ips] - string - If set, list only users with overridden allowed IP setting.
    #   q[password_validity_days] - string - If set, list only users with overridden password validity days setting.
    #   q[ssl_required] - string - If set, list only users with overridden SSL required setting.
    #   search - string - Searches for partial matches of name, username, or email.
    #   sort_by[last_login_at] - string - If set, sort users by 'last_login_at' in either 'asc' or 'desc' direction
    #   sort_by[authenticate_until] - string - If set, sort users by 'authenticate_until' in either 'asc' or 'desc' direction
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: search must be an String") if params.dig(:search) and !params.dig(:search).is_a?(String)

      response, options = Api.send_request("/users", :get, params, options)
      response.data.map do |entity_data|
        User.new(entity_data, options)
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
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

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
    #   grant_permission - string - Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
    #   group_id - int64 - Group ID to associate this user with.
    #   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
    #   password - string - User password.
    #   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
    #   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
    #   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
    #   attachments_permission - boolean - Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
    #   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
    #   authentication_method - string - How is this user authenticated?
    #   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
    #   bypass_inactive_disable - boolean - Exempt this user from being disabled based on inactivity?
    #   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
    #   dav_permission - boolean - Can the user connect with WebDAV?
    #   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
    #   ftp_permission - boolean - Can the user access with FTP/FTPS?
    #   header_text - string - Text to display to the user in the header of the UI
    #   language - string - Preferred language
    #   notification_daily_send_time - int64 - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
    #   name - string - User's full name
    #   notes - string - Any internal notes on the user
    #   password_validity_days - int64 - Number of days to allow user to use the same password
    #   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
    #   require_password_change - boolean - Is a password change required upon next user login?
    #   restapi_permission - boolean - Can this user access the REST API?
    #   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
    #   sftp_permission - boolean - Can the user access with SFTP?
    #   site_admin - boolean - Is the user an administrator for this site?
    #   skip_welcome_screen - boolean - Skip Welcome page in the UI?
    #   ssl_required - string - SSL required setting
    #   sso_strategy_id - int64 - SSO (Single Sign On) strategy ID for the user, if applicable.
    #   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
    #   time_zone - string - User time zone
    #   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
    #   username - string - User's username
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: change_password must be an String") if params.dig(:change_password) and !params.dig(:change_password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: change_password_confirmation must be an String") if params.dig(:change_password_confirmation) and !params.dig(:change_password_confirmation).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params.dig(:email) and !params.dig(:email).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: grant_permission must be an String") if params.dig(:grant_permission) and !params.dig(:grant_permission).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params.dig(:group_id) and !params.dig(:group_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params.dig(:group_ids) and !params.dig(:group_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params.dig(:password) and !params.dig(:password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_confirmation must be an String") if params.dig(:password_confirmation) and !params.dig(:password_confirmation).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if params.dig(:allowed_ips) and !params.dig(:allowed_ips).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authenticate_until must be an String") if params.dig(:authenticate_until) and !params.dig(:authenticate_until).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if params.dig(:authentication_method) and !params.dig(:authentication_method).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: header_text must be an String") if params.dig(:header_text) and !params.dig(:header_text).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if params.dig(:language) and !params.dig(:language).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notification_daily_send_time must be an Integer") if params.dig(:notification_daily_send_time) and !params.dig(:notification_daily_send_time).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params.dig(:notes) and !params.dig(:notes).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_validity_days must be an Integer") if params.dig(:password_validity_days) and !params.dig(:password_validity_days).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ssl_required must be an String") if params.dig(:ssl_required) and !params.dig(:ssl_required).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sso_strategy_id must be an Integer") if params.dig(:sso_strategy_id) and !params.dig(:sso_strategy_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: time_zone must be an String") if params.dig(:time_zone) and !params.dig(:time_zone).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_root must be an String") if params.dig(:user_root) and !params.dig(:user_root).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params.dig(:username) and !params.dig(:username).is_a?(String)

      response, options = Api.send_request("/users", :post, params, options)
      User.new(response.data, options)
    end

    # Unlock user who has been locked out due to failed logins
    def self.unlock(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/users/#{params[:id]}/unlock", :post, params, options)
      response.data
    end

    # Resend user welcome email
    def self.resend_welcome_email(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/users/#{params[:id]}/resend_welcome_email", :post, params, options)
      response.data
    end

    # Trigger 2FA Reset process for user who has lost access to their existing 2FA methods
    def self.user_2fa_reset(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/users/#{params[:id]}/2fa/reset", :post, params, options)
      response.data
    end

    # Parameters:
    #   avatar_file - file - An image file for your user avatar.
    #   avatar_delete - boolean - If true, the avatar will be deleted.
    #   change_password - string - Used for changing a password on an existing user.
    #   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
    #   email - string - User's email.
    #   grant_permission - string - Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
    #   group_id - int64 - Group ID to associate this user with.
    #   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
    #   password - string - User password.
    #   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
    #   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
    #   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
    #   attachments_permission - boolean - Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
    #   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
    #   authentication_method - string - How is this user authenticated?
    #   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
    #   bypass_inactive_disable - boolean - Exempt this user from being disabled based on inactivity?
    #   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
    #   dav_permission - boolean - Can the user connect with WebDAV?
    #   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
    #   ftp_permission - boolean - Can the user access with FTP/FTPS?
    #   header_text - string - Text to display to the user in the header of the UI
    #   language - string - Preferred language
    #   notification_daily_send_time - int64 - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
    #   name - string - User's full name
    #   notes - string - Any internal notes on the user
    #   password_validity_days - int64 - Number of days to allow user to use the same password
    #   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
    #   require_password_change - boolean - Is a password change required upon next user login?
    #   restapi_permission - boolean - Can this user access the REST API?
    #   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
    #   sftp_permission - boolean - Can the user access with SFTP?
    #   site_admin - boolean - Is the user an administrator for this site?
    #   skip_welcome_screen - boolean - Skip Welcome page in the UI?
    #   ssl_required - string - SSL required setting
    #   sso_strategy_id - int64 - SSO (Single Sign On) strategy ID for the user, if applicable.
    #   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
    #   time_zone - string - User time zone
    #   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
    #   username - string - User's username
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: change_password must be an String") if params.dig(:change_password) and !params.dig(:change_password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: change_password_confirmation must be an String") if params.dig(:change_password_confirmation) and !params.dig(:change_password_confirmation).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params.dig(:email) and !params.dig(:email).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: grant_permission must be an String") if params.dig(:grant_permission) and !params.dig(:grant_permission).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params.dig(:group_id) and !params.dig(:group_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params.dig(:group_ids) and !params.dig(:group_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params.dig(:password) and !params.dig(:password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_confirmation must be an String") if params.dig(:password_confirmation) and !params.dig(:password_confirmation).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if params.dig(:allowed_ips) and !params.dig(:allowed_ips).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authenticate_until must be an String") if params.dig(:authenticate_until) and !params.dig(:authenticate_until).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if params.dig(:authentication_method) and !params.dig(:authentication_method).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: header_text must be an String") if params.dig(:header_text) and !params.dig(:header_text).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if params.dig(:language) and !params.dig(:language).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notification_daily_send_time must be an Integer") if params.dig(:notification_daily_send_time) and !params.dig(:notification_daily_send_time).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params.dig(:notes) and !params.dig(:notes).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password_validity_days must be an Integer") if params.dig(:password_validity_days) and !params.dig(:password_validity_days).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ssl_required must be an String") if params.dig(:ssl_required) and !params.dig(:ssl_required).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sso_strategy_id must be an Integer") if params.dig(:sso_strategy_id) and !params.dig(:sso_strategy_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: time_zone must be an String") if params.dig(:time_zone) and !params.dig(:time_zone).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_root must be an String") if params.dig(:user_root) and !params.dig(:user_root).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params.dig(:username) and !params.dig(:username).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/users/#{params[:id]}", :patch, params, options)
      User.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/users/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
