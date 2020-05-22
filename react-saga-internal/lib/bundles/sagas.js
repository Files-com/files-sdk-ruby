import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const shareBundleSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.shareBundle.request))
  yield put(setLoadingStatus(actions.shareBundle.request))

  yield postEntitySaga(
    actions.shareBundle,
    ApiShareBundle,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.shareBundle.request))
}

const deleteBundleSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteBundle.request))
  yield put(setLoadingStatus(actions.deleteBundle.request))

  yield deleteEntitySaga(
    actions.deleteBundle,
    ApiDeleteBundle,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteBundle.request))
}

const listBundleSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Bundles objects.',
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

  yield put(clearErrorStatus(actions.listBundle.request))
  yield put(setLoadingStatus(actions.listBundle.request))

  yield loadEntitySaga(
    actions.listBundle,
    ApiListBundle,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listBundle.request))
}

const findBundleSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Bundles object.',
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

  yield put(clearErrorStatus(actions.findBundle.request))
  yield put(setLoadingStatus(actions.findBundle.request))

  yield loadEntitySaga(
    actions.findBundle,
    ApiFindBundle,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findBundle.request))
}

const createBundleSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Bundles object.',
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

  yield put(clearErrorStatus(actions.createBundle.request))
  yield put(setLoadingStatus(actions.createBundle.request))

  yield postEntitySaga(
    actions.createBundle,
    ApiCreateBundle,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createBundle.request))
}

function * bundleSagas() {
  return [
    yield takeLatest(actions.shareBundle.request, shareBundleSaga),
    yield takeLatest(actions.deleteBundle.request, deleteBundleSaga),

    yield takeLatest(actions.listBundle.request, listBundleSaga),
    yield takeLatest(actions.findBundle.request, findBundleSaga),
    yield takeLatest(actions.createBundle.request, createBundleSaga),
  ]
}

export default bundleSagas
