const sample = {
  "user_id": 1,
  "file_comment_id": 1,
  "emoji": "emoji"
}


const operationLabel = 'Create FileCommentReaction'
const operationImportant = false
const validParams = ["user_id", "file_comment_id", "emoji"]

const extraInputFields = []
const modelName = 'File Comment Reaction'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/file_comment_reactions.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
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
        key: 'file_comment_id',
        label: 'File Comment',
        helpText: "ID of file comment to attach reaction to.",
        required: true,
        type: 'integer',
        dynamic: 'file_comment.id',
      },
      {
        key: 'emoji',
        label: 'Emoji',
        helpText: "Emoji to react with.",
        required: true,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create File Comment Reaction.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
