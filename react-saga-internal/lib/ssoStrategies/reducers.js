import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.listSsoStrategy.request]: safeReducer((state, { payload }) => state),
  [actions.listSsoStrategy.failure]: safeReducer((state, { payload }) => state),
  [actions.listSsoStrategy.success]: safeReducer((state, { payload }) => state),

  [actions.findSsoStrategy.request]: safeReducer((state, { payload }) => state),
  [actions.findSsoStrategy.failure]: safeReducer((state, { payload }) => state),
  [actions.findSsoStrategy.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
