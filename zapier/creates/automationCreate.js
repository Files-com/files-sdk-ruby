const sample = {
  "automation": "create_folder",
  "source": "source",
  "destination": "destination",
  "interval": "year"
}


const operationLabel = 'Create Automation'
const operationImportant = false
const validParams = ["automation", "source", "destination", "destination_replace_from", "destination_replace_to", "interval", "path", "user_ids", "group_ids"]

const extraInputFields = []
const modelName = 'Automation'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/automations.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'automation',
        label: 'Automation',
        helpText: "Type of automation.  One of: `create_folder`, `request_file`, `request_move`",
        required: true,
        type: 'string',
      },
      {
        key: 'source',
        label: 'Source',
        helpText: "Source Path",
        required: false,
        type: 'string',
      },
      {
        key: 'destination',
        label: 'Destination',
        helpText: "Destination Path",
        required: false,
        type: 'string',
      },
      {
        key: 'destination_replace_from',
        label: 'Destination Replace From',
        helpText: "If set, this string in the destination path will be replaced with the value in `destination_replace_to`.",
        required: false,
        type: 'string',
      },
      {
        key: 'destination_replace_to',
        label: 'Destination Replace To',
        helpText: "If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.",
        required: false,
        type: 'string',
      },
      {
        key: 'interval',
        label: 'Interval',
        helpText: "How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`",
        required: false,
        type: 'string',
      },
      {
        key: 'path',
        label: 'Path',
        helpText: "Path on which this Automation runs.  Supports globs.",
        required: false,
        type: 'string',
      },
      {
        key: 'user_ids',
        label: 'User Ids',
        helpText: "A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.",
        required: false,
        type: 'string',
      },
      {
        key: 'group_ids',
        label: 'Group Ids',
        helpText: "A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create Automation.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
