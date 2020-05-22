const sample = {
  "id": 1,
  "body": "What a great idea, thank you!",
  "reactions": [

  ]
}

const searchMessageComment = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/message_comments/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'message_comment',
  noun: 'Message Comment',

  display: {
    label: 'Find Message Comment',
    description: 'Find a single message comment.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "Message Comment ID.",
        required: true,
        type: 'integer',
        dynamic: 'message_comment.id',
      },
    ],
    perform: searchMessageComment,
    sample: sample
  }
}
