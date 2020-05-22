import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateMessage.request]: safeReducer((state, { payload }) => state),
  [actions.updateMessage.failure]: safeReducer((state, { payload }) => state),
  [actions.updateMessage.success]: safeReducer((state, { payload }) => state),

  [actions.deleteMessage.request]: safeReducer((state, { payload }) => state),
  [actions.deleteMessage.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteMessage.success]: safeReducer((state, { payload }) => state),

  [actions.listMessage.request]: safeReducer((state, { payload }) => state),
  [actions.listMessage.failure]: safeReducer((state, { payload }) => state),
  [actions.listMessage.success]: safeReducer((state, { payload }) => state),

  [actions.findMessage.request]: safeReducer((state, { payload }) => state),
  [actions.findMessage.failure]: safeReducer((state, { payload }) => state),
  [actions.findMessage.success]: safeReducer((state, { payload }) => state),

  [actions.createMessage.request]: safeReducer((state, { payload }) => state),
  [actions.createMessage.failure]: safeReducer((state, { payload }) => state),
  [actions.createMessage.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
