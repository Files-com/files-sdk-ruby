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

const searchNotification = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/notifications/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'notification',
  noun: 'Notification',

  display: {
    label: 'Find Notification',
    description: 'Find a single notification.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "Notification ID.",
        required: true,
        type: 'integer',
        dynamic: 'notification.id',
      },
    ],
    perform: searchNotification,
    sample: sample
  }
}
