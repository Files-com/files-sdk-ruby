import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.listIpAddress.request]: safeReducer((state, { payload }) => state),
  [actions.listIpAddress.failure]: safeReducer((state, { payload }) => state),
  [actions.listIpAddress.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
