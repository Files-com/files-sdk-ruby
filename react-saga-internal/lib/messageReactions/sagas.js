import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const deleteMessageReactionSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteMessageReaction.request))
  yield put(setLoadingStatus(actions.deleteMessageReaction.request))

  yield deleteEntitySaga(
    actions.deleteMessageReaction,
    ApiDeleteMessageReaction,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteMessageReaction.request))
}

const listMessageReactionSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of MessageReactions objects.',
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

  yield put(clearErrorStatus(actions.listMessageReaction.request))
  yield put(setLoadingStatus(actions.listMessageReaction.request))

  yield loadEntitySaga(
    actions.listMessageReaction,
    ApiListMessageReaction,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listMessageReaction.request))
}

const findMessageReactionSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The MessageReactions object.',
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

  yield put(clearErrorStatus(actions.findMessageReaction.request))
  yield put(setLoadingStatus(actions.findMessageReaction.request))

  yield loadEntitySaga(
    actions.findMessageReaction,
    ApiFindMessageReaction,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findMessageReaction.request))
}

const createMessageReactionSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The MessageReactions object.',
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

  yield put(clearErrorStatus(actions.createMessageReaction.request))
  yield put(setLoadingStatus(actions.createMessageReaction.request))

  yield postEntitySaga(
    actions.createMessageReaction,
    ApiCreateMessageReaction,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createMessageReaction.request))
}

function * messageReactionSagas() {
  return [
    yield takeLatest(actions.deleteMessageReaction.request, deleteMessageReactionSaga),

    yield takeLatest(actions.listMessageReaction.request, listMessageReactionSaga),
    yield takeLatest(actions.findMessageReaction.request, findMessageReactionSaga),
    yield takeLatest(actions.createMessageReaction.request, createMessageReactionSaga),
  ]
}

export default messageReactionSagas
