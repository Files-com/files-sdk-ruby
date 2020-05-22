const sample = {
  "user_id": 1,
  "name": "My Key",
  "permission_set": "full",
  "expires_at": "2000-01-01T01:00:00Z"
}


const operationLabel = 'Create ApiKey'
const operationImportant = false
const validParams = ["user_id", "name", "permission_set", "expires_at"]

const extraInputFields = []
const modelName = 'Api Key'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/api_keys.json',
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
        key: 'name',
        label: 'Name',
        helpText: "Internal name for key.  For your reference only.",
        required: false,
        type: 'string',
      },
      {
        key: 'permission_set',
        label: 'Permission Set',
        helpText: "Leave blank, or set to 'desktop_app' to restrict the key to only desktop app functions.",
        required: false,
        type: 'string',
      },
      {
        key: 'expires_at',
        label: 'Expires At',
        helpText: "Have the key expire at this date/time.",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create Api Key.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
