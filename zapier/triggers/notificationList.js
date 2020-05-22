const sample = {
  "id": 1,
  "path": "path",
  "group_id": 1,
  "group_name": "",
  "notify_user_actions": true,
  "notify_on_copy": true,
  "send_interval": "fifteen_minutes",
  "unsubscribed": true,
  "unsubscribed_reason": "",
  "user_id": 1,
  "username": "User",
  "suppressed_email": "suppressed_email"
}
const validParams = ["user_id", "group_id"]
const modelName = 'Notification'
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
    url: 'https://app.files.com/api/rest/v1/notifications.json',
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
        key: 'user_id',
        label: 'User',
        helpText: "Show notifications for this User ID.",
        required: false,
        type: 'integer',
        dynamic: 'user.id',
      },
      {
        key: 'group_id',
        label: 'Group',
        helpText: "Show notifications for this Group ID.",
        required: false,
        type: 'integer',
        dynamic: 'group.id',
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
