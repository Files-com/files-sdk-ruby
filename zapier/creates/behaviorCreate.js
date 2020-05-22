const sample = {
  "value": "{\"method\": \"GET\"}",
  "path": "path",
  "behavior": "webhook"
}


const operationLabel = 'Create Behavior'
const operationImportant = false
const validParams = ["value", "attachment_file", "path", "behavior"]

const extraInputFields = []
const modelName = 'Behavior'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/behaviors.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'value',
        label: 'Value',
        helpText: "The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior.",
        required: false,
        type: 'string',
      },
      {
        key: 'attachment_file',
        label: 'Attachment File',
        helpText: "Certain behaviors may require a file, for instance, the \"watermark\" behavior requires a watermark image",
        required: false,
        type: 'file',
      },
      {
        key: 'path',
        label: 'Path',
        helpText: "Folder behaviors path.",
        required: true,
        type: 'string',
      },
      {
        key: 'behavior',
        label: 'Behavior',
        helpText: "Behavior type.",
        required: true,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create Behavior.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
