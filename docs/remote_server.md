# RemoteServer

## Example RemoteServer Object

```
{
  "id": 1,
  "authentication_method": "password",
  "hostname": "remote-server.com",
  "name": "My Remote server",
  "port": 1,
  "max_connections": 1,
  "s3_bucket": "my-bucket",
  "s3_region": "us-east-1",
  "server_certificate": "[certificate]",
  "server_type": "s3",
  "ssl": "always",
  "username": "user",
  "google_cloud_storage_bucket": "my-bucket",
  "google_cloud_storage_project_id": "my-project",
  "google_cloud_storage_credentials_json": "{}"
}
```

* `id` (int64): Remote server ID
* `authentication_method` (string): Type of authentication method
* `hostname` (string): Hostname or IP address
* `name` (string): Internal name for your reference
* `port` (int64): Port for remote server.  Not needed for S3.
* `max_connections` (int64): Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
* `s3_bucket` (string): S3 bucket name
* `s3_region` (string): S3 region
* `server_certificate` (string): Remote server certificate
* `server_type` (string): Remote server type.
* `ssl` (string): Should we require SSL?
* `username` (string): Remote server username.  Not needed for S3 buckets.
* `google_cloud_storage_bucket` (string): Google Cloud Storage bucket name
* `google_cloud_storage_project_id` (string): Google Cloud Project ID
* `google_cloud_storage_credentials_json` (string): A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
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
  max_connections: 1, 
  port: 1, 
  s3_bucket: "my-bucket", 
  s3_region: "us-east-1", 
  server_certificate: "[certificate]", 
  server_type: "s3", 
  ssl: "always", 
  username: "user", 
  google_cloud_storage_bucket: "my-bucket", 
  google_cloud_storage_project_id: "my-project", 
  google_cloud_storage_credentials_json: "{}"
)
```

### Parameters

* `aws_access_key` (string): AWS Access Key.
* `aws_secret_key` (string): AWS secret key.
* `password` (string): Password if needed.
* `private_key` (string): Private key if needed.
* `hostname` (string): Hostname or IP address
* `name` (string): Internal name for your reference
* `max_connections` (int64): Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
* `port` (int64): Port for remote server.  Not needed for S3.
* `s3_bucket` (string): S3 bucket name
* `s3_region` (string): S3 region
* `server_certificate` (string): Remote server certificate
* `server_type` (string): Remote server type.
* `ssl` (string): Should we require SSL?
* `username` (string): Remote server username.  Not needed for S3 buckets.
* `google_cloud_storage_bucket` (string): Google Cloud Storage bucket name
* `google_cloud_storage_project_id` (string): Google Cloud Project ID
* `google_cloud_storage_credentials_json` (string): A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey


---

## Update Remote Server

```
Files::RemoteServer.update(id, 
  hostname: "remote-server.com", 
  name: "My Remote server", 
  max_connections: 1, 
  port: 1, 
  s3_bucket: "my-bucket", 
  s3_region: "us-east-1", 
  server_certificate: "[certificate]", 
  server_type: "s3", 
  ssl: "always", 
  username: "user", 
  google_cloud_storage_bucket: "my-bucket", 
  google_cloud_storage_project_id: "my-project", 
  google_cloud_storage_credentials_json: "{}"
)
```

### Parameters

* `id` (int64): Required - Remote Server ID.
* `aws_access_key` (string): AWS Access Key.
* `aws_secret_key` (string): AWS secret key.
* `password` (string): Password if needed.
* `private_key` (string): Private key if needed.
* `hostname` (string): Hostname or IP address
* `name` (string): Internal name for your reference
* `max_connections` (int64): Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
* `port` (int64): Port for remote server.  Not needed for S3.
* `s3_bucket` (string): S3 bucket name
* `s3_region` (string): S3 region
* `server_certificate` (string): Remote server certificate
* `server_type` (string): Remote server type.
* `ssl` (string): Should we require SSL?
* `username` (string): Remote server username.  Not needed for S3 buckets.
* `google_cloud_storage_bucket` (string): Google Cloud Storage bucket name
* `google_cloud_storage_project_id` (string): Google Cloud Project ID
* `google_cloud_storage_credentials_json` (string): A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey


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
  max_connections: 1,
  port: 1,
  s3_bucket: "my-bucket",
  s3_region: "us-east-1",
  server_certificate: "[certificate]",
  server_type: "s3",
  ssl: "always",
  username: "user",
  google_cloud_storage_bucket: "my-bucket",
  google_cloud_storage_project_id: "my-project",
  google_cloud_storage_credentials_json: "{}"
)
```

### Parameters

* `id` (int64): Required - Remote Server ID.
* `aws_access_key` (string): AWS Access Key.
* `aws_secret_key` (string): AWS secret key.
* `password` (string): Password if needed.
* `private_key` (string): Private key if needed.
* `hostname` (string): Hostname or IP address
* `name` (string): Internal name for your reference
* `max_connections` (int64): Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
* `port` (int64): Port for remote server.  Not needed for S3.
* `s3_bucket` (string): S3 bucket name
* `s3_region` (string): S3 region
* `server_certificate` (string): Remote server certificate
* `server_type` (string): Remote server type.
* `ssl` (string): Should we require SSL?
* `username` (string): Remote server username.  Not needed for S3 buckets.
* `google_cloud_storage_bucket` (string): Google Cloud Storage bucket name
* `google_cloud_storage_project_id` (string): Google Cloud Project ID
* `google_cloud_storage_credentials_json` (string): A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey


---

## Delete Remote Server

```
remote_server = Files::RemoteServer.find(1)
remote_server.delete
```

### Parameters

* `id` (int64): Required - Remote Server ID.
