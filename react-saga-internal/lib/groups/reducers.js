import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateGroup.request]: safeReducer((state, { payload }) => state),
  [actions.updateGroup.failure]: safeReducer((state, { payload }) => state),
  [actions.updateGroup.success]: safeReducer((state, { payload }) => state),

  [actions.deleteGroup.request]: safeReducer((state, { payload }) => state),
  [actions.deleteGroup.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteGroup.success]: safeReducer((state, { payload }) => state),

  [actions.listGroup.request]: safeReducer((state, { payload }) => state),
  [actions.listGroup.failure]: safeReducer((state, { payload }) => state),
  [actions.listGroup.success]: safeReducer((state, { payload }) => state),

  [actions.findGroup.request]: safeReducer((state, { payload }) => state),
  [actions.findGroup.failure]: safeReducer((state, { payload }) => state),
  [actions.findGroup.success]: safeReducer((state, { payload }) => state),

  [actions.createGroup.request]: safeReducer((state, { payload }) => state),
  [actions.createGroup.failure]: safeReducer((state, { payload }) => state),
  [actions.createGroup.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
