import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateStyleSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Styles object.',
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

  yield put(clearErrorStatus(actions.updateStyle.request))
  yield put(setLoadingStatus(actions.updateStyle.request))

  yield updateEntitySaga(
    actions.updateStyle,
    ApiUpdateStyle,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateStyle.request))
}

const deleteStyleSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteStyle.request))
  yield put(setLoadingStatus(actions.deleteStyle.request))

  yield deleteEntitySaga(
    actions.deleteStyle,
    ApiDeleteStyle,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteStyle.request))
}

const listStyleSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Styles object.',
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

  yield put(clearErrorStatus(actions.listStyle.request))
  yield put(setLoadingStatus(actions.listStyle.request))

  yield loadEntitySaga(
    actions.listStyle,
    ApiListStyle,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listStyle.request))
}

function * styleSagas() {
  return [
    yield takeLatest(actions.updateStyle.request, updateStyleSaga),
    yield takeLatest(actions.deleteStyle.request, deleteStyleSaga),

    yield takeLatest(actions.listStyle.request, listStyleSaga),
  ]
}

export default styleSagas
