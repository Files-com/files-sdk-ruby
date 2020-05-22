import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const copyFileActionSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.copyFileAction.request))
  yield put(setLoadingStatus(actions.copyFileAction.request))

  yield postEntitySaga(
    actions.copyFileAction,
    ApiCopyFileAction,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.copyFileAction.request))
}

const moveFileActionSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.moveFileAction.request))
  yield put(setLoadingStatus(actions.moveFileAction.request))

  yield postEntitySaga(
    actions.moveFileAction,
    ApiMoveFileAction,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.moveFileAction.request))
}

const begin_uploadFileActionSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The FileActions object.',
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

  yield put(clearErrorStatus(actions.begin_uploadFileAction.request))
  yield put(setLoadingStatus(actions.begin_uploadFileAction.request))

  yield postEntitySaga(
    actions.begin_uploadFileAction,
    ApiBeginUploadFileAction,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.begin_uploadFileAction.request))
}

function * fileActionSagas() {
  return [
    yield takeLatest(actions.copyFileAction.request, copyFileActionSaga),
    yield takeLatest(actions.moveFileAction.request, moveFileActionSaga),
    yield takeLatest(actions.begin_uploadFileAction.request, begin_uploadFileActionSaga),

  ]
}

export default fileActionSagas
