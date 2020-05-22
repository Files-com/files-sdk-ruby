import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateMessageSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Messages object.',
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

  yield put(clearErrorStatus(actions.updateMessage.request))
  yield put(setLoadingStatus(actions.updateMessage.request))

  yield updateEntitySaga(
    actions.updateMessage,
    ApiUpdateMessage,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateMessage.request))
}

const deleteMessageSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteMessage.request))
  yield put(setLoadingStatus(actions.deleteMessage.request))

  yield deleteEntitySaga(
    actions.deleteMessage,
    ApiDeleteMessage,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteMessage.request))
}

const listMessageSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Messages objects.',
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

  yield put(clearErrorStatus(actions.listMessage.request))
  yield put(setLoadingStatus(actions.listMessage.request))

  yield loadEntitySaga(
    actions.listMessage,
    ApiListMessage,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listMessage.request))
}

const findMessageSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Messages object.',
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

  yield put(clearErrorStatus(actions.findMessage.request))
  yield put(setLoadingStatus(actions.findMessage.request))

  yield loadEntitySaga(
    actions.findMessage,
    ApiFindMessage,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findMessage.request))
}

const createMessageSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Messages object.',
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

  yield put(clearErrorStatus(actions.createMessage.request))
  yield put(setLoadingStatus(actions.createMessage.request))

  yield postEntitySaga(
    actions.createMessage,
    ApiCreateMessage,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createMessage.request))
}

function * messageSagas() {
  return [
    yield takeLatest(actions.updateMessage.request, updateMessageSaga),
    yield takeLatest(actions.deleteMessage.request, deleteMessageSaga),

    yield takeLatest(actions.listMessage.request, listMessageSaga),
    yield takeLatest(actions.findMessage.request, findMessageSaga),
    yield takeLatest(actions.createMessage.request, createMessageSaga),
  ]
}

export default messageSagas
