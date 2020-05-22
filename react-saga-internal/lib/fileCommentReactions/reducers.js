import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.deleteFileCommentReaction.request]: safeReducer((state, { payload }) => state),
  [actions.deleteFileCommentReaction.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteFileCommentReaction.success]: safeReducer((state, { payload }) => state),

  [actions.createFileCommentReaction.request]: safeReducer((state, { payload }) => state),
  [actions.createFileCommentReaction.failure]: safeReducer((state, { payload }) => state),
  [actions.createFileCommentReaction.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
