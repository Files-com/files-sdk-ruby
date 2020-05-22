const sample = {
  "path": "path",
  "length": 1,
  "mkdir_parents": true,
  "part": 1,
  "parts": 1,
  "provided_mtime": "2000-01-01T01:00:00Z",
  "restart": 1,
  "size": 1,
  "with_rename": true
}

const operationLabel = 'Upload File'
const operationImportant = true
const validParams = ['file', 'upload_folder', 'file_name']
const extraInputFields = [
  {
    key: 'file',
    label: 'File',
      helpText: 'The file to be uploaded.',
    required: true,
    type: 'file',
  },
  {
    key: 'upload_folder',
    label: 'Upload Folder',
    helpText: 'This is the folder where the file will be uploaded to. Leave blank to upload into the Root Folder.',
    required: false,
    type: 'string',
  },
  {
    key: 'file_name',
    label: 'File Name',
    helpText: 'The name of the uploaded file. leave blank to use the name of the file received.',
    required: false,
    type: 'string',
  },
]

const requestUpload = async (path, fileName, z) => {
  const postParams = { action: 'put', with_rename: true }
  const url = `https://app.files.com/api/rest/v1/files/${path}/${fileName}`

  const response = await z.request({
    method: 'POST',
    url: url,
    body: postParams,
  })

  if (response.status != 200) {
    z.console.log('Failed to request upload to files.com')
    requestUploadResponse.throwForStatus()
  }

  return response;
}

const uploadFile = async (uploadUrl, headers, downloadUrl, z) => {
  const downloadResponse = await z.request({
    method: 'GET',
    url: downloadUrl,
    raw: true,
  })

  if (downloadResponse.status != 200) {
    z.console.log('Failed to download file data from Zapier')
    downloadResponse.throwForStatus()
  }

  const uploadResponse = await z.request({
    method: 'PUT',
    url: uploadUrl,
    headers: {
      ...headers,
      'content-length': downloadResponse.getHeader('content-length'),
      'content-type': 'application/octet-stream',
      'x-mime-type': downloadResponse.getHeader('content-type'),
    },
    body: downloadResponse.body,
  })

  if (uploadResponse.status != 200) {
    z.console.log('Failed to upload data to files.com')
    uploadResponse.throwForStatus()
  }

  return uploadResponse;
}

const finalizeUpload = async (path, fileName, ref, z) => {
  const postParams = { action: 'end', ref: ref, with_rename: true }
  const url = `https://app.files.com/api/rest/v1/files/${path}/${fileName}`

  const response = await z.request({
    method: 'POST',
    url: url,
    body: postParams,
  })

  if (response.status != 201) {
    z.console.log('Failed to finalize upload to files.com')
    response.throwForStatus()
  }

  return response;
}

const perform = async (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const filePath = encodeURIComponent(requestParams['upload_folder'] || '').replace('%2F', '/')
  const fileName = encodeURIComponent(requestParams['file_name'] || '')
  const downloadUrl = requestParams['file']

  const requestUploadResponse = await requestUpload(filePath, fileName, z)
  const { upload_uri, headers, ref } = z.JSON.parse(requestUploadResponse.content)

  await uploadFile(upload_uri, headers, downloadUrl, z)

  await finalizeUpload(filePath, fileName, ref, z)

  // TODO: Add download URL info here so it can be chained.
  return { filePath, fileName }
}

const modelName = 'File'


const inputFields = [
      {
        key: 'path',
        label: 'Path',
        helpText: "Path to operate on.",
        required: true,
        type: 'string',
      },
      {
        key: 'length',
        label: 'Length',
        helpText: "Length of file.",
        required: false,
        type: 'integer',
      },
      {
        key: 'mkdir_parents',
        label: 'Mkdir Parents',
        helpText: "Create parent directories if they do not exist?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'part',
        label: 'Part',
        helpText: "Part if uploading a part.",
        required: false,
        type: 'integer',
      },
      {
        key: 'parts',
        label: 'Parts',
        helpText: "How many parts to fetch?",
        required: false,
        type: 'integer',
      },
      {
        key: 'provided_mtime',
        label: 'Provided Mtime',
        helpText: "User provided modification time.",
        required: false,
        type: 'string',
      },
      {
        key: 'ref',
        label: 'Ref',
        required: false,
        type: 'string',
      },
      {
        key: 'restart',
        label: 'Restart',
        helpText: "File byte offset to restart from.",
        required: false,
        type: 'integer',
      },
      {
        key: 'size',
        label: 'Size',
        helpText: "Size of file.",
        required: false,
        type: 'integer',
      },
      {
        key: 'structure',
        label: 'Structure',
        helpText: "If copying folder, copy just the structure?",
        required: false,
        type: 'string',
      },
      {
        key: 'with_rename',
        label: 'With Rename',
        helpText: "Allow file rename instead of overwrite?",
        required: false,
        type: 'boolean',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Upload file.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
