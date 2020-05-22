import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.downloadFile.request]: safeReducer((state, { payload }) => state),
  [actions.downloadFile.failure]: safeReducer((state, { payload }) => state),
  [actions.downloadFile.success]: safeReducer((state, { payload }) => state),

  [actions.updateFile.request]: safeReducer((state, { payload }) => state),
  [actions.updateFile.failure]: safeReducer((state, { payload }) => state),
  [actions.updateFile.success]: safeReducer((state, { payload }) => state),

  [actions.deleteFile.request]: safeReducer((state, { payload }) => state),
  [actions.deleteFile.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteFile.success]: safeReducer((state, { payload }) => state),

  [actions.createFile.request]: safeReducer((state, { payload }) => state),
  [actions.createFile.failure]: safeReducer((state, { payload }) => state),
  [actions.createFile.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
