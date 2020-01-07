# Site

## Example Site Object

```
{
  "allowed_2fa_method_sms": true,
  "allowed_2fa_method_totp": true,
  "allowed_2fa_method_u2f": true,
  "allowed_2fa_method_yubi": true,
  "admin_user_id": 1,
  "allowed_file_types": "",
  "allowed_ips": "",
  "ask_about_overwrites": true,
  "bundle_expiration": 1,
  "bundle_password_required": true,
  "color2_left": "#0066a7",
  "color2_link": "#d34f5d",
  "color2_text": "#0066a7",
  "color2_top": "#000000",
  "color2_top_text": "#ffffff",
  "created_at": "2000-01-01 01:00:00 UTC",
  "currency": "USD",
  "custom_namespace": true,
  "days_to_retain_backups": 30,
  "default_time_zone": "Pacific Time (US & Canada)",
  "desktop_app": true,
  "desktop_app_session_ip_pinning": true,
  "desktop_app_session_lifetime": 1,
  "disable_notifications": true,
  "disable_password_reset": true,
  "domain": "my-custom-domain.com",
  "email": "john.doe@files.com",
  "folder_permissions_groups_only": true,
  "hipaa": true,
  "icon128": "",
  "icon16": "",
  "icon32": "",
  "icon48": "",
  "immutable_files_set_at": "2000-01-01 01:00:00 UTC",
  "include_password_in_welcome_email": true,
  "language": "en",
  "ldap_base_dn": "",
  "ldap_domain": "mysite.com",
  "ldap_enabled": true,
  "ldap_group_action": "disabled",
  "ldap_group_exclusion": "",
  "ldap_group_inclusion": "",
  "ldap_host": "ldap.site.com",
  "ldap_host_2": "ldap2.site.com",
  "ldap_host_3": "ldap3.site.com",
  "ldap_port": 1,
  "ldap_secure": true,
  "ldap_type": "open_ldap",
  "ldap_user_action": "disabled",
  "ldap_user_include_groups": "",
  "ldap_username": "[ldap username]",
  "ldap_username_field": "sAMAccountName",
  "login_help_text": "Login page help text.",
  "logo": "",
  "max_prior_passwords": 1,
  "name": "My Site",
  "next_billing_amount": "",
  "next_billing_date": "Apr 20",
  "opt_out_global": true,
  "overage_notified_at": "2000-01-01 01:00:00 UTC",
  "overage_notify": true,
  "overdue": true,
  "password_min_length": 1,
  "password_require_letter": true,
  "password_require_mixed": true,
  "password_require_number": true,
  "password_require_special": true,
  "password_requirements_apply_to_bundles": true,
  "password_validity_days": 1,
  "phone": "555-555-5555",
  "require_2fa": true,
  "require_2fa_stop_time": "2000-01-01 01:00:00 UTC",
  "require_2fa_user_type": "`site_admins`",
  "session": "",
  "session_pinned_by_ip": true,
  "sftp_user_root_enabled": true,
  "show_request_access_link": true,
  "site_footer": "",
  "site_header": "",
  "smtp_address": "smtp.my-mail-server.com",
  "smtp_authentication": "plain",
  "smtp_from": "me@my-mail-server.com",
  "smtp_port": 25,
  "smtp_username": "mail",
  "session_expiry": 6,
  "ssl_required": true,
  "subdomain": "mysite",
  "switch_to_plan_date": "2000-01-01 01:00:00 UTC",
  "tls_disabled": true,
  "trial_days_left": 1,
  "trial_until": "2000-01-01 01:00:00 UTC",
  "updated_at": "2000-01-01 01:00:00 UTC",
  "use_provided_modified_at": true,
  "user": "",
  "user_lockout": true,
  "user_lockout_lock_period": 1,
  "user_lockout_tries": 1,
  "user_lockout_within": 6,
  "welcome_custom_text": "Welcome to my site!",
  "welcome_email_cc": "",
  "welcome_email_enabled": true,
  "welcome_screen": "user_controlled",
  "windows_mode_ftp": true,
  "disable_users_from_inactivity_period_days": 1
}
```

* `allowed_2fa_method_sms` (boolean): Is SMS two factor authentication allowed?
* `allowed_2fa_method_totp` (boolean): Is TOTP two factor authentication allowed?
* `allowed_2fa_method_u2f` (boolean): Is U2F two factor authentication allowed?
* `allowed_2fa_method_yubi` (boolean): Is yubikey two factor authentication allowed?
* `admin_user_id` (int64): User ID for the main site administrator
* `allowed_file_types` (string): List of allowed file types
* `allowed_ips` (string): List of allowed IP addresses
* `ask_about_overwrites` (boolean): If false, rename conflicting files instead of asking for overwrite confirmation.  Only applies to web interface.
* `bundle_expiration` (int64): Site-wide Bundle expiration in days
* `bundle_password_required` (boolean): Do Bundles require password protection?
* `color2_left` (string): Page link and button color
* `color2_link` (string): Top bar link color
* `color2_text` (string): Page link and button color
* `color2_top` (string): Top bar background color
* `color2_top_text` (string): Top bar text color
* `created_at` (date-time): Time this site was created
* `currency` (string): Preferred currency
* `custom_namespace` (boolean): Is this site using a custom namespace for users?
* `days_to_retain_backups` (int64): Number of days to keep deleted files
* `default_time_zone` (string): Site default time zone
* `desktop_app` (boolean): Is the desktop app enabled?
* `desktop_app_session_ip_pinning` (boolean): Is desktop app session IP pinning enabled?
* `desktop_app_session_lifetime` (int64): Desktop app session lifetime (in hours)
* `disable_notifications` (boolean): Are notifications disabled?
* `disable_password_reset` (boolean): Is password reset disabled?
* `domain` (string): Custom domain
* `email` (email): Main email for this site
* `folder_permissions_groups_only` (boolean): If true, permissions for this site must be bound to a group (not a user). Otherwise, permissions must be bound to a user.
* `hipaa` (boolean): Is there a signed HIPAA BAA between Files.com and this site?
* `icon128`: Branded icon 128x128
* `icon16`: Branded icon 16x16
* `icon32`: Branded icon 32x32
* `icon48`: Branded icon 48x48
* `immutable_files_set_at` (date-time): Can files be modified?
* `include_password_in_welcome_email` (boolean): Include password in emails to new users?
* `language` (string): Site default language
* `ldap_base_dn` (string): Base DN for looking up users in LDAP server
* `ldap_domain` (string): Domain name that will be appended to usernames
* `ldap_enabled` (boolean): Main LDAP setting: is LDAP enabled?
* `ldap_group_action` (string): Should we sync groups from LDAP server?
* `ldap_group_exclusion` (string): Comma or newline separated list of group names (with optional wildcards) to exclude when syncing.
* `ldap_group_inclusion` (string): Comma or newline separated list of group names (with optional wildcards) to include when syncing.
* `ldap_host` (string): LDAP host
* `ldap_host_2` (string): LDAP backup host
* `ldap_host_3` (string): LDAP backup host
* `ldap_port` (int64): LDAP port
* `ldap_secure` (boolean): Use secure LDAP?
* `ldap_type` (string): LDAP type
* `ldap_user_action` (string): Should we sync users from LDAP server?
* `ldap_user_include_groups` (string): Comma or newline separated list of group names (with optional wildcards) - if provided, only users in these groups will be added or synced.
* `ldap_username` (string): Username for signing in to LDAP server.
* `ldap_username_field` (string): LDAP username field
* `login_help_text` (string): Login help text
* `logo`: Branded logo
* `max_prior_passwords` (int64): Number of prior passwords to disallow
* `name` (string): Site name
* `next_billing_amount` (float): Next billing amount
* `next_billing_date` (string): Next billing date
* `opt_out_global` (boolean): Use servers in the USA only?
* `overage_notified_at` (date-time): Last time the site was notified about an overage
* `overage_notify` (boolean): Notify site email of overages?
* `overdue` (boolean): Is this site's billing overdue?
* `password_min_length` (int64): Shortest password length for users
* `password_require_letter` (boolean): Require a letter in passwords?
* `password_require_mixed` (boolean): Require lower and upper case letters in passwords?
* `password_require_number` (boolean): Require a number in passwords?
* `password_require_special` (boolean): Require special characters in password?
* `password_requirements_apply_to_bundles` (boolean): Require bundles' passwords to conform to the same requirements as users' passwords?
* `password_validity_days` (int64): Number of days password is valid
* `phone` (string): Site phone number
* `require_2fa` (boolean): Require two-factor authentication for all users?
* `require_2fa_stop_time` (date-time): If set, requirement for two-factor authentication has been scheduled to end on this date-time.
* `require_2fa_user_type` (string): What type of user is required to use two-factor authentication (when require_2fa is set to `true` for this site)?
* `session`: Current session
* `session_pinned_by_ip` (boolean): Are sessions locked to the same IP? (i.e. do users need to log in again if they change IPs?)
* `sftp_user_root_enabled` (boolean): Use user FTP roots also for SFTP?
* `show_request_access_link` (boolean): Show request access link for users without access?  Currently unused.
* `site_footer` (string): Custom site footer text
* `site_header` (string): Custom site header text
* `smtp_address` (string): SMTP server hostname or IP
* `smtp_authentication` (string): SMTP server authentication type
* `smtp_from` (string): From address to use when mailing through custom SMTP
* `smtp_port` (int64): SMTP server port
* `smtp_username` (string): SMTP server username
* `session_expiry` (int64): Session expiry in hours
* `ssl_required` (boolean): Is SSL required?  Disabling this is insecure.
* `subdomain` (string): Site subdomain
* `switch_to_plan_date` (date-time): If switching plans, when does the new plan take effect?
* `tls_disabled` (boolean): Is TLS disabled(site setting)?
* `trial_days_left` (int64): Number of days left in trial
* `trial_until` (date-time): When does this Site trial expire?
* `updated_at` (date-time): Last time this Site was updated
* `use_provided_modified_at` (boolean): Allow uploaders to set `provided_modified_at` for uploaded files?
* `user`: User of current session
* `user_lockout` (boolean): Will users be locked out after incorrect login attempts?
* `user_lockout_lock_period` (int64): How many hours to lock user out for failed password?
* `user_lockout_tries` (int64): Number of login tries within `user_lockout_within` hours before users are locked out
* `user_lockout_within` (int64): Number of hours for user lockout window
* `welcome_custom_text` (string): Custom text send in user welcome email
* `welcome_email_cc` (email): Include this email in welcome emails if enabled
* `welcome_email_enabled` (boolean): Will the welcome email be sent to new users?
* `welcome_screen` (string): Does the welcome screen appear?
* `windows_mode_ftp` (boolean): Does FTP user Windows emulation mode?
* `disable_users_from_inactivity_period_days` (int64): If greater than zero, users will unable to login if they do not show activity within this number of days.


---

## Show site settings

```
Files::Site.get
```


---

## Show plan that will be switched to in the future. (Populated if current plan is deprecated and no longer offered beyond the current billing period.)

```
Files::Site.get_switch_to_plan
```


---

## Show the current billing plan of a site

```
Files::Site.get_plan(
  currency: "USD"
)
```

### Parameters

* `currency` (string): Currency.


---

## Get either the most recent usage snapshot (usage data for billing purposes) for a Site, or optionally get a specific usage snapshot

```
Files::Site.get_usage
```


---

## Complete a PayPal subscription

```
Files::Site.get_paypal_express_info(
  paypal_token: "[token]"
)
```

### Parameters

* `paypal_token` (string): Required - Billing token for use with paypal.


---

## Initiate a new PayPal subscription

```
Files::Site.get_paypal_express(
  return_to_url: "https://app.files.com/...", 
  plan_id: 1
)
```

### Parameters

* `return_to_url` (string): Required - URL that paypal express forwards the user to.
* `plan_id` (int64): Required - Plan ID to switch to.


---

## Update site settings

```
Files::Site.update(
  name: "My Site", 
  subdomain: "mysite", 
  domain: "my-custom-domain.com", 
  email: "john.doe@files.com", 
  bundle_expiration: 1, 
  overage_notify: true, 
  welcome_email_enabled: true, 
  ask_about_overwrites: true, 
  show_request_access_link: true, 
  welcome_custom_text: "Welcome to my site!", 
  language: "en", 
  windows_mode_ftp: true, 
  default_time_zone: "Pacific Time (US & Canada)", 
  desktop_app: true, 
  desktop_app_session_ip_pinning: true, 
  desktop_app_session_lifetime: 1, 
  folder_permissions_groups_only: true, 
  welcome_screen: "user_controlled", 
  session_expiry: 1, 
  ssl_required: true, 
  tls_disabled: true, 
  user_lockout: true, 
  user_lockout_tries: 1, 
  user_lockout_within: 1, 
  user_lockout_lock_period: 1, 
  include_password_in_welcome_email: true, 
  days_to_retain_backups: 1, 
  max_prior_passwords: 1, 
  password_validity_days: 1, 
  password_min_length: 1, 
  password_require_letter: true, 
  password_require_mixed: true, 
  password_require_special: true, 
  password_require_number: true, 
  sftp_user_root_enabled: true, 
  disable_password_reset: true, 
  immutable_files: true, 
  session_pinned_by_ip: true, 
  bundle_password_required: true, 
  password_requirements_apply_to_bundles: true, 
  opt_out_global: true, 
  use_provided_modified_at: true, 
  custom_namespace: true, 
  disable_users_from_inactivity_period_days: 1, 
  allowed_2fa_method_sms: true, 
  allowed_2fa_method_u2f: true, 
  allowed_2fa_method_totp: true, 
  allowed_2fa_method_yubi: true, 
  require_2fa: true, 
  require_2fa_user_type: "`site_admins`", 
  color2_top: "#000000", 
  color2_left: "#0066a7", 
  color2_link: "#d34f5d", 
  color2_text: "#0066a7", 
  color2_top_text: "#ffffff", 
  login_help_text: "Login page help text.", 
  smtp_address: "smtp.my-mail-server.com", 
  smtp_authentication: "plain", 
  smtp_from: "me@my-mail-server.com", 
  smtp_username: "mail", 
  smtp_port: 1, 
  ldap_enabled: true, 
  ldap_type: "open_ldap", 
  ldap_host: "ldap.site.com", 
  ldap_host_2: "ldap2.site.com", 
  ldap_host_3: "ldap3.site.com", 
  ldap_port: 1, 
  ldap_secure: true, 
  ldap_username: "[ldap username]", 
  ldap_username_field: "sAMAccountName", 
  ldap_domain: "mysite.com", 
  ldap_user_action: "disabled", 
  ldap_group_action: "disabled", 
  days_until_2fa_required: 1, 
  disable_2fa_with_delay: true, 
  remove_icons: true
)
```

### Parameters

* `name` (string): Site name
* `subdomain` (string): Site subdomain
* `domain` (string): Custom domain
* `email` (string): Main email for this site
* `bundle_expiration` (int64): Site-wide Bundle expiration in days
* `overage_notify` (boolean): Notify site email of overages?
* `welcome_email_enabled` (boolean): Will the welcome email be sent to new users?
* `ask_about_overwrites` (boolean): If false, rename conflicting files instead of asking for overwrite confirmation.  Only applies to web interface.
* `show_request_access_link` (boolean): Show request access link for users without access?  Currently unused.
* `welcome_email_cc` (string): Include this email in welcome emails if enabled
* `welcome_custom_text` (string): Custom text send in user welcome email
* `language` (string): Site default language
* `windows_mode_ftp` (boolean): Does FTP user Windows emulation mode?
* `default_time_zone` (string): Site default time zone
* `desktop_app` (boolean): Is the desktop app enabled?
* `desktop_app_session_ip_pinning` (boolean): Is desktop app session IP pinning enabled?
* `desktop_app_session_lifetime` (int64): Desktop app session lifetime (in hours)
* `folder_permissions_groups_only` (boolean): If true, permissions for this site must be bound to a group (not a user). Otherwise, permissions must be bound to a user.
* `welcome_screen` (string): Does the welcome screen appear?
* `session_expiry` (int64): Session expiry in hours
* `ssl_required` (boolean): Is SSL required?  Disabling this is insecure.
* `tls_disabled` (boolean): Is TLS disabled(site setting)?
* `user_lockout` (boolean): Will users be locked out after incorrect login attempts?
* `user_lockout_tries` (int64): Number of login tries within `user_lockout_within` hours before users are locked out
* `user_lockout_within` (int64): Number of hours for user lockout window
* `user_lockout_lock_period` (int64): How many hours to lock user out for failed password?
* `include_password_in_welcome_email` (boolean): Include password in emails to new users?
* `allowed_file_types` (string): List of allowed file types
* `allowed_ips` (string): List of allowed IP addresses
* `days_to_retain_backups` (int64): Number of days to keep deleted files
* `max_prior_passwords` (int64): Number of prior passwords to disallow
* `password_validity_days` (int64): Number of days password is valid
* `password_min_length` (int64): Shortest password length for users
* `password_require_letter` (boolean): Require a letter in passwords?
* `password_require_mixed` (boolean): Require lower and upper case letters in passwords?
* `password_require_special` (boolean): Require special characters in password?
* `password_require_number` (boolean): Require a number in passwords?
* `sftp_user_root_enabled` (boolean): Use user FTP roots also for SFTP?
* `disable_password_reset` (boolean): Is password reset disabled?
* `immutable_files` (boolean): Are files protected from modification?
* `session_pinned_by_ip` (boolean): Are sessions locked to the same IP? (i.e. do users need to log in again if they change IPs?)
* `bundle_password_required` (boolean): Do Bundles require password protection?
* `password_requirements_apply_to_bundles` (boolean): Require bundles' passwords to conform to the same requirements as users' passwords?
* `opt_out_global` (boolean): Use servers in the USA only?
* `use_provided_modified_at` (boolean): Allow uploaders to set `provided_modified_at` for uploaded files?
* `custom_namespace` (boolean): Is this site using a custom namespace for users?
* `disable_users_from_inactivity_period_days` (int64): If greater than zero, users will unable to login if they do not show activity within this number of days.
* `allowed_2fa_method_sms` (boolean): Is SMS two factor authentication allowed?
* `allowed_2fa_method_u2f` (boolean): Is U2F two factor authentication allowed?
* `allowed_2fa_method_totp` (boolean): Is TOTP two factor authentication allowed?
* `allowed_2fa_method_yubi` (boolean): Is yubikey two factor authentication allowed?
* `require_2fa` (boolean): Require two-factor authentication for all users?
* `require_2fa_user_type` (string): What type of user is required to use two-factor authentication (when require_2fa is set to `true` for this site)?
* `color2_top` (string): Top bar background color
* `color2_left` (string): Page link and button color
* `color2_link` (string): Top bar link color
* `color2_text` (string): Page link and button color
* `color2_top_text` (string): Top bar text color
* `site_header` (string): Custom site header text
* `site_footer` (string): Custom site footer text
* `login_help_text` (string): Login help text
* `icon16` (object): Branded icon 16x16
* `icon32` (object): Branded icon 32x32
* `icon48` (object): Branded icon 48x48
* `icon128` (object): Branded icon 128x128
* `logo` (object): Branded logo
* `smtp_address` (string): SMTP server hostname or IP
* `smtp_authentication` (string): SMTP server authentication type
* `smtp_from` (string): From address to use when mailing through custom SMTP
* `smtp_username` (string): SMTP server username
* `smtp_port` (int64): SMTP server port
* `ldap_enabled` (boolean): Main LDAP setting: is LDAP enabled?
* `ldap_type` (string): LDAP type
* `ldap_host` (string): LDAP host
* `ldap_host_2` (string): LDAP backup host
* `ldap_host_3` (string): LDAP backup host
* `ldap_port` (int64): LDAP port
* `ldap_secure` (boolean): Use secure LDAP?
* `ldap_username` (string): Username for signing in to LDAP server.
* `ldap_username_field` (string): LDAP username field
* `ldap_domain` (string): Domain name that will be appended to usernames
* `ldap_user_action` (string): Should we sync users from LDAP server?
* `ldap_group_action` (string): Should we sync groups from LDAP server?
* `ldap_user_include_groups` (string): Comma or newline separated list of group names (with optional wildcards) - if provided, only users in these groups will be added or synced.
* `ldap_group_exclusion` (string): Comma or newline separated list of group names (with optional wildcards) to exclude when syncing.
* `ldap_group_inclusion` (string): Comma or newline separated list of group names (with optional wildcards) to include when syncing.
* `ldap_base_dn` (string): Base DN for looking up users in LDAP server
* `days_until_2fa_required` (int64): When enabling 2FA, set this to a delay period in days.
* `disable_2fa_with_delay` (boolean): If set to true, we will begin the process of disabling 2FA on this site.
* `ldap_password_change` (string): New LDAP password.
* `ldap_password_change_confirmation` (string): Confirm new LDAP password.
* `remove_icons` (boolean): If set to true, icons will be removed.
* `smtp_password` (string): Password for SMTP server.


---

## Change the current billing plan for the site

```
Files::Site.update_plan(id, 
  billing_frequency: 1
)
```

### Parameters

* `id` (int64): Required - Site ID.
* `billing_frequency` (int64): The billing frequency for the site.  Must be 1(monthly) or 12(annual).


---

## Change the current billing plan for the site

```
site = Files::Site.find(1)
site.update_plan(
  billing_frequency: 1
)
```

### Parameters

* `id` (int64): Required - Site ID.
* `billing_frequency` (int64): The billing frequency for the site.  Must be 1(monthly) or 12(annual).
