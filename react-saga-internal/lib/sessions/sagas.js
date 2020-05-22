import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const createSessionSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Sessions object.',
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

  yield put(clearErrorStatus(actions.createSession.request))
  yield put(setLoadingStatus(actions.createSession.request))

  yield postEntitySaga(
    actions.createSession,
    ApiCreateSession,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createSession.request))
}

const deleteSessionSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteSession.request))
  yield put(setLoadingStatus(actions.deleteSession.request))

  yield deleteEntitySaga(
    actions.deleteSession,
    ApiDeleteSession,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteSession.request))
}

function * sessionSagas() {
  return [

    yield takeLatest(actions.createSession.request, createSessionSaga),
    yield takeLatest(actions.deleteSession.request, deleteSessionSaga),
  ]
}

export default sessionSagas
