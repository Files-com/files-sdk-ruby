const sample = {
  "username": "username",
  "password": "password",
  "otp": "123456"
}


const operationLabel = 'Create Session'
const operationImportant = false
const validParams = ["username", "password", "otp", "partial_session_id"]

const extraInputFields = []
const modelName = 'Session'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/sessions.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'username',
        label: 'Username',
        helpText: "Username to sign in as",
        required: false,
        type: 'string',
      },
      {
        key: 'password',
        label: 'Password',
        helpText: "Password for sign in",
        required: false,
        type: 'string',
      },
      {
        key: 'otp',
        label: 'Otp',
        helpText: "If this user has a 2FA device, provide its OTP or code here.",
        required: false,
        type: 'string',
      },
      {
        key: 'partial_session_id',
        label: 'Partial Session',
        helpText: "Identifier for a partially-completed login",
        required: false,
        type: 'string',
        dynamic: 'partial_session.id',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create user session (log in).",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
