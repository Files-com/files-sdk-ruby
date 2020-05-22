import { createActions } from 'utils/actions'
import Api from 'utils/api'


// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.

const ApiListSsoStrategy = params => Api.get(`/sso_strategies`, params)
const listSsoStrategy = createActions('SSOSTRATEGY_LIST')

// Parameters:
//   id (required) - integer - Sso Strategy ID.

const ApiFindSsoStrategy = params => Api.get(`/sso_strategies/${params.id}`, params)
const findSsoStrategy = createActions('SSOSTRATEGY_FIND')

export {

  listSsoStrategy, ApiListSsoStrategy,
  findSsoStrategy, ApiFindSsoStrategy,
}
