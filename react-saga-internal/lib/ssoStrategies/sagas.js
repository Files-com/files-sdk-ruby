import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const listSsoStrategySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of SsoStrategies objects.',
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

  yield put(clearErrorStatus(actions.listSsoStrategy.request))
  yield put(setLoadingStatus(actions.listSsoStrategy.request))

  yield loadEntitySaga(
    actions.listSsoStrategy,
    ApiListSsoStrategy,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listSsoStrategy.request))
}

const findSsoStrategySaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The SsoStrategies object.',
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

  yield put(clearErrorStatus(actions.findSsoStrategy.request))
  yield put(setLoadingStatus(actions.findSsoStrategy.request))

  yield loadEntitySaga(
    actions.findSsoStrategy,
    ApiFindSsoStrategy,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findSsoStrategy.request))
}

function * ssoStrategySagas() {
  return [

    yield takeLatest(actions.listSsoStrategy.request, listSsoStrategySaga),
    yield takeLatest(actions.findSsoStrategy.request, findSsoStrategySaga),
  ]
}

export default ssoStrategySagas
