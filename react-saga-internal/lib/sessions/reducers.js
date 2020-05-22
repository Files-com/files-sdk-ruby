import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.createSession.request]: safeReducer((state, { payload }) => state),
  [actions.createSession.failure]: safeReducer((state, { payload }) => state),
  [actions.createSession.success]: safeReducer((state, { payload }) => state),

  [actions.deleteSession.request]: safeReducer((state, { payload }) => state),
  [actions.deleteSession.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteSession.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
