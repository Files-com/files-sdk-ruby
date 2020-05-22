import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.copyFileAction.request]: safeReducer((state, { payload }) => state),
  [actions.copyFileAction.failure]: safeReducer((state, { payload }) => state),
  [actions.copyFileAction.success]: safeReducer((state, { payload }) => state),

  [actions.moveFileAction.request]: safeReducer((state, { payload }) => state),
  [actions.moveFileAction.failure]: safeReducer((state, { payload }) => state),
  [actions.moveFileAction.success]: safeReducer((state, { payload }) => state),

  [actions.begin_uploadFileAction.request]: safeReducer((state, { payload }) => state),
  [actions.begin_uploadFileAction.failure]: safeReducer((state, { payload }) => state),
  [actions.begin_uploadFileAction.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
