import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const unlockUserSaga = function * ({ payload }) {
  const responseCodeMessages = {
    204: 'No body.',
    400: 'Bad Request',
    401: 'Unauthorized',
    403: 'Forbidden',
    404: 'Not Found',
    405: 'Method Not Allowed',
    409: 'Conflict',
    412: 'Precondition Failed',
    422: 'Unprocessable Entity',
    423: 'Locked',
    429: 'Too Many Requests',
  }

  yield put(clearErrorStatus(actions.unlockUser.request))
  yield put(setLoadingStatus(actions.unlockUser.request))

  yield postEntitySaga(
    actions.unlockUser,
    ApiUnlockUser,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.unlockUser.request))
}

const resend_welcome_emailUserSaga = function * ({ payload }) {
  const responseCodeMessages = {
    204: 'No body.',
    400: 'Bad Request',
    401: 'Unauthorized',
    403: 'Forbidden',
    404: 'Not Found',
    405: 'Method Not Allowed',
    409: 'Conflict',
    412: 'Precondition Failed',
    422: 'Unprocessable Entity',
    423: 'Locked',
    429: 'Too Many Requests',
  }

  yield put(clearErrorStatus(actions.resend_welcome_emailUser.request))
  yield put(setLoadingStatus(actions.resend_welcome_emailUser.request))

  yield postEntitySaga(
    actions.resend_welcome_emailUser,
    ApiResendWelcomeEmailUser,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.resend_welcome_emailUser.request))
}

const user_2fa_resetUserSaga = function * ({ payload }) {
  const responseCodeMessages = {
    204: 'No body.',
    400: 'Bad Request',
    401: 'Unauthorized',
    403: 'Forbidden',
    404: 'Not Found',
    405: 'Method Not Allowed',
    409: 'Conflict',
    412: 'Precondition Failed',
    422: 'Unprocessable Entity',
    423: 'Locked',
    429: 'Too Many Requests',
  }

  yield put(clearErrorStatus(actions.user_2fa_resetUser.request))
  yield put(setLoadingStatus(actions.user_2fa_resetUser.request))

  yield postEntitySaga(
    actions.user_2fa_resetUser,
    ApiUser2faResetUser,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.user_2fa_resetUser.request))
}

const updateUserSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Users object.',
    400: 'Bad Request',
    401: 'Unauthorized',
    403: 'Forbidden',
    404: 'Not Found',
    405: 'Method Not Allowed',
    409: 'Conflict',
    412: 'Precondition Failed',
    422: 'Unprocessable Entity',
    423: 'Locked',
    429: 'Too Many Requests',
  }

  yield put(clearErrorStatus(actions.updateUser.request))
  yield put(setLoadingStatus(actions.updateUser.request))

  yield updateEntitySaga(
    actions.updateUser,
    ApiUpdateUser,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateUser.request))
}

const deleteUserSaga = function * ({ payload }) {
  const responseCodeMessages = {
    204: 'No body.',
    400: 'Bad Request',
    401: 'Unauthorized',
    403: 'Forbidden',
    404: 'Not Found',
    405: 'Method Not Allowed',
    409: 'Conflict',
    412: 'Precondition Failed',
    422: 'Unprocessable Entity',
    423: 'Locked',
    429: 'Too Many Requests',
  }

  yield put(clearErrorStatus(actions.deleteUser.request))
  yield put(setLoadingStatus(actions.deleteUser.request))

  yield deleteEntitySaga(
    actions.deleteUser,
    ApiDeleteUser,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteUser.request))
}

const listUserSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Users objects.',
    400: 'Bad Request',
    401: 'Unauthorized',
    403: 'Forbidden',
    404: 'Not Found',
    405: 'Method Not Allowed',
    409: 'Conflict',
    412: 'Precondition Failed',
    422: 'Unprocessable Entity',
    423: 'Locked',
    429: 'Too Many Requests',
  }

  yield put(clearErrorStatus(actions.listUser.request))
  yield put(setLoadingStatus(actions.listUser.request))

  yield loadEntitySaga(
    actions.listUser,
    ApiListUser,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listUser.request))
}

const findUserSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Users object.',
    400: 'Bad Request',
    401: 'Unauthorized',
    403: 'Forbidden',
    404: 'Not Found',
    405: 'Method Not Allowed',
    409: 'Conflict',
    412: 'Precondition Failed',
    422: 'Unprocessable Entity',
    423: 'Locked',
    429: 'Too Many Requests',
  }

  yield put(clearErrorStatus(actions.findUser.request))
  yield put(setLoadingStatus(actions.findUser.request))

  yield loadEntitySaga(
    actions.findUser,
    ApiFindUser,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findUser.request))
}

const createUserSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Users object.',
    400: 'Bad Request',
    401: 'Unauthorized',
    403: 'Forbidden',
    404: 'Not Found',
    405: 'Method Not Allowed',
    409: 'Conflict',
    412: 'Precondition Failed',
    422: 'Unprocessable Entity',
    423: 'Locked',
    429: 'Too Many Requests',
  }

  yield put(clearErrorStatus(actions.createUser.request))
  yield put(setLoadingStatus(actions.createUser.request))

  yield postEntitySaga(
    actions.createUser,
    ApiCreateUser,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createUser.request))
}

function * userSagas() {
  return [
    yield takeLatest(actions.unlockUser.request, unlockUserSaga),
    yield takeLatest(actions.resend_welcome_emailUser.request, resend_welcome_emailUserSaga),
    yield takeLatest(actions.user_2fa_resetUser.request, user_2fa_resetUserSaga),
    yield takeLatest(actions.updateUser.request, updateUserSaga),
    yield takeLatest(actions.deleteUser.request, deleteUserSaga),

    yield takeLatest(actions.listUser.request, listUserSaga),
    yield takeLatest(actions.findUser.request, findUserSaga),
    yield takeLatest(actions.createUser.request, createUserSaga),
  ]
}

export default userSagas
