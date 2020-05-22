const sample = {
  "user_id": 1,
  "project_id": 1,
  "subject": "subject",
  "body": "body"
}


const operationLabel = 'Create Message'
const operationImportant = false
const validParams = ["user_id", "project_id", "subject", "body"]

const extraInputFields = []
const modelName = 'Message'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/messages.json',
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
        key: 'project_id',
        label: 'Project',
        helpText: "Project to attach the message to.",
        required: true,
        type: 'integer',
        dynamic: 'project.id',
      },
      {
        key: 'subject',
        label: 'Subject',
        helpText: "Message subject.",
        required: true,
        type: 'string',
      },
      {
        key: 'body',
        label: 'Body',
        helpText: "Message body.",
        required: true,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create Message.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
