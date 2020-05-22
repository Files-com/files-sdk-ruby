const sample = {
  "id": 1,
  "path": "",
  "attachment_url": "",
  "behavior": "webhook",
  "value": {
    "method": "GET"
  }
}
const validParams = ["path", "recursive", "behavior"]
const modelName = 'Behavior'
const noun = modelName
const display = {
  label: `${modelName} Created`,
  description: `Triggers when a new ${modelName.replace(/_/g, ' ')} is created.`,
  important: false,
}

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/behaviors/folders/?*path.json',
    params: {
      per_page: 10000,
      page: 1,
      ...requestParams,
    },
  })

  return responsePromise
    .then(response => JSON.parse(response.content))
}

const inputFields = [
      {
        key: 'path',
        label: 'Path',
        helpText: "Path to operate on.",
        required: true,
        type: 'string',
      },
      {
        key: 'recursive',
        label: 'Recursive',
        helpText: "Show behaviors below this path?",
        required: false,
        type: 'string',
      },
      {
        key: 'behavior',
        label: 'Behavior',
        helpText: "If set only shows folder behaviors matching this behavior type.",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: noun,
  display: display,

  operation: {
    canPaginate: true,
    inputFields: inputFields,
    perform: perform,
    sample: sample,
  }
}
