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
* `client_id` (string): OAuth Client ID for your auth provider.
* `client_secret` (string): OAuth Client Secret for your auth provider.
* `scim_password` (string): Password for scim integration if using basic auth


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


---

## Create Sso Strategy

```
Files::SsoStrategy.create(
  provider: "okta", 
  subdomain: "subdomain", 
  client_id: "[client id]", 
  client_secret: "[client secret]", 
  protocol: "okta", 
  provision_users: true, 
  provision_groups: true, 
  provision_group_default: "Employees", 
  provision_group_exclusion: "Employees", 
  provision_group_inclusion: "Employees", 
  provision_attachments_permission: true, 
  provision_dav_permission: true, 
  provision_ftp_permission: true, 
  provision_sftp_permission: true, 
  provision_time_zone: "Eastern Time (US & Canada)"
)
```

### Parameters

* `provider` (string): Required - One of the following: google, auth0, okta, atlassian, azure, box, dropbox, slack, ubuntu, onelogin, saml, idaptive
* `subdomain` (string): Subdomain or domain name for your auth provider.   Example: `https://[subdomain].okta.com/`
* `client_id` (string): OAuth Client ID for your auth provider.
* `client_secret` (string): OAuth Client Secret for your auth provider.
* `saml_provider_metadata_url` (string): Metadata URL for the SAML identity provider
* `saml_provider_cert_fingerprint` (string): Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
* `saml_provider_issuer_url` (string): Identity provider issuer url
* `saml_provider_slo_target_url` (string): Identity provider SLO endpoint
* `saml_provider_sso_target_url` (string): Identity provider SSO endpoint if saml_provider_metadata_url is not available.
* `scim_authentication_method` (string): The authentication method to use when using scim provisioning
* `scim_password` (string): Password for scim integration if using basic auth
* `scim_username` (string): Username for scim integration
* `protocol` (string): SSO Protocol
* `provision_users` (boolean): Auto-provision users?
* `provision_groups` (boolean): Auto-provision group memberships?
* `provision_group_default` (string): Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
* `provision_group_exclusion` (string): Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
* `provision_group_inclusion` (string): Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
* `provision_group_required` (string): Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
* `provision_attachments_permission` (boolean): Provisioned users to get sharing permission?
* `provision_dav_permission` (boolean): Provisioned users to get WebDAV permission?
* `provision_ftp_permission` (boolean): Provisioned users to get FTP permission?
* `provision_sftp_permission` (boolean): Provisioned users to get SFTP permission?
* `provision_time_zone` (string): Default timezone to use for provisioned users


---

## Update Sso Strategy

```
Files::SsoStrategy.update(id, 
  provider: "okta", 
  subdomain: "subdomain", 
  client_id: "[client id]", 
  client_secret: "[client secret]", 
  protocol: "okta", 
  provision_users: true, 
  provision_groups: true, 
  provision_group_default: "Employees", 
  provision_group_exclusion: "Employees", 
  provision_group_inclusion: "Employees", 
  provision_attachments_permission: true, 
  provision_dav_permission: true, 
  provision_ftp_permission: true, 
  provision_sftp_permission: true, 
  provision_time_zone: "Eastern Time (US & Canada)"
)
```

### Parameters

* `id` (int64): Required - Sso Strategy ID.
* `provider` (string): Required - One of the following: google, auth0, okta, atlassian, azure, box, dropbox, slack, ubuntu, onelogin, saml, idaptive
* `subdomain` (string): Subdomain or domain name for your auth provider.   Example: `https://[subdomain].okta.com/`
* `client_id` (string): OAuth Client ID for your auth provider.
* `client_secret` (string): OAuth Client Secret for your auth provider.
* `saml_provider_metadata_url` (string): Metadata URL for the SAML identity provider
* `saml_provider_cert_fingerprint` (string): Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
* `saml_provider_issuer_url` (string): Identity provider issuer url
* `saml_provider_slo_target_url` (string): Identity provider SLO endpoint
* `saml_provider_sso_target_url` (string): Identity provider SSO endpoint if saml_provider_metadata_url is not available.
* `scim_authentication_method` (string): The authentication method to use when using scim provisioning
* `scim_password` (string): Password for scim integration if using basic auth
* `scim_username` (string): Username for scim integration
* `protocol` (string): SSO Protocol
* `provision_users` (boolean): Auto-provision users?
* `provision_groups` (boolean): Auto-provision group memberships?
* `provision_group_default` (string): Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
* `provision_group_exclusion` (string): Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
* `provision_group_inclusion` (string): Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
* `provision_group_required` (string): Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
* `provision_attachments_permission` (boolean): Provisioned users to get sharing permission?
* `provision_dav_permission` (boolean): Provisioned users to get WebDAV permission?
* `provision_ftp_permission` (boolean): Provisioned users to get FTP permission?
* `provision_sftp_permission` (boolean): Provisioned users to get SFTP permission?
* `provision_time_zone` (string): Default timezone to use for provisioned users


---

## Delete Sso Strategy

```
Files::SsoStrategy.delete(id)
```

### Parameters

* `id` (int64): Required - Sso Strategy ID.


---

## Update Sso Strategy

```
sso_strategy = Files::SsoStrategy.find(1)
sso_strategy.update(
  provider: "okta",
  subdomain: "subdomain",
  client_id: "[client id]",
  client_secret: "[client secret]",
  protocol: "okta",
  provision_users: true,
  provision_groups: true,
  provision_group_default: "Employees",
  provision_group_exclusion: "Employees",
  provision_group_inclusion: "Employees",
  provision_attachments_permission: true,
  provision_dav_permission: true,
  provision_ftp_permission: true,
  provision_sftp_permission: true,
  provision_time_zone: "Eastern Time (US & Canada)"
)
```

### Parameters

* `id` (int64): Required - Sso Strategy ID.
* `provider` (string): Required - One of the following: google, auth0, okta, atlassian, azure, box, dropbox, slack, ubuntu, onelogin, saml, idaptive
* `subdomain` (string): Subdomain or domain name for your auth provider.   Example: `https://[subdomain].okta.com/`
* `client_id` (string): OAuth Client ID for your auth provider.
* `client_secret` (string): OAuth Client Secret for your auth provider.
* `saml_provider_metadata_url` (string): Metadata URL for the SAML identity provider
* `saml_provider_cert_fingerprint` (string): Identity provider sha256 cert fingerprint if saml_provider_metadata_url is not available.
* `saml_provider_issuer_url` (string): Identity provider issuer url
* `saml_provider_slo_target_url` (string): Identity provider SLO endpoint
* `saml_provider_sso_target_url` (string): Identity provider SSO endpoint if saml_provider_metadata_url is not available.
* `scim_authentication_method` (string): The authentication method to use when using scim provisioning
* `scim_password` (string): Password for scim integration if using basic auth
* `scim_username` (string): Username for scim integration
* `protocol` (string): SSO Protocol
* `provision_users` (boolean): Auto-provision users?
* `provision_groups` (boolean): Auto-provision group memberships?
* `provision_group_default` (string): Comma-separated list of group names for groups to automatically add all auto-provisioned users to.
* `provision_group_exclusion` (string): Comma-separated list of group names for groups (with optional wildcards) that will be excluded from auto-provisioning.
* `provision_group_inclusion` (string): Comma-separated list of group names for groups (with optional wildcards) that will be auto-provisioned.
* `provision_group_required` (string): Comma or newline separated list of group names (with optional wildcards) to require membership for user provisioning.
* `provision_attachments_permission` (boolean): Provisioned users to get sharing permission?
* `provision_dav_permission` (boolean): Provisioned users to get WebDAV permission?
* `provision_ftp_permission` (boolean): Provisioned users to get FTP permission?
* `provision_sftp_permission` (boolean): Provisioned users to get SFTP permission?
* `provision_time_zone` (string): Default timezone to use for provisioned users


---

## Delete Sso Strategy

```
sso_strategy = Files::SsoStrategy.find(1)
sso_strategy.delete
```

### Parameters

* `id` (int64): Required - Sso Strategy ID.
