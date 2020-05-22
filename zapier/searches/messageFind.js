const sample = {
  "id": 1,
  "subject": "Files.com Account Upgrade",
  "body": "We should upgrade our Files.com account!",
  "comments": [

  ]
}

const searchMessage = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/messages/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'message',
  noun: 'Message',

  display: {
    label: 'Find Message',
    description: 'Find a single message.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "Message ID.",
        required: true,
        type: 'integer',
        dynamic: 'message.id',
      },
    ],
    perform: searchMessage,
    sample: sample
  }
}
