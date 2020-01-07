# RemoteServer

## Example RemoteServer Object

```
{
  "id": 1,
  "hostname": "remote-server.com",
  "name": "My Remote server",
  "port": 1,
  "s3_bucket": "my-bucket",
  "s3_region": "us-east-1",
  "server_certificate": "[certificate]",
  "server_type": "s3",
  "ssl": "always",
  "username": "user"
}
```

* `id` (int64): Remote server ID
* `hostname` (string): Hostname or IP address
* `name` (string): Internal name for your reference
* `port` (int64): Port for remote server.  Not needed for S3.
* `s3_bucket` (string): S3 bucket name
* `s3_region` (string): S3 region
* `server_certificate` (string): Remote server certificate
* `server_type` (string): Remote server type.
* `ssl` (string): Should we require SSL?
* `username` (string): Remote server username.  Not needed for S3 buckets.
* `aws_access_key` (string): AWS Access Key.
* `aws_secret_key` (string): AWS secret key.
* `password` (string): Password if needed.
* `private_key` (string): Private key if needed.


---

## List Remote Servers

```
Files::RemoteServer.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.


---

## Show Remote Server

```
Files::RemoteServer.find(id)
```

### Parameters

* `id` (int64): Required - Remote Server ID.


---

## Create Remote Server

```
Files::RemoteServer.create(
  hostname: "remote-server.com", 
  name: "My Remote server", 
  port: 1, 
  s3_bucket: "my-bucket", 
  s3_region: "us-east-1", 
  server_certificate: "[certificate]", 
  server_type: "s3", 
  ssl: "always", 
  username: "user"
)
```

### Parameters

* `aws_access_key` (string): AWS Access Key.
* `aws_secret_key` (string): AWS secret key.
* `hostname` (string): Hostname.
* `name` (string): Internal reference name for server.
* `password` (string): Password if needed.
* `port` (string): Port.
* `private_key` (string): Private key if needed.
* `s3_bucket` (string): S3 bucket name.
* `s3_region` (string): S3 region.
* `server_certificate` (string): Certificate for this server.
* `server_type` (string): Type of server.  Can be ftp, sftp, or s3.
* `ssl` (string): SSL requirements.  Can be if_available, require, require_implicit, never.
* `username` (string): Server username if needed.


---

## Update Remote Server

```
Files::RemoteServer.update(id, 
  hostname: "remote-server.com", 
  name: "My Remote server", 
  port: 1, 
  s3_bucket: "my-bucket", 
  s3_region: "us-east-1", 
  server_certificate: "[certificate]", 
  server_type: "s3", 
  ssl: "always", 
  username: "user"
)
```

### Parameters

* `id` (int64): Required - Remote Server ID.
* `aws_access_key` (string): AWS Access Key.
* `aws_secret_key` (string): AWS secret key.
* `hostname` (string): Hostname.
* `name` (string): Internal reference name for server.
* `password` (string): Password if needed.
* `port` (string): Port.
* `private_key` (string): Private key if needed.
* `s3_bucket` (string): S3 bucket name.
* `s3_region` (string): S3 region.
* `server_certificate` (string): Certificate for this server.
* `server_type` (string): Type of server.  Can be ftp, sftp, or s3.
* `ssl` (string): SSL requirements.  Can be if_available, require, require_implicit, never.
* `username` (string): Server username if needed.


---

## Delete Remote Server

```
Files::RemoteServer.delete(id)
```

### Parameters

* `id` (int64): Required - Remote Server ID.


---

## Update Remote Server

```
remote_server = Files::RemoteServer.find(1)
remote_server.update(
  hostname: "remote-server.com",
  name: "My Remote server",
  port: 1,
  s3_bucket: "my-bucket",
  s3_region: "us-east-1",
  server_certificate: "[certificate]",
  server_type: "s3",
  ssl: "always",
  username: "user"
)
```

### Parameters

* `id` (int64): Required - Remote Server ID.
* `aws_access_key` (string): AWS Access Key.
* `aws_secret_key` (string): AWS secret key.
* `hostname` (string): Hostname.
* `name` (string): Internal reference name for server.
* `password` (string): Password if needed.
* `port` (string): Port.
* `private_key` (string): Private key if needed.
* `s3_bucket` (string): S3 bucket name.
* `s3_region` (string): S3 region.
* `server_certificate` (string): Certificate for this server.
* `server_type` (string): Type of server.  Can be ftp, sftp, or s3.
* `ssl` (string): SSL requirements.  Can be if_available, require, require_implicit, never.
* `username` (string): Server username if needed.


---

## Delete Remote Server

```
remote_server = Files::RemoteServer.find(1)
remote_server.delete
```

### Parameters

* `id` (int64): Required - Remote Server ID.
