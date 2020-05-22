const sample = {
  "path": "path",
  "destination": "destination"
}

const operationImportant = true
const operationLabel = 'Create Request'
const validParams = ["path", "destination", "user_ids", "group_ids"]

const extraInputFields = []
const modelName = 'Request'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/requests.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'path',
        label: 'Path',
        helpText: "Folder path on which to request the file.",
        required: true,
        type: 'string',
      },
      {
        key: 'destination',
        label: 'Destination',
        helpText: "Destination filename (without extension) to request.",
        required: true,
        type: 'string',
      },
      {
        key: 'user_ids',
        label: 'User Ids',
        helpText: "A list of user IDs to request the file from. If sent as a string, it should be comma-delimited.",
        required: false,
        type: 'string',
      },
      {
        key: 'group_ids',
        label: 'Group Ids',
        helpText: "A list of group IDs to request the file from. If sent as a string, it should be comma-delimited.",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create Request.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
