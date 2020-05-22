const sample = {
  "id": 1,
  "name": "owners",
  "admin_ids": [

  ],
  "notes": "",
  "user_ids": [

  ],
  "usernames": [

  ]
}

const searchGroup = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/groups/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'group',
  noun: 'Group',

  display: {
    label: 'Find Group',
    description: 'Find a single group.',
    important: true,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: "Group ID.",
        required: true,
        type: 'integer',
        dynamic: 'group.id',
      },
    ],
    perform: searchGroup,
    sample: sample
  }
}
