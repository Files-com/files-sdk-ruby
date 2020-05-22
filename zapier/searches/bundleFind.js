const sample = {
  "id": 1,
  "code": "abc123",
  "created_at": "2000-01-01T01:00:00Z",
  "description": "The public description of the bundle.",
  "expires_at": "2000-01-01T01:00:00Z",
  "paths": [

  ],
  "note": "The internal note on the bundle.",
  "password_protected": true,
  "url": "https://subdomain.files.com/f/12345678",
  "user_id": 1,
  "username": "user"
}

const searchBundle = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/bundles/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'bundle',
  noun: 'Bundle',

  display: {
    label: 'Find Bundle',
    description: 'Find a single bundle.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: "Bundle ID.",
        required: true,
        type: 'integer',
        dynamic: 'bundle.id',
      },
    ],
    perform: searchBundle,
    sample: sample
  }
}
