const sample = {
  "url": "https://www.site.com/...",
  "method": "GET",
  "encoding": "RAW"
}


const operationLabel = 'Webhook Test'
const operationImportant = false
const validParams = ["url", "method", "encoding"]

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
    url: 'https://app.files.com/api/rest/v1/behaviors/webhook/test.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'url',
        label: 'Url',
        helpText: "URL for testing the webhook.",
        required: true,
        type: 'string',
      },
      {
        key: 'method',
        label: 'Method',
        helpText: "HTTP method(GET or POST).",
        required: false,
        type: 'string',
      },
      {
        key: 'encoding',
        label: 'Encoding',
        helpText: "HTTP encoding method.  Can be JSON, XML, or RAW (form data).",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Test webhook.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
