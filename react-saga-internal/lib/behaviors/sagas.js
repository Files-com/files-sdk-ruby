import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateBehaviorSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Behaviors object.',
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

  yield put(clearErrorStatus(actions.updateBehavior.request))
  yield put(setLoadingStatus(actions.updateBehavior.request))

  yield updateEntitySaga(
    actions.updateBehavior,
    ApiUpdateBehavior,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateBehavior.request))
}

const deleteBehaviorSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteBehavior.request))
  yield put(setLoadingStatus(actions.deleteBehavior.request))

  yield deleteEntitySaga(
    actions.deleteBehavior,
    ApiDeleteBehavior,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteBehavior.request))
}

const listBehaviorSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Behaviors objects.',
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

  yield put(clearErrorStatus(actions.listBehavior.request))
  yield put(setLoadingStatus(actions.listBehavior.request))

  yield loadEntitySaga(
    actions.listBehavior,
    ApiListBehavior,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listBehavior.request))
}

const list_forBehaviorSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Behaviors objects.',
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

  yield put(clearErrorStatus(actions.list_forBehavior.request))
  yield put(setLoadingStatus(actions.list_forBehavior.request))

  yield loadEntitySaga(
    actions.list_forBehavior,
    ApiListForBehavior,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.list_forBehavior.request))
}

const findBehaviorSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Behaviors object.',
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

  yield put(clearErrorStatus(actions.findBehavior.request))
  yield put(setLoadingStatus(actions.findBehavior.request))

  yield loadEntitySaga(
    actions.findBehavior,
    ApiFindBehavior,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findBehavior.request))
}

const createBehaviorSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Behaviors object.',
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

  yield put(clearErrorStatus(actions.createBehavior.request))
  yield put(setLoadingStatus(actions.createBehavior.request))

  yield postEntitySaga(
    actions.createBehavior,
    ApiCreateBehavior,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createBehavior.request))
}

const webhook_testBehaviorSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Behaviors object.',
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

  yield put(clearErrorStatus(actions.webhook_testBehavior.request))
  yield put(setLoadingStatus(actions.webhook_testBehavior.request))

  yield postEntitySaga(
    actions.webhook_testBehavior,
    ApiWebhookTestBehavior,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.webhook_testBehavior.request))
}

function * behaviorSagas() {
  return [
    yield takeLatest(actions.updateBehavior.request, updateBehaviorSaga),
    yield takeLatest(actions.deleteBehavior.request, deleteBehaviorSaga),

    yield takeLatest(actions.listBehavior.request, listBehaviorSaga),
    yield takeLatest(actions.list_forBehavior.request, list_forBehaviorSaga),
    yield takeLatest(actions.findBehavior.request, findBehaviorSaga),
    yield takeLatest(actions.createBehavior.request, createBehaviorSaga),
    yield takeLatest(actions.webhook_testBehavior.request, webhook_testBehaviorSaga),
  ]
}

export default behaviorSagas
