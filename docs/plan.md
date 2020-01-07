# Plan

## Example Plan Object

```
{
  "id": 1,
  "advanced_behaviors": true,
  "antivirus_advanced": true,
  "antivirus_basic": true,
  "audit_hours": 1,
  "auth_google": true,
  "auth_oauth": true,
  "auth_oauth_custom": true,
  "auth_user_count": 1,
  "automations": true,
  "custom_namespace": true,
  "custom_smtp": true,
  "dedicated_ip": true,
  "dedicated_ips": 1,
  "differences": "",
  "domain": true,
  "domain_count": 1,
  "email_inboxes": true,
  "extended_folder_permissions": true,
  "extended_log_retention": true,
  "free_developer_accounts": 1,
  "ftp_sftp_webdav": true,
  "full_text_search": true,
  "global_acceleration": true,
  "gpg": true,
  "group_admins_enabled": true,
  "group_notifications": true,
  "hipaa": true,
  "html_branding": true,
  "ldap": true,
  "legal_flexibility": true,
  "max_folder_size": "10000",
  "max_individual_file_size": "5 TB",
  "name": "Enterprise",
  "nested_groups": true,
  "preview_page_limit": 100,
  "regions_included": 2,
  "remote_sync_ftp": true,
  "remote_sync_interval": 1,
  "remote_sync_other": true,
  "remote_sync_s3": true,
  "require_2fa": true,
  "site_fields_requiring_upgrade": [

  ],
  "support_level": "standard",
  "usage_cost": "0.1",
  "usage_included": "2500",
  "users": 1,
  "watermark_documents": true,
  "watermark_images": true,
  "webhooks": true,
  "webhooks_sns": true,
  "whitelabel": true,
  "activation_cost": "10.0",
  "annually": "2988.0",
  "currency": "USD",
  "monthly": "249.0",
  "user_cost": "5.0"
}
```

* `id` (int64): Plan ID
* `advanced_behaviors` (boolean): Are advanced behaviors included in plan?
* `antivirus_advanced` (boolean): Is advanced antivirus included in plan?
* `antivirus_basic` (boolean): Is basic antivirus included in plan?
* `audit_hours` (int64): How many audit hours included in plan?
* `auth_google` (boolean): Is google authentication included in plan?
* `auth_oauth` (boolean): Is oauth included in plan?
* `auth_oauth_custom` (boolean): Is custom oauth included in plan?
* `auth_user_count` (int64): Number of SSO, 2FA, Desktop users included in plan
* `automations` (boolean): Are automations included in plan?
* `custom_namespace` (boolean): If true all usernames can be used, otherwise usernames must be unique
* `custom_smtp` (boolean): Custom SMTP support?
* `dedicated_ip` (boolean): Offers dedicated ip?
* `dedicated_ips` (int64): Number of dedicated IPs
* `differences` (object): Results of comparing with a different Plan
* `domain` (boolean): Custom domain(s)?
* `domain_count` (int64): Number of custom domains
* `email_inboxes` (boolean): Does the plan include E-Mail inboxes?
* `extended_folder_permissions` (boolean): Supports extended folder permissions like viewing history?
* `extended_log_retention` (boolean): Can log preservation be extended?
* `free_developer_accounts` (int64): Number of free developer accounts
* `ftp_sftp_webdav` (boolean): Supports connections via FTP, SFTP, and WebDAV?
* `full_text_search` (boolean): Full text search enabled?
* `global_acceleration` (boolean): Global acceleration enabled?
* `gpg` (boolean): Support for GPG encryption?
* `group_admins_enabled` (boolean): Group admin functionality enabled?
* `group_notifications` (boolean): Group notifications functionality enabled?
* `hipaa` (boolean): Support for HIPAA regulation?
* `html_branding` (boolean): HTML branding available?
* `ldap` (boolean): LDAP integration enabled?
* `legal_flexibility` (boolean): Does the plan offer any legal flexibility?
* `max_folder_size` (int64): Max number of files in a folder
* `max_individual_file_size` (int64): Maximum individual file size
* `name` (string): Plan name
* `nested_groups` (boolean): Are nested groups enabled?
* `preview_page_limit` (int64): Number of previews available
* `regions_included` (int64): Number of storage regions included
* `remote_sync_ftp` (boolean): Remote sync with FTP available?
* `remote_sync_interval` (int64): Number of hours between remote sync
* `remote_sync_other` (boolean): Are other forms of remote sync available?
* `remote_sync_s3` (boolean): Can sync to s3 bucket?
* `require_2fa` (boolean): 2FA support enabled?
* `site_fields_requiring_upgrade` (array): Site attributes which require upgrade
* `support_level` (string): Priority of customer support
* `usage_cost` (string): Usage cost per GB of overage
* `usage_included` (string): Usage included per month, in GB
* `users` (int64): # of users included.  0 or -1 mean unlimited.
* `watermark_documents` (boolean): Watermark enabled?
* `watermark_images` (boolean): Watermark enabled?
* `webhooks` (boolean): Webhooks enabled?
* `webhooks_sns` (boolean): Webhook SNS integration enabled?
* `whitelabel` (boolean): Whitelabel site?
* `activation_cost` (string): Activation cost (upfront)
* `annually` (string): Price annually
* `currency` (string): Currency
* `monthly` (string): Price monthly
* `user_cost` (string): Cost per additional user


---

## List Plans

```
Files::Plan.list(
  page: 1, 
  per_page: 1, 
  currency: "USD"
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `currency` (string): Currency.
