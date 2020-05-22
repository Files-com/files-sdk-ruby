import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const list_forFolderSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Folders objects.',
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

  yield put(clearErrorStatus(actions.list_forFolder.request))
  yield put(setLoadingStatus(actions.list_forFolder.request))

  yield loadEntitySaga(
    actions.list_forFolder,
    ApiListForFolder,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.list_forFolder.request))
}

const createFolderSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Folders object.',
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

  yield put(clearErrorStatus(actions.createFolder.request))
  yield put(setLoadingStatus(actions.createFolder.request))

  yield postEntitySaga(
    actions.createFolder,
    ApiCreateFolder,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createFolder.request))
}

function * folderSagas() {
  return [

    yield takeLatest(actions.list_forFolder.request, list_forFolderSaga),
    yield takeLatest(actions.createFolder.request, createFolderSaga),
  ]
}

export default folderSagas
