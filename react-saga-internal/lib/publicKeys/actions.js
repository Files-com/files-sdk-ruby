import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   title (required) - string - Internal reference for key.

const ApiUpdatePublicKey = params => Api.patch(`/public_keys/${params.id}`, params)
const updatePublicKey = createActions('PUBLICKEY_UPDATE')

const ApiDeletePublicKey = params => Api.delete(`/public_keys/${params.id}`, params)
const deletePublicKey = createActions('PUBLICKEY_DELETE')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.

const ApiListPublicKey = params => Api.get(`/public_keys`, params)
const listPublicKey = createActions('PUBLICKEY_LIST')

// Parameters:
//   id (required) - integer - Public Key ID.

const ApiFindPublicKey = params => Api.get(`/public_keys/${params.id}`, params)
const findPublicKey = createActions('PUBLICKEY_FIND')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   title (required) - string - Internal reference for key.
//   public_key (required) - string - Actual contents of SSH key.

const ApiCreatePublicKey = params => Api.post(`/public_keys`, params)
const createPublicKey = createActions('PUBLICKEY_CREATE')

export {
  updatePublicKey, ApiUpdatePublicKey,
  deletePublicKey, ApiDeletePublicKey,

  listPublicKey, ApiListPublicKey,
  findPublicKey, ApiFindPublicKey,
  createPublicKey, ApiCreatePublicKey,
}
