import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.listUsageSnapshot.request]: safeReducer((state, { payload }) => state),
  [actions.listUsageSnapshot.failure]: safeReducer((state, { payload }) => state),
  [actions.listUsageSnapshot.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
