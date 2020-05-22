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
  "mime_type": "application/octet-stream",
  "region": "us-east-1",
  "permissions": "rpw",
}

const hydrators = require('../hydrators')

const modelName = 'File'
const display = {
  label: 'New File Uploaded',
  description: 'Triggers when a new File is uploaded. (note: This trigger will only fire for files < 150MB.  This is a limit of Zapier.  To support larger files, consider a Files.com built-in integration or sync).',
  important: true,
}
const validParams = ['path', 'filter']

const fileMaxBytesSize = 150000000

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

  const folderEntries = z.JSON.parse(folderResponse.content)
  const files = [];

  // Filter out folders and files that are too large.
  folderEntries.forEach(entry => {
    if (entry.type === 'file' && entry.size < fileMaxBytesSize) {
      files.push({
        ...entry,
        file: z.dehydrateFile(hydrators.downloadFile, { fileId: entry.id })
      })
    }
  });

  return files;
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
        key: 'filter',
        label: 'Filter',
        helpText: "If specified, will to filter folders/files list by this string.  Wildcards of `*` and `?` are acceptable here.",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,
  display: display,

  operation: {
    canPaginate: true,
    inputFields: inputFields,
    perform: perform,
    sample: sample,
  }
}