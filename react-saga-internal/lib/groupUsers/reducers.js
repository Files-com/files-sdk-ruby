import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateGroupUser.request]: safeReducer((state, { payload }) => state),
  [actions.updateGroupUser.failure]: safeReducer((state, { payload }) => state),
  [actions.updateGroupUser.success]: safeReducer((state, { payload }) => state),

  [actions.deleteGroupUser.request]: safeReducer((state, { payload }) => state),
  [actions.deleteGroupUser.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteGroupUser.success]: safeReducer((state, { payload }) => state),

  [actions.listGroupUser.request]: safeReducer((state, { payload }) => state),
  [actions.listGroupUser.failure]: safeReducer((state, { payload }) => state),
  [actions.listGroupUser.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
