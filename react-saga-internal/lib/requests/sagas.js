import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const foldersRequestSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Requests objects.',
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

  yield put(clearErrorStatus(actions.foldersRequest.request))
  yield put(setLoadingStatus(actions.foldersRequest.request))

  yield loadEntitySaga(
    actions.foldersRequest,
    ApiFoldersRequest,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.foldersRequest.request))
}

const listRequestSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Requests objects.',
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

  yield put(clearErrorStatus(actions.listRequest.request))
  yield put(setLoadingStatus(actions.listRequest.request))

  yield loadEntitySaga(
    actions.listRequest,
    ApiListRequest,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listRequest.request))
}

const createRequestSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Requests object.',
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

  yield put(clearErrorStatus(actions.createRequest.request))
  yield put(setLoadingStatus(actions.createRequest.request))

  yield postEntitySaga(
    actions.createRequest,
    ApiCreateRequest,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createRequest.request))
}

const deleteRequestSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteRequest.request))
  yield put(setLoadingStatus(actions.deleteRequest.request))

  yield deleteEntitySaga(
    actions.deleteRequest,
    ApiDeleteRequest,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteRequest.request))
}

function * requestSagas() {
  return [
    yield takeLatest(actions.foldersRequest.request, foldersRequestSaga),

    yield takeLatest(actions.listRequest.request, listRequestSaga),
    yield takeLatest(actions.createRequest.request, createRequestSaga),
    yield takeLatest(actions.deleteRequest.request, deleteRequestSaga),
  ]
}

export default requestSagas
