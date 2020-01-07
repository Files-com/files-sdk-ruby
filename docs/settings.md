# Settings

## Example Settings Object

```
{
  "image_regex": ".(png|...)",
  "video_regex": ".(avi|...)",
  "audio_regex": ".(mp3|...)",
  "pdf_regex": ".(pdf|...)",
  "tab_config": "",
  "reauth": true,
  "regions": [

  ],
  "s3_regions": [

  ],
  "sales_tax_regions": [

  ],
  "current_language": "en",
  "read_only": "en",
  "session_language": "en",
  "primary_sub_domain_base": "files.com",
  "attachments_permission": true,
  "authentication_method": "password",
  "avatar_url": "",
  "dav_permission": true,
  "email": "",
  "folder_permissions_groups_only": true,
  "ftp_permission": true,
  "group_admin": true,
  "last_read_announcements_at": "2000-01-01 01:00:00 UTC",
  "name": "user",
  "notification_daily_send_time": 18,
  "self_managed": true,
  "sftp_permission": true,
  "site_admin": true,
  "skip_welcome_screen": true,
  "externally_managed": true,
  "time_zone": "Pacific Time (US & Canada)",
  "type_of_2fa": "totp",
  "reauth_2fa": "totp",
  "user_id": 1,
  "user_language": "en",
  "username": "user",
  "web_root": "web_root",
  "allowed_2fa_method_sms": true,
  "allowed_2fa_method_totp": true,
  "allowed_2fa_method_u2f": true,
  "allowed_2fa_method_yubi": true,
  "beta_features": true,
  "beta_feature2": true,
  "beta_feature3": true,
  "bundle_expiration": 1,
  "bundle_password_required": true,
  "password_requirements_apply_to_bundles": true,
  "desktop_app": true,
  "has_account": true,
  "hide_billing": true,
  "history_unavailable": true,
  "immutable_files": true,
  "overdue": true,
  "site_unavailable": true,
  "password_min_length": 1,
  "password_require_letter": true,
  "password_require_mixed": true,
  "password_require_number": true,
  "password_require_special": true,
  "public_url": "mygreatwebsite.com",
  "require_2fa": true,
  "show_request_access_link": true,
  "trial_days_left": 1,
  "trial_locked": true,
  "trial_flagged_as_duplicate": true,
  "trial_until": "2000-01-01 01:00:00 UTC",
  "use_provided_modified_at": true,
  "high_users_count": true,
  "users_count": 1,
  "color2_left": "#0066a7",
  "color2_link": "#d34f5d",
  "color2_text": "#0066a7",
  "color2_top": "#000000",
  "color2_top_text": "#ffffff",
  "disable_password_reset": true,
  "login_help_text": "Text shown on login page.",
  "site_name": "My Great Site",
  "sso_strategies": "",
  "site_footer": "",
  "site_header": "",
  "site_language": "en",
  "welcome_screen": "user_controlled",
  "icon128": "",
  "icon16": "",
  "icon32": "",
  "icon48": "",
  "logo": ""
}
```

* `image_regex` (string): All supported image types
* `video_regex` (string): All supported video types
* `audio_regex` (string): All supported audio types
* `pdf_regex` (string): All supported PDF types
* `tab_config` (string): Deprecated
* `reauth` (boolean): Password check skipped?
* `regions` (array): Region name and description
* `s3_regions` (array): Region name and description
* `sales_tax_regions` (array): States with applicable sales tax
* `current_language` (string): Current language locale setting
* `read_only` (string): Is this session read only?
* `session_language` (string): Session locale setting
* `primary_sub_domain_base` (string): Primary domain name base of the site
* `attachments_permission` (boolean): Can the user create attachments, including bundles?
* `authentication_method` (string): Authentication method for the user.  Can be `password`, `ldap`, `sso`, or `none`
* `avatar_url` (string): URL holding the user's avatar
* `dav_permission` (boolean): Can the user connect with WebDAV?
* `email` (email): User email address
* `folder_permissions_groups_only` (boolean): If true, permissions for this site must be bound to a group (not a user). Otherwise, permissions must be bound to a user.
* `ftp_permission` (boolean): Can the user access with FTP/FTPS?
* `group_admin` (boolean): Is a group administrator?
* `last_read_announcements_at` (date-time): The last date/time this user has read announcements
* `name` (string): User name
* `notification_daily_send_time` (int64): Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
* `self_managed` (boolean): Does this user manage it's own credentials?
* `sftp_permission` (boolean): Can the user access with SFTP?
* `site_admin` (boolean): Is the user an administrator for this site?
* `skip_welcome_screen` (boolean): Skip the welcome screen?
* `externally_managed` (boolean): Is this user automatically managed?
* `time_zone` (string): User time zone
* `type_of_2fa` (string): 2fa type
* `reauth_2fa` (string): 2fa type
* `user_id` (int64): User ID
* `user_language` (string): Preferred language
* `username` (string): User's username
* `web_root` (string): Root web folder
* `allowed_2fa_method_sms` (boolean): Is SMS two factor authentication allowed?
* `allowed_2fa_method_totp` (boolean): Is TOTP two factor authentication allowed?
* `allowed_2fa_method_u2f` (boolean): Is U2F two factor authentication allowed?
* `allowed_2fa_method_yubi` (boolean): Is yubikey two factor authentication allowed?
* `beta_features` (boolean): Is beta feature 1 available?
* `beta_feature2` (boolean): Is beta feature 2 available?
* `beta_feature3` (boolean): Is beta feature 3 available?
* `bundle_expiration` (int64): Site-wide bundle expiration in days
* `bundle_password_required` (boolean): Do bundle shares require password protection?
* `password_requirements_apply_to_bundles` (boolean): Do site-wide password requirements apply to bundles?
* `desktop_app` (boolean): Is the desktop app enabled?
* `has_account` (boolean): Connected to an account?
* `hide_billing` (boolean): Hide billing information?
* `history_unavailable` (boolean): Is history unavailable?
* `immutable_files` (boolean): Are files protected from modification?
* `overdue` (boolean): Is billing overdue?
* `site_unavailable` (boolean): Is the site unavailable?
* `password_min_length` (int64): Shortest password length for users
* `password_require_letter` (boolean): Require a letter in passwords?
* `password_require_mixed` (boolean): Require lower and upper case letters in passwords?
* `password_require_number` (boolean): Require a number in passwords?
* `password_require_special` (boolean): Require special characters in password?
* `public_url` (string): Site public url
* `require_2fa` (boolean): Require two-factor authentication for the current user?
* `show_request_access_link` (boolean): Show request access link for users without access?
* `trial_days_left` (int64): Number of days left in trial
* `trial_locked` (boolean): Is this site a free trial that is locked due to fraud concerns?
* `trial_flagged_as_duplicate` (boolean): Has this site been flagged as a duplicate of another trial?
* `trial_until` (date-time): When does this Site trial expire?
* `use_provided_modified_at` (boolean): Allow setting provided_modified_at?
* `high_users_count` (boolean): Does the site have a large number of users?  (Used to hide some UI features that may be slow in this case.)
* `users_count` (int64): Count of users on the site.  Only exposed for site admins.
* `color2_left` (string): Page link and button color
* `color2_link` (string): Top bar link color
* `color2_text` (string): Page link and button color
* `color2_top` (string): Top bar background color
* `color2_top_text` (string): Top bar text color
* `disable_password_reset` (boolean): Is password reset disabled?
* `login_help_text` (string): Login help text
* `site_name` (string): Site name
* `sso_strategies`: 
* `site_footer` (string): Site footer for branding
* `site_header` (string): Site header for branding
* `site_language` (string): Site language locale
* `welcome_screen` (string): Does the welcome screen appear? Can be `enabled`, `hidden`, or `disabled`
* `icon128`: Branded icon 128x128
* `icon16`: Branded icon 16x16
* `icon32`: Branded icon 32x32
* `icon48`: Branded icon 48x48
* `logo`: Branded logo
