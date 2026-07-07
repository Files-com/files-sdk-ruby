# Ip

## Example Ip Object

```
{
  "ip": "example",
  "external_ip": "example",
  "assigned": true,
  "site": {
    "name": "example",
    "certificate": "example",
    "private_key": "example",
    "key": "example",
    "intermediates": "example",
    "id": 1,
    "domain_hsts_header": true,
    "ftps_enabled": true,
    "https_enabled": true,
    "sftp_insecure_ciphers": true,
    "tls_disabled": true,
    "subdomain": "example",
    "domains": [
      "example"
    ]
  },
  "ftp_enabled": true,
  "sftp_enabled": true,
  "sftp_host_key_type": "example",
  "sftp_host_key_private_key": "example",
  "site_id": 1,
  "motd_text": "example",
  "motd_use_for_ftp": true,
  "motd_use_for_sftp": true,
  "custom_domains": [
    {
      "id": 1,
      "domain": "example",
      "destination": "example",
      "ssl_certificate_id": 1,
      "certificate": "example",
      "private_key": "example",
      "intermediates": "example"
    }
  ],
  "pair_type": "example"
}
```

* `ip` (string): Private IP of the server.
* `external_ip` (string): Public IP of the server.
* `assigned` (boolean): Flag to signal to other systems to use this config
* `site` (SslCertificate): SSL certificate information for the site associated with this IP, if available.
* `ftp_enabled` (boolean): 
* `sftp_enabled` (boolean): 
* `sftp_host_key_type` (string): Which SFTP host key to use.
* `sftp_host_key_private_key` (string): SFTP Host Key private key if using a custom key.
* `site_id` (int64): Site Id
* `motd_text` (string): A message to show users when they connect via FTP or SFTP.
* `motd_use_for_ftp` (boolean): Show message to users connecting via FTP
* `motd_use_for_sftp` (boolean): Show message to users connecting via SFTP
* `custom_domains` (array(object)): Active Custom Domains for the site associated with this IP, with their attached SSL certificate content.
* `pair_type` (string): Pair type for General Use Public IPs
