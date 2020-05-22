import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateNotification.request]: safeReducer((state, { payload }) => state),
  [actions.updateNotification.failure]: safeReducer((state, { payload }) => state),
  [actions.updateNotification.success]: safeReducer((state, { payload }) => state),

  [actions.deleteNotification.request]: safeReducer((state, { payload }) => state),
  [actions.deleteNotification.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteNotification.success]: safeReducer((state, { payload }) => state),

  [actions.listNotification.request]: safeReducer((state, { payload }) => state),
  [actions.listNotification.failure]: safeReducer((state, { payload }) => state),
  [actions.listNotification.success]: safeReducer((state, { payload }) => state),

  [actions.findNotification.request]: safeReducer((state, { payload }) => state),
  [actions.findNotification.failure]: safeReducer((state, { payload }) => state),
  [actions.findNotification.success]: safeReducer((state, { payload }) => state),

  [actions.createNotification.request]: safeReducer((state, { payload }) => state),
  [actions.createNotification.failure]: safeReducer((state, { payload }) => state),
  [actions.createNotification.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
