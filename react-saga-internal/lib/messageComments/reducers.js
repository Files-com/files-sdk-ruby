import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateMessageComment.request]: safeReducer((state, { payload }) => state),
  [actions.updateMessageComment.failure]: safeReducer((state, { payload }) => state),
  [actions.updateMessageComment.success]: safeReducer((state, { payload }) => state),

  [actions.deleteMessageComment.request]: safeReducer((state, { payload }) => state),
  [actions.deleteMessageComment.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteMessageComment.success]: safeReducer((state, { payload }) => state),

  [actions.listMessageComment.request]: safeReducer((state, { payload }) => state),
  [actions.listMessageComment.failure]: safeReducer((state, { payload }) => state),
  [actions.listMessageComment.success]: safeReducer((state, { payload }) => state),

  [actions.findMessageComment.request]: safeReducer((state, { payload }) => state),
  [actions.findMessageComment.failure]: safeReducer((state, { payload }) => state),
  [actions.findMessageComment.success]: safeReducer((state, { payload }) => state),

  [actions.createMessageComment.request]: safeReducer((state, { payload }) => state),
  [actions.createMessageComment.failure]: safeReducer((state, { payload }) => state),
  [actions.createMessageComment.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
