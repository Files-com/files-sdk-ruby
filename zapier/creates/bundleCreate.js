const sample = {
  "user_id": 1,
  "paths": [
    "file.txt"
  ],
  "password": "Password",
  "expires_at": "2000-01-01T01:00:00Z",
  "description": "Public description",
  "note": "Internal Note",
  "code": "abc123"
}


const operationLabel = 'Create Bundle'
const operationImportant = false
const validParams = ["user_id", "paths", "password", "expires_at", "description", "note", "code"]

const extraInputFields = []
const modelName = 'Bundle'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/bundles.json',
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
        key: 'paths',
        label: 'Paths',
        helpText: "A list of paths to include in this bundle.",
        required: true,
      },
      {
        key: 'password',
        label: 'Password',
        helpText: "Password for this bundle.",
        required: false,
        type: 'string',
      },
      {
        key: 'expires_at',
        label: 'Expires At',
        helpText: "Bundle expiration date/time.",
        required: false,
        type: 'string',
      },
      {
        key: 'description',
        label: 'Description',
        helpText: "Bundle public description",
        required: false,
        type: 'string',
      },
      {
        key: 'note',
        label: 'Note',
        helpText: "Bundle internal note",
        required: false,
        type: 'string',
      },
      {
        key: 'code',
        label: 'Code',
        helpText: "Bundle name",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create Bundle.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
