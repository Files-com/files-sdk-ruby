# frozen_string_literal: true

require "bigdecimal"

module Files
  class StagingSite
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Site Id
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Site name
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # array(string) - Additional extensions that are considered text files
    def additional_text_file_types
      @attributes[:additional_text_file_types]
    end

    def additional_text_file_types=(value)
      @attributes[:additional_text_file_types] = value
    end

    # object - Availability settings for AI features by user class
    def ai_feature_availability
      @attributes[:ai_feature_availability]
    end

    def ai_feature_availability=(value)
      @attributes[:ai_feature_availability] = value
    end

    # boolean - Is SMS two factor authentication allowed?
    def allowed_2fa_method_sms
      @attributes[:allowed_2fa_method_sms]
    end

    def allowed_2fa_method_sms=(value)
      @attributes[:allowed_2fa_method_sms] = value
    end

    # boolean - Is TOTP two factor authentication allowed?
    def allowed_2fa_method_totp
      @attributes[:allowed_2fa_method_totp]
    end

    def allowed_2fa_method_totp=(value)
      @attributes[:allowed_2fa_method_totp] = value
    end

    # boolean - Is WebAuthn two factor authentication allowed?
    def allowed_2fa_method_webauthn
      @attributes[:allowed_2fa_method_webauthn]
    end

    def allowed_2fa_method_webauthn=(value)
      @attributes[:allowed_2fa_method_webauthn] = value
    end

    # boolean - Is yubikey two factor authentication allowed?
    def allowed_2fa_method_yubi
      @attributes[:allowed_2fa_method_yubi]
    end

    def allowed_2fa_method_yubi=(value)
      @attributes[:allowed_2fa_method_yubi] = value
    end

    # boolean - Is OTP via email two factor authentication allowed?
    def allowed_2fa_method_email
      @attributes[:allowed_2fa_method_email]
    end

    def allowed_2fa_method_email=(value)
      @attributes[:allowed_2fa_method_email] = value
    end

    # boolean - Is OTP via static codes for two factor authentication allowed?
    def allowed_2fa_method_static
      @attributes[:allowed_2fa_method_static]
    end

    def allowed_2fa_method_static=(value)
      @attributes[:allowed_2fa_method_static] = value
    end

    # boolean - Are users allowed to configure their two factor authentication to be bypassed for FTP/SFTP/WebDAV?
    def allowed_2fa_method_bypass_for_ftp_sftp_dav
      @attributes[:allowed_2fa_method_bypass_for_ftp_sftp_dav]
    end

    def allowed_2fa_method_bypass_for_ftp_sftp_dav=(value)
      @attributes[:allowed_2fa_method_bypass_for_ftp_sftp_dav] = value
    end

    # int64 - User ID for the main site administrator
    def admin_user_id
      @attributes[:admin_user_id]
    end

    def admin_user_id=(value)
      @attributes[:admin_user_id] = value
    end

    # boolean - Allow admins to bypass the locked subfolders setting.
    def admins_bypass_locked_subfolders
      @attributes[:admins_bypass_locked_subfolders]
    end

    def admins_bypass_locked_subfolders=(value)
      @attributes[:admins_bypass_locked_subfolders] = value
    end

    # boolean - Are manual Bundle names allowed?
    def allow_bundle_names
      @attributes[:allow_bundle_names]
    end

    def allow_bundle_names=(value)
      @attributes[:allow_bundle_names] = value
    end

    # boolean - Allow the site-wide two-factor authentication requirement to be overriden on a per-user-basis?
    def allow_user_level_2fa_override
      @attributes[:allow_user_level_2fa_override]
    end

    def allow_user_level_2fa_override=(value)
      @attributes[:allow_user_level_2fa_override] = value
    end

    # boolean - Allow the site-wide allowed IP restriction to be overriden on a per-user-basis?
    def allow_user_level_allowed_ip_override
      @attributes[:allow_user_level_allowed_ip_override]
    end

    def allow_user_level_allowed_ip_override=(value)
      @attributes[:allow_user_level_allowed_ip_override] = value
    end

    # boolean - Allow the site-wide FTP SSL requirement to be overriden on a per-user-basis?
    def allow_user_level_ssl_override
      @attributes[:allow_user_level_ssl_override]
    end

    def allow_user_level_ssl_override=(value)
      @attributes[:allow_user_level_ssl_override] = value
    end

    # string - Comma separated list of allowed Country codes
    def allowed_countries
      @attributes[:allowed_countries]
    end

    def allowed_countries=(value)
      @attributes[:allowed_countries] = value
    end

    # string - List of allowed IP addresses
    def allowed_ips
      @attributes[:allowed_ips]
    end

    def allowed_ips=(value)
      @attributes[:allowed_ips] = value
    end

    # boolean - Create parent directories if they do not exist during uploads?  This is primarily used to work around broken upload clients that assume servers will perform this step.
    def always_mkdir_parents
      @attributes[:always_mkdir_parents]
    end

    def always_mkdir_parents=(value)
      @attributes[:always_mkdir_parents] = value
    end

    # int64 - Number of days to retain AS2 messages (incoming and outgoing).
    def as2_message_retention_days
      @attributes[:as2_message_retention_days]
    end

    def as2_message_retention_days=(value)
      @attributes[:as2_message_retention_days] = value
    end

    # boolean - If false, rename conflicting files instead of asking for overwrite confirmation.  Only applies to web interface.
    def ask_about_overwrites
      @attributes[:ask_about_overwrites]
    end

    def ask_about_overwrites=(value)
      @attributes[:ask_about_overwrites] = value
    end

    # string - Do Bundle owners receive activity notifications?
    def bundle_activity_notifications
      @attributes[:bundle_activity_notifications]
    end

    def bundle_activity_notifications=(value)
      @attributes[:bundle_activity_notifications] = value
    end

    # int64 - Site-wide Bundle expiration in days
    def bundle_expiration
      @attributes[:bundle_expiration]
    end

    def bundle_expiration=(value)
      @attributes[:bundle_expiration] = value
    end

    # string - Custom error message to show when bundle is not found.
    def bundle_not_found_message
      @attributes[:bundle_not_found_message]
    end

    def bundle_not_found_message=(value)
      @attributes[:bundle_not_found_message] = value
    end

    # boolean - Do Bundles require password protection?
    def bundle_password_required
      @attributes[:bundle_password_required]
    end

    def bundle_password_required=(value)
      @attributes[:bundle_password_required] = value
    end

    # boolean - If true, new Share Links created by a user with a primary group will default to that group as owner.
    def bundles_default_owned_by_primary_group
      @attributes[:bundles_default_owned_by_primary_group]
    end

    def bundles_default_owned_by_primary_group=(value)
      @attributes[:bundles_default_owned_by_primary_group] = value
    end

    # array(string) - List of email domains to disallow when entering a Bundle/Inbox recipients
    def bundle_recipient_blacklist_domains
      @attributes[:bundle_recipient_blacklist_domains]
    end

    def bundle_recipient_blacklist_domains=(value)
      @attributes[:bundle_recipient_blacklist_domains] = value
    end

    # boolean - Disallow free email domains for Bundle/Inbox recipients?
    def bundle_recipient_blacklist_free_email_domains
      @attributes[:bundle_recipient_blacklist_free_email_domains]
    end

    def bundle_recipient_blacklist_free_email_domains=(value)
      @attributes[:bundle_recipient_blacklist_free_email_domains] = value
    end

    # string - Do Bundle owners receive registration notification?
    def bundle_registration_notifications
      @attributes[:bundle_registration_notifications]
    end

    def bundle_registration_notifications=(value)
      @attributes[:bundle_registration_notifications] = value
    end

    # boolean - Do Bundles require registration?
    def bundle_require_registration
      @attributes[:bundle_require_registration]
    end

    def bundle_require_registration=(value)
      @attributes[:bundle_require_registration] = value
    end

    # boolean - Do Bundles require recipients for sharing?
    def bundle_require_share_recipient
      @attributes[:bundle_require_share_recipient]
    end

    def bundle_require_share_recipient=(value)
      @attributes[:bundle_require_share_recipient] = value
    end

    # boolean - Do Bundles require internal notes?
    def bundle_require_note
      @attributes[:bundle_require_note]
    end

    def bundle_require_note=(value)
      @attributes[:bundle_require_note] = value
    end

    # boolean - Do Bundle creators receive receipts of invitations?
    def bundle_send_shared_receipts
      @attributes[:bundle_send_shared_receipts]
    end

    def bundle_send_shared_receipts=(value)
      @attributes[:bundle_send_shared_receipts] = value
    end

    # string - Do Bundle uploaders receive upload confirmation notifications?
    def bundle_upload_receipt_notifications
      @attributes[:bundle_upload_receipt_notifications]
    end

    def bundle_upload_receipt_notifications=(value)
      @attributes[:bundle_upload_receipt_notifications] = value
    end

    # Image - Preview watermark image applied to all bundle items.
    def bundle_watermark_attachment
      @attributes[:bundle_watermark_attachment]
    end

    def bundle_watermark_attachment=(value)
      @attributes[:bundle_watermark_attachment] = value
    end

    # object - Preview watermark settings applied to all bundle items. Uses the same keys as Behavior.value
    def bundle_watermark_value
      @attributes[:bundle_watermark_value]
    end

    def bundle_watermark_value=(value)
      @attributes[:bundle_watermark_value] = value
    end

    # boolean - Calculate CRC32 checksums for files?
    def calculate_file_checksums_crc32
      @attributes[:calculate_file_checksums_crc32]
    end

    def calculate_file_checksums_crc32=(value)
      @attributes[:calculate_file_checksums_crc32] = value
    end

    # boolean - Calculate MD5 checksums for files?
    def calculate_file_checksums_md5
      @attributes[:calculate_file_checksums_md5]
    end

    def calculate_file_checksums_md5=(value)
      @attributes[:calculate_file_checksums_md5] = value
    end

    # boolean - Calculate SHA1 checksums for files?
    def calculate_file_checksums_sha1
      @attributes[:calculate_file_checksums_sha1]
    end

    def calculate_file_checksums_sha1=(value)
      @attributes[:calculate_file_checksums_sha1] = value
    end

    # boolean - Calculate SHA256 checksums for files?
    def calculate_file_checksums_sha256
      @attributes[:calculate_file_checksums_sha256]
    end

    def calculate_file_checksums_sha256=(value)
      @attributes[:calculate_file_checksums_sha256] = value
    end

    # boolean - Do incoming emails in the Inboxes require checking for SPF/DKIM/DMARC?
    def uploads_via_email_authentication
      @attributes[:uploads_via_email_authentication]
    end

    def uploads_via_email_authentication=(value)
      @attributes[:uploads_via_email_authentication] = value
    end

    # string - Page link and button color
    def color2_left
      @attributes[:color2_left]
    end

    def color2_left=(value)
      @attributes[:color2_left] = value
    end

    # string - Top bar link color
    def color2_link
      @attributes[:color2_link]
    end

    def color2_link=(value)
      @attributes[:color2_link] = value
    end

    # string - Page link and button color
    def color2_text
      @attributes[:color2_text]
    end

    def color2_text=(value)
      @attributes[:color2_text] = value
    end

    # string - Top bar background color
    def color2_top
      @attributes[:color2_top]
    end

    def color2_top=(value)
      @attributes[:color2_top] = value
    end

    # string - Top bar text color
    def color2_top_text
      @attributes[:color2_top_text]
    end

    def color2_top_text=(value)
      @attributes[:color2_top_text] = value
    end

    # string - Site main contact name
    def contact_name
      @attributes[:contact_name]
    end

    def contact_name=(value)
      @attributes[:contact_name] = value
    end

    # date-time - Time this site was created
    def created_at
      @attributes[:created_at]
    end

    # string - Preferred currency
    def currency
      @attributes[:currency]
    end

    def currency=(value)
      @attributes[:currency] = value
    end

    # boolean - Is this site using a custom namespace for users?
    def custom_namespace
      @attributes[:custom_namespace]
    end

    def custom_namespace=(value)
      @attributes[:custom_namespace] = value
    end

    # boolean - Is WebDAV enabled?
    def dav_enabled
      @attributes[:dav_enabled]
    end

    def dav_enabled=(value)
      @attributes[:dav_enabled] = value
    end

    # boolean - Use user FTP roots also for WebDAV?
    def dav_user_root_enabled
      @attributes[:dav_user_root_enabled]
    end

    def dav_user_root_enabled=(value)
      @attributes[:dav_user_root_enabled] = value
    end

    # int64 - Number of days to keep deleted files
    def days_to_retain_backups
      @attributes[:days_to_retain_backups]
    end

    def days_to_retain_backups=(value)
      @attributes[:days_to_retain_backups] = value
    end

    # boolean - If true, allow public viewers of Bundles with full permissions to use document editing integrations.
    def document_edits_in_bundle_allowed
      @attributes[:document_edits_in_bundle_allowed]
    end

    def document_edits_in_bundle_allowed=(value)
      @attributes[:document_edits_in_bundle_allowed] = value
    end

    # string - Site default time zone
    def default_time_zone
      @attributes[:default_time_zone]
    end

    def default_time_zone=(value)
      @attributes[:default_time_zone] = value
    end

    # boolean - Is the desktop app enabled?
    def desktop_app
      @attributes[:desktop_app]
    end

    def desktop_app=(value)
      @attributes[:desktop_app] = value
    end

    # boolean - Is desktop app session IP pinning enabled?
    def desktop_app_session_ip_pinning
      @attributes[:desktop_app_session_ip_pinning]
    end

    def desktop_app_session_ip_pinning=(value)
      @attributes[:desktop_app_session_ip_pinning] = value
    end

    # int64 - Desktop app session lifetime (in hours)
    def desktop_app_session_lifetime
      @attributes[:desktop_app_session_lifetime]
    end

    def desktop_app_session_lifetime=(value)
      @attributes[:desktop_app_session_lifetime] = value
    end

    # boolean - Use legacy checksums mode?
    def legacy_checksums_mode
      @attributes[:legacy_checksums_mode]
    end

    def legacy_checksums_mode=(value)
      @attributes[:legacy_checksums_mode] = value
    end

    # boolean - If true, we will migrate all remote server syncs to the new Sync model.
    def migrate_remote_server_sync_to_sync
      @attributes[:migrate_remote_server_sync_to_sync]
    end

    def migrate_remote_server_sync_to_sync=(value)
      @attributes[:migrate_remote_server_sync_to_sync] = value
    end

    # boolean - Is OAuth DCR (dynamic client registration) for MCP enabled?
    def mcp_dcr_enabled
      @attributes[:mcp_dcr_enabled]
    end

    def mcp_dcr_enabled=(value)
      @attributes[:mcp_dcr_enabled] = value
    end

    # boolean - Is the mobile app enabled?
    def mobile_app
      @attributes[:mobile_app]
    end

    def mobile_app=(value)
      @attributes[:mobile_app] = value
    end

    # boolean - Is mobile app session IP pinning enabled?
    def mobile_app_session_ip_pinning
      @attributes[:mobile_app_session_ip_pinning]
    end

    def mobile_app_session_ip_pinning=(value)
      @attributes[:mobile_app_session_ip_pinning] = value
    end

    # int64 - Mobile app session lifetime (in hours)
    def mobile_app_session_lifetime
      @attributes[:mobile_app_session_lifetime]
    end

    def mobile_app_session_lifetime=(value)
      @attributes[:mobile_app_session_lifetime] = value
    end

    # string - Comma separated list of disallowed Country codes
    def disallowed_countries
      @attributes[:disallowed_countries]
    end

    def disallowed_countries=(value)
      @attributes[:disallowed_countries] = value
    end

    # boolean - If true, all AI features are disabled for this site.
    def disable_all_ai_features
      @attributes[:disable_all_ai_features]
    end

    def disable_all_ai_features=(value)
      @attributes[:disable_all_ai_features] = value
    end

    # boolean - If set, Files.com will not set the CAA records required to generate future SSL certificates for this domain.
    def disable_files_certificate_generation
      @attributes[:disable_files_certificate_generation]
    end

    def disable_files_certificate_generation=(value)
      @attributes[:disable_files_certificate_generation] = value
    end

    # boolean - Are notifications disabled?
    def disable_notifications
      @attributes[:disable_notifications]
    end

    def disable_notifications=(value)
      @attributes[:disable_notifications] = value
    end

    # boolean - Is password reset disabled?
    def disable_password_reset
      @attributes[:disable_password_reset]
    end

    def disable_password_reset=(value)
      @attributes[:disable_password_reset] = value
    end

    # string - Custom domain
    def domain
      @attributes[:domain]
    end

    def domain=(value)
      @attributes[:domain] = value
    end

    # boolean - Send HSTS (HTTP Strict Transport Security) header when visitors access the site via a custom domain?
    def domain_hsts_header
      @attributes[:domain_hsts_header]
    end

    def domain_hsts_header=(value)
      @attributes[:domain_hsts_header] = value
    end

    # string - Letsencrypt chain to use when registering SSL Certificate for domain. No longer used as of 2026.
    def domain_letsencrypt_chain
      @attributes[:domain_letsencrypt_chain]
    end

    def domain_letsencrypt_chain=(value)
      @attributes[:domain_letsencrypt_chain] = value
    end

    # email - Main email for this site
    def email
      @attributes[:email]
    end

    def email=(value)
      @attributes[:email] = value
    end

    # boolean - Is FTP enabled?
    def ftp_enabled
      @attributes[:ftp_enabled]
    end

    def ftp_enabled=(value)
      @attributes[:ftp_enabled] = value
    end

    # email - Reply-to email for this site
    def reply_to_email
      @attributes[:reply_to_email]
    end

    def reply_to_email=(value)
      @attributes[:reply_to_email] = value
    end

    # boolean - If true, groups can be manually created / modified / deleted by Site Admins. Otherwise, groups can only be managed via your SSO provider.
    def non_sso_groups_allowed
      @attributes[:non_sso_groups_allowed]
    end

    def non_sso_groups_allowed=(value)
      @attributes[:non_sso_groups_allowed] = value
    end

    # boolean - If true, users can be manually created / modified / deleted by Site Admins. Otherwise, users can only be managed via your SSO provider.
    def non_sso_users_allowed
      @attributes[:non_sso_users_allowed]
    end

    def non_sso_users_allowed=(value)
      @attributes[:non_sso_users_allowed] = value
    end

    # boolean - If true, permissions for this site must be bound to a group (not a user).
    def folder_permissions_groups_only
      @attributes[:folder_permissions_groups_only]
    end

    def folder_permissions_groups_only=(value)
      @attributes[:folder_permissions_groups_only] = value
    end

    # boolean - Allow group admins to create users in their groups
    def group_admins_can_add_users
      @attributes[:group_admins_can_add_users]
    end

    def group_admins_can_add_users=(value)
      @attributes[:group_admins_can_add_users] = value
    end

    # boolean - Allow group admins to delete users in their groups
    def group_admins_can_delete_users
      @attributes[:group_admins_can_delete_users]
    end

    def group_admins_can_delete_users=(value)
      @attributes[:group_admins_can_delete_users] = value
    end

    # boolean - Allow group admins to enable or disable users in their groups
    def group_admins_can_enable_disable_users
      @attributes[:group_admins_can_enable_disable_users]
    end

    def group_admins_can_enable_disable_users=(value)
      @attributes[:group_admins_can_enable_disable_users] = value
    end

    # boolean - Allow group admins to modify users in their groups
    def group_admins_can_modify_users
      @attributes[:group_admins_can_modify_users]
    end

    def group_admins_can_modify_users=(value)
      @attributes[:group_admins_can_modify_users] = value
    end

    # boolean - Allow group admins to exempt users in their groups from lifecycle rules
    def group_admins_can_bypass_user_lifecycle_rules
      @attributes[:group_admins_can_bypass_user_lifecycle_rules]
    end

    def group_admins_can_bypass_user_lifecycle_rules=(value)
      @attributes[:group_admins_can_bypass_user_lifecycle_rules] = value
    end

    # boolean - Allow group admins to reset passwords for users in their groups
    def group_admins_can_reset_passwords
      @attributes[:group_admins_can_reset_passwords]
    end

    def group_admins_can_reset_passwords=(value)
      @attributes[:group_admins_can_reset_passwords] = value
    end

    # boolean - Allow group admins to set password authentication method
    def group_admins_can_set_user_password
      @attributes[:group_admins_can_set_user_password]
    end

    def group_admins_can_set_user_password=(value)
      @attributes[:group_admins_can_set_user_password] = value
    end

    # boolean - Is there a signed HIPAA BAA between Files.com and this site?
    def hipaa
      @attributes[:hipaa]
    end

    def hipaa=(value)
      @attributes[:hipaa] = value
    end

    # Image - Branded icon 128x128
    def icon128
      @attributes[:icon128]
    end

    def icon128=(value)
      @attributes[:icon128] = value
    end

    # Image - Branded icon 16x16
    def icon16
      @attributes[:icon16]
    end

    def icon16=(value)
      @attributes[:icon16] = value
    end

    # Image - Branded icon 32x32
    def icon32
      @attributes[:icon32]
    end

    def icon32=(value)
      @attributes[:icon32] = value
    end

    # Image - Branded icon 48x48
    def icon48
      @attributes[:icon48]
    end

    def icon48=(value)
      @attributes[:icon48] = value
    end

    # date-time - Can files be modified?
    def immutable_files_set_at
      @attributes[:immutable_files_set_at]
    end

    def immutable_files_set_at=(value)
      @attributes[:immutable_files_set_at] = value
    end

    # boolean - Include password in emails to new users?
    def include_password_in_welcome_email
      @attributes[:include_password_in_welcome_email]
    end

    def include_password_in_welcome_email=(value)
      @attributes[:include_password_in_welcome_email] = value
    end

    # string - Site default language
    def language
      @attributes[:language]
    end

    def language=(value)
      @attributes[:language] = value
    end

    # string - Base DN for looking up users in LDAP server
    def ldap_base_dn
      @attributes[:ldap_base_dn]
    end

    def ldap_base_dn=(value)
      @attributes[:ldap_base_dn] = value
    end

    # string - Domain name that will be appended to usernames
    def ldap_domain
      @attributes[:ldap_domain]
    end

    def ldap_domain=(value)
      @attributes[:ldap_domain] = value
    end

    # boolean - Main LDAP setting: is LDAP enabled?
    def ldap_enabled
      @attributes[:ldap_enabled]
    end

    def ldap_enabled=(value)
      @attributes[:ldap_enabled] = value
    end

    # string - Should we sync groups from LDAP server?
    def ldap_group_action
      @attributes[:ldap_group_action]
    end

    def ldap_group_action=(value)
      @attributes[:ldap_group_action] = value
    end

    # string - Comma or newline separated list of group names (with optional wildcards) to exclude when syncing.
    def ldap_group_exclusion
      @attributes[:ldap_group_exclusion]
    end

    def ldap_group_exclusion=(value)
      @attributes[:ldap_group_exclusion] = value
    end

    # string - Comma or newline separated list of group names (with optional wildcards) to include when syncing.
    def ldap_group_inclusion
      @attributes[:ldap_group_inclusion]
    end

    def ldap_group_inclusion=(value)
      @attributes[:ldap_group_inclusion] = value
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

    # boolean - Use secure LDAP?
    def ldap_secure
      @attributes[:ldap_secure]
    end

    def ldap_secure=(value)
      @attributes[:ldap_secure] = value
    end

    # string - LDAP type
    def ldap_type
      @attributes[:ldap_type]
    end

    def ldap_type=(value)
      @attributes[:ldap_type] = value
    end

    # string - Should we sync users from LDAP server?
    def ldap_user_action
      @attributes[:ldap_user_action]
    end

    def ldap_user_action=(value)
      @attributes[:ldap_user_action] = value
    end

    # string - Comma or newline separated list of group names (with optional wildcards) - if provided, only users in these groups will be added or synced.
    def ldap_user_include_groups
      @attributes[:ldap_user_include_groups]
    end

    def ldap_user_include_groups=(value)
      @attributes[:ldap_user_include_groups] = value
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

    # string - Login help text
    def login_help_text
      @attributes[:login_help_text]
    end

    def login_help_text=(value)
      @attributes[:login_help_text] = value
    end

    # Image - Branded logo
    def logo
      @attributes[:logo]
    end

    def logo=(value)
      @attributes[:logo] = value
    end

    # Image - Branded login page background
    def login_page_background_image
      @attributes[:login_page_background_image]
    end

    def login_page_background_image=(value)
      @attributes[:login_page_background_image] = value
    end

    # int64 - Number of prior passwords to disallow
    def max_prior_passwords
      @attributes[:max_prior_passwords]
    end

    def max_prior_passwords=(value)
      @attributes[:max_prior_passwords] = value
    end

    # object - List of site settings managed by the parent site
    def managed_site_settings
      @attributes[:managed_site_settings]
    end

    def managed_site_settings=(value)
      @attributes[:managed_site_settings] = value
    end

    # string - A message to show users when they connect via FTP or SFTP.
    def motd_text
      @attributes[:motd_text]
    end

    def motd_text=(value)
      @attributes[:motd_text] = value
    end

    # boolean - Show message to users connecting via FTP
    def motd_use_for_ftp
      @attributes[:motd_use_for_ftp]
    end

    def motd_use_for_ftp=(value)
      @attributes[:motd_use_for_ftp] = value
    end

    # boolean - Show message to users connecting via SFTP
    def motd_use_for_sftp
      @attributes[:motd_use_for_sftp]
    end

    def motd_use_for_sftp=(value)
      @attributes[:motd_use_for_sftp] = value
    end

    # decimal - Next billing amount
    def next_billing_amount
      value = @attributes[:next_billing_amount]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    def next_billing_amount=(value)
      @attributes[:next_billing_amount] = value
    end

    # string - Next billing date
    def next_billing_date
      @attributes[:next_billing_date]
    end

    def next_billing_date=(value)
      @attributes[:next_billing_date] = value
    end

    # boolean - If true, allows users to use a document editing integration.
    def office_integration_available
      @attributes[:office_integration_available]
    end

    def office_integration_available=(value)
      @attributes[:office_integration_available] = value
    end

    # string - Which document editing integration to support. Files.com Editor or Microsoft Office for the Web.
    def office_integration_type
      @attributes[:office_integration_type]
    end

    def office_integration_type=(value)
      @attributes[:office_integration_type] = value
    end

    # string - Link to scheduling a meeting with our Sales team
    def oncehub_link
      @attributes[:oncehub_link]
    end

    def oncehub_link=(value)
      @attributes[:oncehub_link] = value
    end

    # boolean - Use servers in the USA only?
    def opt_out_global
      @attributes[:opt_out_global]
    end

    def opt_out_global=(value)
      @attributes[:opt_out_global] = value
    end

    # boolean - Is this site's billing overdue?
    def overdue
      @attributes[:overdue]
    end

    def overdue=(value)
      @attributes[:overdue] = value
    end

    # int64 - Shortest password length for users
    def password_min_length
      @attributes[:password_min_length]
    end

    def password_min_length=(value)
      @attributes[:password_min_length] = value
    end

    # boolean - Require a letter in passwords?
    def password_require_letter
      @attributes[:password_require_letter]
    end

    def password_require_letter=(value)
      @attributes[:password_require_letter] = value
    end

    # boolean - Require lower and upper case letters in passwords?
    def password_require_mixed
      @attributes[:password_require_mixed]
    end

    def password_require_mixed=(value)
      @attributes[:password_require_mixed] = value
    end

    # boolean - Require a number in passwords?
    def password_require_number
      @attributes[:password_require_number]
    end

    def password_require_number=(value)
      @attributes[:password_require_number] = value
    end

    # boolean - Require special characters in password?
    def password_require_special
      @attributes[:password_require_special]
    end

    def password_require_special=(value)
      @attributes[:password_require_special] = value
    end

    # boolean - Require passwords that have not been previously breached? (see https://haveibeenpwned.com/)
    def password_require_unbreached
      @attributes[:password_require_unbreached]
    end

    def password_require_unbreached=(value)
      @attributes[:password_require_unbreached] = value
    end

    # boolean - Require bundles' passwords, and passwords for other items (inboxes, public shares, etc.) to conform to the same requirements as users' passwords?
    def password_requirements_apply_to_bundles
      @attributes[:password_requirements_apply_to_bundles]
    end

    def password_requirements_apply_to_bundles=(value)
      @attributes[:password_requirements_apply_to_bundles] = value
    end

    # int64 - Number of days password is valid
    def password_validity_days
      @attributes[:password_validity_days]
    end

    def password_validity_days=(value)
      @attributes[:password_validity_days] = value
    end

    # string - Site phone number
    def phone
      @attributes[:phone]
    end

    def phone=(value)
      @attributes[:phone] = value
    end

    # boolean - If true, we will ensure that all internal communications with any remote server are made through the primary region of the site. This setting overrides individual remote server settings.
    def pin_all_remote_servers_to_site_region
      @attributes[:pin_all_remote_servers_to_site_region]
    end

    def pin_all_remote_servers_to_site_region=(value)
      @attributes[:pin_all_remote_servers_to_site_region] = value
    end

    # boolean - If true, we will prevent non-administrators from receiving any permissions directly on the root folder.  This is commonly used to prevent the accidental application of permissions.
    def prevent_root_permissions_for_non_site_admins
      @attributes[:prevent_root_permissions_for_non_site_admins]
    end

    def prevent_root_permissions_for_non_site_admins=(value)
      @attributes[:prevent_root_permissions_for_non_site_admins] = value
    end

    # boolean - If true, protocol access permissions on users will be ignored, and only protocol access permissions set on Groups will be honored.  Make sure that your current user is a member of a group with API permission when changing this value to avoid locking yourself out of your site.
    def protocol_access_groups_only
      @attributes[:protocol_access_groups_only]
    end

    def protocol_access_groups_only=(value)
      @attributes[:protocol_access_groups_only] = value
    end

    # boolean - Require two-factor authentication for all users?
    def require_2fa
      @attributes[:require_2fa]
    end

    def require_2fa=(value)
      @attributes[:require_2fa] = value
    end

    # boolean - If true, SSO users using the default user-level two-factor authentication setting are exempt from the site-wide two-factor authentication requirement.
    def require_2fa_exempt_all_sso_users
      @attributes[:require_2fa_exempt_all_sso_users]
    end

    def require_2fa_exempt_all_sso_users=(value)
      @attributes[:require_2fa_exempt_all_sso_users] = value
    end

    # date-time - If set, requirement for two-factor authentication has been scheduled to end on this date-time.
    def require_2fa_stop_time
      @attributes[:require_2fa_stop_time]
    end

    def require_2fa_stop_time=(value)
      @attributes[:require_2fa_stop_time] = value
    end

    # boolean - Auto-removes bundles for disabled/deleted users and enforces bundle expiry within user access period.
    def revoke_bundle_access_on_disable_or_delete
      @attributes[:revoke_bundle_access_on_disable_or_delete]
    end

    def revoke_bundle_access_on_disable_or_delete=(value)
      @attributes[:revoke_bundle_access_on_disable_or_delete] = value
    end

    # string - What type of user is required to use two-factor authentication (when require_2fa is set to `true` for this site)?
    def require_2fa_user_type
      @attributes[:require_2fa_user_type]
    end

    def require_2fa_user_type=(value)
      @attributes[:require_2fa_user_type] = value
    end

    # boolean - If true, we will hide the 'Remember Me' box on Inbox and Bundle registration pages, requiring that the user logout and log back in every time they visit the page.
    def require_logout_from_bundles_and_inboxes
      @attributes[:require_logout_from_bundles_and_inboxes]
    end

    def require_logout_from_bundles_and_inboxes=(value)
      @attributes[:require_logout_from_bundles_and_inboxes] = value
    end

    # Session - Current session
    def session
      @attributes[:session]
    end

    def session=(value)
      @attributes[:session] = value
    end

    # boolean - Is SFTP enabled?
    def sftp_enabled
      @attributes[:sftp_enabled]
    end

    def sftp_enabled=(value)
      @attributes[:sftp_enabled] = value
    end

    # boolean - Finalize partial SFTP uploads from interrupted connections? Default: true.
    def sftp_finalize_partial_uploads
      @attributes[:sftp_finalize_partial_uploads]
    end

    def sftp_finalize_partial_uploads=(value)
      @attributes[:sftp_finalize_partial_uploads] = value
    end

    # string - Sftp Host Key Type
    def sftp_host_key_type
      @attributes[:sftp_host_key_type]
    end

    def sftp_host_key_type=(value)
      @attributes[:sftp_host_key_type] = value
    end

    # int64 - Id of the currently selected custom SFTP Host Key
    def active_sftp_host_key_id
      @attributes[:active_sftp_host_key_id]
    end

    def active_sftp_host_key_id=(value)
      @attributes[:active_sftp_host_key_id] = value
    end

    # boolean - If true, we will allow weak and known insecure ciphers to be used for SFTP connections.  Enabling this setting severely weakens the security of your site and it is not recommend, except as a last resort for compatibility.
    def sftp_insecure_ciphers
      @attributes[:sftp_insecure_ciphers]
    end

    def sftp_insecure_ciphers=(value)
      @attributes[:sftp_insecure_ciphers] = value
    end

    # boolean - If true, we will allow weak Diffie Hellman parameters to be used within ciphers for SFTP that are otherwise on our secure list.  This has the effect of making the cipher weaker than our normal threshold for security, but is required to support certain legacy or broken SSH and MFT clients.  Enabling this weakens security, but not nearly as much as enabling the full `sftp_insecure_ciphers` option.
    def sftp_insecure_diffie_hellman
      @attributes[:sftp_insecure_diffie_hellman]
    end

    def sftp_insecure_diffie_hellman=(value)
      @attributes[:sftp_insecure_diffie_hellman] = value
    end

    # boolean - Use user FTP roots also for SFTP?
    def sftp_user_root_enabled
      @attributes[:sftp_user_root_enabled]
    end

    def sftp_user_root_enabled=(value)
      @attributes[:sftp_user_root_enabled] = value
    end

    # boolean - Allow bundle creation
    def sharing_enabled
      @attributes[:sharing_enabled]
    end

    def sharing_enabled=(value)
      @attributes[:sharing_enabled] = value
    end

    # boolean - Show log in link in user notifications?
    def show_user_notifications_log_in_link
      @attributes[:show_user_notifications_log_in_link]
    end

    def show_user_notifications_log_in_link=(value)
      @attributes[:show_user_notifications_log_in_link] = value
    end

    # boolean - Show request access link for users without access?  Currently unused.
    def show_request_access_link
      @attributes[:show_request_access_link]
    end

    def show_request_access_link=(value)
      @attributes[:show_request_access_link] = value
    end

    # string - Custom site footer text for authenticated pages
    def site_footer
      @attributes[:site_footer]
    end

    def site_footer=(value)
      @attributes[:site_footer] = value
    end

    # string - Custom site header text for authenticated pages
    def site_header
      @attributes[:site_header]
    end

    def site_header=(value)
      @attributes[:site_header] = value
    end

    # string - Custom site footer text for public pages
    def site_public_footer
      @attributes[:site_public_footer]
    end

    def site_public_footer=(value)
      @attributes[:site_public_footer] = value
    end

    # string - Custom site header text for public pages
    def site_public_header
      @attributes[:site_public_header]
    end

    def site_public_header=(value)
      @attributes[:site_public_header] = value
    end

    # string - SMTP server hostname or IP
    def smtp_address
      @attributes[:smtp_address]
    end

    def smtp_address=(value)
      @attributes[:smtp_address] = value
    end

    # string - SMTP server authentication type
    def smtp_authentication
      @attributes[:smtp_authentication]
    end

    def smtp_authentication=(value)
      @attributes[:smtp_authentication] = value
    end

    # string - From address to use when mailing through custom SMTP
    def smtp_from
      @attributes[:smtp_from]
    end

    def smtp_from=(value)
      @attributes[:smtp_from] = value
    end

    # int64 - SMTP server port
    def smtp_port
      @attributes[:smtp_port]
    end

    def smtp_port=(value)
      @attributes[:smtp_port] = value
    end

    # string - SMTP server username
    def smtp_username
      @attributes[:smtp_username]
    end

    def smtp_username=(value)
      @attributes[:smtp_username] = value
    end

    # int64 - Session expiry in minutes
    def session_expiry_minutes
      @attributes[:session_expiry_minutes]
    end

    def session_expiry_minutes=(value)
      @attributes[:session_expiry_minutes] = value
    end

    # boolean - Allow snapshot share links creation
    def snapshot_sharing_enabled
      @attributes[:snapshot_sharing_enabled]
    end

    def snapshot_sharing_enabled=(value)
      @attributes[:snapshot_sharing_enabled] = value
    end

    # boolean - Is SSL required?  Disabling this is insecure.
    def ssl_required
      @attributes[:ssl_required]
    end

    def ssl_required=(value)
      @attributes[:ssl_required] = value
    end

    # string - Site subdomain
    def subdomain
      @attributes[:subdomain]
    end

    def subdomain=(value)
      @attributes[:subdomain] = value
    end

    # date-time - If switching plans, when does the new plan take effect?
    def switch_to_plan_date
      @attributes[:switch_to_plan_date]
    end

    def switch_to_plan_date=(value)
      @attributes[:switch_to_plan_date] = value
    end

    # int64 - Number of days left in trial
    def trial_days_left
      @attributes[:trial_days_left]
    end

    def trial_days_left=(value)
      @attributes[:trial_days_left] = value
    end

    # date-time - When does this Site trial expire?
    def trial_until
      @attributes[:trial_until]
    end

    def trial_until=(value)
      @attributes[:trial_until] = value
    end

    # boolean - If using custom SMTP, should we use dedicated IPs to deliver emails?
    def use_dedicated_ips_for_smtp
      @attributes[:use_dedicated_ips_for_smtp]
    end

    def use_dedicated_ips_for_smtp=(value)
      @attributes[:use_dedicated_ips_for_smtp] = value
    end

    # boolean - Allow uploaders to set `provided_modified_at` for uploaded files?
    def use_provided_modified_at
      @attributes[:use_provided_modified_at]
    end

    def use_provided_modified_at=(value)
      @attributes[:use_provided_modified_at] = value
    end

    # User - User of current session
    def user
      @attributes[:user]
    end

    def user=(value)
      @attributes[:user] = value
    end

    # boolean - Will users be locked out after incorrect login attempts?
    def user_lockout
      @attributes[:user_lockout]
    end

    def user_lockout=(value)
      @attributes[:user_lockout] = value
    end

    # int64 - How many hours to lock user out for failed password?
    def user_lockout_lock_period
      @attributes[:user_lockout_lock_period]
    end

    def user_lockout_lock_period=(value)
      @attributes[:user_lockout_lock_period] = value
    end

    # int64 - Number of login tries within `user_lockout_within` hours before users are locked out
    def user_lockout_tries
      @attributes[:user_lockout_tries]
    end

    def user_lockout_tries=(value)
      @attributes[:user_lockout_tries] = value
    end

    # int64 - Number of hours for user lockout window
    def user_lockout_within
      @attributes[:user_lockout_within]
    end

    def user_lockout_within=(value)
      @attributes[:user_lockout_within] = value
    end

    # boolean - Enable User Requests feature
    def user_requests_enabled
      @attributes[:user_requests_enabled]
    end

    def user_requests_enabled=(value)
      @attributes[:user_requests_enabled] = value
    end

    # boolean - Send email to site admins when a user request is received?
    def user_requests_notify_admins
      @attributes[:user_requests_notify_admins]
    end

    def user_requests_notify_admins=(value)
      @attributes[:user_requests_notify_admins] = value
    end

    # boolean - Allow users to create their own API keys?
    def users_can_create_api_keys
      @attributes[:users_can_create_api_keys]
    end

    def users_can_create_api_keys=(value)
      @attributes[:users_can_create_api_keys] = value
    end

    # boolean - Allow users to create their own SSH keys?
    def users_can_create_ssh_keys
      @attributes[:users_can_create_ssh_keys]
    end

    def users_can_create_ssh_keys=(value)
      @attributes[:users_can_create_ssh_keys] = value
    end

    # string - How usernames are displayed in the web UI. Can be `username_only`, `full_name_only`, `full_name_username`, `full_name_company`, or `full_name_username_company`.
    def username_display
      @attributes[:username_display]
    end

    def username_display=(value)
      @attributes[:username_display] = value
    end

    # string - Custom text send in user welcome email
    def welcome_custom_text
      @attributes[:welcome_custom_text]
    end

    def welcome_custom_text=(value)
      @attributes[:welcome_custom_text] = value
    end

    # string - Custom footer text for system-generated emails. Supports standard strftime date/time patterns like %Y (4-digit year), %m (month), %d (day).
    def email_footer_custom_text
      @attributes[:email_footer_custom_text]
    end

    def email_footer_custom_text=(value)
      @attributes[:email_footer_custom_text] = value
    end

    # email - Include this email in welcome emails if enabled
    def welcome_email_cc
      @attributes[:welcome_email_cc]
    end

    def welcome_email_cc=(value)
      @attributes[:welcome_email_cc] = value
    end

    # string - Include this email subject in welcome emails if enabled
    def welcome_email_subject
      @attributes[:welcome_email_subject]
    end

    def welcome_email_subject=(value)
      @attributes[:welcome_email_subject] = value
    end

    # boolean - Will the welcome email be sent to new users?
    def welcome_email_enabled
      @attributes[:welcome_email_enabled]
    end

    def welcome_email_enabled=(value)
      @attributes[:welcome_email_enabled] = value
    end

    # string - Does the welcome screen appear?
    def welcome_screen
      @attributes[:welcome_screen]
    end

    def welcome_screen=(value)
      @attributes[:welcome_screen] = value
    end

    # boolean - Does FTP user Windows emulation mode?
    def windows_mode_ftp
      @attributes[:windows_mode_ftp]
    end

    def windows_mode_ftp=(value)
      @attributes[:windows_mode_ftp] = value
    end

    # string
    def username
      @attributes[:username]
    end

    def username=(value)
      @attributes[:username] = value
    end

    # string
    def password
      @attributes[:password]
    end

    def password=(value)
      @attributes[:password] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The StagingSite object doesn't support updates.")
      else
        new_obj = StagingSite.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(Site, params) do
        Api.send_request("/staging_sites", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   name (required) - string
    #   email (required) - string
    #   username - string
    #   password - string
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]
      raise MissingParameterError.new("Parameter missing: email") unless params[:email]

      response, options = Api.send_request("/staging_sites", :post, params, options)
      Site.new(response.data, options)
    end

    def self.create_export(params = {}, options = {})
      response, options = Api.send_request("/staging_sites/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
