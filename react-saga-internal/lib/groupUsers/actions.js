import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   group_id (required) - integer - Group ID to add user to.
//   user_id (required) - integer - User ID to add to group.
//   admin - boolean - Is the user a group administrator?

const ApiUpdateGroupUser = params => Api.patch(`/group_users/${params.id}`, params)
const updateGroupUser = createActions('GROUPUSER_UPDATE')

const ApiDeleteGroupUser = params => Api.delete(`/group_users/${params.id}`, params)
const deleteGroupUser = createActions('GROUPUSER_DELETE')

// Parameters:
//   user_id - integer - User ID.  If provided, will return groups of which this user is a member.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   group_id - integer - Group ID.  If provided, will return members of this group.

const ApiListGroupUser = params => Api.get(`/group_users`, params)
const listGroupUser = createActions('GROUPUSER_LIST')

export {
  updateGroupUser, ApiUpdateGroupUser,
  deleteGroupUser, ApiDeleteGroupUser,

  listGroupUser, ApiListGroupUser,
}
