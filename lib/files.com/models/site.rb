# frozen_string_literal: true

module Files
  class Site
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Site Id
    def id
      @attributes[:id]
    end

    # string - Site name
    def name
      @attributes[:name]
    end

    # array(string) - Additional extensions that are considered text files
    def additional_text_file_types
      @attributes[:additional_text_file_types]
    end

    # boolean - Is SMS two factor authentication allowed?
    def allowed_2fa_method_sms
      @attributes[:allowed_2fa_method_sms]
    end

    # boolean - Is TOTP two factor authentication allowed?
    def allowed_2fa_method_totp
      @attributes[:allowed_2fa_method_totp]
    end

    # boolean - Is WebAuthn two factor authentication allowed?
    def allowed_2fa_method_webauthn
      @attributes[:allowed_2fa_method_webauthn]
    end

    # boolean - Is yubikey two factor authentication allowed?
    def allowed_2fa_method_yubi
      @attributes[:allowed_2fa_method_yubi]
    end

    # boolean - Is OTP via email two factor authentication allowed?
    def allowed_2fa_method_email
      @attributes[:allowed_2fa_method_email]
    end

    # boolean - Is OTP via static codes for two factor authentication allowed?
    def allowed_2fa_method_static
      @attributes[:allowed_2fa_method_static]
    end

    # boolean - Are users allowed to configure their two factor authentication to be bypassed for FTP/SFTP/WebDAV?
    def allowed_2fa_method_bypass_for_ftp_sftp_dav
      @attributes[:allowed_2fa_method_bypass_for_ftp_sftp_dav]
    end

    # int64 - User ID for the main site administrator
    def admin_user_id
      @attributes[:admin_user_id]
    end

    # boolean - Allow admins to bypass the locked subfolders setting.
    def admins_bypass_locked_subfolders
      @attributes[:admins_bypass_locked_subfolders]
    end

    # boolean - Are manual Bundle names allowed?
    def allow_bundle_names
      @attributes[:allow_bundle_names]
    end

    # string - Comma separated list of allowed Country codes
    def allowed_countries
      @attributes[:allowed_countries]
    end

    # string - List of allowed IP addresses
    def allowed_ips
      @attributes[:allowed_ips]
    end

    # boolean - Create parent directories if they do not exist during uploads?  This is primarily used to work around broken upload clients that assume servers will perform this step.
    def always_mkdir_parents
      @attributes[:always_mkdir_parents]
    end

    # boolean - If false, rename conflicting files instead of asking for overwrite confirmation.  Only applies to web interface.
    def ask_about_overwrites
      @attributes[:ask_about_overwrites]
    end

    # string - Do Bundle owners receive activity notifications?
    def bundle_activity_notifications
      @attributes[:bundle_activity_notifications]
    end

    # int64 - Site-wide Bundle expiration in days
    def bundle_expiration
      @attributes[:bundle_expiration]
    end

    # string - Custom error message to show when bundle is not found.
    def bundle_not_found_message
      @attributes[:bundle_not_found_message]
    end

    # boolean - Do Bundles require password protection?
    def bundle_password_required
      @attributes[:bundle_password_required]
    end

    # array(string) - List of email domains to disallow when entering a Bundle/Inbox recipients
    def bundle_recipient_blacklist_domains
      @attributes[:bundle_recipient_blacklist_domains]
    end

    # boolean - Disallow free email domains for Bundle/Inbox recipients?
    def bundle_recipient_blacklist_free_email_domains
      @attributes[:bundle_recipient_blacklist_free_email_domains]
    end

    # string - Do Bundle owners receive registration notification?
    def bundle_registration_notifications
      @attributes[:bundle_registration_notifications]
    end

    # boolean - Do Bundles require registration?
    def bundle_require_registration
      @attributes[:bundle_require_registration]
    end

    # boolean - Do Bundles require recipients for sharing?
    def bundle_require_share_recipient
      @attributes[:bundle_require_share_recipient]
    end

    # boolean - Do Bundles require internal notes?
    def bundle_require_note
      @attributes[:bundle_require_note]
    end

    # boolean - Do Bundle creators receive receipts of invitations?
    def bundle_send_shared_receipts
      @attributes[:bundle_send_shared_receipts]
    end

    # string - Do Bundle uploaders receive upload confirmation notifications?
    def bundle_upload_receipt_notifications
      @attributes[:bundle_upload_receipt_notifications]
    end

    # Image - Preview watermark image applied to all bundle items.
    def bundle_watermark_attachment
      @attributes[:bundle_watermark_attachment]
    end

    # object - Preview watermark settings applied to all bundle items. Uses the same keys as Behavior.value
    def bundle_watermark_value
      @attributes[:bundle_watermark_value]
    end

    # boolean - Calculate CRC32 checksums for files?
    def calculate_file_checksums_crc32
      @attributes[:calculate_file_checksums_crc32]
    end

    # boolean - Calculate MD5 checksums for files?
    def calculate_file_checksums_md5
      @attributes[:calculate_file_checksums_md5]
    end

    # boolean - Calculate SHA1 checksums for files?
    def calculate_file_checksums_sha1
      @attributes[:calculate_file_checksums_sha1]
    end

    # boolean - Calculate SHA256 checksums for files?
    def calculate_file_checksums_sha256
      @attributes[:calculate_file_checksums_sha256]
    end

    # boolean - Do incoming emails in the Inboxes require checking for SPF/DKIM/DMARC?
    def uploads_via_email_authentication
      @attributes[:uploads_via_email_authentication]
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

    # string - Site main contact name
    def contact_name
      @attributes[:contact_name]
    end

    # date-time - Time this site was created
    def created_at
      @attributes[:created_at]
    end

    # string - Preferred currency
    def currency
      @attributes[:currency]
    end

    # boolean - Is this site using a custom namespace for users?
    def custom_namespace
      @attributes[:custom_namespace]
    end

    # boolean - Is WebDAV enabled?
    def dav_enabled
      @attributes[:dav_enabled]
    end

    # boolean - Use user FTP roots also for WebDAV?
    def dav_user_root_enabled
      @attributes[:dav_user_root_enabled]
    end

    # int64 - Number of days to keep deleted files
    def days_to_retain_backups
      @attributes[:days_to_retain_backups]
    end

    # boolean - If true, allow public viewers of Bundles with full permissions to use document editing integrations.
    def document_edits_in_bundle_allowed
      @attributes[:document_edits_in_bundle_allowed]
    end

    # string - Site default time zone
    def default_time_zone
      @attributes[:default_time_zone]
    end

    # boolean - Is the desktop app enabled?
    def desktop_app
      @attributes[:desktop_app]
    end

    # boolean - Is desktop app session IP pinning enabled?
    def desktop_app_session_ip_pinning
      @attributes[:desktop_app_session_ip_pinning]
    end

    # int64 - Desktop app session lifetime (in hours)
    def desktop_app_session_lifetime
      @attributes[:desktop_app_session_lifetime]
    end

    # boolean - Use legacy checksums mode?
    def legacy_checksums_mode
      @attributes[:legacy_checksums_mode]
    end

    # boolean - If true, we will migrate all remote server syncs to the new Sync model.
    def migrate_remote_server_sync_to_sync
      @attributes[:migrate_remote_server_sync_to_sync]
    end

    # boolean - Is the mobile app enabled?
    def mobile_app
      @attributes[:mobile_app]
    end

    # boolean - Is mobile app session IP pinning enabled?
    def mobile_app_session_ip_pinning
      @attributes[:mobile_app_session_ip_pinning]
    end

    # int64 - Mobile app session lifetime (in hours)
    def mobile_app_session_lifetime
      @attributes[:mobile_app_session_lifetime]
    end

    # string - Comma separated list of disallowed Country codes
    def disallowed_countries
      @attributes[:disallowed_countries]
    end

    # boolean - If set, Files.com will not set the CAA records required to generate future SSL certificates for this domain.
    def disable_files_certificate_generation
      @attributes[:disable_files_certificate_generation]
    end

    # boolean - Are notifications disabled?
    def disable_notifications
      @attributes[:disable_notifications]
    end

    # boolean - Is password reset disabled?
    def disable_password_reset
      @attributes[:disable_password_reset]
    end

    # string - Custom domain
    def domain
      @attributes[:domain]
    end

    # boolean - Send HSTS (HTTP Strict Transport Security) header when visitors access the site via a custom domain?
    def domain_hsts_header
      @attributes[:domain_hsts_header]
    end

    # string - Letsencrypt chain to use when registering SSL Certificate for domain.
    def domain_letsencrypt_chain
      @attributes[:domain_letsencrypt_chain]
    end

    # email - Main email for this site
    def email
      @attributes[:email]
    end

    # boolean - Is FTP enabled?
    def ftp_enabled
      @attributes[:ftp_enabled]
    end

    # email - Reply-to email for this site
    def reply_to_email
      @attributes[:reply_to_email]
    end

    # boolean - If true, groups can be manually created / modified / deleted by Site Admins. Otherwise, groups can only be managed via your SSO provider.
    def non_sso_groups_allowed
      @attributes[:non_sso_groups_allowed]
    end

    # boolean - If true, users can be manually created / modified / deleted by Site Admins. Otherwise, users can only be managed via your SSO provider.
    def non_sso_users_allowed
      @attributes[:non_sso_users_allowed]
    end

    # boolean - If true, permissions for this site must be bound to a group (not a user).
    def folder_permissions_groups_only
      @attributes[:folder_permissions_groups_only]
    end

    # boolean - Is there a signed HIPAA BAA between Files.com and this site?
    def hipaa
      @attributes[:hipaa]
    end

    # Image - Branded icon 128x128
    def icon128
      @attributes[:icon128]
    end

    # Image - Branded icon 16x16
    def icon16
      @attributes[:icon16]
    end

    # Image - Branded icon 32x32
    def icon32
      @attributes[:icon32]
    end

    # Image - Branded icon 48x48
    def icon48
      @attributes[:icon48]
    end

    # date-time - Can files be modified?
    def immutable_files_set_at
      @attributes[:immutable_files_set_at]
    end

    # boolean - Include password in emails to new users?
    def include_password_in_welcome_email
      @attributes[:include_password_in_welcome_email]
    end

    # string - Site default language
    def language
      @attributes[:language]
    end

    # string - Base DN for looking up users in LDAP server
    def ldap_base_dn
      @attributes[:ldap_base_dn]
    end

    # string - Domain name that will be appended to usernames
    def ldap_domain
      @attributes[:ldap_domain]
    end

    # boolean - Main LDAP setting: is LDAP enabled?
    def ldap_enabled
      @attributes[:ldap_enabled]
    end

    # string - Should we sync groups from LDAP server?
    def ldap_group_action
      @attributes[:ldap_group_action]
    end

    # string - Comma or newline separated list of group names (with optional wildcards) to exclude when syncing.
    def ldap_group_exclusion
      @attributes[:ldap_group_exclusion]
    end

    # string - Comma or newline separated list of group names (with optional wildcards) to include when syncing.
    def ldap_group_inclusion
      @attributes[:ldap_group_inclusion]
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

    # string - LDAP type
    def ldap_type
      @attributes[:ldap_type]
    end

    # string - Should we sync users from LDAP server?
    def ldap_user_action
      @attributes[:ldap_user_action]
    end

    # string - Comma or newline separated list of group names (with optional wildcards) - if provided, only users in these groups will be added or synced.
    def ldap_user_include_groups
      @attributes[:ldap_user_include_groups]
    end

    # string - Username for signing in to LDAP server.
    def ldap_username
      @attributes[:ldap_username]
    end

    # string - LDAP username field
    def ldap_username_field
      @attributes[:ldap_username_field]
    end

    # string - Login help text
    def login_help_text
      @attributes[:login_help_text]
    end

    # Image - Branded logo
    def logo
      @attributes[:logo]
    end

    # Image - Branded login page background
    def login_page_background_image
      @attributes[:login_page_background_image]
    end

    # int64 - Number of prior passwords to disallow
    def max_prior_passwords
      @attributes[:max_prior_passwords]
    end

    # string - A message to show users when they connect via FTP or SFTP.
    def motd_text
      @attributes[:motd_text]
    end

    # boolean - Show message to users connecting via FTP
    def motd_use_for_ftp
      @attributes[:motd_use_for_ftp]
    end

    # boolean - Show message to users connecting via SFTP
    def motd_use_for_sftp
      @attributes[:motd_use_for_sftp]
    end

    # double - Next billing amount
    def next_billing_amount
      @attributes[:next_billing_amount]
    end

    # string - Next billing date
    def next_billing_date
      @attributes[:next_billing_date]
    end

    # boolean - If true, allows users to use a document editing integration.
    def office_integration_available
      @attributes[:office_integration_available]
    end

    # string - Which document editing integration to support. Files.com Editor or Microsoft Office for the Web.
    def office_integration_type
      @attributes[:office_integration_type]
    end

    # string - Link to scheduling a meeting with our Sales team
    def oncehub_link
      @attributes[:oncehub_link]
    end

    # boolean - Use servers in the USA only?
    def opt_out_global
      @attributes[:opt_out_global]
    end

    # boolean - Is this site's billing overdue?
    def overdue
      @attributes[:overdue]
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

    # boolean - Require passwords that have not been previously breached? (see https://haveibeenpwned.com/)
    def password_require_unbreached
      @attributes[:password_require_unbreached]
    end

    # boolean - Require bundles' passwords, and passwords for other items (inboxes, public shares, etc.) to conform to the same requirements as users' passwords?
    def password_requirements_apply_to_bundles
      @attributes[:password_requirements_apply_to_bundles]
    end

    # int64 - Number of days password is valid
    def password_validity_days
      @attributes[:password_validity_days]
    end

    # string - Site phone number
    def phone
      @attributes[:phone]
    end

    # boolean - If true, we will ensure that all internal communications with any remote server are made through the primary region of the site. This setting overrides individual remote server settings.
    def pin_all_remote_servers_to_site_region
      @attributes[:pin_all_remote_servers_to_site_region]
    end

    # boolean - If true, we will prevent non-administrators from receiving any permissions directly on the root folder.  This is commonly used to prevent the accidental application of permissions.
    def prevent_root_permissions_for_non_site_admins
      @attributes[:prevent_root_permissions_for_non_site_admins]
    end

    # boolean - If true, protocol access permissions on users will be ignored, and only protocol access permissions set on Groups will be honored.  Make sure that your current user is a member of a group with API permission when changing this value to avoid locking yourself out of your site.
    def protocol_access_groups_only
      @attributes[:protocol_access_groups_only]
    end

    # boolean - Require two-factor authentication for all users?
    def require_2fa
      @attributes[:require_2fa]
    end

    # date-time - If set, requirement for two-factor authentication has been scheduled to end on this date-time.
    def require_2fa_stop_time
      @attributes[:require_2fa_stop_time]
    end

    # boolean - Auto-removes bundles for disabled/deleted users and enforces bundle expiry within user access period.
    def revoke_bundle_access_on_disable_or_delete
      @attributes[:revoke_bundle_access_on_disable_or_delete]
    end

    # string - What type of user is required to use two-factor authentication (when require_2fa is set to `true` for this site)?
    def require_2fa_user_type
      @attributes[:require_2fa_user_type]
    end

    # boolean - If true, we will hide the 'Remember Me' box on Inbox and Bundle registration pages, requiring that the user logout and log back in every time they visit the page.
    def require_logout_from_bundles_and_inboxes
      @attributes[:require_logout_from_bundles_and_inboxes]
    end

    # Session - Current session
    def session
      @attributes[:session]
    end

    # boolean - Is SFTP enabled?
    def sftp_enabled
      @attributes[:sftp_enabled]
    end

    # string - Sftp Host Key Type
    def sftp_host_key_type
      @attributes[:sftp_host_key_type]
    end

    # int64 - Id of the currently selected custom SFTP Host Key
    def active_sftp_host_key_id
      @attributes[:active_sftp_host_key_id]
    end

    # boolean - If true, we will allow weak and known insecure ciphers to be used for SFTP connections.  Enabling this setting severely weakens the security of your site and it is not recommend, except as a last resort for compatibility.
    def sftp_insecure_ciphers
      @attributes[:sftp_insecure_ciphers]
    end

    # boolean - If true, we will allow weak Diffie Hellman parameters to be used within ciphers for SFTP that are otherwise on our secure list.  This has the effect of making the cipher weaker than our normal threshold for security, but is required to support certain legacy or broken SSH and MFT clients.  Enabling this weakens security, but not nearly as much as enabling the full `sftp_insecure_ciphers` option.
    def sftp_insecure_diffie_hellman
      @attributes[:sftp_insecure_diffie_hellman]
    end

    # boolean - Use user FTP roots also for SFTP?
    def sftp_user_root_enabled
      @attributes[:sftp_user_root_enabled]
    end

    # boolean - Allow bundle creation
    def sharing_enabled
      @attributes[:sharing_enabled]
    end

    # boolean - Show log in link in user notifications?
    def show_user_notifications_log_in_link
      @attributes[:show_user_notifications_log_in_link]
    end

    # boolean - Show request access link for users without access?  Currently unused.
    def show_request_access_link
      @attributes[:show_request_access_link]
    end

    # string - Custom site footer text
    def site_footer
      @attributes[:site_footer]
    end

    # string - Custom site header text
    def site_header
      @attributes[:site_header]
    end

    # string - SMTP server hostname or IP
    def smtp_address
      @attributes[:smtp_address]
    end

    # string - SMTP server authentication type
    def smtp_authentication
      @attributes[:smtp_authentication]
    end

    # string - From address to use when mailing through custom SMTP
    def smtp_from
      @attributes[:smtp_from]
    end

    # int64 - SMTP server port
    def smtp_port
      @attributes[:smtp_port]
    end

    # string - SMTP server username
    def smtp_username
      @attributes[:smtp_username]
    end

    # double - Session expiry in hours
    def session_expiry
      @attributes[:session_expiry]
    end

    # int64 - Session expiry in minutes
    def session_expiry_minutes
      @attributes[:session_expiry_minutes]
    end

    # boolean - Allow snapshot share links creation
    def snapshot_sharing_enabled
      @attributes[:snapshot_sharing_enabled]
    end

    # boolean - Is SSL required?  Disabling this is insecure.
    def ssl_required
      @attributes[:ssl_required]
    end

    # string - Site subdomain
    def subdomain
      @attributes[:subdomain]
    end

    # date-time - If switching plans, when does the new plan take effect?
    def switch_to_plan_date
      @attributes[:switch_to_plan_date]
    end

    # boolean - DO NOT ENABLE. This setting allows TLSv1.0 and TLSv1.1 to be used on your site.  We intend to remove this capability entirely in early 2024.  If set, the `sftp_insecure_ciphers` flag will be automatically set to true.
    def tls_disabled
      @attributes[:tls_disabled]
    end

    # int64 - Number of days left in trial
    def trial_days_left
      @attributes[:trial_days_left]
    end

    # date-time - When does this Site trial expire?
    def trial_until
      @attributes[:trial_until]
    end

    # boolean - If using custom SMTP, should we use dedicated IPs to deliver emails?
    def use_dedicated_ips_for_smtp
      @attributes[:use_dedicated_ips_for_smtp]
    end

    # boolean - Allow uploaders to set `provided_modified_at` for uploaded files?
    def use_provided_modified_at
      @attributes[:use_provided_modified_at]
    end

    # User - User of current session
    def user
      @attributes[:user]
    end

    # boolean - Will users be locked out after incorrect login attempts?
    def user_lockout
      @attributes[:user_lockout]
    end

    # int64 - How many hours to lock user out for failed password?
    def user_lockout_lock_period
      @attributes[:user_lockout_lock_period]
    end

    # int64 - Number of login tries within `user_lockout_within` hours before users are locked out
    def user_lockout_tries
      @attributes[:user_lockout_tries]
    end

    # int64 - Number of hours for user lockout window
    def user_lockout_within
      @attributes[:user_lockout_within]
    end

    # boolean - Enable User Requests feature
    def user_requests_enabled
      @attributes[:user_requests_enabled]
    end

    # boolean - Send email to site admins when a user request is received?
    def user_requests_notify_admins
      @attributes[:user_requests_notify_admins]
    end

    # boolean - Allow users to create their own API keys?
    def users_can_create_api_keys
      @attributes[:users_can_create_api_keys]
    end

    # boolean - Allow users to create their own SSH keys?
    def users_can_create_ssh_keys
      @attributes[:users_can_create_ssh_keys]
    end

    # string - Custom text send in user welcome email
    def welcome_custom_text
      @attributes[:welcome_custom_text]
    end

    # email - Include this email in welcome emails if enabled
    def welcome_email_cc
      @attributes[:welcome_email_cc]
    end

    # string - Include this email subject in welcome emails if enabled
    def welcome_email_subject
      @attributes[:welcome_email_subject]
    end

    # boolean - Will the welcome email be sent to new users?
    def welcome_email_enabled
      @attributes[:welcome_email_enabled]
    end

    # string - Does the welcome screen appear?
    def welcome_screen
      @attributes[:welcome_screen]
    end

    # boolean - Does FTP user Windows emulation mode?
    def windows_mode_ftp
      @attributes[:windows_mode_ftp]
    end

    # boolean - Allow group admins set password authentication method
    def group_admins_can_set_user_password
      @attributes[:group_admins_can_set_user_password]
    end

    def self.get(params = {}, options = {})
      response, options = Api.send_request("/site", :get, params, options)
      Site.new(response.data, options)
    end

    def self.get_usage(params = {}, options = {})
      response, options = Api.send_request("/site/usage", :get, params, options)
      UsageSnapshot.new(response.data, options)
    end

    # Parameters:
    #   name - string - Site name
    #   subdomain - string - Site subdomain
    #   domain - string - Custom domain
    #   domain_hsts_header - boolean - Send HSTS (HTTP Strict Transport Security) header when visitors access the site via a custom domain?
    #   domain_letsencrypt_chain - string - Letsencrypt chain to use when registering SSL Certificate for domain.
    #   email - string - Main email for this site
    #   reply_to_email - string - Reply-to email for this site
    #   allow_bundle_names - boolean - Are manual Bundle names allowed?
    #   bundle_expiration - int64 - Site-wide Bundle expiration in days
    #   welcome_email_enabled - boolean - Will the welcome email be sent to new users?
    #   ask_about_overwrites - boolean - If false, rename conflicting files instead of asking for overwrite confirmation.  Only applies to web interface.
    #   show_request_access_link - boolean - Show request access link for users without access?  Currently unused.
    #   always_mkdir_parents - boolean - Create parent directories if they do not exist during uploads?  This is primarily used to work around broken upload clients that assume servers will perform this step.
    #   welcome_email_cc - string - Include this email in welcome emails if enabled
    #   welcome_email_subject - string - Include this email subject in welcome emails if enabled
    #   welcome_custom_text - string - Custom text send in user welcome email
    #   language - string - Site default language
    #   windows_mode_ftp - boolean - Does FTP user Windows emulation mode?
    #   default_time_zone - string - Site default time zone
    #   desktop_app - boolean - Is the desktop app enabled?
    #   desktop_app_session_ip_pinning - boolean - Is desktop app session IP pinning enabled?
    #   desktop_app_session_lifetime - int64 - Desktop app session lifetime (in hours)
    #   mobile_app - boolean - Is the mobile app enabled?
    #   mobile_app_session_ip_pinning - boolean - Is mobile app session IP pinning enabled?
    #   mobile_app_session_lifetime - int64 - Mobile app session lifetime (in hours)
    #   folder_permissions_groups_only - boolean - If true, permissions for this site must be bound to a group (not a user).
    #   welcome_screen - string - Does the welcome screen appear?
    #   office_integration_available - boolean - If true, allows users to use a document editing integration.
    #   office_integration_type - string - Which document editing integration to support. Files.com Editor or Microsoft Office for the Web.
    #   pin_all_remote_servers_to_site_region - boolean - If true, we will ensure that all internal communications with any remote server are made through the primary region of the site. This setting overrides individual remote server settings.
    #   motd_text - string - A message to show users when they connect via FTP or SFTP.
    #   motd_use_for_ftp - boolean - Show message to users connecting via FTP
    #   motd_use_for_sftp - boolean - Show message to users connecting via SFTP
    #   left_navigation_visibility - object - Visibility settings for account navigation
    #   additional_text_file_types - array(string) - Additional extensions that are considered text files
    #   bundle_require_note - boolean - Do Bundles require internal notes?
    #   bundle_send_shared_receipts - boolean - Do Bundle creators receive receipts of invitations?
    #   calculate_file_checksums_crc32 - boolean - Calculate CRC32 checksums for files?
    #   calculate_file_checksums_md5 - boolean - Calculate MD5 checksums for files?
    #   calculate_file_checksums_sha1 - boolean - Calculate SHA1 checksums for files?
    #   calculate_file_checksums_sha256 - boolean - Calculate SHA256 checksums for files?
    #   legacy_checksums_mode - boolean - Use legacy checksums mode?
    #   migrate_remote_server_sync_to_sync - boolean - If true, we will migrate all remote server syncs to the new Sync model.
    #   session_expiry - double - Session expiry in hours
    #   ssl_required - boolean - Is SSL required?  Disabling this is insecure.
    #   tls_disabled - boolean - DO NOT ENABLE. This setting allows TLSv1.0 and TLSv1.1 to be used on your site.  We intend to remove this capability entirely in early 2024.  If set, the `sftp_insecure_ciphers` flag will be automatically set to true.
    #   sftp_insecure_ciphers - boolean - If true, we will allow weak and known insecure ciphers to be used for SFTP connections.  Enabling this setting severely weakens the security of your site and it is not recommend, except as a last resort for compatibility.
    #   sftp_insecure_diffie_hellman - boolean - If true, we will allow weak Diffie Hellman parameters to be used within ciphers for SFTP that are otherwise on our secure list.  This has the effect of making the cipher weaker than our normal threshold for security, but is required to support certain legacy or broken SSH and MFT clients.  Enabling this weakens security, but not nearly as much as enabling the full `sftp_insecure_ciphers` option.
    #   disable_files_certificate_generation - boolean - If set, Files.com will not set the CAA records required to generate future SSL certificates for this domain.
    #   user_lockout - boolean - Will users be locked out after incorrect login attempts?
    #   user_lockout_tries - int64 - Number of login tries within `user_lockout_within` hours before users are locked out
    #   user_lockout_within - int64 - Number of hours for user lockout window
    #   user_lockout_lock_period - int64 - How many hours to lock user out for failed password?
    #   include_password_in_welcome_email - boolean - Include password in emails to new users?
    #   allowed_countries - string - Comma separated list of allowed Country codes
    #   allowed_ips - string - List of allowed IP addresses
    #   disallowed_countries - string - Comma separated list of disallowed Country codes
    #   days_to_retain_backups - int64 - Number of days to keep deleted files
    #   max_prior_passwords - int64 - Number of prior passwords to disallow
    #   password_validity_days - int64 - Number of days password is valid
    #   password_min_length - int64 - Shortest password length for users
    #   password_require_letter - boolean - Require a letter in passwords?
    #   password_require_mixed - boolean - Require lower and upper case letters in passwords?
    #   password_require_special - boolean - Require special characters in password?
    #   password_require_number - boolean - Require a number in passwords?
    #   password_require_unbreached - boolean - Require passwords that have not been previously breached? (see https://haveibeenpwned.com/)
    #   require_logout_from_bundles_and_inboxes - boolean - If true, we will hide the 'Remember Me' box on Inbox and Bundle registration pages, requiring that the user logout and log back in every time they visit the page.
    #   dav_user_root_enabled - boolean - Use user FTP roots also for WebDAV?
    #   sftp_user_root_enabled - boolean - Use user FTP roots also for SFTP?
    #   disable_password_reset - boolean - Is password reset disabled?
    #   immutable_files - boolean - Are files protected from modification?
    #   bundle_not_found_message - string - Custom error message to show when bundle is not found.
    #   bundle_password_required - boolean - Do Bundles require password protection?
    #   bundle_require_registration - boolean - Do Bundles require registration?
    #   bundle_require_share_recipient - boolean - Do Bundles require recipients for sharing?
    #   bundle_registration_notifications - string - Do Bundle owners receive registration notification?
    #   bundle_activity_notifications - string - Do Bundle owners receive activity notifications?
    #   bundle_upload_receipt_notifications - string - Do Bundle uploaders receive upload confirmation notifications?
    #   document_edits_in_bundle_allowed - boolean - If true, allow public viewers of Bundles with full permissions to use document editing integrations.
    #   password_requirements_apply_to_bundles - boolean - Require bundles' passwords, and passwords for other items (inboxes, public shares, etc.) to conform to the same requirements as users' passwords?
    #   prevent_root_permissions_for_non_site_admins - boolean - If true, we will prevent non-administrators from receiving any permissions directly on the root folder.  This is commonly used to prevent the accidental application of permissions.
    #   opt_out_global - boolean - Use servers in the USA only?
    #   use_provided_modified_at - boolean - Allow uploaders to set `provided_modified_at` for uploaded files?
    #   custom_namespace - boolean - Is this site using a custom namespace for users?
    #   non_sso_groups_allowed - boolean - If true, groups can be manually created / modified / deleted by Site Admins. Otherwise, groups can only be managed via your SSO provider.
    #   non_sso_users_allowed - boolean - If true, users can be manually created / modified / deleted by Site Admins. Otherwise, users can only be managed via your SSO provider.
    #   sharing_enabled - boolean - Allow bundle creation
    #   snapshot_sharing_enabled - boolean - Allow snapshot share links creation
    #   user_requests_enabled - boolean - Enable User Requests feature
    #   user_requests_notify_admins - boolean - Send email to site admins when a user request is received?
    #   dav_enabled - boolean - Is WebDAV enabled?
    #   ftp_enabled - boolean - Is FTP enabled?
    #   sftp_enabled - boolean - Is SFTP enabled?
    #   users_can_create_api_keys - boolean - Allow users to create their own API keys?
    #   users_can_create_ssh_keys - boolean - Allow users to create their own SSH keys?
    #   show_user_notifications_log_in_link - boolean - Show log in link in user notifications?
    #   sftp_host_key_type - string - Sftp Host Key Type
    #   active_sftp_host_key_id - int64 - Id of the currently selected custom SFTP Host Key
    #   protocol_access_groups_only - boolean - If true, protocol access permissions on users will be ignored, and only protocol access permissions set on Groups will be honored.  Make sure that your current user is a member of a group with API permission when changing this value to avoid locking yourself out of your site.
    #   revoke_bundle_access_on_disable_or_delete - boolean - Auto-removes bundles for disabled/deleted users and enforces bundle expiry within user access period.
    #   bundle_watermark_value - object - Preview watermark settings applied to all bundle items. Uses the same keys as Behavior.value
    #   group_admins_can_set_user_password - boolean - Allow group admins set password authentication method
    #   bundle_recipient_blacklist_free_email_domains - boolean - Disallow free email domains for Bundle/Inbox recipients?
    #   bundle_recipient_blacklist_domains - array(string) - List of email domains to disallow when entering a Bundle/Inbox recipients
    #   admins_bypass_locked_subfolders - boolean - Allow admins to bypass the locked subfolders setting.
    #   allowed_2fa_method_sms - boolean - Is SMS two factor authentication allowed?
    #   allowed_2fa_method_totp - boolean - Is TOTP two factor authentication allowed?
    #   allowed_2fa_method_webauthn - boolean - Is WebAuthn two factor authentication allowed?
    #   allowed_2fa_method_yubi - boolean - Is yubikey two factor authentication allowed?
    #   allowed_2fa_method_email - boolean - Is OTP via email two factor authentication allowed?
    #   allowed_2fa_method_static - boolean - Is OTP via static codes for two factor authentication allowed?
    #   allowed_2fa_method_bypass_for_ftp_sftp_dav - boolean - Are users allowed to configure their two factor authentication to be bypassed for FTP/SFTP/WebDAV?
    #   require_2fa - boolean - Require two-factor authentication for all users?
    #   require_2fa_user_type - string - What type of user is required to use two-factor authentication (when require_2fa is set to `true` for this site)?
    #   color2_top - string - Top bar background color
    #   color2_left - string - Page link and button color
    #   color2_link - string - Top bar link color
    #   color2_text - string - Page link and button color
    #   color2_top_text - string - Top bar text color
    #   site_header - string - Custom site header text
    #   site_footer - string - Custom site footer text
    #   login_help_text - string - Login help text
    #   use_dedicated_ips_for_smtp - boolean - If using custom SMTP, should we use dedicated IPs to deliver emails?
    #   smtp_address - string - SMTP server hostname or IP
    #   smtp_authentication - string - SMTP server authentication type
    #   smtp_from - string - From address to use when mailing through custom SMTP
    #   smtp_username - string - SMTP server username
    #   smtp_port - int64 - SMTP server port
    #   ldap_enabled - boolean - Main LDAP setting: is LDAP enabled?
    #   ldap_type - string - LDAP type
    #   ldap_host - string - LDAP host
    #   ldap_host_2 - string - LDAP backup host
    #   ldap_host_3 - string - LDAP backup host
    #   ldap_port - int64 - LDAP port
    #   ldap_secure - boolean - Use secure LDAP?
    #   ldap_username - string - Username for signing in to LDAP server.
    #   ldap_username_field - string - LDAP username field
    #   ldap_domain - string - Domain name that will be appended to usernames
    #   ldap_user_action - string - Should we sync users from LDAP server?
    #   ldap_group_action - string - Should we sync groups from LDAP server?
    #   ldap_user_include_groups - string - Comma or newline separated list of group names (with optional wildcards) - if provided, only users in these groups will be added or synced.
    #   ldap_group_exclusion - string - Comma or newline separated list of group names (with optional wildcards) to exclude when syncing.
    #   ldap_group_inclusion - string - Comma or newline separated list of group names (with optional wildcards) to include when syncing.
    #   ldap_base_dn - string - Base DN for looking up users in LDAP server
    #   uploads_via_email_authentication - boolean - Do incoming emails in the Inboxes require checking for SPF/DKIM/DMARC?
    #   icon16_file - file
    #   icon16_delete - boolean - If true, will delete the file stored in icon16
    #   icon32_file - file
    #   icon32_delete - boolean - If true, will delete the file stored in icon32
    #   icon48_file - file
    #   icon48_delete - boolean - If true, will delete the file stored in icon48
    #   icon128_file - file
    #   icon128_delete - boolean - If true, will delete the file stored in icon128
    #   logo_file - file
    #   logo_delete - boolean - If true, will delete the file stored in logo
    #   bundle_watermark_attachment_file - file
    #   bundle_watermark_attachment_delete - boolean - If true, will delete the file stored in bundle_watermark_attachment
    #   login_page_background_image_file - file
    #   login_page_background_image_delete - boolean - If true, will delete the file stored in login_page_background_image
    #   disable_2fa_with_delay - boolean - If set to true, we will begin the process of disabling 2FA on this site.
    #   ldap_password_change - string - New LDAP password.
    #   ldap_password_change_confirmation - string - Confirm new LDAP password.
    #   smtp_password - string - Password for SMTP server.
    #   session_expiry_minutes - int64 - Session expiry in minutes
    def self.update(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subdomain must be an String") if params[:subdomain] and !params[:subdomain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: domain must be an String") if params[:domain] and !params[:domain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: domain_letsencrypt_chain must be an String") if params[:domain_letsencrypt_chain] and !params[:domain_letsencrypt_chain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: reply_to_email must be an String") if params[:reply_to_email] and !params[:reply_to_email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bundle_expiration must be an Integer") if params[:bundle_expiration] and !params[:bundle_expiration].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: welcome_email_cc must be an String") if params[:welcome_email_cc] and !params[:welcome_email_cc].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: welcome_email_subject must be an String") if params[:welcome_email_subject] and !params[:welcome_email_subject].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: welcome_custom_text must be an String") if params[:welcome_custom_text] and !params[:welcome_custom_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if params[:language] and !params[:language].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: default_time_zone must be an String") if params[:default_time_zone] and !params[:default_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: desktop_app_session_lifetime must be an Integer") if params[:desktop_app_session_lifetime] and !params[:desktop_app_session_lifetime].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: mobile_app_session_lifetime must be an Integer") if params[:mobile_app_session_lifetime] and !params[:mobile_app_session_lifetime].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: welcome_screen must be an String") if params[:welcome_screen] and !params[:welcome_screen].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: office_integration_type must be an String") if params[:office_integration_type] and !params[:office_integration_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: motd_text must be an String") if params[:motd_text] and !params[:motd_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: left_navigation_visibility must be an Hash") if params[:left_navigation_visibility] and !params[:left_navigation_visibility].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: additional_text_file_types must be an Array") if params[:additional_text_file_types] and !params[:additional_text_file_types].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: session_expiry must be an Float") if params[:session_expiry] and !params[:session_expiry].is_a?(Float)
      raise InvalidParameterError.new("Bad parameter: user_lockout_tries must be an Integer") if params[:user_lockout_tries] and !params[:user_lockout_tries].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_lockout_within must be an Integer") if params[:user_lockout_within] and !params[:user_lockout_within].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_lockout_lock_period must be an Integer") if params[:user_lockout_lock_period] and !params[:user_lockout_lock_period].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: allowed_countries must be an String") if params[:allowed_countries] and !params[:allowed_countries].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if params[:allowed_ips] and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: disallowed_countries must be an String") if params[:disallowed_countries] and !params[:disallowed_countries].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: days_to_retain_backups must be an Integer") if params[:days_to_retain_backups] and !params[:days_to_retain_backups].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_prior_passwords must be an Integer") if params[:max_prior_passwords] and !params[:max_prior_passwords].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password_validity_days must be an Integer") if params[:password_validity_days] and !params[:password_validity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password_min_length must be an Integer") if params[:password_min_length] and !params[:password_min_length].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: bundle_not_found_message must be an String") if params[:bundle_not_found_message] and !params[:bundle_not_found_message].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bundle_registration_notifications must be an String") if params[:bundle_registration_notifications] and !params[:bundle_registration_notifications].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bundle_activity_notifications must be an String") if params[:bundle_activity_notifications] and !params[:bundle_activity_notifications].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bundle_upload_receipt_notifications must be an String") if params[:bundle_upload_receipt_notifications] and !params[:bundle_upload_receipt_notifications].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sftp_host_key_type must be an String") if params[:sftp_host_key_type] and !params[:sftp_host_key_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: active_sftp_host_key_id must be an Integer") if params[:active_sftp_host_key_id] and !params[:active_sftp_host_key_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: bundle_watermark_value must be an Hash") if params[:bundle_watermark_value] and !params[:bundle_watermark_value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: bundle_recipient_blacklist_domains must be an Array") if params[:bundle_recipient_blacklist_domains] and !params[:bundle_recipient_blacklist_domains].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: require_2fa_user_type must be an String") if params[:require_2fa_user_type] and !params[:require_2fa_user_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: color2_top must be an String") if params[:color2_top] and !params[:color2_top].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: color2_left must be an String") if params[:color2_left] and !params[:color2_left].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: color2_link must be an String") if params[:color2_link] and !params[:color2_link].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: color2_text must be an String") if params[:color2_text] and !params[:color2_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: color2_top_text must be an String") if params[:color2_top_text] and !params[:color2_top_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: site_header must be an String") if params[:site_header] and !params[:site_header].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: site_footer must be an String") if params[:site_footer] and !params[:site_footer].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: login_help_text must be an String") if params[:login_help_text] and !params[:login_help_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smtp_address must be an String") if params[:smtp_address] and !params[:smtp_address].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smtp_authentication must be an String") if params[:smtp_authentication] and !params[:smtp_authentication].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smtp_from must be an String") if params[:smtp_from] and !params[:smtp_from].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smtp_username must be an String") if params[:smtp_username] and !params[:smtp_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smtp_port must be an Integer") if params[:smtp_port] and !params[:smtp_port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ldap_type must be an String") if params[:ldap_type] and !params[:ldap_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host must be an String") if params[:ldap_host] and !params[:ldap_host].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host_2 must be an String") if params[:ldap_host_2] and !params[:ldap_host_2].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host_3 must be an String") if params[:ldap_host_3] and !params[:ldap_host_3].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_port must be an Integer") if params[:ldap_port] and !params[:ldap_port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ldap_username must be an String") if params[:ldap_username] and !params[:ldap_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_username_field must be an String") if params[:ldap_username_field] and !params[:ldap_username_field].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_domain must be an String") if params[:ldap_domain] and !params[:ldap_domain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_user_action must be an String") if params[:ldap_user_action] and !params[:ldap_user_action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_group_action must be an String") if params[:ldap_group_action] and !params[:ldap_group_action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_user_include_groups must be an String") if params[:ldap_user_include_groups] and !params[:ldap_user_include_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_group_exclusion must be an String") if params[:ldap_group_exclusion] and !params[:ldap_group_exclusion].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_group_inclusion must be an String") if params[:ldap_group_inclusion] and !params[:ldap_group_inclusion].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_base_dn must be an String") if params[:ldap_base_dn] and !params[:ldap_base_dn].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_password_change must be an String") if params[:ldap_password_change] and !params[:ldap_password_change].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_password_change_confirmation must be an String") if params[:ldap_password_change_confirmation] and !params[:ldap_password_change_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smtp_password must be an String") if params[:smtp_password] and !params[:smtp_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: session_expiry_minutes must be an Integer") if params[:session_expiry_minutes] and !params[:session_expiry_minutes].is_a?(Integer)

      response, options = Api.send_request("/site", :patch, params, options)
      Site.new(response.data, options)
    end
  end
end
