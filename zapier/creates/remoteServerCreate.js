const sample = {
  "hostname": "remote-server.com",
  "name": "My Remote server",
  "max_connections": 1,
  "port": 1,
  "s3_bucket": "my-bucket",
  "s3_region": "us-east-1",
  "server_certificate": "[certificate]",
  "server_type": "s3",
  "ssl": "always",
  "username": "user",
  "google_cloud_storage_bucket": "my-bucket",
  "google_cloud_storage_project_id": "my-project",
  "backblaze_b2_bucket": "my-bucket",
  "backblaze_b2_s3_endpoint": "s3.us-west-001.backblazeb2.com",
  "wasabi_bucket": "us-west-1",
  "wasabi_region": "my-bucket"
}


const operationLabel = 'Create RemoteServer'
const operationImportant = false
const validParams = ["aws_access_key", "aws_secret_key", "password", "private_key", "google_cloud_storage_credentials_json", "wasabi_access_key", "wasabi_secret_key", "backblaze_b2_key_id", "backblaze_b2_application_key", "hostname", "name", "max_connections", "port", "s3_bucket", "s3_region", "server_certificate", "server_type", "ssl", "username", "google_cloud_storage_bucket", "google_cloud_storage_project_id", "backblaze_b2_bucket", "backblaze_b2_s3_endpoint", "wasabi_bucket", "wasabi_region"]

const extraInputFields = []
const modelName = 'Remote Server'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/remote_servers.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'aws_access_key',
        label: 'Aws Access Key',
        helpText: "AWS Access Key.",
        required: false,
        type: 'string',
      },
      {
        key: 'aws_secret_key',
        label: 'Aws Secret Key',
        helpText: "AWS secret key.",
        required: false,
        type: 'string',
      },
      {
        key: 'password',
        label: 'Password',
        helpText: "Password if needed.",
        required: false,
        type: 'string',
      },
      {
        key: 'private_key',
        label: 'Private Key',
        helpText: "Private key if needed.",
        required: false,
        type: 'string',
      },
      {
        key: 'google_cloud_storage_credentials_json',
        label: 'Google Cloud Storage Credentials Json',
        helpText: "A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey",
        required: false,
        type: 'string',
      },
      {
        key: 'wasabi_access_key',
        label: 'Wasabi Access Key',
        helpText: "Wasabi access key.",
        required: false,
        type: 'string',
      },
      {
        key: 'wasabi_secret_key',
        label: 'Wasabi Secret Key',
        helpText: "Wasabi secret key.",
        required: false,
        type: 'string',
      },
      {
        key: 'backblaze_b2_key_id',
        label: 'Backblaze B2 Key',
        helpText: "Backblaze B2 Cloud Storage keyID.",
        required: false,
        type: 'string',
        dynamic: 'backblaze_b2_key.id',
      },
      {
        key: 'backblaze_b2_application_key',
        label: 'Backblaze B2 Application Key',
        helpText: "Backblaze B2 Cloud Storage applicationKey.",
        required: false,
        type: 'string',
      },
      {
        key: 'hostname',
        label: 'Hostname',
        helpText: "Hostname or IP address",
        required: false,
        type: 'string',
      },
      {
        key: 'name',
        label: 'Name',
        helpText: "Internal name for your reference",
        required: false,
        type: 'string',
      },
      {
        key: 'max_connections',
        label: 'Max Connections',
        helpText: "Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).",
        required: false,
        type: 'integer',
      },
      {
        key: 'port',
        label: 'Port',
        helpText: "Port for remote server.  Not needed for S3.",
        required: false,
        type: 'integer',
      },
      {
        key: 's3_bucket',
        label: 'S3 Bucket',
        helpText: "S3 bucket name",
        required: false,
        type: 'string',
      },
      {
        key: 's3_region',
        label: "S3 region",
        required: false,
        type: 'string',
      },
      {
        key: 'server_certificate',
        label: 'Server Certificate',
        helpText: "Remote server certificate",
        required: false,
        type: 'string',
        choices: {require_match: 'require_match', allow_any: 'allow_any'},
      },
      {
        key: 'server_type',
        label: 'Server Type',
        helpText: "Remote server type.",
        required: false,
        type: 'string',
        choices: {ftp: 'ftp', sftp: 'sftp', s3: 's3', google_cloud_storage: 'google_cloud_storage', webdav: 'webdav', wasabi: 'wasabi', backblaze_b2: 'backblaze_b2'},
      },
      {
        key: 'ssl',
        label: 'Ssl',
        helpText: "Should we require SSL?",
        required: false,
        type: 'string',
        choices: {if_available: 'if_available', require: 'require', require_implicit: 'require_implicit', never: 'never'},
      },
      {
        key: 'username',
        label: 'Username',
        helpText: "Remote server username.  Not needed for S3 buckets.",
        required: false,
        type: 'string',
      },
      {
        key: 'google_cloud_storage_bucket',
        label: 'Google Cloud Storage Bucket',
        helpText: "Google Cloud Storage bucket name",
        required: false,
        type: 'string',
      },
      {
        key: 'google_cloud_storage_project_id',
        label: 'Google Cloud Storage Project',
        helpText: "Google Cloud Project ID",
        required: false,
        type: 'string',
        dynamic: 'google_cloud_storage_project.id',
      },
      {
        key: 'backblaze_b2_bucket',
        label: 'Backblaze B2 Bucket',
        helpText: "Backblaze B2 Cloud Storage Bucket name",
        required: false,
        type: 'string',
      },
      {
        key: 'backblaze_b2_s3_endpoint',
        label: 'Backblaze B2 S3 Endpoint',
        helpText: "Backblaze B2 Cloud Storage S3 Endpoint",
        required: false,
        type: 'string',
      },
      {
        key: 'wasabi_bucket',
        label: 'Wasabi Bucket',
        helpText: "Wasabi region",
        required: false,
        type: 'string',
      },
      {
        key: 'wasabi_region',
        label: 'Wasabi Region',
        helpText: "Wasabi Bucket name",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create Remote Server.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
