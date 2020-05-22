import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.listDnsRecord.request]: safeReducer((state, { payload }) => state),
  [actions.listDnsRecord.failure]: safeReducer((state, { payload }) => state),
  [actions.listDnsRecord.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
