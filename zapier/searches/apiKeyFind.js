const sample = {
  "id": 1,
  "descriptive_label": "Site-wide API key for https://site.files.com/ (key ID #1)",
  "created_at": "2000-01-01T01:00:00Z",
  "expires_at": "2000-01-01T01:00:00Z",
  "key": "[key]",
  "last_use_at": "2000-01-01T01:00:00Z",
  "name": "My Main API Key",
  "permission_set": "full",
  "platform": "win32",
  "user_id": 1
}

const searchApiKey = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/api_keys/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'api_key',
  noun: 'Api Key',

  display: {
    label: 'Find Api Key',
    description: 'Find a single api key.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "Api Key ID.",
        required: true,
        type: 'integer',
        dynamic: 'api_key.id',
      },
    ],
    perform: searchApiKey,
    sample: sample
  }
}
