const sample = {
  "path": "path",
  "mkdir_parents": true,
  "part": 1,
  "parts": 1,
  "ref": "upload-1",
  "restart": 1,
  "with_rename": true
}


const operationLabel = 'Begin Upload'
const operationImportant = false
const validParams = ["path", "mkdir_parents", "part", "parts", "ref", "restart", "with_rename"]

const extraInputFields = []
const modelName = 'File Action'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/file_actions/begin_upload/?*path.json',
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
        helpText: "Path to operate on.",
        required: true,
        type: 'string',
      },
      {
        key: 'mkdir_parents',
        label: 'Mkdir Parents',
        helpText: "Create parent directories if they do not exist?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'part',
        label: 'Part',
        helpText: "Part if uploading a part.",
        required: false,
        type: 'integer',
      },
      {
        key: 'parts',
        label: 'Parts',
        helpText: "How many parts to fetch?",
        required: false,
        type: 'integer',
      },
      {
        key: 'ref',
        label: 'Ref',
        required: false,
        type: 'string',
      },
      {
        key: 'restart',
        label: 'Restart',
        helpText: "File byte offset to restart from.",
        required: false,
        type: 'integer',
      },
      {
        key: 'with_rename',
        label: 'With Rename',
        helpText: "Allow file rename instead of overwrite?",
        required: false,
        type: 'boolean',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Begin file upload.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
