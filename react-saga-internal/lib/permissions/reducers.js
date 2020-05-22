import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.listPermission.request]: safeReducer((state, { payload }) => state),
  [actions.listPermission.failure]: safeReducer((state, { payload }) => state),
  [actions.listPermission.success]: safeReducer((state, { payload }) => state),

  [actions.createPermission.request]: safeReducer((state, { payload }) => state),
  [actions.createPermission.failure]: safeReducer((state, { payload }) => state),
  [actions.createPermission.success]: safeReducer((state, { payload }) => state),

  [actions.deletePermission.request]: safeReducer((state, { payload }) => state),
  [actions.deletePermission.failure]: safeReducer((state, { payload }) => state),
  [actions.deletePermission.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
