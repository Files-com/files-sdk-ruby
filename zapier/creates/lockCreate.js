const sample = {
  "path": "path",
  "timeout": 1
}


const operationLabel = 'Create Lock'
const operationImportant = false
const validParams = ["path", "timeout"]

const extraInputFields = []
const modelName = 'Lock'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/locks/?*path.json',
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
        label: "Path",
        required: true,
        type: 'string',
      },
      {
        key: 'timeout',
        label: 'Timeout',
        helpText: "Lock timeout length",
        required: false,
        type: 'integer',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create Lock.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
