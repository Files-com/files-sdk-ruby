import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const deleteMessageCommentReactionSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteMessageCommentReaction.request))
  yield put(setLoadingStatus(actions.deleteMessageCommentReaction.request))

  yield deleteEntitySaga(
    actions.deleteMessageCommentReaction,
    ApiDeleteMessageCommentReaction,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteMessageCommentReaction.request))
}

const listMessageCommentReactionSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of MessageCommentReactions objects.',
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

  yield put(clearErrorStatus(actions.listMessageCommentReaction.request))
  yield put(setLoadingStatus(actions.listMessageCommentReaction.request))

  yield loadEntitySaga(
    actions.listMessageCommentReaction,
    ApiListMessageCommentReaction,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listMessageCommentReaction.request))
}

const findMessageCommentReactionSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The MessageCommentReactions object.',
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

  yield put(clearErrorStatus(actions.findMessageCommentReaction.request))
  yield put(setLoadingStatus(actions.findMessageCommentReaction.request))

  yield loadEntitySaga(
    actions.findMessageCommentReaction,
    ApiFindMessageCommentReaction,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findMessageCommentReaction.request))
}

const createMessageCommentReactionSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The MessageCommentReactions object.',
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

  yield put(clearErrorStatus(actions.createMessageCommentReaction.request))
  yield put(setLoadingStatus(actions.createMessageCommentReaction.request))

  yield postEntitySaga(
    actions.createMessageCommentReaction,
    ApiCreateMessageCommentReaction,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createMessageCommentReaction.request))
}

function * messageCommentReactionSagas() {
  return [
    yield takeLatest(actions.deleteMessageCommentReaction.request, deleteMessageCommentReactionSaga),

    yield takeLatest(actions.listMessageCommentReaction.request, listMessageCommentReactionSaga),
    yield takeLatest(actions.findMessageCommentReaction.request, findMessageCommentReactionSaga),
    yield takeLatest(actions.createMessageCommentReaction.request, createMessageCommentReactionSaga),
  ]
}

export default messageCommentReactionSagas
