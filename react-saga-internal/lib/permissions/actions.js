import { createActions } from 'utils/actions'
import Api from 'utils/api'


// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   path - string - Permission path.  If provided, will scope permissions to this path.
//   group_id - string - Group ID.  If provided, will scope permissions to this group.
//   user_id - string - User ID.  If provided, will scope permissions to this user.
//   include_groups - boolean - If searching by user or group, also include user's permissions that are inherited from its groups?

const ApiListPermission = params => Api.get(`/permissions`, params)
const listPermission = createActions('PERMISSION_LIST')

// Parameters:
//   group_id - integer - Group ID
//   path - string - Folder path
//   permission - string -  Permission type.  Can be `admin`, `full`, `readonly`, `writeonly`, `previewonly`, or `history`
//   recursive - boolean - Apply to subfolders recursively?
//   user_id - integer - User ID.  Provide `username` or `user_id`
//   username - string - User username.  Provide `username` or `user_id`

const ApiCreatePermission = params => Api.post(`/permissions`, params)
const createPermission = createActions('PERMISSION_CREATE')

// Parameters:
//   id (required) - integer - Permission ID.

const ApiDeletePermission = params => Api.delete(`/permissions/${params.id}`, params)
const deletePermission = createActions('PERMISSION_DELETE')

export {

  listPermission, ApiListPermission,
  createPermission, ApiCreatePermission,
  deletePermission, ApiDeletePermission,
}
