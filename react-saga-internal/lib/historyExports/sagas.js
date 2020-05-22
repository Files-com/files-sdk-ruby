import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const deleteHistoryExportSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteHistoryExport.request))
  yield put(setLoadingStatus(actions.deleteHistoryExport.request))

  yield deleteEntitySaga(
    actions.deleteHistoryExport,
    ApiDeleteHistoryExport,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteHistoryExport.request))
}

const listHistoryExportSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of HistoryExports objects.',
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

  yield put(clearErrorStatus(actions.listHistoryExport.request))
  yield put(setLoadingStatus(actions.listHistoryExport.request))

  yield loadEntitySaga(
    actions.listHistoryExport,
    ApiListHistoryExport,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listHistoryExport.request))
}

const findHistoryExportSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The HistoryExports object.',
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

  yield put(clearErrorStatus(actions.findHistoryExport.request))
  yield put(setLoadingStatus(actions.findHistoryExport.request))

  yield loadEntitySaga(
    actions.findHistoryExport,
    ApiFindHistoryExport,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findHistoryExport.request))
}

const createHistoryExportSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The HistoryExports object.',
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

  yield put(clearErrorStatus(actions.createHistoryExport.request))
  yield put(setLoadingStatus(actions.createHistoryExport.request))

  yield postEntitySaga(
    actions.createHistoryExport,
    ApiCreateHistoryExport,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createHistoryExport.request))
}

function * historyExportSagas() {
  return [
    yield takeLatest(actions.deleteHistoryExport.request, deleteHistoryExportSaga),

    yield takeLatest(actions.listHistoryExport.request, listHistoryExportSaga),
    yield takeLatest(actions.findHistoryExport.request, findHistoryExportSaga),
    yield takeLatest(actions.createHistoryExport.request, createHistoryExportSaga),
  ]
}

export default historyExportSagas
