import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.foldersRequest.request]: safeReducer((state, { payload }) => state),
  [actions.foldersRequest.failure]: safeReducer((state, { payload }) => state),
  [actions.foldersRequest.success]: safeReducer((state, { payload }) => state),

  [actions.listRequest.request]: safeReducer((state, { payload }) => state),
  [actions.listRequest.failure]: safeReducer((state, { payload }) => state),
  [actions.listRequest.success]: safeReducer((state, { payload }) => state),

  [actions.createRequest.request]: safeReducer((state, { payload }) => state),
  [actions.createRequest.failure]: safeReducer((state, { payload }) => state),
  [actions.createRequest.success]: safeReducer((state, { payload }) => state),

  [actions.deleteRequest.request]: safeReducer((state, { payload }) => state),
  [actions.deleteRequest.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteRequest.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
