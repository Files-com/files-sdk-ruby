import { createActions } from 'utils/actions'
import Api from 'utils/api'


// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.

const ApiListUsageDailySnapshot = params => Api.get(`/usage_daily_snapshots`, params)
const listUsageDailySnapshot = createActions('USAGEDAILYSNAPSHOT_LIST')

export {

  listUsageDailySnapshot, ApiListUsageDailySnapshot,
}
