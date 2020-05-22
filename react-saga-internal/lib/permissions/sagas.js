import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const listPermissionSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Permissions objects.',
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

  yield put(clearErrorStatus(actions.listPermission.request))
  yield put(setLoadingStatus(actions.listPermission.request))

  yield loadEntitySaga(
    actions.listPermission,
    ApiListPermission,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listPermission.request))
}

const createPermissionSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Permissions object.',
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

  yield put(clearErrorStatus(actions.createPermission.request))
  yield put(setLoadingStatus(actions.createPermission.request))

  yield postEntitySaga(
    actions.createPermission,
    ApiCreatePermission,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createPermission.request))
}

const deletePermissionSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deletePermission.request))
  yield put(setLoadingStatus(actions.deletePermission.request))

  yield deleteEntitySaga(
    actions.deletePermission,
    ApiDeletePermission,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deletePermission.request))
}

function * permissionSagas() {
  return [

    yield takeLatest(actions.listPermission.request, listPermissionSaga),
    yield takeLatest(actions.createPermission.request, createPermissionSaga),
    yield takeLatest(actions.deletePermission.request, deletePermissionSaga),
  ]
}

export default permissionSagas
