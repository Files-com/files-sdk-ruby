const sample = {
  "id": 1,
  "automation": "create_folder",
  "source": "",
  "destination": "",
  "destination_replace_from": "",
  "destination_replace_to": "",
  "interval": "week",
  "next_process_on": "2020-01-01",
  "path": "",
  "realtime": true,
  "user_id": 1,
  "user_ids": [

  ],
  "group_ids": [

  ]
}

const searchAutomation = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/automations/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'automation',
  noun: 'Automation',

  display: {
    label: 'Find Automation',
    description: 'Find a single automation.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "Automation ID.",
        required: true,
        type: 'integer',
        dynamic: 'automation.id',
      },
    ],
    perform: searchAutomation,
    sample: sample
  }
}
