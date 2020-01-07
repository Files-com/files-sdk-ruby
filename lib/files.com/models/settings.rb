# frozen_string_literal: true

module Files
  class Settings
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - All supported image types
    def image_regex
      @attributes[:image_regex]
    end

    # string - All supported video types
    def video_regex
      @attributes[:video_regex]
    end

    # string - All supported audio types
    def audio_regex
      @attributes[:audio_regex]
    end

    # string - All supported PDF types
    def pdf_regex
      @attributes[:pdf_regex]
    end

    # string - Deprecated
    def tab_config
      @attributes[:tab_config]
    end

    # boolean - Password check skipped?
    def reauth
      @attributes[:reauth]
    end

    # array - Region name and description
    def regions
      @attributes[:regions]
    end

    # array - Region name and description
    def s3_regions
      @attributes[:s3_regions]
    end

    # array - States with applicable sales tax
    def sales_tax_regions
      @attributes[:sales_tax_regions]
    end

    # string - Current language locale setting
    def current_language
      @attributes[:current_language]
    end

    # string - Is this session read only?
    def read_only
      @attributes[:read_only]
    end

    # string - Session locale setting
    def session_language
      @attributes[:session_language]
    end

    # string - Primary domain name base of the site
    def primary_sub_domain_base
      @attributes[:primary_sub_domain_base]
    end

    # boolean - Can the user create attachments, including bundles?
    def attachments_permission
      @attributes[:attachments_permission]
    end

    # string - Authentication method for the user.  Can be `password`, `ldap`, `sso`, or `none`
    def authentication_method
      @attributes[:authentication_method]
    end

    # string - URL holding the user's avatar
    def avatar_url
      @attributes[:avatar_url]
    end

    # boolean - Can the user connect with WebDAV?
    def dav_permission
      @attributes[:dav_permission]
    end

    # email - User email address
    def email
      @attributes[:email]
    end

    # boolean - If true, permissions for this site must be bound to a group (not a user). Otherwise, permissions must be bound to a user.
    def folder_permissions_groups_only
      @attributes[:folder_permissions_groups_only]
    end

    # boolean - Can the user access with FTP/FTPS?
    def ftp_permission
      @attributes[:ftp_permission]
    end

    # boolean - Is a group administrator?
    def group_admin
      @attributes[:group_admin]
    end

    # date-time - The last date/time this user has read announcements
    def last_read_announcements_at
      @attributes[:last_read_announcements_at]
    end

    # string - User name
    def name
      @attributes[:name]
    end

    # int64 - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
    def notification_daily_send_time
      @attributes[:notification_daily_send_time]
    end

    # boolean - Does this user manage it's own credentials?
    def self_managed
      @attributes[:self_managed]
    end

    # boolean - Can the user access with SFTP?
    def sftp_permission
      @attributes[:sftp_permission]
    end

    # boolean - Is the user an administrator for this site?
    def site_admin
      @attributes[:site_admin]
    end

    # boolean - Skip the welcome screen?
    def skip_welcome_screen
      @attributes[:skip_welcome_screen]
    end

    # boolean - Is this user automatically managed?
    def externally_managed
      @attributes[:externally_managed]
    end

    # string - User time zone
    def time_zone
      @attributes[:time_zone]
    end

    # string - 2fa type
    def type_of_2fa
      @attributes[:type_of_2fa]
    end

    # string - 2fa type
    def reauth_2fa
      @attributes[:reauth_2fa]
    end

    # int64 - User ID
    def user_id
      @attributes[:user_id]
    end

    # string - Preferred language
    def user_language
      @attributes[:user_language]
    end

    # string - User's username
    def username
      @attributes[:username]
    end

    # string - Root web folder
    def web_root
      @attributes[:web_root]
    end

    # boolean - Is SMS two factor authentication allowed?
    def allowed_2fa_method_sms
      @attributes[:allowed_2fa_method_sms]
    end

    # boolean - Is TOTP two factor authentication allowed?
    def allowed_2fa_method_totp
      @attributes[:allowed_2fa_method_totp]
    end

    # boolean - Is U2F two factor authentication allowed?
    def allowed_2fa_method_u2f
      @attributes[:allowed_2fa_method_u2f]
    end

    # boolean - Is yubikey two factor authentication allowed?
    def allowed_2fa_method_yubi
      @attributes[:allowed_2fa_method_yubi]
    end

    # boolean - Is beta feature 1 available?
    def beta_features
      @attributes[:beta_features]
    end

    # boolean - Is beta feature 2 available?
    def beta_feature2
      @attributes[:beta_feature2]
    end

    # boolean - Is beta feature 3 available?
    def beta_feature3
      @attributes[:beta_feature3]
    end

    # int64 - Site-wide bundle expiration in days
    def bundle_expiration
      @attributes[:bundle_expiration]
    end

    # boolean - Do bundle shares require password protection?
    def bundle_password_required
      @attributes[:bundle_password_required]
    end

    # boolean - Do site-wide password requirements apply to bundles?
    def password_requirements_apply_to_bundles
      @attributes[:password_requirements_apply_to_bundles]
    end

    # boolean - Is the desktop app enabled?
    def desktop_app
      @attributes[:desktop_app]
    end

    # boolean - Connected to an account?
    def has_account
      @attributes[:has_account]
    end

    # boolean - Hide billing information?
    def hide_billing
      @attributes[:hide_billing]
    end

    # boolean - Is history unavailable?
    def history_unavailable
      @attributes[:history_unavailable]
    end

    # boolean - Are files protected from modification?
    def immutable_files
      @attributes[:immutable_files]
    end

    # boolean - Is billing overdue?
    def overdue
      @attributes[:overdue]
    end

    # boolean - Is the site unavailable?
    def site_unavailable
      @attributes[:site_unavailable]
    end

    # int64 - Shortest password length for users
    def password_min_length
      @attributes[:password_min_length]
    end

    # boolean - Require a letter in passwords?
    def password_require_letter
      @attributes[:password_require_letter]
    end

    # boolean - Require lower and upper case letters in passwords?
    def password_require_mixed
      @attributes[:password_require_mixed]
    end

    # boolean - Require a number in passwords?
    def password_require_number
      @attributes[:password_require_number]
    end

    # boolean - Require special characters in password?
    def password_require_special
      @attributes[:password_require_special]
    end

    # string - Site public url
    def public_url
      @attributes[:public_url]
    end

    # boolean - Require two-factor authentication for the current user?
    def require_2fa
      @attributes[:require_2fa]
    end

    # boolean - Show request access link for users without access?
    def show_request_access_link
      @attributes[:show_request_access_link]
    end

    # int64 - Number of days left in trial
    def trial_days_left
      @attributes[:trial_days_left]
    end

    # boolean - Is this site a free trial that is locked due to fraud concerns?
    def trial_locked
      @attributes[:trial_locked]
    end

    # boolean - Has this site been flagged as a duplicate of another trial?
    def trial_flagged_as_duplicate
      @attributes[:trial_flagged_as_duplicate]
    end

    # date-time - When does this Site trial expire?
    def trial_until
      @attributes[:trial_until]
    end

    # boolean - Allow setting provided_modified_at?
    def use_provided_modified_at
      @attributes[:use_provided_modified_at]
    end

    # boolean - Does the site have a large number of users?  (Used to hide some UI features that may be slow in this case.)
    def high_users_count
      @attributes[:high_users_count]
    end

    # int64 - Count of users on the site.  Only exposed for site admins.
    def users_count
      @attributes[:users_count]
    end

    # string - Page link and button color
    def color2_left
      @attributes[:color2_left]
    end

    # string - Top bar link color
    def color2_link
      @attributes[:color2_link]
    end

    # string - Page link and button color
    def color2_text
      @attributes[:color2_text]
    end

    # string - Top bar background color
    def color2_top
      @attributes[:color2_top]
    end

    # string - Top bar text color
    def color2_top_text
      @attributes[:color2_top_text]
    end

    # boolean - Is password reset disabled?
    def disable_password_reset
      @attributes[:disable_password_reset]
    end

    # string - Login help text
    def login_help_text
      @attributes[:login_help_text]
    end

    # string - Site name
    def site_name
      @attributes[:site_name]
    end

    def sso_strategies
      @attributes[:sso_strategies]
    end

    # string - Site footer for branding
    def site_footer
      @attributes[:site_footer]
    end

    # string - Site header for branding
    def site_header
      @attributes[:site_header]
    end

    # string - Site language locale
    def site_language
      @attributes[:site_language]
    end

    # string - Does the welcome screen appear? Can be `enabled`, `hidden`, or `disabled`
    def welcome_screen
      @attributes[:welcome_screen]
    end

    # Branded icon 128x128
    def icon128
      @attributes[:icon128]
    end

    # Branded icon 16x16
    def icon16
      @attributes[:icon16]
    end

    # Branded icon 32x32
    def icon32
      @attributes[:icon32]
    end

    # Branded icon 48x48
    def icon48
      @attributes[:icon48]
    end

    # Branded logo
    def logo
      @attributes[:logo]
    end
  end
end
