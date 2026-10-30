# frozen_string_literal: true

require "bigdecimal"

module Files
  # Files::Site is the Ruby SDK's representation of Files.com API Site objects.
  # Each instance keeps its API field values in +attributes+.
  class Site
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

    # Site Id
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Site name
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Additional extensions that are considered text files
    # @return [Array<String>, nil] the field value, or nil when absent.
    def additional_text_file_types
      @attributes[:additional_text_file_types]
    end

    # Availability settings for AI features. Each feature requires the site_admins, workspace_admins, folder_admins, and all_users keys. Optional selected_group_members defaults to false; when true, members of at least one group in group_ids get access regardless of the other options. All availability options are additive: any enabled option matching the user grants access. Optional group_ids is an array of integer IDs of active groups on this site, from any workspace. Omitted or empty group_ids grants no access through selected_group_members and does not affect other options. Disabling all AI features overrides these settings.
    # @return [Hash, nil] the field value, or nil when absent.
    def ai_feature_availability
      @attributes[:ai_feature_availability]
    end

    # Is SMS two factor authentication allowed?
    # @return [Boolean, nil] the field value, or nil when absent.
    def allowed_2fa_method_sms
      @attributes[:allowed_2fa_method_sms]
    end

    # Is TOTP two factor authentication allowed?
    # @return [Boolean, nil] the field value, or nil when absent.
    def allowed_2fa_method_totp
      @attributes[:allowed_2fa_method_totp]
    end

    # Is WebAuthn two factor authentication allowed?
    # @return [Boolean, nil] the field value, or nil when absent.
    def allowed_2fa_method_webauthn
      @attributes[:allowed_2fa_method_webauthn]
    end

    # Is yubikey two factor authentication allowed?
    # @return [Boolean, nil] the field value, or nil when absent.
    def allowed_2fa_method_yubi
      @attributes[:allowed_2fa_method_yubi]
    end

    # Is OTP via email two factor authentication allowed?
    # @return [Boolean, nil] the field value, or nil when absent.
    def allowed_2fa_method_email
      @attributes[:allowed_2fa_method_email]
    end

    # Is OTP via static codes for two factor authentication allowed?
    # @return [Boolean, nil] the field value, or nil when absent.
    def allowed_2fa_method_static
      @attributes[:allowed_2fa_method_static]
    end

    # Are users allowed to configure their two factor authentication to be bypassed for FTP/SFTP/WebDAV?
    # @return [Boolean, nil] the field value, or nil when absent.
    def allowed_2fa_method_bypass_for_ftp_sftp_dav
      @attributes[:allowed_2fa_method_bypass_for_ftp_sftp_dav]
    end

    # User ID for the main site administrator
    # @return [Integer, nil] the field value, or nil when absent.
    def admin_user_id
      @attributes[:admin_user_id]
    end

    # Allow admins to bypass the locked subfolders setting.
    # @return [Boolean, nil] the field value, or nil when absent.
    def admins_bypass_locked_subfolders
      @attributes[:admins_bypass_locked_subfolders]
    end

    # Are manual Bundle names allowed?
    # @return [Boolean, nil] the field value, or nil when absent.
    def allow_bundle_names
      @attributes[:allow_bundle_names]
    end

    # Allow the site-wide two-factor authentication requirement to be overriden on a per-user-basis?
    # @return [Boolean, nil] the field value, or nil when absent.
    def allow_user_level_2fa_override
      @attributes[:allow_user_level_2fa_override]
    end

    # Allow the site-wide allowed IP restriction to be overriden on a per-user-basis?
    # @return [Boolean, nil] the field value, or nil when absent.
    def allow_user_level_allowed_ip_override
      @attributes[:allow_user_level_allowed_ip_override]
    end

    # Allow the site-wide FTP SSL requirement to be overriden on a per-user-basis?
    # @return [Boolean, nil] the field value, or nil when absent.
    def allow_user_level_ssl_override
      @attributes[:allow_user_level_ssl_override]
    end

    # Comma separated list of allowed Country codes
    # @return [String, nil] the field value, or nil when absent.
    def allowed_countries
      @attributes[:allowed_countries]
    end

    # List of allowed IP addresses
    # @return [String, nil] the field value, or nil when absent.
    def allowed_ips
      @attributes[:allowed_ips]
    end

    # Require Parent Site users entering this Child Site to match its allowed IP addresses in addition to their existing IP restrictions. Applies to all Workspaces. Defaults to false.
    # @return [Boolean, nil] the field value, or nil when absent.
    def enforce_parent_site_user_ip_restrictions
      @attributes[:enforce_parent_site_user_ip_restrictions]
    end

    # Create parent directories if they do not exist during uploads?  This is primarily used to work around broken upload clients that assume servers will perform this step.
    # @return [Boolean, nil] the field value, or nil when absent.
    def always_mkdir_parents
      @attributes[:always_mkdir_parents]
    end

    # Number of days to retain AS2 messages (incoming and outgoing).
    # @return [Integer, nil] the field value, or nil when absent.
    def as2_message_retention_days
      @attributes[:as2_message_retention_days]
    end

    # If false, rename conflicting files instead of asking for overwrite confirmation.  Only applies to web interface.
    # @return [Boolean, nil] the field value, or nil when absent.
    def ask_about_overwrites
      @attributes[:ask_about_overwrites]
    end

    # Do Bundle owners receive activity notifications?
    # @return [String, nil] the field value, or nil when absent.
    def bundle_activity_notifications
      @attributes[:bundle_activity_notifications]
    end

    # Site-wide Bundle expiration in days
    # @return [Integer, nil] the field value, or nil when absent.
    def bundle_expiration
      @attributes[:bundle_expiration]
    end

    # Custom error message to show when bundle is not found.
    # @return [String, nil] the field value, or nil when absent.
    def bundle_not_found_message
      @attributes[:bundle_not_found_message]
    end

    # Do Bundles require password protection?
    # @return [Boolean, nil] the field value, or nil when absent.
    def bundle_password_required
      @attributes[:bundle_password_required]
    end

    # If true, new Share Links created by a user with a primary group will default to that group as owner.
    # @return [Boolean, nil] the field value, or nil when absent.
    def bundles_default_owned_by_primary_group
      @attributes[:bundles_default_owned_by_primary_group]
    end

    # List of email domains to disallow when entering a Bundle/Inbox recipients
    # @return [Array<String>, nil] the field value, or nil when absent.
    def bundle_recipient_blacklist_domains
      @attributes[:bundle_recipient_blacklist_domains]
    end

    # Disallow free email domains for Bundle/Inbox recipients?
    # @return [Boolean, nil] the field value, or nil when absent.
    def bundle_recipient_blacklist_free_email_domains
      @attributes[:bundle_recipient_blacklist_free_email_domains]
    end

    # Do Bundle owners receive registration notification?
    # @return [String, nil] the field value, or nil when absent.
    def bundle_registration_notifications
      @attributes[:bundle_registration_notifications]
    end

    # Do Bundles require registration?
    # @return [Boolean, nil] the field value, or nil when absent.
    def bundle_require_registration
      @attributes[:bundle_require_registration]
    end

    # Do Bundles require recipients for sharing?
    # @return [Boolean, nil] the field value, or nil when absent.
    def bundle_require_share_recipient
      @attributes[:bundle_require_share_recipient]
    end

    # If true, new Share Links must send a one-time password to the recipient when they register. Requires bundle_require_share_recipient and cannot be enabled with bundle_password_required.
    # @return [Boolean, nil] the field value, or nil when absent.
    def bundle_send_one_time_password_to_recipient_at_registration
      @attributes[:bundle_send_one_time_password_to_recipient_at_registration]
    end

    # Do Bundles require internal notes?
    # @return [Boolean, nil] the field value, or nil when absent.
    def bundle_require_note
      @attributes[:bundle_require_note]
    end

    # Do Bundle creators receive receipts of invitations?
    # @return [Boolean, nil] the field value, or nil when absent.
    def bundle_send_shared_receipts
      @attributes[:bundle_send_shared_receipts]
    end

    # Do Bundle uploaders receive upload confirmation notifications?
    # @return [String, nil] the field value, or nil when absent.
    def bundle_upload_receipt_notifications
      @attributes[:bundle_upload_receipt_notifications]
    end

    # Preview watermark image applied to all bundle items.
    # @return [Hash, nil] the field value, or nil when absent.
    def bundle_watermark_attachment
      @attributes[:bundle_watermark_attachment]
    end

    # Preview watermark settings applied to all bundle items. Uses the same keys as Behavior.value
    # @return [Hash, nil] the field value, or nil when absent.
    def bundle_watermark_value
      @attributes[:bundle_watermark_value]
    end

    # Calculate CRC32 checksums for files?
    # @return [Boolean, nil] the field value, or nil when absent.
    def calculate_file_checksums_crc32
      @attributes[:calculate_file_checksums_crc32]
    end

    # Calculate MD5 checksums for files?
    # @return [Boolean, nil] the field value, or nil when absent.
    def calculate_file_checksums_md5
      @attributes[:calculate_file_checksums_md5]
    end

    # Calculate SHA1 checksums for files?
    # @return [Boolean, nil] the field value, or nil when absent.
    def calculate_file_checksums_sha1
      @attributes[:calculate_file_checksums_sha1]
    end

    # Calculate SHA256 checksums for files?
    # @return [Boolean, nil] the field value, or nil when absent.
    def calculate_file_checksums_sha256
      @attributes[:calculate_file_checksums_sha256]
    end

    # If true, administrators on this site's Child Sites, including Folder Admins, can list this site's Default Workspace users and groups and grant them folder permissions and notifications on Child Site paths.
    # @return [Boolean, nil] the field value, or nil when absent.
    def child_site_folder_admins_can_see_parent_site_directory
      @attributes[:child_site_folder_admins_can_see_parent_site_directory]
    end

    # If true, Workspace Administrators and Folder Admins in a Custom Workspace can list the Default Workspace users and groups that have permissions in that Workspace and choose them as Email Notification recipients.
    # @return [Boolean, nil] the field value, or nil when absent.
    def workspace_folder_admins_can_see_default_workspace_directory
      @attributes[:workspace_folder_admins_can_see_default_workspace_directory]
    end

    # Require email authentication, virus, and spam checks for incoming emails to Inboxes and Incoming Email Automations in every Workspace on this site?
    # @return [Boolean, nil] the field value, or nil when absent.
    def uploads_via_email_authentication
      @attributes[:uploads_via_email_authentication]
    end

    # Page link and button color
    # @return [String, nil] the field value, or nil when absent.
    def color2_left
      @attributes[:color2_left]
    end

    # Top bar link color
    # @return [String, nil] the field value, or nil when absent.
    def color2_link
      @attributes[:color2_link]
    end

    # Page link and button color
    # @return [String, nil] the field value, or nil when absent.
    def color2_text
      @attributes[:color2_text]
    end

    # Top bar background color
    # @return [String, nil] the field value, or nil when absent.
    def color2_top
      @attributes[:color2_top]
    end

    # Top bar text color
    # @return [String, nil] the field value, or nil when absent.
    def color2_top_text
      @attributes[:color2_top_text]
    end

    # Site main contact name
    # @return [String, nil] the field value, or nil when absent.
    def contact_name
      @attributes[:contact_name]
    end

    # Time this site was created
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Preferred currency
    # @return [String, nil] the field value, or nil when absent.
    def currency
      @attributes[:currency]
    end

    # Is this site using a custom namespace for users?
    # @return [Boolean, nil] the field value, or nil when absent.
    def custom_namespace
      @attributes[:custom_namespace]
    end

    # Is WebDAV enabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def dav_enabled
      @attributes[:dav_enabled]
    end

    # Use user FTP roots also for WebDAV?
    # @return [Boolean, nil] the field value, or nil when absent.
    def dav_user_root_enabled
      @attributes[:dav_user_root_enabled]
    end

    # Number of days to keep deleted files
    # @return [Integer, nil] the field value, or nil when absent.
    def days_to_retain_backups
      @attributes[:days_to_retain_backups]
    end

    # If true, allow public viewers of Bundles with full permissions to use document editing integrations.
    # @return [Boolean, nil] the field value, or nil when absent.
    def document_edits_in_bundle_allowed
      @attributes[:document_edits_in_bundle_allowed]
    end

    # Site default time zone
    # @return [String, nil] the field value, or nil when absent.
    def default_time_zone
      @attributes[:default_time_zone]
    end

    # Is the desktop app enabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def desktop_app
      @attributes[:desktop_app]
    end

    # Is desktop app session IP pinning enabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def desktop_app_session_ip_pinning
      @attributes[:desktop_app_session_ip_pinning]
    end

    # Desktop app session lifetime (in hours)
    # @return [Integer, nil] the field value, or nil when absent.
    def desktop_app_session_lifetime
      @attributes[:desktop_app_session_lifetime]
    end

    # Use legacy checksums mode?
    # @return [Boolean, nil] the field value, or nil when absent.
    def legacy_checksums_mode
      @attributes[:legacy_checksums_mode]
    end

    # If true, we will migrate all remote server syncs to the new Sync model.
    # @return [Boolean, nil] the field value, or nil when absent.
    def migrate_remote_server_sync_to_sync
      @attributes[:migrate_remote_server_sync_to_sync]
    end

    # Is OAuth DCR (dynamic client registration) for MCP enabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def mcp_dcr_enabled
      @attributes[:mcp_dcr_enabled]
    end

    # Is the mobile app enabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def mobile_app
      @attributes[:mobile_app]
    end

    # Is mobile app session IP pinning enabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def mobile_app_session_ip_pinning
      @attributes[:mobile_app_session_ip_pinning]
    end

    # Mobile app session lifetime (in hours)
    # @return [Integer, nil] the field value, or nil when absent.
    def mobile_app_session_lifetime
      @attributes[:mobile_app_session_lifetime]
    end

    # Comma separated list of disallowed Country codes
    # @return [String, nil] the field value, or nil when absent.
    def disallowed_countries
      @attributes[:disallowed_countries]
    end

    # If true, all AI features are disabled for this site.
    # @return [Boolean, nil] the field value, or nil when absent.
    def disable_all_ai_features
      @attributes[:disable_all_ai_features]
    end

    # If set, Files.com will not set the CAA records required to generate future SSL certificates for this domain.
    # @return [Boolean, nil] the field value, or nil when absent.
    def disable_files_certificate_generation
      @attributes[:disable_files_certificate_generation]
    end

    # Are notifications disabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def disable_notifications
      @attributes[:disable_notifications]
    end

    # If true, file operations produce file_action.activity.v1 EventChannel events in all workspaces. Defaults to false; subscription filters and workspace access still control delivery.
    # @return [Boolean, nil] the field value, or nil when absent.
    def file_activity_events_enabled
      @attributes[:file_activity_events_enabled]
    end

    # Is password reset disabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def disable_password_reset
      @attributes[:disable_password_reset]
    end

    # Custom domain
    # @return [String, nil] the field value, or nil when absent.
    def domain
      @attributes[:domain]
    end

    # Send HSTS (HTTP Strict Transport Security) header when visitors access the site via a custom domain?
    # @return [Boolean, nil] the field value, or nil when absent.
    def domain_hsts_header
      @attributes[:domain_hsts_header]
    end

    # Letsencrypt chain to use when registering SSL Certificate for domain. No longer used as of 2026.
    # @return [String, nil] the field value, or nil when absent.
    def domain_letsencrypt_chain
      @attributes[:domain_letsencrypt_chain]
    end

    # Main email for this site
    # @return [Hash, nil] the field value, or nil when absent.
    def email
      @attributes[:email]
    end

    # Are FedRAMP security restrictions enabled for this site?
    # @return [Boolean, nil] the field value, or nil when absent.
    def fedramp
      @attributes[:fedramp]
    end

    # Allow other Files.com sites to use this site's API keys for native Files.com Remote Server connections? Defaults to true and applies to all keys and workspaces on this site. When false, new pairings and access through existing connections are rejected without revoking keys or deleting connections. Re-enabling permits access again with usable keys. Does not disable this site's connections to other sites, ordinary API access, or Connected Sites.
    # @return [Boolean, nil] the field value, or nil when absent.
    def files_com_remote_server_enabled
      @attributes[:files_com_remote_server_enabled]
    end

    # Is FTP enabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def ftp_enabled
      @attributes[:ftp_enabled]
    end

    # Reply-to email for this site
    # @return [Hash, nil] the field value, or nil when absent.
    def reply_to_email
      @attributes[:reply_to_email]
    end

    # If true, groups can be manually created / modified / deleted by Site Admins. Otherwise, groups can only be managed via your SSO provider.
    # @return [Boolean, nil] the field value, or nil when absent.
    def non_sso_groups_allowed
      @attributes[:non_sso_groups_allowed]
    end

    # If true, users can be manually created / modified / deleted by Site Admins. Otherwise, users can only be managed via your SSO provider.
    # @return [Boolean, nil] the field value, or nil when absent.
    def non_sso_users_allowed
      @attributes[:non_sso_users_allowed]
    end

    # If true, permissions for this site must be bound to a group (not a user).
    # @return [Boolean, nil] the field value, or nil when absent.
    def folder_permissions_groups_only
      @attributes[:folder_permissions_groups_only]
    end

    # Allow group admins to create users in their groups
    # @return [Boolean, nil] the field value, or nil when absent.
    def group_admins_can_add_users
      @attributes[:group_admins_can_add_users]
    end

    # Allow group admins to add or remove existing users in their groups
    # @return [Boolean, nil] the field value, or nil when absent.
    def group_admins_can_manage_group_memberships
      @attributes[:group_admins_can_manage_group_memberships]
    end

    # Allow group admins to delete users in their groups
    # @return [Boolean, nil] the field value, or nil when absent.
    def group_admins_can_delete_users
      @attributes[:group_admins_can_delete_users]
    end

    # Allow group admins to enable or disable users in their groups
    # @return [Boolean, nil] the field value, or nil when absent.
    def group_admins_can_enable_disable_users
      @attributes[:group_admins_can_enable_disable_users]
    end

    # Allow group admins to modify users in their groups
    # @return [Boolean, nil] the field value, or nil when absent.
    def group_admins_can_modify_users
      @attributes[:group_admins_can_modify_users]
    end

    # Allow group admins to exempt users in their groups from lifecycle rules
    # @return [Boolean, nil] the field value, or nil when absent.
    def group_admins_can_bypass_user_lifecycle_rules
      @attributes[:group_admins_can_bypass_user_lifecycle_rules]
    end

    # Allow group admins to reset passwords for users in their groups
    # @return [Boolean, nil] the field value, or nil when absent.
    def group_admins_can_reset_passwords
      @attributes[:group_admins_can_reset_passwords]
    end

    # Allow group admins to set password authentication method
    # @return [Boolean, nil] the field value, or nil when absent.
    def group_admins_can_set_user_password
      @attributes[:group_admins_can_set_user_password]
    end

    # Is there a signed HIPAA BAA between Files.com and this site?
    # @return [Boolean, nil] the field value, or nil when absent.
    def hipaa
      @attributes[:hipaa]
    end

    # Branded icon 128x128
    # @return [Hash, nil] the field value, or nil when absent.
    def icon128
      @attributes[:icon128]
    end

    # Branded icon 16x16
    # @return [Hash, nil] the field value, or nil when absent.
    def icon16
      @attributes[:icon16]
    end

    # Branded icon 32x32
    # @return [Hash, nil] the field value, or nil when absent.
    def icon32
      @attributes[:icon32]
    end

    # Branded icon 48x48
    # @return [Hash, nil] the field value, or nil when absent.
    def icon48
      @attributes[:icon48]
    end

    # Can files be modified?
    # @return [String, nil] the field value, or nil when absent.
    def immutable_files_set_at
      @attributes[:immutable_files_set_at]
    end

    # Include password in emails to new users?
    # @return [Boolean, nil] the field value, or nil when absent.
    def include_password_in_welcome_email
      @attributes[:include_password_in_welcome_email]
    end

    # Site default language
    # @return [String, nil] the field value, or nil when absent.
    def language
      @attributes[:language]
    end

    # Base DN for looking up users in LDAP server
    # @return [String, nil] the field value, or nil when absent.
    def ldap_base_dn
      @attributes[:ldap_base_dn]
    end

    # Domain name that will be appended to usernames
    # @return [String, nil] the field value, or nil when absent.
    def ldap_domain
      @attributes[:ldap_domain]
    end

    # Main LDAP setting: is LDAP enabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def ldap_enabled
      @attributes[:ldap_enabled]
    end

    # Should we sync groups from LDAP server?
    # @return [String, nil] the field value, or nil when absent.
    def ldap_group_action
      @attributes[:ldap_group_action]
    end

    # Comma or newline separated list of group names (with optional wildcards) to exclude when syncing.
    # @return [String, nil] the field value, or nil when absent.
    def ldap_group_exclusion
      @attributes[:ldap_group_exclusion]
    end

    # Comma or newline separated list of group names (with optional wildcards) to include when syncing.
    # @return [String, nil] the field value, or nil when absent.
    def ldap_group_inclusion
      @attributes[:ldap_group_inclusion]
    end

    # LDAP host
    # @return [String, nil] the field value, or nil when absent.
    def ldap_host
      @attributes[:ldap_host]
    end

    # LDAP backup host
    # @return [String, nil] the field value, or nil when absent.
    def ldap_host_2
      @attributes[:ldap_host_2]
    end

    # LDAP backup host
    # @return [String, nil] the field value, or nil when absent.
    def ldap_host_3
      @attributes[:ldap_host_3]
    end

    # LDAP port
    # @return [Integer, nil] the field value, or nil when absent.
    def ldap_port
      @attributes[:ldap_port]
    end

    # Use secure LDAP?
    # @return [Boolean, nil] the field value, or nil when absent.
    def ldap_secure
      @attributes[:ldap_secure]
    end

    # How to validate the LDAP server certificate. `require_match` validates the certificate chain and hostname; `allow_any` disables certificate validation.
    # @return [String, nil] the field value, or nil when absent.
    def ldap_server_certificate
      @attributes[:ldap_server_certificate]
    end

    # LDAP type
    # @return [String, nil] the field value, or nil when absent.
    def ldap_type
      @attributes[:ldap_type]
    end

    # Should we sync users from LDAP server?
    # @return [String, nil] the field value, or nil when absent.
    def ldap_user_action
      @attributes[:ldap_user_action]
    end

    # Comma or newline separated list of group names (with optional wildcards) - if provided, only users in these groups will be added or synced.
    # @return [String, nil] the field value, or nil when absent.
    def ldap_user_include_groups
      @attributes[:ldap_user_include_groups]
    end

    # Username for signing in to LDAP server.
    # @return [String, nil] the field value, or nil when absent.
    def ldap_username
      @attributes[:ldap_username]
    end

    # LDAP username field
    # @return [String, nil] the field value, or nil when absent.
    def ldap_username_field
      @attributes[:ldap_username_field]
    end

    # Login help text
    # @return [String, nil] the field value, or nil when absent.
    def login_help_text
      @attributes[:login_help_text]
    end

    # Branded logo
    # @return [Hash, nil] the field value, or nil when absent.
    def logo
      @attributes[:logo]
    end

    # Branded login page background
    # @return [Hash, nil] the field value, or nil when absent.
    def login_page_background_image
      @attributes[:login_page_background_image]
    end

    # Number of prior passwords to disallow
    # @return [Integer, nil] the field value, or nil when absent.
    def max_prior_passwords
      @attributes[:max_prior_passwords]
    end

    # Site settings managed by the parent site. Each key identifies a managed setting, with a null value. Non-secret effective values are returned in their own Site settings fields.
    # @return [Hash, nil] the field value, or nil when absent.
    def managed_site_settings
      @attributes[:managed_site_settings]
    end

    # A message to show users when they connect via FTP or SFTP.
    # @return [String, nil] the field value, or nil when absent.
    def motd_text
      @attributes[:motd_text]
    end

    # Show message to users connecting via FTP
    # @return [Boolean, nil] the field value, or nil when absent.
    def motd_use_for_ftp
      @attributes[:motd_use_for_ftp]
    end

    # Show message to users connecting via SFTP
    # @return [Boolean, nil] the field value, or nil when absent.
    def motd_use_for_sftp
      @attributes[:motd_use_for_sftp]
    end

    # Next billing amount
    # @return [BigDecimal, nil] the field value, or nil when absent.
    def next_billing_amount
      value = @attributes[:next_billing_amount]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    # Next billing date
    # @return [String, nil] the field value, or nil when absent.
    def next_billing_date
      @attributes[:next_billing_date]
    end

    # If true, allows users to use a document editing integration.
    # @return [Boolean, nil] the field value, or nil when absent.
    def office_integration_available
      @attributes[:office_integration_available]
    end

    # Which document editing integration to support. Files.com Editor or Microsoft Office for the Web.
    # @return [String, nil] the field value, or nil when absent.
    def office_integration_type
      @attributes[:office_integration_type]
    end

    # Link to scheduling a meeting with our Sales team
    # @return [String, nil] the field value, or nil when absent.
    def oncehub_link
      @attributes[:oncehub_link]
    end

    # Use servers in the USA only?
    # @return [Boolean, nil] the field value, or nil when absent.
    def opt_out_global
      @attributes[:opt_out_global]
    end

    # Is this site's billing overdue?
    # @return [Boolean, nil] the field value, or nil when absent.
    def overdue
      @attributes[:overdue]
    end

    # Shortest password length for users
    # @return [Integer, nil] the field value, or nil when absent.
    def password_min_length
      @attributes[:password_min_length]
    end

    # Require a letter in passwords?
    # @return [Boolean, nil] the field value, or nil when absent.
    def password_require_letter
      @attributes[:password_require_letter]
    end

    # Require lower and upper case letters in passwords?
    # @return [Boolean, nil] the field value, or nil when absent.
    def password_require_mixed
      @attributes[:password_require_mixed]
    end

    # Require a number in passwords?
    # @return [Boolean, nil] the field value, or nil when absent.
    def password_require_number
      @attributes[:password_require_number]
    end

    # Require special characters in password?
    # @return [Boolean, nil] the field value, or nil when absent.
    def password_require_special
      @attributes[:password_require_special]
    end

    # Require passwords that have not been previously breached? (see https://haveibeenpwned.com/)
    # @return [Boolean, nil] the field value, or nil when absent.
    def password_require_unbreached
      @attributes[:password_require_unbreached]
    end

    # Require bundles' passwords, and passwords for other items (inboxes, public shares, etc.) to conform to the same requirements as users' passwords?
    # @return [Boolean, nil] the field value, or nil when absent.
    def password_requirements_apply_to_bundles
      @attributes[:password_requirements_apply_to_bundles]
    end

    # Number of days password is valid
    # @return [Integer, nil] the field value, or nil when absent.
    def password_validity_days
      @attributes[:password_validity_days]
    end

    # Site phone number
    # @return [String, nil] the field value, or nil when absent.
    def phone
      @attributes[:phone]
    end

    # If true, we will ensure that all internal communications with any remote server are made through the primary region of the site. This setting overrides individual remote server settings.
    # @return [Boolean, nil] the field value, or nil when absent.
    def pin_all_remote_servers_to_site_region
      @attributes[:pin_all_remote_servers_to_site_region]
    end

    # If true, we will prevent non-administrators from receiving any permissions directly on the root folder.  This is commonly used to prevent the accidental application of permissions.
    # @return [Boolean, nil] the field value, or nil when absent.
    def prevent_root_permissions_for_non_site_admins
      @attributes[:prevent_root_permissions_for_non_site_admins]
    end

    # If true, protocol access permissions on users will be ignored, and only protocol access permissions set on Groups will be honored.  Make sure that your current user is a member of a group with API permission when changing this value to avoid locking yourself out of your site.
    # @return [Boolean, nil] the field value, or nil when absent.
    def protocol_access_groups_only
      @attributes[:protocol_access_groups_only]
    end

    # Require two-factor authentication for all users?
    # @return [Boolean, nil] the field value, or nil when absent.
    def require_2fa
      @attributes[:require_2fa]
    end

    # If true, only site admins may create, modify, or delete any behavior at the site root, or a skip that would disable one.
    # @return [Boolean, nil] the field value, or nil when absent.
    def restrict_root_folder_behaviors_to_site_admins
      @attributes[:restrict_root_folder_behaviors_to_site_admins]
    end

    # If true, supported protective behaviors at the site root also apply within named workspaces. Requires restrict_root_folder_behaviors_to_site_admins to be enabled.
    # @return [Boolean, nil] the field value, or nil when absent.
    def root_folder_behaviors_apply_to_workspaces
      @attributes[:root_folder_behaviors_apply_to_workspaces]
    end

    # If true, SSO users using the default user-level two-factor authentication setting are exempt from the site-wide two-factor authentication requirement.
    # @return [Boolean, nil] the field value, or nil when absent.
    def require_2fa_exempt_all_sso_users
      @attributes[:require_2fa_exempt_all_sso_users]
    end

    # If set, requirement for two-factor authentication has been scheduled to end on this date-time.
    # @return [String, nil] the field value, or nil when absent.
    def require_2fa_stop_time
      @attributes[:require_2fa_stop_time]
    end

    # Auto-removes bundles for disabled/deleted users and enforces bundle expiry within user access period.
    # @return [Boolean, nil] the field value, or nil when absent.
    def revoke_bundle_access_on_disable_or_delete
      @attributes[:revoke_bundle_access_on_disable_or_delete]
    end

    # What type of user is required to use two-factor authentication (when require_2fa is set to `true` for this site)?
    # @return [String, nil] the field value, or nil when absent.
    def require_2fa_user_type
      @attributes[:require_2fa_user_type]
    end

    # If true, we will hide the 'Remember Me' box on Inbox and Bundle registration pages, requiring that the user logout and log back in every time they visit the page.
    # @return [Boolean, nil] the field value, or nil when absent.
    def require_logout_from_bundles_and_inboxes
      @attributes[:require_logout_from_bundles_and_inboxes]
    end

    # Current session
    # @return [Hash, nil] the field value, or nil when absent.
    def session
      @attributes[:session]
    end

    # Is the S3-compatible endpoint enabled for all users and workspaces on this site? Defaults to true. When false, user and group S3 permissions do not allow access.
    # @return [Boolean, nil] the field value, or nil when absent.
    def s3_compatible_endpoint_enabled
      @attributes[:s3_compatible_endpoint_enabled]
    end

    # Is SFTP enabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def sftp_enabled
      @attributes[:sftp_enabled]
    end

    # Finalize partial SFTP uploads from interrupted connections? Default: true.
    # @return [Boolean, nil] the field value, or nil when absent.
    def sftp_finalize_partial_uploads
      @attributes[:sftp_finalize_partial_uploads]
    end

    # Sftp Host Key Type
    # @return [String, nil] the field value, or nil when absent.
    def sftp_host_key_type
      @attributes[:sftp_host_key_type]
    end

    # Id of the currently selected custom SFTP Host Key
    # @return [Integer, nil] the field value, or nil when absent.
    def active_sftp_host_key_id
      @attributes[:active_sftp_host_key_id]
    end

    # Ids of the selected custom SFTP Host Keys
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def active_sftp_host_key_ids
      @attributes[:active_sftp_host_key_ids]
    end

    # If true, we will allow weak and known insecure ciphers to be used for SFTP connections.  Enabling this setting severely weakens the security of your site and it is not recommend, except as a last resort for compatibility.
    # @return [Boolean, nil] the field value, or nil when absent.
    def sftp_insecure_ciphers
      @attributes[:sftp_insecure_ciphers]
    end

    # If true, we will allow weak Diffie Hellman parameters to be used within ciphers for SFTP that are otherwise on our secure list.  This has the effect of making the cipher weaker than our normal threshold for security, but is required to support certain legacy or broken SSH and MFT clients.  Enabling this weakens security, but not nearly as much as enabling the full `sftp_insecure_ciphers` option.
    # @return [Boolean, nil] the field value, or nil when absent.
    def sftp_insecure_diffie_hellman
      @attributes[:sftp_insecure_diffie_hellman]
    end

    # Use user FTP roots also for SFTP?
    # @return [Boolean, nil] the field value, or nil when absent.
    def sftp_user_root_enabled
      @attributes[:sftp_user_root_enabled]
    end

    # Allow bundle creation
    # @return [Boolean, nil] the field value, or nil when absent.
    def sharing_enabled
      @attributes[:sharing_enabled]
    end

    # Show log in link in user notifications?
    # @return [Boolean, nil] the field value, or nil when absent.
    def show_user_notifications_log_in_link
      @attributes[:show_user_notifications_log_in_link]
    end

    # Show request access link for users without access?  Currently unused.
    # @return [Boolean, nil] the field value, or nil when absent.
    def show_request_access_link
      @attributes[:show_request_access_link]
    end

    # Custom site footer text for authenticated pages
    # @return [String, nil] the field value, or nil when absent.
    def site_footer
      @attributes[:site_footer]
    end

    # Custom site header text for authenticated pages
    # @return [String, nil] the field value, or nil when absent.
    def site_header
      @attributes[:site_header]
    end

    # Custom site footer text for public pages
    # @return [String, nil] the field value, or nil when absent.
    def site_public_footer
      @attributes[:site_public_footer]
    end

    # Custom site header text for public pages
    # @return [String, nil] the field value, or nil when absent.
    def site_public_header
      @attributes[:site_public_header]
    end

    # SMTP server hostname or IP
    # @return [String, nil] the field value, or nil when absent.
    def smtp_address
      @attributes[:smtp_address]
    end

    # SMTP server authentication type
    # @return [String, nil] the field value, or nil when absent.
    def smtp_authentication
      @attributes[:smtp_authentication]
    end

    # From address to use when mailing through custom SMTP
    # @return [String, nil] the field value, or nil when absent.
    def smtp_from
      @attributes[:smtp_from]
    end

    # SMTP server port
    # @return [Integer, nil] the field value, or nil when absent.
    def smtp_port
      @attributes[:smtp_port]
    end

    # Custom SMTP encryption mode: if_available (default) uses STARTTLS when offered and otherwise sends credentials and messages unencrypted. A certificate-verified STARTTLS connection automatically changes if_available to require unless smtp_ssl is managed by a parent policy. require requires STARTTLS before authentication; require_implicit uses TLS from connection start; never disables TLS. TLS verifies the server certificate against smtp_address. Encryption is never automatically downgraded.
    # @return [String, nil] the field value, or nil when absent.
    def smtp_ssl
      @attributes[:smtp_ssl]
    end

    # SMTP server username
    # @return [String, nil] the field value, or nil when absent.
    def smtp_username
      @attributes[:smtp_username]
    end

    # Session expiry in minutes
    # @return [Integer, nil] the field value, or nil when absent.
    def session_expiry_minutes
      @attributes[:session_expiry_minutes]
    end

    # Allow snapshot share links creation
    # @return [Boolean, nil] the field value, or nil when absent.
    def snapshot_sharing_enabled
      @attributes[:snapshot_sharing_enabled]
    end

    # Is SSL required?  Disabling this is insecure.
    # @return [Boolean, nil] the field value, or nil when absent.
    def ssl_required
      @attributes[:ssl_required]
    end

    # Site subdomain
    # @return [String, nil] the field value, or nil when absent.
    def subdomain
      @attributes[:subdomain]
    end

    # If switching plans, when does the new plan take effect?
    # @return [String, nil] the field value, or nil when absent.
    def switch_to_plan_date
      @attributes[:switch_to_plan_date]
    end

    # Number of days left in trial
    # @return [Integer, nil] the field value, or nil when absent.
    def trial_days_left
      @attributes[:trial_days_left]
    end

    # When does this Site trial expire?
    # @return [String, nil] the field value, or nil when absent.
    def trial_until
      @attributes[:trial_until]
    end

    # If using custom SMTP, should we use dedicated IPs to deliver emails?
    # @return [Boolean, nil] the field value, or nil when absent.
    def use_dedicated_ips_for_smtp
      @attributes[:use_dedicated_ips_for_smtp]
    end

    # Allow uploaders to set `provided_modified_at` for uploaded files?
    # @return [Boolean, nil] the field value, or nil when absent.
    def use_provided_modified_at
      @attributes[:use_provided_modified_at]
    end

    # User of current session
    # @return [Hash, nil] the field value, or nil when absent.
    def user
      @attributes[:user]
    end

    # Will users be locked out after incorrect login attempts?
    # @return [Boolean, nil] the field value, or nil when absent.
    def user_lockout
      @attributes[:user_lockout]
    end

    # How many hours to lock user out for failed password?
    # @return [Integer, nil] the field value, or nil when absent.
    def user_lockout_lock_period
      @attributes[:user_lockout_lock_period]
    end

    # Number of login tries within `user_lockout_within` hours before users are locked out
    # @return [Integer, nil] the field value, or nil when absent.
    def user_lockout_tries
      @attributes[:user_lockout_tries]
    end

    # Number of hours for user lockout window
    # @return [Integer, nil] the field value, or nil when absent.
    def user_lockout_within
      @attributes[:user_lockout_within]
    end

    # Enable User Requests feature
    # @return [Boolean, nil] the field value, or nil when absent.
    def user_requests_enabled
      @attributes[:user_requests_enabled]
    end

    # Send email to site admins when a user request is received?
    # @return [Boolean, nil] the field value, or nil when absent.
    def user_requests_notify_admins
      @attributes[:user_requests_notify_admins]
    end

    # Allow users to create their own API keys?
    # @return [Boolean, nil] the field value, or nil when absent.
    def users_can_create_api_keys
      @attributes[:users_can_create_api_keys]
    end

    # Allow users to create their own SSH keys?
    # @return [Boolean, nil] the field value, or nil when absent.
    def users_can_create_ssh_keys
      @attributes[:users_can_create_ssh_keys]
    end

    # How usernames are displayed in the web UI. Can be `username_only`, `full_name_only`, `full_name_username`, `full_name_company`, or `full_name_username_company`.
    # @return [String, nil] the field value, or nil when absent.
    def username_display
      @attributes[:username_display]
    end

    # Custom text send in user welcome email
    # @return [String, nil] the field value, or nil when absent.
    def welcome_custom_text
      @attributes[:welcome_custom_text]
    end

    # Custom footer text for system-generated emails (as Markdown). Supports standard strftime date/time patterns like %Y (4-digit year), %m (month), %d (day).
    # @return [String, nil] the field value, or nil when absent.
    def email_footer_custom_text
      @attributes[:email_footer_custom_text]
    end

    # Include this email in welcome emails if enabled
    # @return [Hash, nil] the field value, or nil when absent.
    def welcome_email_cc
      @attributes[:welcome_email_cc]
    end

    # Include this email subject in welcome emails if enabled
    # @return [String, nil] the field value, or nil when absent.
    def welcome_email_subject
      @attributes[:welcome_email_subject]
    end

    # Will the welcome email be sent to new users?
    # @return [Boolean, nil] the field value, or nil when absent.
    def welcome_email_enabled
      @attributes[:welcome_email_enabled]
    end

    # Does the welcome screen appear?
    # @return [String, nil] the field value, or nil when absent.
    def welcome_screen
      @attributes[:welcome_screen]
    end

    # Does FTP user Windows emulation mode?
    # @return [Boolean, nil] the field value, or nil when absent.
    def windows_mode_ftp
      @attributes[:windows_mode_ftp]
    end

    # Show Site Settings
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Site] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.get(params = {}, options = {})
      response, options = Api.send_request("/site", :get, params, options) { |reply| reply.require_object("Site") }
      Site.new(response.data, options)
    end

    # Get the most recent usage snapshot (usage data for billing purposes) for a Site
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::UsageSnapshot] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.get_usage(params = {}, options = {})
      response, options = Api.send_request("/site/usage", :get, params, options) { |reply| reply.require_object("UsageSnapshot") }
      UsageSnapshot.new(response.data, options)
    end

    # Update Site Settings
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Site name
    # @option params [String] subdomain Site subdomain
    # @option params [String] domain Custom domain
    # @option params [Boolean] domain_hsts_header Send HSTS (HTTP Strict Transport Security) header when visitors access the site via a custom domain?
    # @option params [String] domain_letsencrypt_chain Letsencrypt chain to use when registering SSL Certificate for domain. No longer used as of 2026.
    # @option params [String] email Main email for this site
    # @option params [String] reply_to_email Reply-to email for this site
    # @option params [Boolean] allow_bundle_names Are manual Bundle names allowed?
    # @option params [Integer] bundle_expiration Site-wide Bundle expiration in days
    # @option params [Boolean] welcome_email_enabled Will the welcome email be sent to new users?
    # @option params [Boolean] ask_about_overwrites If false, rename conflicting files instead of asking for overwrite confirmation.  Only applies to web interface.
    # @option params [Boolean] show_request_access_link Show request access link for users without access?  Currently unused.
    # @option params [Boolean] always_mkdir_parents Create parent directories if they do not exist during uploads?  This is primarily used to work around broken upload clients that assume servers will perform this step.
    # @option params [String] welcome_email_cc Include this email in welcome emails if enabled
    # @option params [String] welcome_email_subject Include this email subject in welcome emails if enabled
    # @option params [String] welcome_custom_text Custom text send in user welcome email
    # @option params [String] language Site default language
    # @option params [Boolean] windows_mode_ftp Does FTP user Windows emulation mode?
    # @option params [String] default_time_zone Site default time zone
    # @option params [Boolean] desktop_app Is the desktop app enabled?
    # @option params [Boolean] desktop_app_session_ip_pinning Is desktop app session IP pinning enabled?
    # @option params [Integer] desktop_app_session_lifetime Desktop app session lifetime (in hours)
    # @option params [Boolean] mobile_app Is the mobile app enabled?
    # @option params [Boolean] mobile_app_session_ip_pinning Is mobile app session IP pinning enabled?
    # @option params [Integer] mobile_app_session_lifetime Mobile app session lifetime (in hours)
    # @option params [Boolean] folder_permissions_groups_only If true, permissions for this site must be bound to a group (not a user).
    # @option params [String] welcome_screen Does the welcome screen appear?
    # @option params [Boolean] office_integration_available If true, allows users to use a document editing integration.
    # @option params [String] office_integration_type Which document editing integration to support. Files.com Editor or Microsoft Office for the Web.
    # @option params [Boolean] pin_all_remote_servers_to_site_region If true, we will ensure that all internal communications with any remote server are made through the primary region of the site. This setting overrides individual remote server settings.
    # @option params [String] motd_text A message to show users when they connect via FTP or SFTP.
    # @option params [Boolean] motd_use_for_ftp Show message to users connecting via FTP
    # @option params [Boolean] motd_use_for_sftp Show message to users connecting via SFTP
    # @option params [Hash] left_navigation_visibility Visibility settings for account navigation
    # @option params [Boolean] disable_all_ai_features If true, all AI features are disabled for this site.
    # @option params [Hash] ai_feature_availability Availability settings for AI features. Each feature requires the site_admins, workspace_admins, folder_admins, and all_users keys. Optional selected_group_members defaults to false; when true, members of at least one group in group_ids get access regardless of the other options. All availability options are additive: any enabled option matching the user grants access. Optional group_ids is an array of integer IDs of active groups on this site, from any workspace. Omitted or empty group_ids grants no access through selected_group_members and does not affect other options. Disabling all AI features overrides these settings.
    # @option params [Boolean] mcp_dcr_enabled Is OAuth DCR (dynamic client registration) for MCP enabled?
    # @option params [Array<String>] additional_text_file_types Additional extensions that are considered text files
    # @option params [Boolean] bundle_require_note Do Bundles require internal notes?
    # @option params [Boolean] bundle_send_shared_receipts Do Bundle creators receive receipts of invitations?
    # @option params [Boolean] bundles_default_owned_by_primary_group If true, new Share Links created by a user with a primary group will default to that group as owner.
    # @option params [Boolean] calculate_file_checksums_crc32 Calculate CRC32 checksums for files?
    # @option params [Boolean] calculate_file_checksums_md5 Calculate MD5 checksums for files?
    # @option params [Boolean] calculate_file_checksums_sha1 Calculate SHA1 checksums for files?
    # @option params [Boolean] calculate_file_checksums_sha256 Calculate SHA256 checksums for files?
    # @option params [Boolean] legacy_checksums_mode Use legacy checksums mode?
    # @option params [Boolean] migrate_remote_server_sync_to_sync If true, we will migrate all remote server syncs to the new Sync model.
    # @option params [Integer] as2_message_retention_days Number of days to retain AS2 messages (incoming and outgoing).
    # @option params [Boolean] file_activity_events_enabled If true, file operations produce file_action.activity.v1 EventChannel events in all workspaces. Defaults to false; subscription filters and workspace access still control delivery.
    # @option params [String] username_display How usernames are displayed in the web UI. Can be `username_only`, `full_name_only`, `full_name_username`, `full_name_company`, or `full_name_username_company`.
    # @option params [Integer] session_expiry_minutes Session expiry in minutes
    # @option params [Boolean] ssl_required Is SSL required?  Disabling this is insecure.
    # @option params [Boolean] sftp_insecure_ciphers If true, we will allow weak and known insecure ciphers to be used for SFTP connections.  Enabling this setting severely weakens the security of your site and it is not recommend, except as a last resort for compatibility.
    # @option params [Boolean] sftp_insecure_diffie_hellman If true, we will allow weak Diffie Hellman parameters to be used within ciphers for SFTP that are otherwise on our secure list.  This has the effect of making the cipher weaker than our normal threshold for security, but is required to support certain legacy or broken SSH and MFT clients.  Enabling this weakens security, but not nearly as much as enabling the full `sftp_insecure_ciphers` option.
    # @option params [Boolean] disable_files_certificate_generation If set, Files.com will not set the CAA records required to generate future SSL certificates for this domain.
    # @option params [Boolean] fedramp Are FedRAMP security restrictions enabled for this site?
    # @option params [Boolean] user_lockout Will users be locked out after incorrect login attempts?
    # @option params [Integer] user_lockout_tries Number of login tries within `user_lockout_within` hours before users are locked out
    # @option params [Integer] user_lockout_within Number of hours for user lockout window
    # @option params [Integer] user_lockout_lock_period How many hours to lock user out for failed password?
    # @option params [Boolean] include_password_in_welcome_email Include password in emails to new users?
    # @option params [String] allowed_countries Comma separated list of allowed Country codes
    # @option params [String] allowed_ips List of allowed IP addresses
    # @option params [Boolean] allow_user_level_2fa_override Allow the site-wide two-factor authentication requirement to be overriden on a per-user-basis?
    # @option params [Boolean] allow_user_level_allowed_ip_override Allow the site-wide allowed IP restriction to be overriden on a per-user-basis?
    # @option params [Boolean] allow_user_level_ssl_override Allow the site-wide FTP SSL requirement to be overriden on a per-user-basis?
    # @option params [Boolean] enforce_parent_site_user_ip_restrictions Require Parent Site users entering this Child Site to match its allowed IP addresses in addition to their existing IP restrictions. Applies to all Workspaces. Defaults to false.
    # @option params [String] disallowed_countries Comma separated list of disallowed Country codes
    # @option params [Integer] days_to_retain_backups Number of days to keep deleted files
    # @option params [Integer] max_prior_passwords Number of prior passwords to disallow
    # @option params [Integer] password_validity_days Number of days password is valid
    # @option params [Integer] password_min_length Shortest password length for users
    # @option params [Boolean] password_require_letter Require a letter in passwords?
    # @option params [Boolean] password_require_mixed Require lower and upper case letters in passwords?
    # @option params [Boolean] password_require_special Require special characters in password?
    # @option params [Boolean] password_require_number Require a number in passwords?
    # @option params [Boolean] password_require_unbreached Require passwords that have not been previously breached? (see https://haveibeenpwned.com/)
    # @option params [Boolean] require_logout_from_bundles_and_inboxes If true, we will hide the 'Remember Me' box on Inbox and Bundle registration pages, requiring that the user logout and log back in every time they visit the page.
    # @option params [Boolean] dav_user_root_enabled Use user FTP roots also for WebDAV?
    # @option params [Boolean] sftp_user_root_enabled Use user FTP roots also for SFTP?
    # @option params [Boolean] disable_password_reset Is password reset disabled?
    # @option params [Boolean] immutable_files Are files protected from modification?
    # @option params [String] bundle_not_found_message Custom error message to show when bundle is not found.
    # @option params [Boolean] bundle_password_required Do Bundles require password protection?
    # @option params [Boolean] bundle_require_registration Do Bundles require registration?
    # @option params [Boolean] bundle_require_share_recipient Do Bundles require recipients for sharing?
    # @option params [Boolean] bundle_send_one_time_password_to_recipient_at_registration If true, new Share Links must send a one-time password to the recipient when they register. Requires bundle_require_share_recipient and cannot be enabled with bundle_password_required.
    # @option params [String] bundle_registration_notifications Do Bundle owners receive registration notification?
    # @option params [String] bundle_activity_notifications Do Bundle owners receive activity notifications?
    # @option params [String] bundle_upload_receipt_notifications Do Bundle uploaders receive upload confirmation notifications?
    # @option params [Boolean] document_edits_in_bundle_allowed If true, allow public viewers of Bundles with full permissions to use document editing integrations.
    # @option params [Boolean] password_requirements_apply_to_bundles Require bundles' passwords, and passwords for other items (inboxes, public shares, etc.) to conform to the same requirements as users' passwords?
    # @option params [Boolean] prevent_root_permissions_for_non_site_admins If true, we will prevent non-administrators from receiving any permissions directly on the root folder.  This is commonly used to prevent the accidental application of permissions.
    # @option params [Boolean] restrict_root_folder_behaviors_to_site_admins If true, only site admins may create, modify, or delete any behavior at the site root, or a skip that would disable one.
    # @option params [Boolean] root_folder_behaviors_apply_to_workspaces If true, supported protective behaviors at the site root also apply within named workspaces. Requires restrict_root_folder_behaviors_to_site_admins to be enabled.
    # @option params [Boolean] opt_out_global Use servers in the USA only?
    # @option params [Boolean] use_provided_modified_at Allow uploaders to set `provided_modified_at` for uploaded files?
    # @option params [Boolean] custom_namespace Is this site using a custom namespace for users?
    # @option params [Boolean] non_sso_groups_allowed If true, groups can be manually created / modified / deleted by Site Admins. Otherwise, groups can only be managed via your SSO provider.
    # @option params [Boolean] non_sso_users_allowed If true, users can be manually created / modified / deleted by Site Admins. Otherwise, users can only be managed via your SSO provider.
    # @option params [Boolean] sharing_enabled Allow bundle creation
    # @option params [Boolean] snapshot_sharing_enabled Allow snapshot share links creation
    # @option params [Boolean] user_requests_enabled Enable User Requests feature
    # @option params [Boolean] user_requests_notify_admins Send email to site admins when a user request is received?
    # @option params [Boolean] dav_enabled Is WebDAV enabled?
    # @option params [Boolean] files_com_remote_server_enabled Allow other Files.com sites to use this site's API keys for native Files.com Remote Server connections? Defaults to true and applies to all keys and workspaces on this site. When false, new pairings and access through existing connections are rejected without revoking keys or deleting connections. Re-enabling permits access again with usable keys. Does not disable this site's connections to other sites, ordinary API access, or Connected Sites.
    # @option params [Boolean] ftp_enabled Is FTP enabled?
    # @option params [Boolean] s3_compatible_endpoint_enabled Is the S3-compatible endpoint enabled for all users and workspaces on this site? Defaults to true. When false, user and group S3 permissions do not allow access.
    # @option params [Boolean] sftp_enabled Is SFTP enabled?
    # @option params [Boolean] sftp_finalize_partial_uploads Finalize partial SFTP uploads from interrupted connections? Default: true.
    # @option params [Boolean] users_can_create_api_keys Allow users to create their own API keys?
    # @option params [Boolean] users_can_create_ssh_keys Allow users to create their own SSH keys?
    # @option params [Boolean] show_user_notifications_log_in_link Show log in link in user notifications?
    # @option params [String] sftp_host_key_type Sftp Host Key Type
    # @option params [Integer] active_sftp_host_key_id Id of the currently selected custom SFTP Host Key
    # @option params [Array<Integer>] active_sftp_host_key_ids Ids of the selected custom SFTP Host Keys
    # @option params [Boolean] protocol_access_groups_only If true, protocol access permissions on users will be ignored, and only protocol access permissions set on Groups will be honored.  Make sure that your current user is a member of a group with API permission when changing this value to avoid locking yourself out of your site.
    # @option params [Boolean] revoke_bundle_access_on_disable_or_delete Auto-removes bundles for disabled/deleted users and enforces bundle expiry within user access period.
    # @option params [Boolean] group_admins_can_add_users Allow group admins to create users in their groups
    # @option params [Boolean] group_admins_can_manage_group_memberships Allow group admins to add or remove existing users in their groups
    # @option params [Boolean] group_admins_can_delete_users Allow group admins to delete users in their groups
    # @option params [Boolean] group_admins_can_enable_disable_users Allow group admins to enable or disable users in their groups
    # @option params [Boolean] group_admins_can_modify_users Allow group admins to modify users in their groups
    # @option params [Boolean] group_admins_can_bypass_user_lifecycle_rules Allow group admins to exempt users in their groups from lifecycle rules
    # @option params [Boolean] group_admins_can_reset_passwords Allow group admins to reset passwords for users in their groups
    # @option params [Boolean] group_admins_can_set_user_password Allow group admins to set password authentication method
    # @option params [Boolean] child_site_folder_admins_can_see_parent_site_directory If true, administrators on this site's Child Sites, including Folder Admins, can list this site's Default Workspace users and groups and grant them folder permissions and notifications on Child Site paths.
    # @option params [Boolean] workspace_folder_admins_can_see_default_workspace_directory If true, Workspace Administrators and Folder Admins in a Custom Workspace can list the Default Workspace users and groups that have permissions in that Workspace and choose them as Email Notification recipients.
    # @option params [Boolean] bundle_recipient_blacklist_free_email_domains Disallow free email domains for Bundle/Inbox recipients?
    # @option params [Array<String>] bundle_recipient_blacklist_domains List of email domains to disallow when entering a Bundle/Inbox recipients
    # @option params [Boolean] admins_bypass_locked_subfolders Allow admins to bypass the locked subfolders setting.
    # @option params [Boolean] allowed_2fa_method_sms Is SMS two factor authentication allowed?
    # @option params [Boolean] allowed_2fa_method_totp Is TOTP two factor authentication allowed?
    # @option params [Boolean] allowed_2fa_method_webauthn Is WebAuthn two factor authentication allowed?
    # @option params [Boolean] allowed_2fa_method_yubi Is yubikey two factor authentication allowed?
    # @option params [Boolean] allowed_2fa_method_email Is OTP via email two factor authentication allowed?
    # @option params [Boolean] allowed_2fa_method_static Is OTP via static codes for two factor authentication allowed?
    # @option params [Boolean] allowed_2fa_method_bypass_for_ftp_sftp_dav Are users allowed to configure their two factor authentication to be bypassed for FTP/SFTP/WebDAV?
    # @option params [Boolean] require_2fa Require two-factor authentication for all users?
    # @option params [Boolean] require_2fa_exempt_all_sso_users If true, SSO users using the default user-level two-factor authentication setting are exempt from the site-wide two-factor authentication requirement.
    # @option params [String] require_2fa_user_type What type of user is required to use two-factor authentication (when require_2fa is set to `true` for this site)?
    # @option params [String] color2_top Top bar background color
    # @option params [String] color2_left Page link and button color
    # @option params [String] color2_link Top bar link color
    # @option params [String] color2_text Page link and button color
    # @option params [String] color2_top_text Top bar text color
    # @option params [String] site_header Custom site header text for authenticated pages
    # @option params [String] site_footer Custom site footer text for authenticated pages
    # @option params [String] site_public_header Custom site header text for public pages
    # @option params [String] site_public_footer Custom site footer text for public pages
    # @option params [String] login_help_text Login help text
    # @option params [Boolean] use_dedicated_ips_for_smtp If using custom SMTP, should we use dedicated IPs to deliver emails?
    # @option params [String] email_footer_custom_text Custom footer text for system-generated emails (as Markdown). Supports standard strftime date/time patterns like %Y (4-digit year), %m (month), %d (day).
    # @option params [String] smtp_address SMTP server hostname or IP
    # @option params [String] smtp_authentication SMTP server authentication type
    # @option params [String] smtp_from From address to use when mailing through custom SMTP
    # @option params [String] smtp_username SMTP server username
    # @option params [Integer] smtp_port SMTP server port
    # @option params [String] smtp_ssl Custom SMTP encryption mode: if_available (default) uses STARTTLS when offered and otherwise sends credentials and messages unencrypted. A certificate-verified STARTTLS connection automatically changes if_available to require unless smtp_ssl is managed by a parent policy. require requires STARTTLS before authentication; require_implicit uses TLS from connection start; never disables TLS. TLS verifies the server certificate against smtp_address. Encryption is never automatically downgraded.
    # @option params [Boolean] ldap_enabled Main LDAP setting: is LDAP enabled?
    # @option params [String] ldap_type LDAP type
    # @option params [String] ldap_host LDAP host
    # @option params [String] ldap_host_2 LDAP backup host
    # @option params [String] ldap_host_3 LDAP backup host
    # @option params [Integer] ldap_port LDAP port
    # @option params [Boolean] ldap_secure Use secure LDAP?
    # @option params [String] ldap_server_certificate How to validate the LDAP server certificate. `require_match` validates the certificate chain and hostname; `allow_any` disables certificate validation.
    # @option params [String] ldap_username Username for signing in to LDAP server.
    # @option params [String] ldap_username_field LDAP username field
    # @option params [String] ldap_domain Domain name that will be appended to usernames
    # @option params [String] ldap_user_action Should we sync users from LDAP server?
    # @option params [String] ldap_group_action Should we sync groups from LDAP server?
    # @option params [String] ldap_user_include_groups Comma or newline separated list of group names (with optional wildcards) - if provided, only users in these groups will be added or synced.
    # @option params [String] ldap_group_exclusion Comma or newline separated list of group names (with optional wildcards) to exclude when syncing.
    # @option params [String] ldap_group_inclusion Comma or newline separated list of group names (with optional wildcards) to include when syncing.
    # @option params [String] ldap_base_dn Base DN for looking up users in LDAP server
    # @option params [Boolean] uploads_via_email_authentication Require email authentication, virus, and spam checks for incoming emails to Inboxes and Incoming Email Automations in every Workspace on this site?
    # @option params [Hash] bundle_watermark_value Preview watermark settings applied to all bundle items. Uses the same keys as Behavior.value
    # @option params [Object] icon16_file
    # @option params [Boolean] icon16_delete If true, will delete the file stored in icon16
    # @option params [Object] icon32_file
    # @option params [Boolean] icon32_delete If true, will delete the file stored in icon32
    # @option params [Object] icon48_file
    # @option params [Boolean] icon48_delete If true, will delete the file stored in icon48
    # @option params [Object] icon128_file
    # @option params [Boolean] icon128_delete If true, will delete the file stored in icon128
    # @option params [Object] logo_file
    # @option params [Boolean] logo_delete If true, will delete the file stored in logo
    # @option params [Object] bundle_watermark_attachment_file
    # @option params [Boolean] bundle_watermark_attachment_delete If true, will delete the file stored in bundle_watermark_attachment
    # @option params [Object] login_page_background_image_file
    # @option params [Boolean] login_page_background_image_delete If true, will delete the file stored in login_page_background_image
    # @option params [Boolean] disable_2fa_with_delay If set to true, we will begin the process of disabling 2FA on this site.
    # @option params [String] ldap_password_change New LDAP password.
    # @option params [String] ldap_password_change_confirmation Confirm new LDAP password.
    # @option params [Boolean] redirect_old_subdomain If true, and if changing the site subdomain, then create a redirect from the previous Files.com subdomain to the new Files.com subdomain.
    # @option params [String] smtp_password Password for SMTP server.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Site] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subdomain must be an String") if !params[:subdomain].nil? and !params[:subdomain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: domain must be an String") if !params[:domain].nil? and !params[:domain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: domain_hsts_header must be a single value, not #{params[:domain_hsts_header].class}") if [ Array, Hash ].any? { |klass| params[:domain_hsts_header].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: domain_letsencrypt_chain must be an String") if !params[:domain_letsencrypt_chain].nil? and !params[:domain_letsencrypt_chain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if !params[:email].nil? and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: reply_to_email must be an String") if !params[:reply_to_email].nil? and !params[:reply_to_email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allow_bundle_names must be a single value, not #{params[:allow_bundle_names].class}") if [ Array, Hash ].any? { |klass| params[:allow_bundle_names].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bundle_expiration must be an Integer") if !params[:bundle_expiration].nil? and !params[:bundle_expiration].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: welcome_email_enabled must be a single value, not #{params[:welcome_email_enabled].class}") if [ Array, Hash ].any? { |klass| params[:welcome_email_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ask_about_overwrites must be a single value, not #{params[:ask_about_overwrites].class}") if [ Array, Hash ].any? { |klass| params[:ask_about_overwrites].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: show_request_access_link must be a single value, not #{params[:show_request_access_link].class}") if [ Array, Hash ].any? { |klass| params[:show_request_access_link].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: always_mkdir_parents must be a single value, not #{params[:always_mkdir_parents].class}") if [ Array, Hash ].any? { |klass| params[:always_mkdir_parents].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: welcome_email_cc must be an String") if !params[:welcome_email_cc].nil? and !params[:welcome_email_cc].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: welcome_email_subject must be an String") if !params[:welcome_email_subject].nil? and !params[:welcome_email_subject].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: welcome_custom_text must be an String") if !params[:welcome_custom_text].nil? and !params[:welcome_custom_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if !params[:language].nil? and !params[:language].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: windows_mode_ftp must be a single value, not #{params[:windows_mode_ftp].class}") if [ Array, Hash ].any? { |klass| params[:windows_mode_ftp].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: default_time_zone must be an String") if !params[:default_time_zone].nil? and !params[:default_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: desktop_app must be a single value, not #{params[:desktop_app].class}") if [ Array, Hash ].any? { |klass| params[:desktop_app].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: desktop_app_session_ip_pinning must be a single value, not #{params[:desktop_app_session_ip_pinning].class}") if [ Array, Hash ].any? { |klass| params[:desktop_app_session_ip_pinning].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: desktop_app_session_lifetime must be an Integer") if !params[:desktop_app_session_lifetime].nil? and !params[:desktop_app_session_lifetime].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: mobile_app must be a single value, not #{params[:mobile_app].class}") if [ Array, Hash ].any? { |klass| params[:mobile_app].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: mobile_app_session_ip_pinning must be a single value, not #{params[:mobile_app_session_ip_pinning].class}") if [ Array, Hash ].any? { |klass| params[:mobile_app_session_ip_pinning].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: mobile_app_session_lifetime must be an Integer") if !params[:mobile_app_session_lifetime].nil? and !params[:mobile_app_session_lifetime].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: folder_permissions_groups_only must be a single value, not #{params[:folder_permissions_groups_only].class}") if [ Array, Hash ].any? { |klass| params[:folder_permissions_groups_only].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: welcome_screen must be an String") if !params[:welcome_screen].nil? and !params[:welcome_screen].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: office_integration_available must be a single value, not #{params[:office_integration_available].class}") if [ Array, Hash ].any? { |klass| params[:office_integration_available].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: office_integration_type must be an String") if !params[:office_integration_type].nil? and !params[:office_integration_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pin_all_remote_servers_to_site_region must be a single value, not #{params[:pin_all_remote_servers_to_site_region].class}") if [ Array, Hash ].any? { |klass| params[:pin_all_remote_servers_to_site_region].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: motd_text must be an String") if !params[:motd_text].nil? and !params[:motd_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: motd_use_for_ftp must be a single value, not #{params[:motd_use_for_ftp].class}") if [ Array, Hash ].any? { |klass| params[:motd_use_for_ftp].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: motd_use_for_sftp must be a single value, not #{params[:motd_use_for_sftp].class}") if [ Array, Hash ].any? { |klass| params[:motd_use_for_sftp].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: left_navigation_visibility must be an Hash") if !params[:left_navigation_visibility].nil? and !params[:left_navigation_visibility].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: disable_all_ai_features must be a single value, not #{params[:disable_all_ai_features].class}") if [ Array, Hash ].any? { |klass| params[:disable_all_ai_features].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ai_feature_availability must be an Hash") if !params[:ai_feature_availability].nil? and !params[:ai_feature_availability].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: mcp_dcr_enabled must be a single value, not #{params[:mcp_dcr_enabled].class}") if [ Array, Hash ].any? { |klass| params[:mcp_dcr_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: additional_text_file_types must be an Array") if !params[:additional_text_file_types].nil? and !params[:additional_text_file_types].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: bundle_require_note must be a single value, not #{params[:bundle_require_note].class}") if [ Array, Hash ].any? { |klass| params[:bundle_require_note].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bundle_send_shared_receipts must be a single value, not #{params[:bundle_send_shared_receipts].class}") if [ Array, Hash ].any? { |klass| params[:bundle_send_shared_receipts].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bundles_default_owned_by_primary_group must be a single value, not #{params[:bundles_default_owned_by_primary_group].class}") if [ Array, Hash ].any? { |klass| params[:bundles_default_owned_by_primary_group].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: calculate_file_checksums_crc32 must be a single value, not #{params[:calculate_file_checksums_crc32].class}") if [ Array, Hash ].any? { |klass| params[:calculate_file_checksums_crc32].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: calculate_file_checksums_md5 must be a single value, not #{params[:calculate_file_checksums_md5].class}") if [ Array, Hash ].any? { |klass| params[:calculate_file_checksums_md5].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: calculate_file_checksums_sha1 must be a single value, not #{params[:calculate_file_checksums_sha1].class}") if [ Array, Hash ].any? { |klass| params[:calculate_file_checksums_sha1].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: calculate_file_checksums_sha256 must be a single value, not #{params[:calculate_file_checksums_sha256].class}") if [ Array, Hash ].any? { |klass| params[:calculate_file_checksums_sha256].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: legacy_checksums_mode must be a single value, not #{params[:legacy_checksums_mode].class}") if [ Array, Hash ].any? { |klass| params[:legacy_checksums_mode].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: migrate_remote_server_sync_to_sync must be a single value, not #{params[:migrate_remote_server_sync_to_sync].class}") if [ Array, Hash ].any? { |klass| params[:migrate_remote_server_sync_to_sync].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: as2_message_retention_days must be an Integer") if !params[:as2_message_retention_days].nil? and !params[:as2_message_retention_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: file_activity_events_enabled must be a single value, not #{params[:file_activity_events_enabled].class}") if [ Array, Hash ].any? { |klass| params[:file_activity_events_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: username_display must be an String") if !params[:username_display].nil? and !params[:username_display].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: session_expiry_minutes must be an Integer") if !params[:session_expiry_minutes].nil? and !params[:session_expiry_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ssl_required must be a single value, not #{params[:ssl_required].class}") if [ Array, Hash ].any? { |klass| params[:ssl_required].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_insecure_ciphers must be a single value, not #{params[:sftp_insecure_ciphers].class}") if [ Array, Hash ].any? { |klass| params[:sftp_insecure_ciphers].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_insecure_diffie_hellman must be a single value, not #{params[:sftp_insecure_diffie_hellman].class}") if [ Array, Hash ].any? { |klass| params[:sftp_insecure_diffie_hellman].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: disable_files_certificate_generation must be a single value, not #{params[:disable_files_certificate_generation].class}") if [ Array, Hash ].any? { |klass| params[:disable_files_certificate_generation].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: fedramp must be a single value, not #{params[:fedramp].class}") if [ Array, Hash ].any? { |klass| params[:fedramp].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: user_lockout must be a single value, not #{params[:user_lockout].class}") if [ Array, Hash ].any? { |klass| params[:user_lockout].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: user_lockout_tries must be an Integer") if !params[:user_lockout_tries].nil? and !params[:user_lockout_tries].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_lockout_within must be an Integer") if !params[:user_lockout_within].nil? and !params[:user_lockout_within].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_lockout_lock_period must be an Integer") if !params[:user_lockout_lock_period].nil? and !params[:user_lockout_lock_period].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: include_password_in_welcome_email must be a single value, not #{params[:include_password_in_welcome_email].class}") if [ Array, Hash ].any? { |klass| params[:include_password_in_welcome_email].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allowed_countries must be an String") if !params[:allowed_countries].nil? and !params[:allowed_countries].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if !params[:allowed_ips].nil? and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allow_user_level_2fa_override must be a single value, not #{params[:allow_user_level_2fa_override].class}") if [ Array, Hash ].any? { |klass| params[:allow_user_level_2fa_override].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allow_user_level_allowed_ip_override must be a single value, not #{params[:allow_user_level_allowed_ip_override].class}") if [ Array, Hash ].any? { |klass| params[:allow_user_level_allowed_ip_override].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allow_user_level_ssl_override must be a single value, not #{params[:allow_user_level_ssl_override].class}") if [ Array, Hash ].any? { |klass| params[:allow_user_level_ssl_override].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: enforce_parent_site_user_ip_restrictions must be a single value, not #{params[:enforce_parent_site_user_ip_restrictions].class}") if [ Array, Hash ].any? { |klass| params[:enforce_parent_site_user_ip_restrictions].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: disallowed_countries must be an String") if !params[:disallowed_countries].nil? and !params[:disallowed_countries].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: days_to_retain_backups must be an Integer") if !params[:days_to_retain_backups].nil? and !params[:days_to_retain_backups].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_prior_passwords must be an Integer") if !params[:max_prior_passwords].nil? and !params[:max_prior_passwords].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password_validity_days must be an Integer") if !params[:password_validity_days].nil? and !params[:password_validity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password_min_length must be an Integer") if !params[:password_min_length].nil? and !params[:password_min_length].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password_require_letter must be a single value, not #{params[:password_require_letter].class}") if [ Array, Hash ].any? { |klass| params[:password_require_letter].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: password_require_mixed must be a single value, not #{params[:password_require_mixed].class}") if [ Array, Hash ].any? { |klass| params[:password_require_mixed].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: password_require_special must be a single value, not #{params[:password_require_special].class}") if [ Array, Hash ].any? { |klass| params[:password_require_special].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: password_require_number must be a single value, not #{params[:password_require_number].class}") if [ Array, Hash ].any? { |klass| params[:password_require_number].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: password_require_unbreached must be a single value, not #{params[:password_require_unbreached].class}") if [ Array, Hash ].any? { |klass| params[:password_require_unbreached].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: require_logout_from_bundles_and_inboxes must be a single value, not #{params[:require_logout_from_bundles_and_inboxes].class}") if [ Array, Hash ].any? { |klass| params[:require_logout_from_bundles_and_inboxes].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: dav_user_root_enabled must be a single value, not #{params[:dav_user_root_enabled].class}") if [ Array, Hash ].any? { |klass| params[:dav_user_root_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_user_root_enabled must be a single value, not #{params[:sftp_user_root_enabled].class}") if [ Array, Hash ].any? { |klass| params[:sftp_user_root_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: disable_password_reset must be a single value, not #{params[:disable_password_reset].class}") if [ Array, Hash ].any? { |klass| params[:disable_password_reset].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: immutable_files must be a single value, not #{params[:immutable_files].class}") if [ Array, Hash ].any? { |klass| params[:immutable_files].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bundle_not_found_message must be an String") if !params[:bundle_not_found_message].nil? and !params[:bundle_not_found_message].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bundle_password_required must be a single value, not #{params[:bundle_password_required].class}") if [ Array, Hash ].any? { |klass| params[:bundle_password_required].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bundle_require_registration must be a single value, not #{params[:bundle_require_registration].class}") if [ Array, Hash ].any? { |klass| params[:bundle_require_registration].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bundle_require_share_recipient must be a single value, not #{params[:bundle_require_share_recipient].class}") if [ Array, Hash ].any? { |klass| params[:bundle_require_share_recipient].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bundle_send_one_time_password_to_recipient_at_registration must be a single value, not #{params[:bundle_send_one_time_password_to_recipient_at_registration].class}") if [ Array, Hash ].any? { |klass| params[:bundle_send_one_time_password_to_recipient_at_registration].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bundle_registration_notifications must be an String") if !params[:bundle_registration_notifications].nil? and !params[:bundle_registration_notifications].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bundle_activity_notifications must be an String") if !params[:bundle_activity_notifications].nil? and !params[:bundle_activity_notifications].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bundle_upload_receipt_notifications must be an String") if !params[:bundle_upload_receipt_notifications].nil? and !params[:bundle_upload_receipt_notifications].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: document_edits_in_bundle_allowed must be a single value, not #{params[:document_edits_in_bundle_allowed].class}") if [ Array, Hash ].any? { |klass| params[:document_edits_in_bundle_allowed].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: password_requirements_apply_to_bundles must be a single value, not #{params[:password_requirements_apply_to_bundles].class}") if [ Array, Hash ].any? { |klass| params[:password_requirements_apply_to_bundles].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: prevent_root_permissions_for_non_site_admins must be a single value, not #{params[:prevent_root_permissions_for_non_site_admins].class}") if [ Array, Hash ].any? { |klass| params[:prevent_root_permissions_for_non_site_admins].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: restrict_root_folder_behaviors_to_site_admins must be a single value, not #{params[:restrict_root_folder_behaviors_to_site_admins].class}") if [ Array, Hash ].any? { |klass| params[:restrict_root_folder_behaviors_to_site_admins].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: root_folder_behaviors_apply_to_workspaces must be a single value, not #{params[:root_folder_behaviors_apply_to_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:root_folder_behaviors_apply_to_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: opt_out_global must be a single value, not #{params[:opt_out_global].class}") if [ Array, Hash ].any? { |klass| params[:opt_out_global].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: use_provided_modified_at must be a single value, not #{params[:use_provided_modified_at].class}") if [ Array, Hash ].any? { |klass| params[:use_provided_modified_at].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: custom_namespace must be a single value, not #{params[:custom_namespace].class}") if [ Array, Hash ].any? { |klass| params[:custom_namespace].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: non_sso_groups_allowed must be a single value, not #{params[:non_sso_groups_allowed].class}") if [ Array, Hash ].any? { |klass| params[:non_sso_groups_allowed].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: non_sso_users_allowed must be a single value, not #{params[:non_sso_users_allowed].class}") if [ Array, Hash ].any? { |klass| params[:non_sso_users_allowed].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sharing_enabled must be a single value, not #{params[:sharing_enabled].class}") if [ Array, Hash ].any? { |klass| params[:sharing_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: snapshot_sharing_enabled must be a single value, not #{params[:snapshot_sharing_enabled].class}") if [ Array, Hash ].any? { |klass| params[:snapshot_sharing_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: user_requests_enabled must be a single value, not #{params[:user_requests_enabled].class}") if [ Array, Hash ].any? { |klass| params[:user_requests_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: user_requests_notify_admins must be a single value, not #{params[:user_requests_notify_admins].class}") if [ Array, Hash ].any? { |klass| params[:user_requests_notify_admins].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: dav_enabled must be a single value, not #{params[:dav_enabled].class}") if [ Array, Hash ].any? { |klass| params[:dav_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: files_com_remote_server_enabled must be a single value, not #{params[:files_com_remote_server_enabled].class}") if [ Array, Hash ].any? { |klass| params[:files_com_remote_server_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ftp_enabled must be a single value, not #{params[:ftp_enabled].class}") if [ Array, Hash ].any? { |klass| params[:ftp_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint_enabled must be a single value, not #{params[:s3_compatible_endpoint_enabled].class}") if [ Array, Hash ].any? { |klass| params[:s3_compatible_endpoint_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_enabled must be a single value, not #{params[:sftp_enabled].class}") if [ Array, Hash ].any? { |klass| params[:sftp_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_finalize_partial_uploads must be a single value, not #{params[:sftp_finalize_partial_uploads].class}") if [ Array, Hash ].any? { |klass| params[:sftp_finalize_partial_uploads].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: users_can_create_api_keys must be a single value, not #{params[:users_can_create_api_keys].class}") if [ Array, Hash ].any? { |klass| params[:users_can_create_api_keys].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: users_can_create_ssh_keys must be a single value, not #{params[:users_can_create_ssh_keys].class}") if [ Array, Hash ].any? { |klass| params[:users_can_create_ssh_keys].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: show_user_notifications_log_in_link must be a single value, not #{params[:show_user_notifications_log_in_link].class}") if [ Array, Hash ].any? { |klass| params[:show_user_notifications_log_in_link].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_host_key_type must be an String") if !params[:sftp_host_key_type].nil? and !params[:sftp_host_key_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: active_sftp_host_key_id must be an Integer") if !params[:active_sftp_host_key_id].nil? and !params[:active_sftp_host_key_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: active_sftp_host_key_ids must be an Array") if !params[:active_sftp_host_key_ids].nil? and !params[:active_sftp_host_key_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: protocol_access_groups_only must be a single value, not #{params[:protocol_access_groups_only].class}") if [ Array, Hash ].any? { |klass| params[:protocol_access_groups_only].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: revoke_bundle_access_on_disable_or_delete must be a single value, not #{params[:revoke_bundle_access_on_disable_or_delete].class}") if [ Array, Hash ].any? { |klass| params[:revoke_bundle_access_on_disable_or_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: group_admins_can_add_users must be a single value, not #{params[:group_admins_can_add_users].class}") if [ Array, Hash ].any? { |klass| params[:group_admins_can_add_users].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: group_admins_can_manage_group_memberships must be a single value, not #{params[:group_admins_can_manage_group_memberships].class}") if [ Array, Hash ].any? { |klass| params[:group_admins_can_manage_group_memberships].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: group_admins_can_delete_users must be a single value, not #{params[:group_admins_can_delete_users].class}") if [ Array, Hash ].any? { |klass| params[:group_admins_can_delete_users].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: group_admins_can_enable_disable_users must be a single value, not #{params[:group_admins_can_enable_disable_users].class}") if [ Array, Hash ].any? { |klass| params[:group_admins_can_enable_disable_users].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: group_admins_can_modify_users must be a single value, not #{params[:group_admins_can_modify_users].class}") if [ Array, Hash ].any? { |klass| params[:group_admins_can_modify_users].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: group_admins_can_bypass_user_lifecycle_rules must be a single value, not #{params[:group_admins_can_bypass_user_lifecycle_rules].class}") if [ Array, Hash ].any? { |klass| params[:group_admins_can_bypass_user_lifecycle_rules].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: group_admins_can_reset_passwords must be a single value, not #{params[:group_admins_can_reset_passwords].class}") if [ Array, Hash ].any? { |klass| params[:group_admins_can_reset_passwords].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: group_admins_can_set_user_password must be a single value, not #{params[:group_admins_can_set_user_password].class}") if [ Array, Hash ].any? { |klass| params[:group_admins_can_set_user_password].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: child_site_folder_admins_can_see_parent_site_directory must be a single value, not #{params[:child_site_folder_admins_can_see_parent_site_directory].class}") if [ Array, Hash ].any? { |klass| params[:child_site_folder_admins_can_see_parent_site_directory].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_folder_admins_can_see_default_workspace_directory must be a single value, not #{params[:workspace_folder_admins_can_see_default_workspace_directory].class}") if [ Array, Hash ].any? { |klass| params[:workspace_folder_admins_can_see_default_workspace_directory].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bundle_recipient_blacklist_free_email_domains must be a single value, not #{params[:bundle_recipient_blacklist_free_email_domains].class}") if [ Array, Hash ].any? { |klass| params[:bundle_recipient_blacklist_free_email_domains].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bundle_recipient_blacklist_domains must be an Array") if !params[:bundle_recipient_blacklist_domains].nil? and !params[:bundle_recipient_blacklist_domains].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: admins_bypass_locked_subfolders must be a single value, not #{params[:admins_bypass_locked_subfolders].class}") if [ Array, Hash ].any? { |klass| params[:admins_bypass_locked_subfolders].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allowed_2fa_method_sms must be a single value, not #{params[:allowed_2fa_method_sms].class}") if [ Array, Hash ].any? { |klass| params[:allowed_2fa_method_sms].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allowed_2fa_method_totp must be a single value, not #{params[:allowed_2fa_method_totp].class}") if [ Array, Hash ].any? { |klass| params[:allowed_2fa_method_totp].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allowed_2fa_method_webauthn must be a single value, not #{params[:allowed_2fa_method_webauthn].class}") if [ Array, Hash ].any? { |klass| params[:allowed_2fa_method_webauthn].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allowed_2fa_method_yubi must be a single value, not #{params[:allowed_2fa_method_yubi].class}") if [ Array, Hash ].any? { |klass| params[:allowed_2fa_method_yubi].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allowed_2fa_method_email must be a single value, not #{params[:allowed_2fa_method_email].class}") if [ Array, Hash ].any? { |klass| params[:allowed_2fa_method_email].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allowed_2fa_method_static must be a single value, not #{params[:allowed_2fa_method_static].class}") if [ Array, Hash ].any? { |klass| params[:allowed_2fa_method_static].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: allowed_2fa_method_bypass_for_ftp_sftp_dav must be a single value, not #{params[:allowed_2fa_method_bypass_for_ftp_sftp_dav].class}") if [ Array, Hash ].any? { |klass| params[:allowed_2fa_method_bypass_for_ftp_sftp_dav].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: require_2fa must be a single value, not #{params[:require_2fa].class}") if [ Array, Hash ].any? { |klass| params[:require_2fa].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: require_2fa_exempt_all_sso_users must be a single value, not #{params[:require_2fa_exempt_all_sso_users].class}") if [ Array, Hash ].any? { |klass| params[:require_2fa_exempt_all_sso_users].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: require_2fa_user_type must be an String") if !params[:require_2fa_user_type].nil? and !params[:require_2fa_user_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: color2_top must be an String") if !params[:color2_top].nil? and !params[:color2_top].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: color2_left must be an String") if !params[:color2_left].nil? and !params[:color2_left].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: color2_link must be an String") if !params[:color2_link].nil? and !params[:color2_link].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: color2_text must be an String") if !params[:color2_text].nil? and !params[:color2_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: color2_top_text must be an String") if !params[:color2_top_text].nil? and !params[:color2_top_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: site_header must be an String") if !params[:site_header].nil? and !params[:site_header].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: site_footer must be an String") if !params[:site_footer].nil? and !params[:site_footer].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: site_public_header must be an String") if !params[:site_public_header].nil? and !params[:site_public_header].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: site_public_footer must be an String") if !params[:site_public_footer].nil? and !params[:site_public_footer].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: login_help_text must be an String") if !params[:login_help_text].nil? and !params[:login_help_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_dedicated_ips_for_smtp must be a single value, not #{params[:use_dedicated_ips_for_smtp].class}") if [ Array, Hash ].any? { |klass| params[:use_dedicated_ips_for_smtp].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: email_footer_custom_text must be an String") if !params[:email_footer_custom_text].nil? and !params[:email_footer_custom_text].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smtp_address must be an String") if !params[:smtp_address].nil? and !params[:smtp_address].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smtp_authentication must be an String") if !params[:smtp_authentication].nil? and !params[:smtp_authentication].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smtp_from must be an String") if !params[:smtp_from].nil? and !params[:smtp_from].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smtp_username must be an String") if !params[:smtp_username].nil? and !params[:smtp_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smtp_port must be an Integer") if !params[:smtp_port].nil? and !params[:smtp_port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: smtp_ssl must be an String") if !params[:smtp_ssl].nil? and !params[:smtp_ssl].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_enabled must be a single value, not #{params[:ldap_enabled].class}") if [ Array, Hash ].any? { |klass| params[:ldap_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ldap_type must be an String") if !params[:ldap_type].nil? and !params[:ldap_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host must be an String") if !params[:ldap_host].nil? and !params[:ldap_host].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host_2 must be an String") if !params[:ldap_host_2].nil? and !params[:ldap_host_2].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_host_3 must be an String") if !params[:ldap_host_3].nil? and !params[:ldap_host_3].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_port must be an Integer") if !params[:ldap_port].nil? and !params[:ldap_port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ldap_secure must be a single value, not #{params[:ldap_secure].class}") if [ Array, Hash ].any? { |klass| params[:ldap_secure].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ldap_server_certificate must be an String") if !params[:ldap_server_certificate].nil? and !params[:ldap_server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_username must be an String") if !params[:ldap_username].nil? and !params[:ldap_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_username_field must be an String") if !params[:ldap_username_field].nil? and !params[:ldap_username_field].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_domain must be an String") if !params[:ldap_domain].nil? and !params[:ldap_domain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_user_action must be an String") if !params[:ldap_user_action].nil? and !params[:ldap_user_action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_group_action must be an String") if !params[:ldap_group_action].nil? and !params[:ldap_group_action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_user_include_groups must be an String") if !params[:ldap_user_include_groups].nil? and !params[:ldap_user_include_groups].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_group_exclusion must be an String") if !params[:ldap_group_exclusion].nil? and !params[:ldap_group_exclusion].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_group_inclusion must be an String") if !params[:ldap_group_inclusion].nil? and !params[:ldap_group_inclusion].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_base_dn must be an String") if !params[:ldap_base_dn].nil? and !params[:ldap_base_dn].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uploads_via_email_authentication must be a single value, not #{params[:uploads_via_email_authentication].class}") if [ Array, Hash ].any? { |klass| params[:uploads_via_email_authentication].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bundle_watermark_value must be an Hash") if !params[:bundle_watermark_value].nil? and !params[:bundle_watermark_value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: icon16_delete must be a single value, not #{params[:icon16_delete].class}") if [ Array, Hash ].any? { |klass| params[:icon16_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: icon32_delete must be a single value, not #{params[:icon32_delete].class}") if [ Array, Hash ].any? { |klass| params[:icon32_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: icon48_delete must be a single value, not #{params[:icon48_delete].class}") if [ Array, Hash ].any? { |klass| params[:icon48_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: icon128_delete must be a single value, not #{params[:icon128_delete].class}") if [ Array, Hash ].any? { |klass| params[:icon128_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: logo_delete must be a single value, not #{params[:logo_delete].class}") if [ Array, Hash ].any? { |klass| params[:logo_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: bundle_watermark_attachment_delete must be a single value, not #{params[:bundle_watermark_attachment_delete].class}") if [ Array, Hash ].any? { |klass| params[:bundle_watermark_attachment_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: login_page_background_image_delete must be a single value, not #{params[:login_page_background_image_delete].class}") if [ Array, Hash ].any? { |klass| params[:login_page_background_image_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: disable_2fa_with_delay must be a single value, not #{params[:disable_2fa_with_delay].class}") if [ Array, Hash ].any? { |klass| params[:disable_2fa_with_delay].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ldap_password_change must be an String") if !params[:ldap_password_change].nil? and !params[:ldap_password_change].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ldap_password_change_confirmation must be an String") if !params[:ldap_password_change_confirmation].nil? and !params[:ldap_password_change_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: redirect_old_subdomain must be a single value, not #{params[:redirect_old_subdomain].class}") if [ Array, Hash ].any? { |klass| params[:redirect_old_subdomain].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: smtp_password must be an String") if !params[:smtp_password].nil? and !params[:smtp_password].is_a?(String)

      response, options = Api.send_request("/site", :patch, params, options) { |reply| reply.require_object("Site") }
      Site.new(response.data, options)
    end
  end
end
