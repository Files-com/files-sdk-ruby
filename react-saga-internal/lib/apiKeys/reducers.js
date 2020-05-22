import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateApiKey.request]: safeReducer((state, { payload }) => state),
  [actions.updateApiKey.failure]: safeReducer((state, { payload }) => state),
  [actions.updateApiKey.success]: safeReducer((state, { payload }) => state),

  [actions.deleteApiKey.request]: safeReducer((state, { payload }) => state),
  [actions.deleteApiKey.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteApiKey.success]: safeReducer((state, { payload }) => state),

  [actions.listApiKey.request]: safeReducer((state, { payload }) => state),
  [actions.listApiKey.failure]: safeReducer((state, { payload }) => state),
  [actions.listApiKey.success]: safeReducer((state, { payload }) => state),

  [actions.find_currentApiKey.request]: safeReducer((state, { payload }) => state),
  [actions.find_currentApiKey.failure]: safeReducer((state, { payload }) => state),
  [actions.find_currentApiKey.success]: safeReducer((state, { payload }) => state),

  [actions.findApiKey.request]: safeReducer((state, { payload }) => state),
  [actions.findApiKey.failure]: safeReducer((state, { payload }) => state),
  [actions.findApiKey.success]: safeReducer((state, { payload }) => state),

  [actions.createApiKey.request]: safeReducer((state, { payload }) => state),
  [actions.createApiKey.failure]: safeReducer((state, { payload }) => state),
  [actions.createApiKey.success]: safeReducer((state, { payload }) => state),

  [actions.update_currentApiKey.request]: safeReducer((state, { payload }) => state),
  [actions.update_currentApiKey.failure]: safeReducer((state, { payload }) => state),
  [actions.update_currentApiKey.success]: safeReducer((state, { payload }) => state),

  [actions.delete_currentApiKey.request]: safeReducer((state, { payload }) => state),
  [actions.delete_currentApiKey.failure]: safeReducer((state, { payload }) => state),
  [actions.delete_currentApiKey.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
