import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateBehavior.request]: safeReducer((state, { payload }) => state),
  [actions.updateBehavior.failure]: safeReducer((state, { payload }) => state),
  [actions.updateBehavior.success]: safeReducer((state, { payload }) => state),

  [actions.deleteBehavior.request]: safeReducer((state, { payload }) => state),
  [actions.deleteBehavior.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteBehavior.success]: safeReducer((state, { payload }) => state),

  [actions.listBehavior.request]: safeReducer((state, { payload }) => state),
  [actions.listBehavior.failure]: safeReducer((state, { payload }) => state),
  [actions.listBehavior.success]: safeReducer((state, { payload }) => state),

  [actions.list_forBehavior.request]: safeReducer((state, { payload }) => state),
  [actions.list_forBehavior.failure]: safeReducer((state, { payload }) => state),
  [actions.list_forBehavior.success]: safeReducer((state, { payload }) => state),

  [actions.findBehavior.request]: safeReducer((state, { payload }) => state),
  [actions.findBehavior.failure]: safeReducer((state, { payload }) => state),
  [actions.findBehavior.success]: safeReducer((state, { payload }) => state),

  [actions.createBehavior.request]: safeReducer((state, { payload }) => state),
  [actions.createBehavior.failure]: safeReducer((state, { payload }) => state),
  [actions.createBehavior.success]: safeReducer((state, { payload }) => state),

  [actions.webhook_testBehavior.request]: safeReducer((state, { payload }) => state),
  [actions.webhook_testBehavior.failure]: safeReducer((state, { payload }) => state),
  [actions.webhook_testBehavior.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
