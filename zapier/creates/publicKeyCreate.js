const sample = {
  "user_id": 1,
  "title": "My Main Key",
  "public_key": "public_key"
}


const operationLabel = 'Create PublicKey'
const operationImportant = false
const validParams = ["user_id", "title", "public_key"]

const extraInputFields = []
const modelName = 'Public Key'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/public_keys.json',
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
        key: 'title',
        label: 'Title',
        helpText: "Internal reference for key.",
        required: true,
        type: 'string',
      },
      {
        key: 'public_key',
        label: 'Public Key',
        helpText: "Actual contents of SSH key.",
        required: true,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create Public Key.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
