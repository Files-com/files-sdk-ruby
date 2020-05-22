const sample = {
  "path": "locked_file",
  "timeout": 43200,
  "depth": "infinity",
  "owner": "user",
  "scope": "shared",
  "token": "17c54824e9931a4688ca032d03f6663c",
  "type": "write",
  "user_id": 1,
  "username": "username"
}
const validParams = ["path", "include_children"]
const modelName = 'Lock'
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
    url: 'https://app.files.com/api/rest/v1/locks/?*path.json',
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
        key: 'include_children',
        label: 'Include Children',
        helpText: "Include locks from children objects?",
        required: false,
        type: 'boolean',
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
