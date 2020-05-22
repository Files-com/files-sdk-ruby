import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   token (required) - string - Lock token

const ApiDeleteLock = params => Api.delete(`/locks/" . rawurlencode($params['path']) . "`, params)
const deleteLock = createActions('LOCK_DELETE')

// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   path (required) - string - Path to operate on.
//   include_children - boolean - Include locks from children objects?

const ApiListForLock = params => Api.get(`/locks/" . rawurlencode($params['path']) . "`, params)
const list_forLock = createActions('LOCK_LIST_FOR')

// Parameters:
//   path (required) - string - Path
//   timeout - integer - Lock timeout length

const ApiCreateLock = params => Api.post(`/locks/" . rawurlencode($params['path']) . "`, params)
const createLock = createActions('LOCK_CREATE')

export {
  deleteLock, ApiDeleteLock,

  list_forLock, ApiListForLock,
  createLock, ApiCreateLock,
}
