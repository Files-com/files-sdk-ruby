import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updatePublicKey.request]: safeReducer((state, { payload }) => state),
  [actions.updatePublicKey.failure]: safeReducer((state, { payload }) => state),
  [actions.updatePublicKey.success]: safeReducer((state, { payload }) => state),

  [actions.deletePublicKey.request]: safeReducer((state, { payload }) => state),
  [actions.deletePublicKey.failure]: safeReducer((state, { payload }) => state),
  [actions.deletePublicKey.success]: safeReducer((state, { payload }) => state),

  [actions.listPublicKey.request]: safeReducer((state, { payload }) => state),
  [actions.listPublicKey.failure]: safeReducer((state, { payload }) => state),
  [actions.listPublicKey.success]: safeReducer((state, { payload }) => state),

  [actions.findPublicKey.request]: safeReducer((state, { payload }) => state),
  [actions.findPublicKey.failure]: safeReducer((state, { payload }) => state),
  [actions.findPublicKey.success]: safeReducer((state, { payload }) => state),

  [actions.createPublicKey.request]: safeReducer((state, { payload }) => state),
  [actions.createPublicKey.failure]: safeReducer((state, { payload }) => state),
  [actions.createPublicKey.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
