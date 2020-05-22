import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateAs2KeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The As2Keys object.',
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

  yield put(clearErrorStatus(actions.updateAs2Key.request))
  yield put(setLoadingStatus(actions.updateAs2Key.request))

  yield updateEntitySaga(
    actions.updateAs2Key,
    ApiUpdateAs2Key,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateAs2Key.request))
}

const deleteAs2KeySaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteAs2Key.request))
  yield put(setLoadingStatus(actions.deleteAs2Key.request))

  yield deleteEntitySaga(
    actions.deleteAs2Key,
    ApiDeleteAs2Key,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteAs2Key.request))
}

const listAs2KeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of As2Keys objects.',
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

  yield put(clearErrorStatus(actions.listAs2Key.request))
  yield put(setLoadingStatus(actions.listAs2Key.request))

  yield loadEntitySaga(
    actions.listAs2Key,
    ApiListAs2Key,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listAs2Key.request))
}

const findAs2KeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The As2Keys object.',
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

  yield put(clearErrorStatus(actions.findAs2Key.request))
  yield put(setLoadingStatus(actions.findAs2Key.request))

  yield loadEntitySaga(
    actions.findAs2Key,
    ApiFindAs2Key,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findAs2Key.request))
}

const createAs2KeySaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The As2Keys object.',
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

  yield put(clearErrorStatus(actions.createAs2Key.request))
  yield put(setLoadingStatus(actions.createAs2Key.request))

  yield postEntitySaga(
    actions.createAs2Key,
    ApiCreateAs2Key,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createAs2Key.request))
}

function * as2KeySagas() {
  return [
    yield takeLatest(actions.updateAs2Key.request, updateAs2KeySaga),
    yield takeLatest(actions.deleteAs2Key.request, deleteAs2KeySaga),

    yield takeLatest(actions.listAs2Key.request, listAs2KeySaga),
    yield takeLatest(actions.findAs2Key.request, findAs2KeySaga),
    yield takeLatest(actions.createAs2Key.request, createAs2KeySaga),
  ]
}

export default as2KeySagas
