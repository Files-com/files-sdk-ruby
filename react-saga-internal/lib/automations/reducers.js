import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateAutomation.request]: safeReducer((state, { payload }) => state),
  [actions.updateAutomation.failure]: safeReducer((state, { payload }) => state),
  [actions.updateAutomation.success]: safeReducer((state, { payload }) => state),

  [actions.deleteAutomation.request]: safeReducer((state, { payload }) => state),
  [actions.deleteAutomation.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteAutomation.success]: safeReducer((state, { payload }) => state),

  [actions.listAutomation.request]: safeReducer((state, { payload }) => state),
  [actions.listAutomation.failure]: safeReducer((state, { payload }) => state),
  [actions.listAutomation.success]: safeReducer((state, { payload }) => state),

  [actions.findAutomation.request]: safeReducer((state, { payload }) => state),
  [actions.findAutomation.failure]: safeReducer((state, { payload }) => state),
  [actions.findAutomation.success]: safeReducer((state, { payload }) => state),

  [actions.createAutomation.request]: safeReducer((state, { payload }) => state),
  [actions.createAutomation.failure]: safeReducer((state, { payload }) => state),
  [actions.createAutomation.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
