import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.list_for_fileHistory.request]: safeReducer((state, { payload }) => state),
  [actions.list_for_fileHistory.failure]: safeReducer((state, { payload }) => state),
  [actions.list_for_fileHistory.success]: safeReducer((state, { payload }) => state),

  [actions.list_for_folderHistory.request]: safeReducer((state, { payload }) => state),
  [actions.list_for_folderHistory.failure]: safeReducer((state, { payload }) => state),
  [actions.list_for_folderHistory.success]: safeReducer((state, { payload }) => state),

  [actions.list_for_userHistory.request]: safeReducer((state, { payload }) => state),
  [actions.list_for_userHistory.failure]: safeReducer((state, { payload }) => state),
  [actions.list_for_userHistory.success]: safeReducer((state, { payload }) => state),

  [actions.list_loginsHistory.request]: safeReducer((state, { payload }) => state),
  [actions.list_loginsHistory.failure]: safeReducer((state, { payload }) => state),
  [actions.list_loginsHistory.success]: safeReducer((state, { payload }) => state),

  [actions.listHistory.request]: safeReducer((state, { payload }) => state),
  [actions.listHistory.failure]: safeReducer((state, { payload }) => state),
  [actions.listHistory.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
