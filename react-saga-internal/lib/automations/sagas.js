import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateAutomationSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Automations object.',
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

  yield put(clearErrorStatus(actions.updateAutomation.request))
  yield put(setLoadingStatus(actions.updateAutomation.request))

  yield updateEntitySaga(
    actions.updateAutomation,
    ApiUpdateAutomation,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateAutomation.request))
}

const deleteAutomationSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteAutomation.request))
  yield put(setLoadingStatus(actions.deleteAutomation.request))

  yield deleteEntitySaga(
    actions.deleteAutomation,
    ApiDeleteAutomation,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteAutomation.request))
}

const listAutomationSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Automations objects.',
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

  yield put(clearErrorStatus(actions.listAutomation.request))
  yield put(setLoadingStatus(actions.listAutomation.request))

  yield loadEntitySaga(
    actions.listAutomation,
    ApiListAutomation,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listAutomation.request))
}

const findAutomationSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Automations object.',
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

  yield put(clearErrorStatus(actions.findAutomation.request))
  yield put(setLoadingStatus(actions.findAutomation.request))

  yield loadEntitySaga(
    actions.findAutomation,
    ApiFindAutomation,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findAutomation.request))
}

const createAutomationSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Automations object.',
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

  yield put(clearErrorStatus(actions.createAutomation.request))
  yield put(setLoadingStatus(actions.createAutomation.request))

  yield postEntitySaga(
    actions.createAutomation,
    ApiCreateAutomation,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createAutomation.request))
}

function * automationSagas() {
  return [
    yield takeLatest(actions.updateAutomation.request, updateAutomationSaga),
    yield takeLatest(actions.deleteAutomation.request, deleteAutomationSaga),

    yield takeLatest(actions.listAutomation.request, listAutomationSaga),
    yield takeLatest(actions.findAutomation.request, findAutomationSaga),
    yield takeLatest(actions.createAutomation.request, createAutomationSaga),
  ]
}

export default automationSagas
