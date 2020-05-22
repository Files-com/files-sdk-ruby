import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.list_forFolder.request]: safeReducer((state, { payload }) => state),
  [actions.list_forFolder.failure]: safeReducer((state, { payload }) => state),
  [actions.list_forFolder.success]: safeReducer((state, { payload }) => state),

  [actions.createFolder.request]: safeReducer((state, { payload }) => state),
  [actions.createFolder.failure]: safeReducer((state, { payload }) => state),
  [actions.createFolder.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
