const sample = {
  "id": 1,
  "to": [
    "johndoe@gmail.com"
  ],
  "note": "Just a note."
}


const operationLabel = 'Share'
const operationImportant = false
const validParams = ["id", "to", "note"]

const extraInputFields = []
const modelName = 'Bundle'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/bundles/' + bundle.inputData.id + '/share.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'id',
        label: "Bundle ID.",
        required: true,
        type: 'integer',
      },
      {
        key: 'to',
        label: 'To',
        helpText: "A list of email addresses to share this bundle with.",
        required: true,
      },
      {
        key: 'note',
        label: 'Note',
        helpText: "Note to include in email.",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Send email(s) with a link to bundle.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
