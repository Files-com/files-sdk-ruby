# SsoStrategy

## Example SsoStrategy Object

```
{
  "protocol": "okta",
  "provider": "okta",
  "id": 1,
  "saml_provider_cert_fingerprint": "",
  "saml_provider_issuer_url": "",
  "saml_provider_metadata_url": "",
  "saml_provider_slo_target_url": "",
  "saml_provider_sso_target_url": "",
  "scim_authentication_method": "",
  "scim_username": "",
  "subdomain": "my-site",
  "provision_users": true,
  "provision_groups": true,
  "provision_group_default": "Employees",
  "provision_group_exclusion": "Employees",
  "provision_group_inclusion": "Employees",
  "provision_group_required": "",
  "provision_attachments_permission": true,
  "provision_dav_permission": true,
  "provision_ftp_permission": true,
  "provision_sftp_permission": true,
  "provision_time_zone": "Eastern Time (US & Canada)"
}
```

* `protocol` (string): SSO Protocol
* `provider` (string): Provider name
* `id` (int64): ID
* `saml_provider_cert_fingerprint` (string): Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
* `saml_provider_issuer_url` (string): Identity provider issuer url
* `saml_provider_metadata_url` (string): Metadata URL for the SAML identity provider
* `saml_provider_slo_target_url` (string): Identity provider SLO endpoint
* `saml_provider_sso_target_url` (string): Identity provider SSO endpoint if saml_provider_metadata_url is not available.
* `scim_authentication_method` (string): SCIM authentication type.
* `scim_username` (string): SCIM username.
* `subdomain` (string): Subdomain
* `provision_users` (boolean): Auto-provision users?
* `provision_groups` (boolean): Auto-provision group membership based on group memberships on the SSO side?
* `provision_group_default` (string): Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
* `provision_group_exclusion` (string): Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
* `provision_group_inclusion` (string): Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
* `provision_group_required` (string): Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
* `provision_attachments_permission` (boolean): Auto-provisioned users get Sharing permission?
* `provision_dav_permission` (boolean): Auto-provisioned users get WebDAV permission?
* `provision_ftp_permission` (boolean): Auto-provisioned users get FTP permission?
* `provision_sftp_permission` (boolean): Auto-provisioned users get SFTP permission?
* `provision_time_zone` (string): Default time zone for auto provisioned users.


---

## List Sso Strategies

```
Files::SsoStrategy.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.


---

## Show Sso Strategy

```
Files::SsoStrategy.find(id)
```

### Parameters

* `id` (int64): Required - Sso Strategy ID.
