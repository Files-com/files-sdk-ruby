import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.deleteHistoryExport.request]: safeReducer((state, { payload }) => state),
  [actions.deleteHistoryExport.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteHistoryExport.success]: safeReducer((state, { payload }) => state),

  [actions.listHistoryExport.request]: safeReducer((state, { payload }) => state),
  [actions.listHistoryExport.failure]: safeReducer((state, { payload }) => state),
  [actions.listHistoryExport.success]: safeReducer((state, { payload }) => state),

  [actions.findHistoryExport.request]: safeReducer((state, { payload }) => state),
  [actions.findHistoryExport.failure]: safeReducer((state, { payload }) => state),
  [actions.findHistoryExport.success]: safeReducer((state, { payload }) => state),

  [actions.createHistoryExport.request]: safeReducer((state, { payload }) => state),
  [actions.createHistoryExport.failure]: safeReducer((state, { payload }) => state),
  [actions.createHistoryExport.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
