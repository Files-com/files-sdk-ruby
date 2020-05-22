import { createActions } from 'utils/actions'
import Api from 'utils/api'


// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.

const ApiListUserCipherUse = params => Api.get(`/user_cipher_uses`, params)
const listUserCipherUse = createActions('USERCIPHERUSE_LIST')

export {

  listUserCipherUse, ApiListUserCipherUse,
}
