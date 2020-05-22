const sample = {
  "name": "My Group",
  "id": 1,
  "admin": true,
  "usernames": [

  ]
}
const validParams = ["user_id", "group_id"]
const modelName = 'Group User'
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
    url: 'https://app.files.com/api/rest/v1/group_users.json',
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
        helpText: "User ID.  If provided, will return groups of which this user is a member.",
        required: false,
        type: 'integer',
        dynamic: 'user.id',
      },
      {
        key: 'group_id',
        label: 'Group',
        helpText: "Group ID.  If provided, will return members of this group.",
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
