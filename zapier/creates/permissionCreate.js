const sample = {
  "group_id": 1,
  "permission": "full",
  "recursive": true,
  "user_id": 1,
  "username": "Sser"
}


const operationLabel = 'Create Permission'
const operationImportant = false
const validParams = ["group_id", "path", "permission", "recursive", "user_id", "username"]

const extraInputFields = []
const modelName = 'Permission'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/permissions.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'group_id',
        label: "Group ID",
        required: false,
        type: 'integer',
        dynamic: 'group.id',
      },
      {
        key: 'path',
        label: 'Path',
        helpText: "Folder path",
        required: false,
        type: 'string',
      },
      {
        key: 'permission',
        label: 'Permission',
        helpText: " Permission type.  Can be `admin`, `full`, `readonly`, `writeonly`, `previewonly`, or `history`",
        required: false,
        type: 'string',
      },
      {
        key: 'recursive',
        label: 'Recursive',
        helpText: "Apply to subfolders recursively?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'user_id',
        label: 'User',
        helpText: "User ID.  Provide `username` or `user_id`",
        required: false,
        type: 'integer',
        dynamic: 'user.id',
      },
      {
        key: 'username',
        label: 'Username',
        helpText: "User username.  Provide `username` or `user_id`",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create Permission.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
