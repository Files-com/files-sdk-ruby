const sample = {
  "id": 1,
  "path": "",
  "attachment_url": "",
  "behavior": "webhook",
  "value": {
    "method": "GET"
  }
}

const searchBehavior = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/behaviors/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'behavior',
  noun: 'Behavior',

  display: {
    label: 'Find Behavior',
    description: 'Find a single behavior.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "Behavior ID.",
        required: true,
        type: 'integer',
        dynamic: 'behavior.id',
      },
    ],
    perform: searchBehavior,
    sample: sample
  }
}
