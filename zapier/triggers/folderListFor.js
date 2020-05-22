const hydrators = require('../hydrators')

const sample = {
  "id": 1,
  "path": "path/file.txt",
  "display_name": "file.txt",
  "type": "file",
  "size": 1024,
  "mtime": "2000-01-01T01:00:00Z",
  "provided_mtime": "2000-01-01T01:00:00Z",
  "crc32": "70976923",
  "md5": "17c54824e9931a4688ca032d03f6663c",
  "permissions": "rpw",
}

const modelName = 'Folder'
const noun = 'File or Folder'
const display = {
  label: 'New File or Folder Created',
  description: 'Triggers when a new File or Folder is Created. (note: If you need to actually use the File Contents your Action, use the New File Uploaded Trigger instead).',
  important: true,
}
const validParams = ['path', 'filter']

const requestFolder = async (requestParams, z) => {
  const path = requestParams['path'] || ''

  const response = await z.request({
    method: 'GET',
    url: `https://app.files.com/api/rest/v1/folders/${path}`,
    params: {
      per_page: 10000,
      page: 1,
      ...requestParams,
    },
  })

  if (response.status != 200) {
    z.console.log('Failed to list folder')
    response.throwForStatus()
  }

  return response
}

const perform = async (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const folderResponse = await requestFolder(requestParams, z)

  return z.JSON.parse(folderResponse.content)
}


const inputFields = [
      {
        key: 'path',
        label: 'Path',
        helpText: "Path to operate on.",
        required: true,
        type: 'string',
      },
      {
        key: 'cursor',
        label: 'Cursor',
        helpText: "Send cursor to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor header.",
        required: false,
        type: 'string',
      },
      {
        key: 'filter',
        label: 'Filter',
        helpText: "If specified, will to filter folders/files list by this string.  Wildcards of `*` and `?` are acceptable here.",
        required: false,
        type: 'string',
      },
      {
        key: 'preview_size',
        label: 'Preview Size',
        helpText: "Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.",
        required: false,
        type: 'string',
      },
      {
        key: 'search',
        label: 'Search',
        helpText: "If `search_all` is `true`, provide the search string here.  Otherwise, this parameter acts like an alias of `filter`.",
        required: false,
        type: 'string',
      },
      {
        key: 'search_all',
        label: 'Search All',
        helpText: "Search entire site?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'with_priority_color',
        label: 'With Priority Color',
        helpText: "Include file priority color information?",
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
