import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const list_for_fileHistorySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of History objects.',
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

  yield put(clearErrorStatus(actions.list_for_fileHistory.request))
  yield put(setLoadingStatus(actions.list_for_fileHistory.request))

  yield loadEntitySaga(
    actions.list_for_fileHistory,
    ApiListForFileHistory,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.list_for_fileHistory.request))
}

const list_for_folderHistorySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of History objects.',
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

  yield put(clearErrorStatus(actions.list_for_folderHistory.request))
  yield put(setLoadingStatus(actions.list_for_folderHistory.request))

  yield loadEntitySaga(
    actions.list_for_folderHistory,
    ApiListForFolderHistory,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.list_for_folderHistory.request))
}

const list_for_userHistorySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of History objects.',
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

  yield put(clearErrorStatus(actions.list_for_userHistory.request))
  yield put(setLoadingStatus(actions.list_for_userHistory.request))

  yield loadEntitySaga(
    actions.list_for_userHistory,
    ApiListForUserHistory,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.list_for_userHistory.request))
}

const list_loginsHistorySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of History objects.',
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

  yield put(clearErrorStatus(actions.list_loginsHistory.request))
  yield put(setLoadingStatus(actions.list_loginsHistory.request))

  yield loadEntitySaga(
    actions.list_loginsHistory,
    ApiListLoginsHistory,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.list_loginsHistory.request))
}

const listHistorySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of History objects.',
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

  yield put(clearErrorStatus(actions.listHistory.request))
  yield put(setLoadingStatus(actions.listHistory.request))

  yield loadEntitySaga(
    actions.listHistory,
    ApiListHistory,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listHistory.request))
}

function * historySagas() {
  return [

    yield takeLatest(actions.list_for_fileHistory.request, list_for_fileHistorySaga),
    yield takeLatest(actions.list_for_folderHistory.request, list_for_folderHistorySaga),
    yield takeLatest(actions.list_for_userHistory.request, list_for_userHistorySaga),
    yield takeLatest(actions.list_loginsHistory.request, list_loginsHistorySaga),
    yield takeLatest(actions.listHistory.request, listHistorySaga),
  ]
}

export default historySagas
