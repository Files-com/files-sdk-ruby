const sample = {
  "name": "owners"
}


const operationLabel = 'Create Group'
const operationImportant = false
const validParams = ["name", "notes", "user_ids", "admin_ids"]

const extraInputFields = []
const modelName = 'Group'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/groups.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'name',
        label: 'Name',
        helpText: "Group name.",
        required: false,
        type: 'string',
      },
      {
        key: 'notes',
        label: 'Notes',
        helpText: "Group notes.",
        required: false,
        type: 'string',
      },
      {
        key: 'user_ids',
        label: 'User Ids',
        helpText: "A list of user ids. If sent as a string, should be comma-delimited.",
        required: false,
        type: 'string',
      },
      {
        key: 'admin_ids',
        label: 'Admin Ids',
        helpText: "A list of group admin user ids. If sent as a string, should be comma-delimited.",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create Group.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
