import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.deleteMessageCommentReaction.request]: safeReducer((state, { payload }) => state),
  [actions.deleteMessageCommentReaction.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteMessageCommentReaction.success]: safeReducer((state, { payload }) => state),

  [actions.listMessageCommentReaction.request]: safeReducer((state, { payload }) => state),
  [actions.listMessageCommentReaction.failure]: safeReducer((state, { payload }) => state),
  [actions.listMessageCommentReaction.success]: safeReducer((state, { payload }) => state),

  [actions.findMessageCommentReaction.request]: safeReducer((state, { payload }) => state),
  [actions.findMessageCommentReaction.failure]: safeReducer((state, { payload }) => state),
  [actions.findMessageCommentReaction.success]: safeReducer((state, { payload }) => state),

  [actions.createMessageCommentReaction.request]: safeReducer((state, { payload }) => state),
  [actions.createMessageCommentReaction.failure]: safeReducer((state, { payload }) => state),
  [actions.createMessageCommentReaction.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
