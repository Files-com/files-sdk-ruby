import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateRemoteServer.request]: safeReducer((state, { payload }) => state),
  [actions.updateRemoteServer.failure]: safeReducer((state, { payload }) => state),
  [actions.updateRemoteServer.success]: safeReducer((state, { payload }) => state),

  [actions.deleteRemoteServer.request]: safeReducer((state, { payload }) => state),
  [actions.deleteRemoteServer.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteRemoteServer.success]: safeReducer((state, { payload }) => state),

  [actions.listRemoteServer.request]: safeReducer((state, { payload }) => state),
  [actions.listRemoteServer.failure]: safeReducer((state, { payload }) => state),
  [actions.listRemoteServer.success]: safeReducer((state, { payload }) => state),

  [actions.findRemoteServer.request]: safeReducer((state, { payload }) => state),
  [actions.findRemoteServer.failure]: safeReducer((state, { payload }) => state),
  [actions.findRemoteServer.success]: safeReducer((state, { payload }) => state),

  [actions.createRemoteServer.request]: safeReducer((state, { payload }) => state),
  [actions.createRemoteServer.failure]: safeReducer((state, { payload }) => state),
  [actions.createRemoteServer.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
