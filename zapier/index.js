const hydrators = require('./hydrators')
const authentication = require('./authentication')

const fileUpload = require('./triggers/fileUpload')
const fileCreate = require('./creates/fileCreate')
const folderCreate = require('./creates/folderCreate')
const groupCreate = require('./creates/groupCreate')
const groupFind = require('./searches/groupFind')
const userFind = require('./searches/userFind')
const folderListFor = require('./triggers/folderListFor')
const groupList = require('./triggers/groupList')
const userList = require('./triggers/userList')

const handleHTTPError = (response, z) => {
  if (response.status >= 400) {
    throw new Error(`Unexpected status code ${response.status}`)
  }
  return response
}

const addApiKeyToHeader = (request, z, bundle) => {
  if (request.url.startsWith('https://app.files.com/api/rest')) {
    request.headers['X-FilesAPI-Key'] = bundle.authData.api_key
  }
  request.headers['user-agent'] = 'Files.com Zapier Integration v1.0'
  return request
}

const App = {
  version: require('./package.json').version,
  platformVersion: require('zapier-platform-core').version,
  authentication: authentication,

  beforeRequest: [
    addApiKeyToHeader
  ],

  afterResponse: [
    handleHTTPError
  ],

  hydrators: hydrators,

  resources: {
  },

  creates: {
    [fileCreate.key]: fileCreate,
    [folderCreate.key]: folderCreate,
    [groupCreate.key]: groupCreate,
  },

  searches: {
    [groupFind.key]: groupFind,
    [userFind.key]: userFind,
  },

  triggers: {
    [fileUpload.key]: fileUpload,
    [folderListFor.key]: folderListFor,
    [groupList.key]: groupList,
    [userList.key]: userList,
  },
}

module.exports = App
