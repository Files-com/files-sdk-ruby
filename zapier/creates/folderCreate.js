const sample = {
  "path": "path"
}

const validParams = ["path"]
 
const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const path = encodeURIComponent(requestParams['path'] || '').replace('%2F', '/')
  const responsePromise = z.request({
    method: 'POST',
    url: `https://app.files.com/api/rest/v1/folders/${path}`,
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const operationLabel = 'Create Folder'
const operationImportant = false
const extraInputFields = []
const modelName = 'Folder'


const inputFields = [
      {
        key: 'path',
        label: 'Path',
        helpText: "Path to operate on.",
        required: true,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create folder.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
