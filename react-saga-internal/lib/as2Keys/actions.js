import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   as2_partnership_name (required) - string - AS2 Partnership Name

const ApiUpdateAs2Key = params => Api.patch(`/as2_keys/${params.id}`, params)
const updateAs2Key = createActions('AS2KEY_UPDATE')

const ApiDeleteAs2Key = params => Api.delete(`/as2_keys/${params.id}`, params)
const deleteAs2Key = createActions('AS2KEY_DELETE')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.

const ApiListAs2Key = params => Api.get(`/as2_keys`, params)
const listAs2Key = createActions('AS2KEY_LIST')

// Parameters:
//   id (required) - integer - As2 Key ID.

const ApiFindAs2Key = params => Api.get(`/as2_keys/${params.id}`, params)
const findAs2Key = createActions('AS2KEY_FIND')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   as2_partnership_name (required) - string - AS2 Partnership Name
//   public_key (required) - string - Actual contents of Public key.

const ApiCreateAs2Key = params => Api.post(`/as2_keys`, params)
const createAs2Key = createActions('AS2KEY_CREATE')

export {
  updateAs2Key, ApiUpdateAs2Key,
  deleteAs2Key, ApiDeleteAs2Key,

  listAs2Key, ApiListAs2Key,
  findAs2Key, ApiFindAs2Key,
  createAs2Key, ApiCreateAs2Key,
}
