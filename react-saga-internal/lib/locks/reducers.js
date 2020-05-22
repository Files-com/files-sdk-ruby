import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.deleteLock.request]: safeReducer((state, { payload }) => state),
  [actions.deleteLock.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteLock.success]: safeReducer((state, { payload }) => state),

  [actions.list_forLock.request]: safeReducer((state, { payload }) => state),
  [actions.list_forLock.failure]: safeReducer((state, { payload }) => state),
  [actions.list_forLock.success]: safeReducer((state, { payload }) => state),

  [actions.createLock.request]: safeReducer((state, { payload }) => state),
  [actions.createLock.failure]: safeReducer((state, { payload }) => state),
  [actions.createLock.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
