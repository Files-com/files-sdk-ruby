const sample = {
  "id": 1,
  "path": "",
  "source": "",
  "destination": "",
  "automation_id": "",
  "user_display_name": ""
}
const validParams = ["mine", "path"]
const modelName = 'Request'
const noun = modelName
const display = {
  label: `${modelName} Created`,
  description: `Triggers when a new ${modelName.replace(/_/g, ' ')} is created.`,
  important: true,
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
    url: 'https://app.files.com/api/rest/v1/requests.json',
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
        key: 'mine',
        label: 'Mine',
        helpText: "Only show requests of the current user?  (Defaults to true if current user is not a site admin.)",
        required: false,
        type: 'boolean',
      },
      {
        key: 'path',
        label: 'Path',
        helpText: "Path to show requests for.  If omitted, shows all paths. Send `/` to represent the root directory.",
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
