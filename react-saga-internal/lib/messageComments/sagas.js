import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateMessageCommentSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The MessageComments object.',
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

  yield put(clearErrorStatus(actions.updateMessageComment.request))
  yield put(setLoadingStatus(actions.updateMessageComment.request))

  yield updateEntitySaga(
    actions.updateMessageComment,
    ApiUpdateMessageComment,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateMessageComment.request))
}

const deleteMessageCommentSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteMessageComment.request))
  yield put(setLoadingStatus(actions.deleteMessageComment.request))

  yield deleteEntitySaga(
    actions.deleteMessageComment,
    ApiDeleteMessageComment,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteMessageComment.request))
}

const listMessageCommentSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of MessageComments objects.',
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

  yield put(clearErrorStatus(actions.listMessageComment.request))
  yield put(setLoadingStatus(actions.listMessageComment.request))

  yield loadEntitySaga(
    actions.listMessageComment,
    ApiListMessageComment,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listMessageComment.request))
}

const findMessageCommentSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The MessageComments object.',
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

  yield put(clearErrorStatus(actions.findMessageComment.request))
  yield put(setLoadingStatus(actions.findMessageComment.request))

  yield loadEntitySaga(
    actions.findMessageComment,
    ApiFindMessageComment,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findMessageComment.request))
}

const createMessageCommentSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The MessageComments object.',
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

  yield put(clearErrorStatus(actions.createMessageComment.request))
  yield put(setLoadingStatus(actions.createMessageComment.request))

  yield postEntitySaga(
    actions.createMessageComment,
    ApiCreateMessageComment,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createMessageComment.request))
}

function * messageCommentSagas() {
  return [
    yield takeLatest(actions.updateMessageComment.request, updateMessageCommentSaga),
    yield takeLatest(actions.deleteMessageComment.request, deleteMessageCommentSaga),

    yield takeLatest(actions.listMessageComment.request, listMessageCommentSaga),
    yield takeLatest(actions.findMessageComment.request, findMessageCommentSaga),
    yield takeLatest(actions.createMessageComment.request, createMessageCommentSaga),
  ]
}

export default messageCommentSagas
