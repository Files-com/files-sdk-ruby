import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updatePublicKeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The PublicKeys object.',
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

  yield put(clearErrorStatus(actions.updatePublicKey.request))
  yield put(setLoadingStatus(actions.updatePublicKey.request))

  yield updateEntitySaga(
    actions.updatePublicKey,
    ApiUpdatePublicKey,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updatePublicKey.request))
}

const deletePublicKeySaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deletePublicKey.request))
  yield put(setLoadingStatus(actions.deletePublicKey.request))

  yield deleteEntitySaga(
    actions.deletePublicKey,
    ApiDeletePublicKey,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deletePublicKey.request))
}

const listPublicKeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of PublicKeys objects.',
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

  yield put(clearErrorStatus(actions.listPublicKey.request))
  yield put(setLoadingStatus(actions.listPublicKey.request))

  yield loadEntitySaga(
    actions.listPublicKey,
    ApiListPublicKey,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listPublicKey.request))
}

const findPublicKeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The PublicKeys object.',
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

  yield put(clearErrorStatus(actions.findPublicKey.request))
  yield put(setLoadingStatus(actions.findPublicKey.request))

  yield loadEntitySaga(
    actions.findPublicKey,
    ApiFindPublicKey,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findPublicKey.request))
}

const createPublicKeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The PublicKeys object.',
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

  yield put(clearErrorStatus(actions.createPublicKey.request))
  yield put(setLoadingStatus(actions.createPublicKey.request))

  yield postEntitySaga(
    actions.createPublicKey,
    ApiCreatePublicKey,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createPublicKey.request))
}

function * publicKeySagas() {
  return [
    yield takeLatest(actions.updatePublicKey.request, updatePublicKeySaga),
    yield takeLatest(actions.deletePublicKey.request, deletePublicKeySaga),

    yield takeLatest(actions.listPublicKey.request, listPublicKeySaga),
    yield takeLatest(actions.findPublicKey.request, findPublicKeySaga),
    yield takeLatest(actions.createPublicKey.request, createPublicKeySaga),
  ]
}

export default publicKeySagas
