import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateGroupUserSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The GroupUsers object.',
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

  yield put(clearErrorStatus(actions.updateGroupUser.request))
  yield put(setLoadingStatus(actions.updateGroupUser.request))

  yield updateEntitySaga(
    actions.updateGroupUser,
    ApiUpdateGroupUser,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateGroupUser.request))
}

const deleteGroupUserSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteGroupUser.request))
  yield put(setLoadingStatus(actions.deleteGroupUser.request))

  yield deleteEntitySaga(
    actions.deleteGroupUser,
    ApiDeleteGroupUser,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteGroupUser.request))
}

const listGroupUserSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of GroupUsers objects.',
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

  yield put(clearErrorStatus(actions.listGroupUser.request))
  yield put(setLoadingStatus(actions.listGroupUser.request))

  yield loadEntitySaga(
    actions.listGroupUser,
    ApiListGroupUser,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listGroupUser.request))
}

function * groupUserSagas() {
  return [
    yield takeLatest(actions.updateGroupUser.request, updateGroupUserSaga),
    yield takeLatest(actions.deleteGroupUser.request, deleteGroupUserSaga),

    yield takeLatest(actions.listGroupUser.request, listGroupUserSaga),
  ]
}

export default groupUserSagas
