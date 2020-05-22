import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const deleteFileCommentReactionSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteFileCommentReaction.request))
  yield put(setLoadingStatus(actions.deleteFileCommentReaction.request))

  yield deleteEntitySaga(
    actions.deleteFileCommentReaction,
    ApiDeleteFileCommentReaction,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteFileCommentReaction.request))
}

const createFileCommentReactionSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The FileCommentReactions object.',
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

  yield put(clearErrorStatus(actions.createFileCommentReaction.request))
  yield put(setLoadingStatus(actions.createFileCommentReaction.request))

  yield postEntitySaga(
    actions.createFileCommentReaction,
    ApiCreateFileCommentReaction,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createFileCommentReaction.request))
}

function * fileCommentReactionSagas() {
  return [
    yield takeLatest(actions.deleteFileCommentReaction.request, deleteFileCommentReactionSaga),

    yield takeLatest(actions.createFileCommentReaction.request, createFileCommentReactionSaga),
  ]
}

export default fileCommentReactionSagas
