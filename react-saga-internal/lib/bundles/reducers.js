import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.shareBundle.request]: safeReducer((state, { payload }) => state),
  [actions.shareBundle.failure]: safeReducer((state, { payload }) => state),
  [actions.shareBundle.success]: safeReducer((state, { payload }) => state),

  [actions.deleteBundle.request]: safeReducer((state, { payload }) => state),
  [actions.deleteBundle.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteBundle.success]: safeReducer((state, { payload }) => state),

  [actions.listBundle.request]: safeReducer((state, { payload }) => state),
  [actions.listBundle.failure]: safeReducer((state, { payload }) => state),
  [actions.listBundle.success]: safeReducer((state, { payload }) => state),

  [actions.findBundle.request]: safeReducer((state, { payload }) => state),
  [actions.findBundle.failure]: safeReducer((state, { payload }) => state),
  [actions.findBundle.success]: safeReducer((state, { payload }) => state),

  [actions.createBundle.request]: safeReducer((state, { payload }) => state),
  [actions.createBundle.failure]: safeReducer((state, { payload }) => state),
  [actions.createBundle.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
