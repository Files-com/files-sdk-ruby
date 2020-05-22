import { fromJS } from 'immutable'
import { handleActions } from 'redux-actions'

import { safeReducer } from 'store/enhancers'

import * as actions from './actions'

const defaultState = fromJS({
})

const reducer = handleActions({
  [actions.unlockUser.request]: safeReducer((state, { payload }) => state),
  [actions.unlockUser.failure]: safeReducer((state, { payload }) => state),
  [actions.unlockUser.success]: safeReducer((state, { payload }) => state),

  [actions.resend_welcome_emailUser.request]: safeReducer((state, { payload }) => state),
  [actions.resend_welcome_emailUser.failure]: safeReducer((state, { payload }) => state),
  [actions.resend_welcome_emailUser.success]: safeReducer((state, { payload }) => state),

  [actions.user_2fa_resetUser.request]: safeReducer((state, { payload }) => state),
  [actions.user_2fa_resetUser.failure]: safeReducer((state, { payload }) => state),
  [actions.user_2fa_resetUser.success]: safeReducer((state, { payload }) => state),

  [actions.updateUser.request]: safeReducer((state, { payload }) => state),
  [actions.updateUser.failure]: safeReducer((state, { payload }) => state),
  [actions.updateUser.success]: safeReducer((state, { payload }) => state),

  [actions.deleteUser.request]: safeReducer((state, { payload }) => state),
  [actions.deleteUser.failure]: safeReducer((state, { payload }) => state),
  [actions.deleteUser.success]: safeReducer((state, { payload }) => state),

  [actions.listUser.request]: safeReducer((state, { payload }) => state),
  [actions.listUser.failure]: safeReducer((state, { payload }) => state),
  [actions.listUser.success]: safeReducer((state, { payload }) => state),

  [actions.findUser.request]: safeReducer((state, { payload }) => state),
  [actions.findUser.failure]: safeReducer((state, { payload }) => state),
  [actions.findUser.success]: safeReducer((state, { payload }) => state),

  [actions.createUser.request]: safeReducer((state, { payload }) => state),
  [actions.createUser.failure]: safeReducer((state, { payload }) => state),
  [actions.createUser.success]: safeReducer((state, { payload }) => state),

}, defaultState)

export default reducer
export { defaultState }
