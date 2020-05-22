const sample = {
  "id": 1,
  "as2_partnership_name": "Test",
  "created_at": "2000-01-01T01:00:00Z",
  "fingerprint": "cf:cb:d3:26:52:6c:55:88:83:17:13:cf:e7:70:eb:1b:32:37:38:c0"
}

const searchAs2Key = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/as2_keys/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'as2_key',
  noun: 'As2 Key',

  display: {
    label: 'Find As2 Key',
    description: 'Find a single as2 key.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "As2 Key ID.",
        required: true,
        type: 'integer',
        dynamic: 'as2_key.id',
      },
    ],
    perform: searchAs2Key,
    sample: sample
  }
}
