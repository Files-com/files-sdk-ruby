const sample = {
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
  "backblaze_b2_s3_endpoint": "s3.us-west-001.backblazeb2.com",
  "backblaze_b2_bucket": "my-bucket",
  "wasabi_bucket": "us-west-1",
  "wasabi_region": "my-bucket"
}

const searchRemoteServer = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/remote_servers/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'remote_server',
  noun: 'Remote Server',

  display: {
    label: 'Find Remote Server',
    description: 'Find a single remote server.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "Remote Server ID.",
        required: true,
        type: 'integer',
        dynamic: 'remote_server.id',
      },
    ],
    perform: searchRemoteServer,
    sample: sample
  }
}
