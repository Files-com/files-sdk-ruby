import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const downloadFileSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Files object.',
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

  yield put(clearErrorStatus(actions.downloadFile.request))
  yield put(setLoadingStatus(actions.downloadFile.request))

  yield loadEntitySaga(
    actions.downloadFile,
    ApiDownloadFile,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.downloadFile.request))
}

const updateFileSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Files object.',
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

  yield put(clearErrorStatus(actions.updateFile.request))
  yield put(setLoadingStatus(actions.updateFile.request))

  yield updateEntitySaga(
    actions.updateFile,
    ApiUpdateFile,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateFile.request))
}

const deleteFileSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteFile.request))
  yield put(setLoadingStatus(actions.deleteFile.request))

  yield deleteEntitySaga(
    actions.deleteFile,
    ApiDeleteFile,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteFile.request))
}

const createFileSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Files object.',
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

  yield put(clearErrorStatus(actions.createFile.request))
  yield put(setLoadingStatus(actions.createFile.request))

  yield postEntitySaga(
    actions.createFile,
    ApiCreateFile,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createFile.request))
}

function * fileSagas() {
  return [
    yield takeLatest(actions.downloadFile.request, downloadFileSaga),
    yield takeLatest(actions.updateFile.request, updateFileSaga),
    yield takeLatest(actions.deleteFile.request, deleteFileSaga),

    yield takeLatest(actions.createFile.request, createFileSaga),
  ]
}

export default fileSagas
