import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateApiKeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The ApiKeys object.',
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

  yield put(clearErrorStatus(actions.updateApiKey.request))
  yield put(setLoadingStatus(actions.updateApiKey.request))

  yield updateEntitySaga(
    actions.updateApiKey,
    ApiUpdateApiKey,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateApiKey.request))
}

const deleteApiKeySaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteApiKey.request))
  yield put(setLoadingStatus(actions.deleteApiKey.request))

  yield deleteEntitySaga(
    actions.deleteApiKey,
    ApiDeleteApiKey,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteApiKey.request))
}

const listApiKeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of ApiKeys objects.',
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

  yield put(clearErrorStatus(actions.listApiKey.request))
  yield put(setLoadingStatus(actions.listApiKey.request))

  yield loadEntitySaga(
    actions.listApiKey,
    ApiListApiKey,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listApiKey.request))
}

const find_currentApiKeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The ApiKey object.',
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

  yield put(clearErrorStatus(actions.find_currentApiKey.request))
  yield put(setLoadingStatus(actions.find_currentApiKey.request))

  yield loadEntitySaga(
    actions.find_currentApiKey,
    ApiFindCurrentApiKey,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.find_currentApiKey.request))
}

const findApiKeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The ApiKeys object.',
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

  yield put(clearErrorStatus(actions.findApiKey.request))
  yield put(setLoadingStatus(actions.findApiKey.request))

  yield loadEntitySaga(
    actions.findApiKey,
    ApiFindApiKey,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findApiKey.request))
}

const createApiKeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The ApiKeys object.',
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

  yield put(clearErrorStatus(actions.createApiKey.request))
  yield put(setLoadingStatus(actions.createApiKey.request))

  yield postEntitySaga(
    actions.createApiKey,
    ApiCreateApiKey,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createApiKey.request))
}

const update_currentApiKeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The ApiKey object.',
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

  yield put(clearErrorStatus(actions.update_currentApiKey.request))
  yield put(setLoadingStatus(actions.update_currentApiKey.request))

  yield updateEntitySaga(
    actions.update_currentApiKey,
    ApiUpdateCurrentApiKey,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.update_currentApiKey.request))
}

const delete_currentApiKeySaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.delete_currentApiKey.request))
  yield put(setLoadingStatus(actions.delete_currentApiKey.request))

  yield deleteEntitySaga(
    actions.delete_currentApiKey,
    ApiDeleteCurrentApiKey,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.delete_currentApiKey.request))
}

function * apiKeySagas() {
  return [
    yield takeLatest(actions.updateApiKey.request, updateApiKeySaga),
    yield takeLatest(actions.deleteApiKey.request, deleteApiKeySaga),

    yield takeLatest(actions.listApiKey.request, listApiKeySaga),
    yield takeLatest(actions.find_currentApiKey.request, find_currentApiKeySaga),
    yield takeLatest(actions.findApiKey.request, findApiKeySaga),
    yield takeLatest(actions.createApiKey.request, createApiKeySaga),
    yield takeLatest(actions.update_currentApiKey.request, update_currentApiKeySaga),
    yield takeLatest(actions.delete_currentApiKey.request, delete_currentApiKeySaga),
  ]
}

export default apiKeySagas
