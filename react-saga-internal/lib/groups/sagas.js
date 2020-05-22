import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateGroupSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Groups object.',
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

  yield put(clearErrorStatus(actions.updateGroup.request))
  yield put(setLoadingStatus(actions.updateGroup.request))

  yield updateEntitySaga(
    actions.updateGroup,
    ApiUpdateGroup,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateGroup.request))
}

const deleteGroupSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteGroup.request))
  yield put(setLoadingStatus(actions.deleteGroup.request))

  yield deleteEntitySaga(
    actions.deleteGroup,
    ApiDeleteGroup,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteGroup.request))
}

const listGroupSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Groups objects.',
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

  yield put(clearErrorStatus(actions.listGroup.request))
  yield put(setLoadingStatus(actions.listGroup.request))

  yield loadEntitySaga(
    actions.listGroup,
    ApiListGroup,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listGroup.request))
}

const findGroupSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Groups object.',
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

  yield put(clearErrorStatus(actions.findGroup.request))
  yield put(setLoadingStatus(actions.findGroup.request))

  yield loadEntitySaga(
    actions.findGroup,
    ApiFindGroup,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findGroup.request))
}

const createGroupSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Groups object.',
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

  yield put(clearErrorStatus(actions.createGroup.request))
  yield put(setLoadingStatus(actions.createGroup.request))

  yield postEntitySaga(
    actions.createGroup,
    ApiCreateGroup,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createGroup.request))
}

function * groupSagas() {
  return [
    yield takeLatest(actions.updateGroup.request, updateGroupSaga),
    yield takeLatest(actions.deleteGroup.request, deleteGroupSaga),

    yield takeLatest(actions.listGroup.request, listGroupSaga),
    yield takeLatest(actions.findGroup.request, findGroupSaga),
    yield takeLatest(actions.createGroup.request, createGroupSaga),
  ]
}

export default groupSagas
