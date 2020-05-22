const sample = {
  "user_id": 1,
  "notify_on_copy": true,
  "notify_user_actions": true,
  "send_interval": "daily",
  "group_id": 1,
  "path": "path",
  "username": "User"
}


const operationLabel = 'Create Notification'
const operationImportant = false
const validParams = ["user_id", "notify_on_copy", "notify_user_actions", "send_interval", "group_id", "path", "username"]

const extraInputFields = []
const modelName = 'Notification'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/notifications.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'user_id',
        label: 'User',
        helpText: "The id of the user to notify. Provide `user_id`, `username` or `group_id`.",
        required: false,
        type: 'integer',
        dynamic: 'user.id',
      },
      {
        key: 'notify_on_copy',
        label: 'Notify On Copy',
        helpText: "If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.",
        required: false,
        type: 'boolean',
      },
      {
        key: 'notify_user_actions',
        label: 'Notify User Actions',
        helpText: "If `true` actions initiated by the user will still result in a notification",
        required: false,
        type: 'boolean',
      },
      {
        key: 'send_interval',
        label: 'Send Interval',
        helpText: "The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.",
        required: false,
        type: 'string',
      },
      {
        key: 'group_id',
        label: 'Group',
        helpText: "The ID of the group to notify.  Provide `user_id`, `username` or `group_id`.",
        required: false,
        type: 'integer',
        dynamic: 'group.id',
      },
      {
        key: 'path',
        label: "Path",
        required: false,
        type: 'string',
      },
      {
        key: 'username',
        label: 'Username',
        helpText: "The username of the user to notify.  Provide `user_id`, `username` or `group_id`.",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create Notification.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
