const sample = {
  "id": 1,
  "emoji": "👍"
}

const searchMessageReaction = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/message_reactions/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'message_reaction',
  noun: 'Message Reaction',

  display: {
    label: 'Find Message Reaction',
    description: 'Find a single message reaction.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "Message Reaction ID.",
        required: true,
        type: 'integer',
        dynamic: 'message_reaction.id',
      },
    ],
    perform: searchMessageReaction,
    sample: sample
  }
}
