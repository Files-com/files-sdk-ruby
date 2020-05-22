const sample = {
  "id": 1,
  "emoji": "👍"
}
const validParams = ["user_id", "message_comment_id"]
const modelName = 'Message Comment Reaction'
const noun = modelName
const display = {
  label: `${modelName} Created`,
  description: `Triggers when a new ${modelName.replace(/_/g, ' ')} is created.`,
  important: false,
}

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/message_comment_reactions.json',
    params: {
      per_page: 10000,
      page: 1,
      ...requestParams,
    },
  })

  return responsePromise
    .then(response => JSON.parse(response.content))
}

const inputFields = [
      {
        key: 'user_id',
        label: 'User',
        helpText: "User ID.  Provide a value of `0` to operate the current session's user.",
        required: false,
        type: 'integer',
        dynamic: 'user.id',
      },
      {
        key: 'message_comment_id',
        label: 'Message Comment',
        helpText: "Message comment to return reactions for.",
        required: true,
        type: 'integer',
        dynamic: 'message_comment.id',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: noun,
  display: display,

  operation: {
    canPaginate: true,
    inputFields: inputFields,
    perform: perform,
    sample: sample,
  }
}
