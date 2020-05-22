import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.getSite.request]: safeReducer((state, { payload }) => state),
  [actions.getSite.failure]: safeReducer((state, { payload }) => state),
  [actions.getSite.success]: safeReducer((state, { payload }) => state),

  [actions.get_usageSite.request]: safeReducer((state, { payload }) => state),
  [actions.get_usageSite.failure]: safeReducer((state, { payload }) => state),
  [actions.get_usageSite.success]: safeReducer((state, { payload }) => state),

  [actions.updateSite.request]: safeReducer((state, { payload }) => state),
  [actions.updateSite.failure]: safeReducer((state, { payload }) => state),
  [actions.updateSite.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
