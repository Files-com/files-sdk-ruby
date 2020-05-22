import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   name - string - Group name.
//   notes - string - Group notes.
//   user_ids - string - A list of user ids. If sent as a string, should be comma-delimited.
//   admin_ids - string - A list of group admin user ids. If sent as a string, should be comma-delimited.

const ApiUpdateGroup = params => Api.patch(`/groups/${params.id}`, params)
const updateGroup = createActions('GROUP_UPDATE')

const ApiDeleteGroup = params => Api.delete(`/groups/${params.id}`, params)
const deleteGroup = createActions('GROUP_DELETE')

// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   ids - string - Comma-separated list of group ids to include in results.

const ApiListGroup = params => Api.get(`/groups`, params)
const listGroup = createActions('GROUP_LIST')

// Parameters:
//   id (required) - integer - Group ID.

const ApiFindGroup = params => Api.get(`/groups/${params.id}`, params)
const findGroup = createActions('GROUP_FIND')

// Parameters:
//   name - string - Group name.
//   notes - string - Group notes.
//   user_ids - string - A list of user ids. If sent as a string, should be comma-delimited.
//   admin_ids - string - A list of group admin user ids. If sent as a string, should be comma-delimited.

const ApiCreateGroup = params => Api.post(`/groups`, params)
const createGroup = createActions('GROUP_CREATE')

export {
  updateGroup, ApiUpdateGroup,
  deleteGroup, ApiDeleteGroup,

  listGroup, ApiListGroup,
  findGroup, ApiFindGroup,
  createGroup, ApiCreateGroup,
}
