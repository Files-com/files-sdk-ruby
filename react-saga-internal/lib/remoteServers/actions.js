import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   aws_access_key - string - AWS Access Key.
//   aws_secret_key - string - AWS secret key.
//   password - string - Password if needed.
//   private_key - string - Private key if needed.
//   google_cloud_storage_credentials_json - string - A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
//   wasabi_access_key - string - Wasabi access key.
//   wasabi_secret_key - string - Wasabi secret key.
//   backblaze_b2_key_id - string - Backblaze B2 Cloud Storage keyID.
//   backblaze_b2_application_key - string - Backblaze B2 Cloud Storage applicationKey.
//   hostname - string - Hostname or IP address
//   name - string - Internal name for your reference
//   max_connections - integer - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
//   port - integer - Port for remote server.  Not needed for S3.
//   s3_bucket - string - S3 bucket name
//   s3_region - string - S3 region
//   server_certificate - string - Remote server certificate
//   server_type - string - Remote server type.
//   ssl - string - Should we require SSL?
//   username - string - Remote server username.  Not needed for S3 buckets.
//   google_cloud_storage_bucket - string - Google Cloud Storage bucket name
//   google_cloud_storage_project_id - string - Google Cloud Project ID
//   backblaze_b2_bucket - string - Backblaze B2 Cloud Storage Bucket name
//   backblaze_b2_s3_endpoint - string - Backblaze B2 Cloud Storage S3 Endpoint
//   wasabi_bucket - string - Wasabi region
//   wasabi_region - string - Wasabi Bucket name

const ApiUpdateRemoteServer = params => Api.patch(`/remote_servers/${params.id}`, params)
const updateRemoteServer = createActions('REMOTESERVER_UPDATE')

const ApiDeleteRemoteServer = params => Api.delete(`/remote_servers/${params.id}`, params)
const deleteRemoteServer = createActions('REMOTESERVER_DELETE')

// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.

const ApiListRemoteServer = params => Api.get(`/remote_servers`, params)
const listRemoteServer = createActions('REMOTESERVER_LIST')

// Parameters:
//   id (required) - integer - Remote Server ID.

const ApiFindRemoteServer = params => Api.get(`/remote_servers/${params.id}`, params)
const findRemoteServer = createActions('REMOTESERVER_FIND')

// Parameters:
//   aws_access_key - string - AWS Access Key.
//   aws_secret_key - string - AWS secret key.
//   password - string - Password if needed.
//   private_key - string - Private key if needed.
//   google_cloud_storage_credentials_json - string - A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
//   wasabi_access_key - string - Wasabi access key.
//   wasabi_secret_key - string - Wasabi secret key.
//   backblaze_b2_key_id - string - Backblaze B2 Cloud Storage keyID.
//   backblaze_b2_application_key - string - Backblaze B2 Cloud Storage applicationKey.
//   hostname - string - Hostname or IP address
//   name - string - Internal name for your reference
//   max_connections - integer - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
//   port - integer - Port for remote server.  Not needed for S3.
//   s3_bucket - string - S3 bucket name
//   s3_region - string - S3 region
//   server_certificate - string - Remote server certificate
//   server_type - string - Remote server type.
//   ssl - string - Should we require SSL?
//   username - string - Remote server username.  Not needed for S3 buckets.
//   google_cloud_storage_bucket - string - Google Cloud Storage bucket name
//   google_cloud_storage_project_id - string - Google Cloud Project ID
//   backblaze_b2_bucket - string - Backblaze B2 Cloud Storage Bucket name
//   backblaze_b2_s3_endpoint - string - Backblaze B2 Cloud Storage S3 Endpoint
//   wasabi_bucket - string - Wasabi region
//   wasabi_region - string - Wasabi Bucket name

const ApiCreateRemoteServer = params => Api.post(`/remote_servers`, params)
const createRemoteServer = createActions('REMOTESERVER_CREATE')

export {
  updateRemoteServer, ApiUpdateRemoteServer,
  deleteRemoteServer, ApiDeleteRemoteServer,

  listRemoteServer, ApiListRemoteServer,
  findRemoteServer, ApiFindRemoteServer,
  createRemoteServer, ApiCreateRemoteServer,
}
