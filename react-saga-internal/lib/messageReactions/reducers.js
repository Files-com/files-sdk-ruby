import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.deleteMessageReaction.request]: safeReducer((state, { payload }) => state),
  [actions.deleteMessageReaction.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteMessageReaction.success]: safeReducer((state, { payload }) => state),

  [actions.listMessageReaction.request]: safeReducer((state, { payload }) => state),
  [actions.listMessageReaction.failure]: safeReducer((state, { payload }) => state),
  [actions.listMessageReaction.success]: safeReducer((state, { payload }) => state),

  [actions.findMessageReaction.request]: safeReducer((state, { payload }) => state),
  [actions.findMessageReaction.failure]: safeReducer((state, { payload }) => state),
  [actions.findMessageReaction.success]: safeReducer((state, { payload }) => state),

  [actions.createMessageReaction.request]: safeReducer((state, { payload }) => state),
  [actions.createMessageReaction.failure]: safeReducer((state, { payload }) => state),
  [actions.createMessageReaction.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
