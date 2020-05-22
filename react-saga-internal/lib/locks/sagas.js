import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const deleteLockSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteLock.request))
  yield put(setLoadingStatus(actions.deleteLock.request))

  yield deleteEntitySaga(
    actions.deleteLock,
    ApiDeleteLock,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteLock.request))
}

const list_forLockSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Locks objects.',
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

  yield put(clearErrorStatus(actions.list_forLock.request))
  yield put(setLoadingStatus(actions.list_forLock.request))

  yield loadEntitySaga(
    actions.list_forLock,
    ApiListForLock,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.list_forLock.request))
}

const createLockSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Locks object.',
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

  yield put(clearErrorStatus(actions.createLock.request))
  yield put(setLoadingStatus(actions.createLock.request))

  yield postEntitySaga(
    actions.createLock,
    ApiCreateLock,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createLock.request))
}

function * lockSagas() {
  return [
    yield takeLatest(actions.deleteLock.request, deleteLockSaga),

    yield takeLatest(actions.list_forLock.request, list_forLockSaga),
    yield takeLatest(actions.createLock.request, createLockSaga),
  ]
}

export default lockSagas
