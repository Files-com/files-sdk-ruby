const sample = {
  "id": 1,
  "path": "",
  "user_id": 1,
  "username": "Sser",
  "group_id": 1,
  "group_name": "",
  "permission": "full",
  "recursive": true
}
const validParams = ["path", "group_id", "user_id", "include_groups"]
const modelName = 'Permission'
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
    url: 'https://app.files.com/api/rest/v1/permissions.json',
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
        key: 'path',
        label: 'Path',
        helpText: "Permission path.  If provided, will scope permissions to this path.",
        required: false,
        type: 'string',
      },
      {
        key: 'group_id',
        label: 'Group',
        helpText: "Group ID.  If provided, will scope permissions to this group.",
        required: false,
        type: 'string',
        dynamic: 'group.id',
      },
      {
        key: 'user_id',
        label: 'User',
        helpText: "User ID.  If provided, will scope permissions to this user.",
        required: false,
        type: 'string',
        dynamic: 'user.id',
      },
      {
        key: 'include_groups',
        label: 'Include Groups',
        helpText: "If searching by user or group, also include user's permissions that are inherited from its groups?",
        required: false,
        type: 'boolean',
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
