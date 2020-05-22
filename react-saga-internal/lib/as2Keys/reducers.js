import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateAs2Key.request]: safeReducer((state, { payload }) => state),
  [actions.updateAs2Key.failure]: safeReducer((state, { payload }) => state),
  [actions.updateAs2Key.success]: safeReducer((state, { payload }) => state),

  [actions.deleteAs2Key.request]: safeReducer((state, { payload }) => state),
  [actions.deleteAs2Key.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteAs2Key.success]: safeReducer((state, { payload }) => state),

  [actions.listAs2Key.request]: safeReducer((state, { payload }) => state),
  [actions.listAs2Key.failure]: safeReducer((state, { payload }) => state),
  [actions.listAs2Key.success]: safeReducer((state, { payload }) => state),

  [actions.findAs2Key.request]: safeReducer((state, { payload }) => state),
  [actions.findAs2Key.failure]: safeReducer((state, { payload }) => state),
  [actions.findAs2Key.success]: safeReducer((state, { payload }) => state),

  [actions.createAs2Key.request]: safeReducer((state, { payload }) => state),
  [actions.createAs2Key.failure]: safeReducer((state, { payload }) => state),
  [actions.createAs2Key.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
