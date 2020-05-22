const sample = {
  "body": "body",
  "path": "path"
}


const operationLabel = 'Create FileComment'
const operationImportant = false
const validParams = ["body", "path"]

const extraInputFields = []
const modelName = 'File Comment'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/file_comments.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'body',
        label: 'Body',
        helpText: "Comment body.",
        required: true,
        type: 'string',
      },
      {
        key: 'path',
        label: "File path.",
        required: true,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create File Comment.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
