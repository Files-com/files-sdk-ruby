import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateFileCommentSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The FileComments object.',
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

  yield put(clearErrorStatus(actions.updateFileComment.request))
  yield put(setLoadingStatus(actions.updateFileComment.request))

  yield updateEntitySaga(
    actions.updateFileComment,
    ApiUpdateFileComment,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateFileComment.request))
}

const deleteFileCommentSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteFileComment.request))
  yield put(setLoadingStatus(actions.deleteFileComment.request))

  yield deleteEntitySaga(
    actions.deleteFileComment,
    ApiDeleteFileComment,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteFileComment.request))
}

const list_forFileCommentSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of FileComments objects.',
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

  yield put(clearErrorStatus(actions.list_forFileComment.request))
  yield put(setLoadingStatus(actions.list_forFileComment.request))

  yield loadEntitySaga(
    actions.list_forFileComment,
    ApiListForFileComment,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.list_forFileComment.request))
}

const createFileCommentSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The FileComments object.',
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

  yield put(clearErrorStatus(actions.createFileComment.request))
  yield put(setLoadingStatus(actions.createFileComment.request))

  yield postEntitySaga(
    actions.createFileComment,
    ApiCreateFileComment,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createFileComment.request))
}

function * fileCommentSagas() {
  return [
    yield takeLatest(actions.updateFileComment.request, updateFileCommentSaga),
    yield takeLatest(actions.deleteFileComment.request, deleteFileCommentSaga),

    yield takeLatest(actions.list_forFileComment.request, list_forFileCommentSaga),
    yield takeLatest(actions.createFileComment.request, createFileCommentSaga),
  ]
}

export default fileCommentSagas
