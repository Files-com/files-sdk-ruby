const sample = {
  "id": 1,
  "emoji": "👍"
}

const searchMessageCommentReaction = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/message_comment_reactions/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'message_comment_reaction',
  noun: 'Message Comment Reaction',

  display: {
    label: 'Find Message Comment Reaction',
    description: 'Find a single message comment reaction.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "Message Comment Reaction ID.",
        required: true,
        type: 'integer',
        dynamic: 'message_comment_reaction.id',
      },
    ],
    perform: searchMessageCommentReaction,
    sample: sample
  }
}
