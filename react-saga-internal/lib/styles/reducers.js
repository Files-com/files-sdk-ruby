import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateStyle.request]: safeReducer((state, { payload }) => state),
  [actions.updateStyle.failure]: safeReducer((state, { payload }) => state),
  [actions.updateStyle.success]: safeReducer((state, { payload }) => state),

  [actions.deleteStyle.request]: safeReducer((state, { payload }) => state),
  [actions.deleteStyle.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteStyle.success]: safeReducer((state, { payload }) => state),

  [actions.listStyle.request]: safeReducer((state, { payload }) => state),
  [actions.listStyle.failure]: safeReducer((state, { payload }) => state),
  [actions.listStyle.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
