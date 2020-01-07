# Certificate

## Example Certificate Object

```
{
  "id": 1,
  "certificate": "[certificate]",
  "created_at": "2000-01-01 01:00:00 UTC",
  "display_status": "Available",
  "domains": [

  ],
  "expires_at": "2000-01-01 01:00:00 UTC",
  "brick_managed": true,
  "intermediates": "[certificates]",
  "ip_addresses": [

  ],
  "issuer": "",
  "name": "My Certificate",
  "key_type": "RSA-4096",
  "request": "[CSR]",
  "status": "Available",
  "subject": "my-custom-domain.com",
  "updated_at": "2000-01-01 01:00:00 UTC"
}
```

* `id` (int64): Certificate ID
* `certificate` (string): Full text of SSL certificate
* `created_at` (date-time): Certificate created at
* `display_status` (string): Certificate status. (One of `Request Generated`, `New`, `Active`, `Active/Expired`, `Expired`, or `Available`)
* `domains` (array): Domains on this certificate other than files.com domains
* `expires_at` (date-time): Certificate expiration date/time
* `brick_managed` (boolean): Is this certificate automatically managed and renewed by Files.com?
* `intermediates` (string): Intermediate certificates
* `ip_addresses` (array): A list of IP addresses associated with this SSL Certificate
* `issuer` (string): X509 issuer
* `name` (string): Descriptive name of certificate
* `key_type` (string): Type of key
* `request` (string): Certificate signing request text
* `status` (string): Certificate status (Request Generated, New, Active, Active/Expired, Expired, or Available)
* `subject` (string): X509 Subject name
* `updated_at` (date-time): Certificated last updated at
* `certificate_domain` (string): Domain for certificate.
* `certificate_country` (string): Country.
* `certificate_state_or_province` (string): State or province.
* `certificate_city_or_locale` (string): City or locale.
* `certificate_company_name` (string): Company name.
* `csr_ou1` (string): Department name or organization unit 1
* `csr_ou2` (string): Department name or organization unit 2
* `csr_ou3` (string): Department name or organization unit 3
* `certificate_email_address` (string): Email address for the certificate owner.
* `key_type_confirm_given` (string): Confirms the key type.
* `private_key` (string): Certificate private key.
* `password` (string): Certificate password.


---

## List Certificates

```
Files::Certificate.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.


---

## Show Certificate

```
Files::Certificate.find(id)
```

### Parameters

* `id` (int64): Required - Certificate ID.


---

## Create CSR or import existing SSL Certificate

```
Files::Certificate.create(
  name: "Name", 
  certificate_domain: "domain.com", 
  key_type: "RSA-4096", 
  certificate: "[certificate]", 
  intermediates: "[certificates]"
)
```

### Parameters

* `name` (string): Required - Internal name of the SSL certificate.
* `certificate_domain` (string): Domain for certificate.
* `certificate_country` (string): Country.
* `certificate_state_or_province` (string): State or province.
* `certificate_city_or_locale` (string): City or locale.
* `certificate_company_name` (string): Company name.
* `csr_ou1` (string): Department name or organization unit 1
* `csr_ou2` (string): Department name or organization unit 2
* `csr_ou3` (string): Department name or organization unit 3
* `certificate_email_address` (string): Email address for the certificate owner.
* `key_type` (string): Any supported key type.  Defaults to `RSA-4096`.
* `key_type_confirm_given` (string): Confirms the key type.
* `certificate` (string): The certificate.  PEM or PKCS7 formats accepted.
* `private_key` (string): Certificate private key.
* `password` (string): Certificate password.
* `intermediates` (string): Intermediate certificates.  PEM or PKCS7 formats accepted.


---

## Deactivate SSL Certificate

```
Files::Certificate.deactivate(id)
```

### Parameters

* `id` (int64): Required - Certificate ID.


---

## Activate SSL Certificate

```
Files::Certificate.activate(id, 
  replace_cert: ""
)
```

### Parameters

* `id` (int64): Required - Certificate ID.
* `replace_cert` (string): Leave blank, set to `any` or `new_ips`.


---

## Update Certificate

```
Files::Certificate.update(id, 
  name: "My Certificate", 
  intermediates: "[certificates]", 
  certificate: "[certificate]"
)
```

### Parameters

* `id` (int64): Required - Certificate ID.
* `name` (string): Internal certificate name.
* `intermediates` (string): Any intermediate certificates.  PEM or PKCS7 formats accepted.
* `certificate` (string): The certificate.  PEM or PKCS7 formats accepted.


---

## Delete Certificate

```
Files::Certificate.delete(id)
```

### Parameters

* `id` (int64): Required - Certificate ID.


---

## Deactivate SSL Certificate

```
certificate = Files::Certificate.find(1)
certificate.deactivate
```

### Parameters

* `id` (int64): Required - Certificate ID.


---

## Activate SSL Certificate

```
certificate = Files::Certificate.find(1)
certificate.activate(
  replace_cert: ""
)
```

### Parameters

* `id` (int64): Required - Certificate ID.
* `replace_cert` (string): Leave blank, set to `any` or `new_ips`.


---

## Update Certificate

```
certificate = Files::Certificate.find(1)
certificate.update(
  name: "My Certificate",
  intermediates: "[certificates]",
  certificate: "[certificate]"
)
```

### Parameters

* `id` (int64): Required - Certificate ID.
* `name` (string): Internal certificate name.
* `intermediates` (string): Any intermediate certificates.  PEM or PKCS7 formats accepted.
* `certificate` (string): The certificate.  PEM or PKCS7 formats accepted.


---

## Delete Certificate

```
certificate = Files::Certificate.find(1)
certificate.delete
```

### Parameters

* `id` (int64): Required - Certificate ID.
