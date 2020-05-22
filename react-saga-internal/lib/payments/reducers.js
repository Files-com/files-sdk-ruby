import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.listPayment.request]: safeReducer((state, { payload }) => state),
  [actions.listPayment.failure]: safeReducer((state, { payload }) => state),
  [actions.listPayment.success]: safeReducer((state, { payload }) => state),

  [actions.findPayment.request]: safeReducer((state, { payload }) => state),
  [actions.findPayment.failure]: safeReducer((state, { payload }) => state),
  [actions.findPayment.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
