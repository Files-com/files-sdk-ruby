import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateNotificationSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Notifications object.',
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

  yield put(clearErrorStatus(actions.updateNotification.request))
  yield put(setLoadingStatus(actions.updateNotification.request))

  yield updateEntitySaga(
    actions.updateNotification,
    ApiUpdateNotification,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateNotification.request))
}

const deleteNotificationSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteNotification.request))
  yield put(setLoadingStatus(actions.deleteNotification.request))

  yield deleteEntitySaga(
    actions.deleteNotification,
    ApiDeleteNotification,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteNotification.request))
}

const listNotificationSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Notifications objects.',
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

  yield put(clearErrorStatus(actions.listNotification.request))
  yield put(setLoadingStatus(actions.listNotification.request))

  yield loadEntitySaga(
    actions.listNotification,
    ApiListNotification,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listNotification.request))
}

const findNotificationSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Notifications object.',
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

  yield put(clearErrorStatus(actions.findNotification.request))
  yield put(setLoadingStatus(actions.findNotification.request))

  yield loadEntitySaga(
    actions.findNotification,
    ApiFindNotification,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findNotification.request))
}

const createNotificationSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Notifications object.',
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

  yield put(clearErrorStatus(actions.createNotification.request))
  yield put(setLoadingStatus(actions.createNotification.request))

  yield postEntitySaga(
    actions.createNotification,
    ApiCreateNotification,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createNotification.request))
}

function * notificationSagas() {
  return [
    yield takeLatest(actions.updateNotification.request, updateNotificationSaga),
    yield takeLatest(actions.deleteNotification.request, deleteNotificationSaga),

    yield takeLatest(actions.listNotification.request, listNotificationSaga),
    yield takeLatest(actions.findNotification.request, findNotificationSaga),
    yield takeLatest(actions.createNotification.request, createNotificationSaga),
  ]
}

export default notificationSagas
