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

    # string - Current language locale setting
    def current_language
      @attributes[:current_language]
    end

    # date-time - Current Time in UTC
    def current_time
      @attributes[:current_time]
    end

    # array(object) - Region name and description
    def linode_regions
      @attributes[:linode_regions]
    end

    # array(object) - Region name and description
    def wasabi_regions
      @attributes[:wasabi_regions]
    end

    # string - Primary domain name base of the site
    def primary_sub_domain_base
      @attributes[:primary_sub_domain_base]
    end

    # boolean - Is this session read only?
    def read_only
      @attributes[:read_only]
    end

    # boolean - Password check skipped?
    def reauth
      @attributes[:reauth]
    end

    # array(object) - Region name and description
    def regions
      @attributes[:regions]
    end

    # array(object) - Region name and description
    def s3_regions
      @attributes[:s3_regions]
    end

    # array(object) - States with applicable sales tax
    def sales_tax_regions
      @attributes[:sales_tax_regions]
    end

    # string - Session locale setting
    def session_language
      @attributes[:session_language]
    end

    # string - Deprecated
    def tab_config
      @attributes[:tab_config]
    end

    # boolean - Can users bypass 2FA policies?
    def allow_bypassing_2fa_policies
      @attributes[:allow_bypassing_2fa_policies]
    end

    # boolean - Can partner admins manage user credentials?
    def allow_credential_changes
      @attributes[:allow_credential_changes]
    end

    # boolean - Can partner admins provide their own GPG keys?
    def allow_providing_gpg_keys
      @attributes[:allow_providing_gpg_keys]
    end

    # boolean - Can partner admins create new users?
    def allow_user_creation
      @attributes[:allow_user_creation]
    end

    # string - Custom error message to show when bundle is not found.
    def bundle_not_found_message
      @attributes[:bundle_not_found_message]
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

    # boolean - Calculate CRC32 checksum for incoming files?
    def calculate_file_checksums_crc32
      @attributes[:calculate_file_checksums_crc32]
    end

    # boolean - Calculate MD5 checksum for incoming files?
    def calculate_file_checksums_md5
      @attributes[:calculate_file_checksums_md5]
    end

    # boolean - Calculate SHA1 checksum for incoming files?
    def calculate_file_checksums_sha1
      @attributes[:calculate_file_checksums_sha1]
    end

    # boolean - Calculate SHA256 checksum for incoming files?
    def calculate_file_checksums_sha256
      @attributes[:calculate_file_checksums_sha256]
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

    # boolean - If true, allow public viewers of Bundles with full permissions to use document editing integrations.
    def document_edits_in_bundle_allowed
      @attributes[:document_edits_in_bundle_allowed]
    end

    # string - Custom domain
    def domain
      @attributes[:domain]
    end

    # boolean - Is password reset disabled?
    def disable_password_reset
      @attributes[:disable_password_reset]
    end

    # string - Clickwrap body text to show on every web login.
    def login_clickwrap_body
      @attributes[:login_clickwrap_body]
    end

    # int64 - ID of clickwrap the user must accept.
    def pending_clickwrap_id
      @attributes[:pending_clickwrap_id]
    end

    # string - Body of clickwrap the user must accept.
    def pending_clickwrap_body
      @attributes[:pending_clickwrap_body]
    end

    # boolean - Whether the desktop app should hide drive mounting, prevent new drive mounts, and unmount active drive mounts.
    def disable_drive_mounting
      @attributes[:disable_drive_mounting]
    end

    # object - Mappings from drive letters to paths for the desktop application.
    def desktop_drive_mappings
      @attributes[:desktop_drive_mappings]
    end

    # boolean - Whether remote desktop debug log upload is enabled for this user.
    def remote_desktop_debug_logging_enabled
      @attributes[:remote_desktop_debug_logging_enabled]
    end

    # date-time - When remote desktop debug logging expires for this user.
    def remote_desktop_debug_logging_expires_at
      @attributes[:remote_desktop_debug_logging_expires_at]
    end

    # boolean - True if the current user can access any named Workspaces (id > 0).
    def has_workspaces
      @attributes[:has_workspaces]
    end

    # boolean - True if the current user has access to any GPG keys.
    def has_accessible_gpg_keys
      @attributes[:has_accessible_gpg_keys]
    end

    # int64 - Workspace ID the user should land in by default when more than one Workspace is available.
    def default_workspace_id
      @attributes[:default_workspace_id]
    end

    # boolean - Use legacy checksums mode?
    def legacy_checksums_mode
      @attributes[:legacy_checksums_mode]
    end

    # string - Login help text (as HTML).  Unsafe! Deprecated! Do Not Use!
    def login_help_text
      @attributes[:login_help_text]
    end

    # string - Login help text (as Markdown)
    def login_help_text_markdown
      @attributes[:login_help_text_markdown]
    end

    # string - Site name
    def site_name
      @attributes[:site_name]
    end

    # string - Which document editing integration to support. Files.com Editor or Microsoft Office for the Web.
    def office_integration_type
      @attributes[:office_integration_type]
    end

    # boolean - If true, allows users to use a document editing integration.
    def office_integration_enabled
      @attributes[:office_integration_enabled]
    end

    # string - Document editing integration hostname for API calls.
    def office_integration_host
      @attributes[:office_integration_host]
    end

    # string - Link to scheduling a meeting with our Sales team
    def oncehub_link
      @attributes[:oncehub_link]
    end

    # boolean - If true, allows users to use a document editing integration.
    def office_integration_available
      @attributes[:office_integration_available]
    end

    # boolean - If true, we will hide the 'Remember Me' box on Inbox and Bundle registration pages, requiring that the user logout and log back in every time they visit the page.
    def require_logout_from_bundles_and_inboxes
      @attributes[:require_logout_from_bundles_and_inboxes]
    end

    # boolean - Is self signup available?
    def self_signup_eligible
      @attributes[:self_signup_eligible]
    end

    # boolean - Show request access link for users without access?
    def show_request_access_link
      @attributes[:show_request_access_link]
    end

    # string - Site footer for branding (as Markdown) on authenticated (logged-in) user pages
    def site_footer_markdown
      @attributes[:site_footer_markdown]
    end

    # string - Site header for branding (as Markdown) on authenticated (logged-in) user pages
    def site_header_markdown
      @attributes[:site_header_markdown]
    end

    # string - Custom footer text for system-generated emails. Supports strftime patterns like %Y (4-digit year), %m (month), %d (day).
    def email_footer_custom_text_markdown
      @attributes[:email_footer_custom_text_markdown]
    end

    # string - Site header for branding (as Markdown) on public (unauthenticated) pages.
    def site_public_header_markdown
      @attributes[:site_public_header_markdown]
    end

    # string - Site footer for branding (as Markdown) on public (unauthenticated) pages.
    def site_public_footer_markdown
      @attributes[:site_public_footer_markdown]
    end

    # string - Site language locale
    def site_language
      @attributes[:site_language]
    end

    # int64 - Site ID
    def site_id
      @attributes[:site_id]
    end

    # SsoStrategy - SSO strategies in use
    def sso_strategies
      @attributes[:sso_strategies]
    end

    # string - Site subdomain
    def subdomain
      @attributes[:subdomain]
    end

    # boolean - Allow setting provided_modified_at?
    def use_provided_modified_at
      @attributes[:use_provided_modified_at]
    end

    # boolean - Is the user requests feature enabled?
    def user_requests_enabled
      @attributes[:user_requests_enabled]
    end

    # string - Does the welcome screen appear? Can be `enabled`, `hidden`, or `disabled`
    def welcome_screen
      @attributes[:welcome_screen]
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

    # Image - Branded logo
    def logo
      @attributes[:logo]
    end

    # Image - Branded login page background
    def login_page_background_image
      @attributes[:login_page_background_image]
    end

    # Image - Branded Logo thumbnail
    def logo_thumbnail
      @attributes[:logo_thumbnail]
    end

    # Image - Branded login page background thumbnail
    def login_page_background_image_thumbnail
      @attributes[:login_page_background_image_thumbnail]
    end

    # boolean
    def attachments_permission
      @attributes[:attachments_permission]
    end

    # string - Authentication method for the user.  Can be `password`, `sso`, or `none`
    def authentication_method
      @attributes[:authentication_method]
    end

    # string - URL holding the user's avatar
    def avatar_url
      @attributes[:avatar_url]
    end

    # boolean - Allow this user to perform operations on the account, payments, and invoices?
    def billing_permission
      @attributes[:billing_permission]
    end

    # array(object) - All permissions applicable to this user, including permissions inherited via groups.
    def cached_permissions
      @attributes[:cached_permissions]
    end

    # boolean - If true, user has admin permissions somewhere on the site.
    def can_admin_somewhere
      @attributes[:can_admin_somewhere]
    end

    # boolean - If true, user has bundle permissions somewhere on the site.
    def can_bundle_somewhere
      @attributes[:can_bundle_somewhere]
    end

    # boolean - If true, user has write, full, or admin permissions somewhere on the site.
    def can_write_somewhere
      @attributes[:can_write_somewhere]
    end

    # boolean - Can the user connect with WebDAV?
    def dav_permission
      @attributes[:dav_permission]
    end

    # int64 - Number of days remaining until password expires
    def days_remaining_until_password_expire
      @attributes[:days_remaining_until_password_expire]
    end

    # email - User email address
    def email
      @attributes[:email]
    end

    # boolean - Can the user access with FTP/FTPS?
    def ftp_permission
      @attributes[:ftp_permission]
    end

    # boolean - Is a group administrator?
    def group_admin
      @attributes[:group_admin]
    end

    # string - Text to display to the user in the header of the UI
    def header_text
      @attributes[:header_text]
    end

    # boolean - Is the in-app AI assistant available to the current user?
    def in_app_ai_assistant_available
      @attributes[:in_app_ai_assistant_available]
    end

    # int64 - AI Assistant Personality ID for the in-app AI Assistant.
    def ai_assistant_personality_id
      @attributes[:ai_assistant_personality_id]
    end

    # string - System prompt for the in-app AI Assistant.
    def ai_assistant_personality_system_prompt
      @attributes[:ai_assistant_personality_system_prompt]
    end

    # object - Supported file transform input and output formats
    def file_transform_capabilities
      @attributes[:file_transform_capabilities]
    end

    # int64 - User ID
    def id
      @attributes[:id]
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

    # boolean - Should the user receive site warnings via email?
    def notify_on_all_site_warnings
      @attributes[:notify_on_all_site_warnings]
    end

    # boolean - Should the user receive sso/scim/ldap configuration/sync failures via email?
    def notify_on_all_sso_failures
      @attributes[:notify_on_all_sso_failures]
    end

    # boolean - Should the user receive user security events via email?
    def notify_on_all_user_security_events
      @attributes[:notify_on_all_user_security_events]
    end

    # boolean - Should the user receive pending work failures via email?
    def notify_on_all_pending_work_failures
      @attributes[:notify_on_all_pending_work_failures]
    end

    # boolean - Should the user receive siem failures via email?
    def notify_on_all_siem_http_destination_failures
      @attributes[:notify_on_all_siem_http_destination_failures]
    end

    # boolean - Should the user receive sync failures via email?
    def notify_on_all_sync_failures
      @attributes[:notify_on_all_sync_failures]
    end

    # boolean - Should the user receive automation failures via email?
    def notify_on_all_automation_failures
      @attributes[:notify_on_all_automation_failures]
    end

    # boolean - Should the user receive expectation failures and misses via email?
    def notify_on_all_expectation_failures
      @attributes[:notify_on_all_expectation_failures]
    end

    # boolean - Is this user a Partner administrator?
    def partner_admin
      @attributes[:partner_admin]
    end

    # int64 - Primary group ID for Group Admin scoping
    def primary_group_id
      @attributes[:primary_group_id]
    end

    # int64 - Partner ID, if applicable.
    def partner_id
      @attributes[:partner_id]
    end

    # boolean - Does this user use a File System Layout that restricts creating Files, Folders, or Settings in the Root Folder?
    def root_folder_restricted
      @attributes[:root_folder_restricted]
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

    # boolean - Is the user a read-only administrator for this site?
    def readonly_site_admin
      @attributes[:readonly_site_admin]
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

    # string - URL where this user can login
    def user_login_url
      @attributes[:user_login_url]
    end

    # string - User filesystem root
    def user_root
      @attributes[:user_root]
    end

    # string - User's username
    def username
      @attributes[:username]
    end

    # string - Root web folder
    def web_root
      @attributes[:web_root]
    end

    # boolean - Is the user a Workspace administrator?
    def workspace_admin
      @attributes[:workspace_admin]
    end

    # boolean - Is the current response scoped to a specific workspace?
    def workspace_scoped
      @attributes[:workspace_scoped]
    end

    # boolean - Has the user been asked to respond to an NPS survey?
    def nps_response_requested
      @attributes[:nps_response_requested]
    end

    # int64 - Number of active Storage Regions in use
    def active_region_count
      @attributes[:active_region_count]
    end

    # boolean - Allow admins to bypass the locked subfolders setting.
    def admins_bypass_locked_subfolders
      @attributes[:admins_bypass_locked_subfolders]
    end

    # array(string) - Additional extensions that are considered text files
    def additional_text_file_types
      @attributes[:additional_text_file_types]
    end

    # array(string) - Extensions that are treated as text previews.
    def text_preview_extensions
      @attributes[:text_preview_extensions]
    end

    # boolean - Are users allowed to configure their two factor authentication to be bypassed for FTP/SFTP/WebDAV?
    def allowed_2fa_method_bypass_for_ftp_sftp_dav
      @attributes[:allowed_2fa_method_bypass_for_ftp_sftp_dav]
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

    # boolean - Are manual Bundle names allowed?
    def allow_bundle_names
      @attributes[:allow_bundle_names]
    end

    # boolean - Allow the site-wide two-factor authentication requirement to be overriden on a per-user-basis?
    def allow_user_level_2fa_override
      @attributes[:allow_user_level_2fa_override]
    end

    # boolean - If true, SSO users using the default user-level two-factor authentication setting are exempt from the site-wide two-factor authentication requirement.
    def require_2fa_exempt_all_sso_users
      @attributes[:require_2fa_exempt_all_sso_users]
    end

    # boolean - Allow the site-wide allowed IP restriction to be overriden on a per-user-basis?
    def allow_user_level_allowed_ip_override
      @attributes[:allow_user_level_allowed_ip_override]
    end

    # boolean - Allow the site-wide FTP SSL requirement to be overriden on a per-user-basis?
    def allow_user_level_ssl_override
      @attributes[:allow_user_level_ssl_override]
    end

    # boolean - Are free email domains allowed for bundle and inbox recipients?
    def bundle_recipient_blacklist_free_email_domains
      @attributes[:bundle_recipient_blacklist_free_email_domains]
    end

    # array(string) - List of domains that are not allowed for bundle and inbox recipients
    def bundle_recipient_blacklist_domains
      @attributes[:bundle_recipient_blacklist_domains]
    end

    # string - Do Bundle owners receive activity notifications?
    def bundle_activity_notifications
      @attributes[:bundle_activity_notifications]
    end

    # int64 - Site-wide bundle expiration in days
    def bundle_expiration
      @attributes[:bundle_expiration]
    end

    # boolean - Do bundle shares require password protection?
    def bundle_password_required
      @attributes[:bundle_password_required]
    end

    # string - Do Bundle owners receive registration notification?
    def bundle_registration_notifications
      @attributes[:bundle_registration_notifications]
    end

    # boolean - Do Bundles require registration?
    def bundle_require_registration
      @attributes[:bundle_require_registration]
    end

    # boolean - Do bundles require recipients for sharing?
    def bundle_require_share_recipient
      @attributes[:bundle_require_share_recipient]
    end

    # boolean - Do bundles require a note?
    def bundle_require_note
      @attributes[:bundle_require_note]
    end

    # string - Do Bundle uploaders receive upload confirmation notification?
    def bundle_upload_receipt_notifications
      @attributes[:bundle_upload_receipt_notifications]
    end

    # int64 - Number of child sites available
    def child_site_count_for_plan
      @attributes[:child_site_count_for_plan]
    end

    # boolean - Is the desktop app enabled?
    def desktop_app
      @attributes[:desktop_app]
    end

    # boolean - Is legacy ExaVault API Available?
    def exavault_api_available
      @attributes[:exavault_api_available]
    end

    # boolean - Does the site's plan include the ECA Feature bundle?
    def feature_bundle_eca
      @attributes[:feature_bundle_eca]
    end

    # boolean - Does the site's plan include the Power Feature bundle?
    def feature_bundle_power
      @attributes[:feature_bundle_power]
    end

    # boolean - Does the site's plan include the Enterprise Feature bundle?
    def feature_bundle_premier
      @attributes[:feature_bundle_premier]
    end

    # boolean - If true, permissions for this site must be bound to a group (not a user).
    def folder_permissions_groups_only
      @attributes[:folder_permissions_groups_only]
    end

    # boolean - Allow group admins to create users in their groups
    def group_admins_can_add_users
      @attributes[:group_admins_can_add_users]
    end

    # boolean - Allow group admins to delete users in their groups
    def group_admins_can_delete_users
      @attributes[:group_admins_can_delete_users]
    end

    # boolean - Allow group admins to enable or disable users in their groups
    def group_admins_can_enable_disable_users
      @attributes[:group_admins_can_enable_disable_users]
    end

    # boolean - Allow group admins to modify users in their groups
    def group_admins_can_modify_users
      @attributes[:group_admins_can_modify_users]
    end

    # boolean - Allow group admins to exempt users in their groups from lifecycle rules
    def group_admins_can_bypass_user_lifecycle_rules
      @attributes[:group_admins_can_bypass_user_lifecycle_rules]
    end

    # boolean - Allow group admins to reset passwords for users in their groups
    def group_admins_can_reset_passwords
      @attributes[:group_admins_can_reset_passwords]
    end

    # boolean - Allow group admins set password authentication method
    def group_admins_can_set_user_password
      @attributes[:group_admins_can_set_user_password]
    end

    # boolean - Connected to an account?
    def has_account
      @attributes[:has_account]
    end

    # boolean - Hide billing information?
    def hide_billing
      @attributes[:hide_billing]
    end

    # boolean - Does the site have a large number of users?  (Used to hide some UI features that may be slow in this case.)
    def high_users_count
      @attributes[:high_users_count]
    end

    # boolean - Is history unavailable?
    def history_unavailable
      @attributes[:history_unavailable]
    end

    # boolean - Are files protected from modification?
    def immutable_files
      @attributes[:immutable_files]
    end

    # string - Intersitial page to show
    def intersitial_page
      @attributes[:intersitial_page]
    end

    # boolean - Is this a child site?
    def is_child_site
      @attributes[:is_child_site]
    end

    # object - Visibility settings for account navigation
    def left_navigation_visibility
      @attributes[:left_navigation_visibility]
    end

    # int64 - Minimum remote server sync interval allowed by plan (in minutes)
    def min_remote_sync_interval
      @attributes[:min_remote_sync_interval]
    end

    # boolean - If true, groups can be manually created / modified / deleted by Site Admins. Otherwise, groups can only be managed via your SSO provider.
    def non_sso_groups_allowed
      @attributes[:non_sso_groups_allowed]
    end

    # boolean - If true, users can be manually created / modified / deleted by Site Admins. Otherwise, users can only be managed via your SSO provider.
    def non_sso_users_allowed
      @attributes[:non_sso_users_allowed]
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

    # boolean - Require passwords that have not been previously breached? (see https://haveibeenpwned.com/)
    def password_require_unbreached
      @attributes[:password_require_unbreached]
    end

    # boolean - Do site-wide password requirements apply to bundles?
    def password_requirements_apply_to_bundles
      @attributes[:password_requirements_apply_to_bundles]
    end

    # boolean - Does current plan include AS2 functionality?
    def plan_as2_included
      @attributes[:plan_as2_included]
    end

    # boolean - Prevent regular users to be granted with root folder permissions
    def prevent_root_permissions_for_non_site_admins
      @attributes[:prevent_root_permissions_for_non_site_admins]
    end

    # boolean - If `true`, protocol access permissions on users will be ignored, and only protocol access permissions set on Groups will be honored.  Make sure that your current user is a member of a group with API permission when changing this value to avoid locking yourself out of your site.
    def protocol_access_groups_only
      @attributes[:protocol_access_groups_only]
    end

    # string - Site public url
    def public_url
      @attributes[:public_url]
    end

    # boolean - Is public sharing allowed?
    def public_sharing_allowed
      @attributes[:public_sharing_allowed]
    end

    # boolean - Require two-factor authentication for the current user?
    def require_2fa
      @attributes[:require_2fa]
    end

    # string - Root region of site.  Used for SSL certificate termination, IP Address assignment, and regional pinning of remote servers.  If blank, assume us-east-1.
    def root_region
      @attributes[:root_region]
    end

    # boolean - Auto-removes bundles for disabled/deleted users and enforces bundle expiry within user access period.
    def revoke_bundle_access_on_disable_or_delete
      @attributes[:revoke_bundle_access_on_disable_or_delete]
    end

    # boolean - Allow bundle creation
    def sharing_enabled
      @attributes[:sharing_enabled]
    end

    # boolean - Allow snapshot bundle creation
    def snapshot_sharing_enabled
      @attributes[:snapshot_sharing_enabled]
    end

    # int64 - Number of child sites available
    def staging_site_count_for_plan
      @attributes[:staging_site_count_for_plan]
    end

    # boolean - Has this site been flagged as a duplicate of another trial?
    def trial_flagged_as_duplicate
      @attributes[:trial_flagged_as_duplicate]
    end

    # int64 - Number of days left in trial
    def trial_days_left
      @attributes[:trial_days_left]
    end

    # boolean - Is this site a free trial that is locked due to fraud concerns?
    def trial_locked
      @attributes[:trial_locked]
    end

    # date-time - When does this Site trial expire?
    def trial_until
      @attributes[:trial_until]
    end

    # int64 - Usage included in site's plan, in GB
    def usage_included
      @attributes[:usage_included]
    end

    # boolean - Allow users to create their own API keys?
    def users_can_create_api_keys
      @attributes[:users_can_create_api_keys]
    end

    # boolean - Allow users to create their own SSH keys?
    def users_can_create_ssh_keys
      @attributes[:users_can_create_ssh_keys]
    end

    # boolean - If true, we will migrate all remote server syncs to the new Sync model.
    def migrate_remote_server_sync_to_sync
      @attributes[:migrate_remote_server_sync_to_sync]
    end

    # int64 - Count of users on the site.  Only exposed for site admins.
    def users_count
      @attributes[:users_count]
    end

    # array(object) - All sites that this user has access to.
    def session_available_sites
      @attributes[:session_available_sites]
    end

    # int64 - User ID of the Site Admin who initiated a Read-Only session impersonating this session's user
    def impersonator_user_id
      @attributes[:impersonator_user_id]
    end
  end
end
