import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.updateProject.request]: safeReducer((state, { payload }) => state),
  [actions.updateProject.failure]: safeReducer((state, { payload }) => state),
  [actions.updateProject.success]: safeReducer((state, { payload }) => state),

  [actions.deleteProject.request]: safeReducer((state, { payload }) => state),
  [actions.deleteProject.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteProject.success]: safeReducer((state, { payload }) => state),

  [actions.listProject.request]: safeReducer((state, { payload }) => state),
  [actions.listProject.failure]: safeReducer((state, { payload }) => state),
  [actions.listProject.success]: safeReducer((state, { payload }) => state),

  [actions.findProject.request]: safeReducer((state, { payload }) => state),
  [actions.findProject.failure]: safeReducer((state, { payload }) => state),
  [actions.findProject.success]: safeReducer((state, { payload }) => state),

  [actions.createProject.request]: safeReducer((state, { payload }) => state),
  [actions.createProject.failure]: safeReducer((state, { payload }) => state),
  [actions.createProject.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
