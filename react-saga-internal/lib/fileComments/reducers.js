import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateFileComment.request]: safeReducer((state, { payload }) => state),
  [actions.updateFileComment.failure]: safeReducer((state, { payload }) => state),
  [actions.updateFileComment.success]: safeReducer((state, { payload }) => state),

  [actions.deleteFileComment.request]: safeReducer((state, { payload }) => state),
  [actions.deleteFileComment.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteFileComment.success]: safeReducer((state, { payload }) => state),

  [actions.list_forFileComment.request]: safeReducer((state, { payload }) => state),
  [actions.list_forFileComment.failure]: safeReducer((state, { payload }) => state),
  [actions.list_forFileComment.success]: safeReducer((state, { payload }) => state),

  [actions.createFileComment.request]: safeReducer((state, { payload }) => state),
  [actions.createFileComment.failure]: safeReducer((state, { payload }) => state),
  [actions.createFileComment.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
