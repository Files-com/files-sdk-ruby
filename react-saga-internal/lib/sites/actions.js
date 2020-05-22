import { createActions } from 'utils/actions'
import Api from 'utils/api'



const ApiGetSite = params => Api.get(`/site`)
const getSite = createActions('SITE_GET')


const ApiGetUsageSite = params => Api.get(`/site/usage`)
const get_usageSite = createActions('SITE_GET_USAGE')

// Parameters:
//   name - string - Site name
//   subdomain - string - Site subdomain
//   domain - string - Custom domain
//   email - string - Main email for this site
//   allow_bundle_names - boolean - Are manual Bundle names allowed?
//   bundle_expiration - integer - Site-wide Bundle expiration in days
//   overage_notify - boolean - Notify site email of overages?
//   welcome_email_enabled - boolean - Will the welcome email be sent to new users?
//   ask_about_overwrites - boolean - If false, rename conflicting files instead of asking for overwrite confirmation.  Only applies to web interface.
//   show_request_access_link - boolean - Show request access link for users without access?  Currently unused.
//   welcome_email_cc - string - Include this email in welcome emails if enabled
//   welcome_custom_text - string - Custom text send in user welcome email
//   language - string - Site default language
//   windows_mode_ftp - boolean - Does FTP user Windows emulation mode?
//   default_time_zone - string - Site default time zone
//   desktop_app - boolean - Is the desktop app enabled?
//   desktop_app_session_ip_pinning - boolean - Is desktop app session IP pinning enabled?
//   desktop_app_session_lifetime - integer - Desktop app session lifetime (in hours)
//   folder_permissions_groups_only - boolean - If true, permissions for this site must be bound to a group (not a user). Otherwise, permissions must be bound to a user.
//   welcome_screen - string - Does the welcome screen appear?
//   session_expiry - number - Session expiry in hours
//   ssl_required - boolean - Is SSL required?  Disabling this is insecure.
//   tls_disabled - boolean - Is TLS disabled(site setting)?
//   user_lockout - boolean - Will users be locked out after incorrect login attempts?
//   user_lockout_tries - integer - Number of login tries within `user_lockout_within` hours before users are locked out
//   user_lockout_within - integer - Number of hours for user lockout window
//   user_lockout_lock_period - integer - How many hours to lock user out for failed password?
//   include_password_in_welcome_email - boolean - Include password in emails to new users?
//   allowed_ips - string - List of allowed IP addresses
//   days_to_retain_backups - integer - Number of days to keep deleted files
//   max_prior_passwords - integer - Number of prior passwords to disallow
//   password_validity_days - integer - Number of days password is valid
//   password_min_length - integer - Shortest password length for users
//   password_require_letter - boolean - Require a letter in passwords?
//   password_require_mixed - boolean - Require lower and upper case letters in passwords?
//   password_require_special - boolean - Require special characters in password?
//   password_require_number - boolean - Require a number in passwords?
//   password_require_unbreached - boolean - Require passwords that have not been previously breached? (see https://haveibeenpwned.com/)
//   sftp_user_root_enabled - boolean - Use user FTP roots also for SFTP?
//   disable_password_reset - boolean - Is password reset disabled?
//   immutable_files - boolean - Are files protected from modification?
//   session_pinned_by_ip - boolean - Are sessions locked to the same IP? (i.e. do users need to log in again if they change IPs?)
//   bundle_password_required - boolean - Do Bundles require password protection?
//   password_requirements_apply_to_bundles - boolean - Require bundles' passwords, and passwords for other items (inboxes, public shares, etc.) to conform to the same requirements as users' passwords?
//   opt_out_global - boolean - Use servers in the USA only?
//   use_provided_modified_at - boolean - Allow uploaders to set `provided_modified_at` for uploaded files?
//   custom_namespace - boolean - Is this site using a custom namespace for users?
//   disable_users_from_inactivity_period_days - integer - If greater than zero, users will unable to login if they do not show activity within this number of days.
//   allowed_2fa_method_sms - boolean - Is SMS two factor authentication allowed?
//   allowed_2fa_method_u2f - boolean - Is U2F two factor authentication allowed?
//   allowed_2fa_method_totp - boolean - Is TOTP two factor authentication allowed?
//   allowed_2fa_method_yubi - boolean - Is yubikey two factor authentication allowed?
//   require_2fa - boolean - Require two-factor authentication for all users?
//   require_2fa_user_type - string - What type of user is required to use two-factor authentication (when require_2fa is set to `true` for this site)?
//   color2_top - string - Top bar background color
//   color2_left - string - Page link and button color
//   color2_link - string - Top bar link color
//   color2_text - string - Page link and button color
//   color2_top_text - string - Top bar text color
//   site_header - string - Custom site header text
//   site_footer - string - Custom site footer text
//   login_help_text - string - Login help text
//   smtp_address - string - SMTP server hostname or IP
//   smtp_authentication - string - SMTP server authentication type
//   smtp_from - string - From address to use when mailing through custom SMTP
//   smtp_username - string - SMTP server username
//   smtp_port - integer - SMTP server port
//   ldap_enabled - boolean - Main LDAP setting: is LDAP enabled?
//   ldap_type - string - LDAP type
//   ldap_host - string - LDAP host
//   ldap_host_2 - string - LDAP backup host
//   ldap_host_3 - string - LDAP backup host
//   ldap_port - integer - LDAP port
//   ldap_secure - boolean - Use secure LDAP?
//   ldap_username - string - Username for signing in to LDAP server.
//   ldap_username_field - string - LDAP username field
//   ldap_domain - string - Domain name that will be appended to usernames
//   ldap_user_action - string - Should we sync users from LDAP server?
//   ldap_group_action - string - Should we sync groups from LDAP server?
//   ldap_user_include_groups - string - Comma or newline separated list of group names (with optional wildcards) - if provided, only users in these groups will be added or synced.
//   ldap_group_exclusion - string - Comma or newline separated list of group names (with optional wildcards) to exclude when syncing.
//   ldap_group_inclusion - string - Comma or newline separated list of group names (with optional wildcards) to include when syncing.
//   ldap_base_dn - string - Base DN for looking up users in LDAP server
//   icon16_file - file
//   icon16_delete - boolean - If true, will delete the file stored in icon16
//   icon32_file - file
//   icon32_delete - boolean - If true, will delete the file stored in icon32
//   icon48_file - file
//   icon48_delete - boolean - If true, will delete the file stored in icon48
//   icon128_file - file
//   icon128_delete - boolean - If true, will delete the file stored in icon128
//   logo_file - file
//   logo_delete - boolean - If true, will delete the file stored in logo
//   disable_2fa_with_delay - boolean - If set to true, we will begin the process of disabling 2FA on this site.
//   ldap_password_change - string - New LDAP password.
//   ldap_password_change_confirmation - string - Confirm new LDAP password.
//   smtp_password - string - Password for SMTP server.

const ApiUpdateSite = params => Api.patch(`/site`, params)
const updateSite = createActions('SITE_UPDATE')

export {

  getSite, ApiGetSite,
  get_usageSite, ApiGetUsageSite,
  updateSite, ApiUpdateSite,
}
