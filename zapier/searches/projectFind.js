const sample = {
  "id": 1,
  "global_access": "none"
}

const searchProject = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/projects/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'project',
  noun: 'Project',

  display: {
    label: 'Find Project',
    description: 'Find a single project.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "Project ID.",
        required: true,
        type: 'integer',
        dynamic: 'project.id',
      },
    ],
    perform: searchProject,
    sample: sample
  }
}
