import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.listInvoice.request]: safeReducer((state, { payload }) => state),
  [actions.listInvoice.failure]: safeReducer((state, { payload }) => state),
  [actions.listInvoice.success]: safeReducer((state, { payload }) => state),

  [actions.findInvoice.request]: safeReducer((state, { payload }) => state),
  [actions.findInvoice.failure]: safeReducer((state, { payload }) => state),
  [actions.findInvoice.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
