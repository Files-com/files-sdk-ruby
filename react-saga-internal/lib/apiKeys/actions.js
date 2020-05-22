import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   name - string - Internal name for key.  For your reference only.
//   permission_set - string - Leave blank, or set to 'desktop_app' to restrict the key to only desktop app functions.
//   expires_at - string - Have the key expire at this date/time.

const ApiUpdateApiKey = params => Api.patch(`/api_keys/${params.id}`, params)
const updateApiKey = createActions('APIKEY_UPDATE')

const ApiDeleteApiKey = params => Api.delete(`/api_keys/${params.id}`, params)
const deleteApiKey = createActions('APIKEY_DELETE')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.

const ApiListApiKey = params => Api.get(`/api_keys`, params)
const listApiKey = createActions('APIKEY_LIST')


const ApiFindCurrentApiKey = params => Api.get(`/api_key`)
const find_currentApiKey = createActions('APIKEY_FIND_CURRENT')

// Parameters:
//   id (required) - integer - Api Key ID.

const ApiFindApiKey = params => Api.get(`/api_keys/${params.id}`, params)
const findApiKey = createActions('APIKEY_FIND')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   name - string - Internal name for key.  For your reference only.
//   permission_set - string - Leave blank, or set to 'desktop_app' to restrict the key to only desktop app functions.
//   expires_at - string - Have the key expire at this date/time.

const ApiCreateApiKey = params => Api.post(`/api_keys`, params)
const createApiKey = createActions('APIKEY_CREATE')

// Parameters:
//   name - string - Internal name for key.  For your reference only.
//   permission_set - string - Leave blank, or set to `desktop_app` to restrict the key to only desktop app functions.
//   expires_at - string - Have the key expire at this date/time.

const ApiUpdateCurrentApiKey = params => Api.patch(`/api_key`, params)
const update_currentApiKey = createActions('APIKEY_UPDATE_CURRENT')


const ApiDeleteCurrentApiKey = params => Api.delete(`/api_key`)
const delete_currentApiKey = createActions('APIKEY_DELETE_CURRENT')

export {
  updateApiKey, ApiUpdateApiKey,
  deleteApiKey, ApiDeleteApiKey,

  listApiKey, ApiListApiKey,
  find_currentApiKey, ApiFindCurrentApiKey,
  findApiKey, ApiFindApiKey,
  createApiKey, ApiCreateApiKey,
  update_currentApiKey, ApiUpdateCurrentApiKey,
  delete_currentApiKey, ApiDeleteCurrentApiKey,
}
