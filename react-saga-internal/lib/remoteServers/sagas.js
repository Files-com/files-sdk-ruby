import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateRemoteServerSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The RemoteServers object.',
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

  yield put(clearErrorStatus(actions.updateRemoteServer.request))
  yield put(setLoadingStatus(actions.updateRemoteServer.request))

  yield updateEntitySaga(
    actions.updateRemoteServer,
    ApiUpdateRemoteServer,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateRemoteServer.request))
}

const deleteRemoteServerSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteRemoteServer.request))
  yield put(setLoadingStatus(actions.deleteRemoteServer.request))

  yield deleteEntitySaga(
    actions.deleteRemoteServer,
    ApiDeleteRemoteServer,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteRemoteServer.request))
}

const listRemoteServerSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of RemoteServers objects.',
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

  yield put(clearErrorStatus(actions.listRemoteServer.request))
  yield put(setLoadingStatus(actions.listRemoteServer.request))

  yield loadEntitySaga(
    actions.listRemoteServer,
    ApiListRemoteServer,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listRemoteServer.request))
}

const findRemoteServerSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The RemoteServers object.',
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

  yield put(clearErrorStatus(actions.findRemoteServer.request))
  yield put(setLoadingStatus(actions.findRemoteServer.request))

  yield loadEntitySaga(
    actions.findRemoteServer,
    ApiFindRemoteServer,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findRemoteServer.request))
}

const createRemoteServerSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The RemoteServers object.',
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

  yield put(clearErrorStatus(actions.createRemoteServer.request))
  yield put(setLoadingStatus(actions.createRemoteServer.request))

  yield postEntitySaga(
    actions.createRemoteServer,
    ApiCreateRemoteServer,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createRemoteServer.request))
}

function * remoteServerSagas() {
  return [
    yield takeLatest(actions.updateRemoteServer.request, updateRemoteServerSaga),
    yield takeLatest(actions.deleteRemoteServer.request, deleteRemoteServerSaga),

    yield takeLatest(actions.listRemoteServer.request, listRemoteServerSaga),
    yield takeLatest(actions.findRemoteServer.request, findRemoteServerSaga),
    yield takeLatest(actions.createRemoteServer.request, createRemoteServerSaga),
  ]
}

export default remoteServerSagas
