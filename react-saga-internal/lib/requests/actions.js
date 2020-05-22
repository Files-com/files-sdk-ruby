import { createActions } from 'utils/actions'
import Api from 'utils/api'

// List Requests
//
// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   mine - boolean - Only show requests of the current user?  (Defaults to true if current user is not a site admin.)

const ApiFoldersRequest = params => Api.get(`/requests/folders/" . rawurlencode($params['path']) . "`, params)
const foldersRequest = createActions('REQUEST_FOLDERS')

// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   mine - boolean - Only show requests of the current user?  (Defaults to true if current user is not a site admin.)
//   path - string - Path to show requests for.  If omitted, shows all paths. Send `/` to represent the root directory.

const ApiListRequest = params => Api.get(`/requests`, params)
const listRequest = createActions('REQUEST_LIST')

// Parameters:
//   path (required) - string - Folder path on which to request the file.
//   destination (required) - string - Destination filename (without extension) to request.
//   user_ids - string - A list of user IDs to request the file from. If sent as a string, it should be comma-delimited.
//   group_ids - string - A list of group IDs to request the file from. If sent as a string, it should be comma-delimited.

const ApiCreateRequest = params => Api.post(`/requests`, params)
const createRequest = createActions('REQUEST_CREATE')

// Parameters:
//   id (required) - integer - Request ID.

const ApiDeleteRequest = params => Api.delete(`/requests/${params.id}`, params)
const deleteRequest = createActions('REQUEST_DELETE')

export {
  foldersRequest, ApiFoldersRequest,

  listRequest, ApiListRequest,
  createRequest, ApiCreateRequest,
  deleteRequest, ApiDeleteRequest,
}
