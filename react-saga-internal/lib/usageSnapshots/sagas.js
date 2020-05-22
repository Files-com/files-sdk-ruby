import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const listUsageSnapshotSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of UsageSnapshots objects.',
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

  yield put(clearErrorStatus(actions.listUsageSnapshot.request))
  yield put(setLoadingStatus(actions.listUsageSnapshot.request))

  yield loadEntitySaga(
    actions.listUsageSnapshot,
    ApiListUsageSnapshot,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listUsageSnapshot.request))
}

function * usageSnapshotSagas() {
  return [

    yield takeLatest(actions.listUsageSnapshot.request, listUsageSnapshotSaga),
  ]
}

export default usageSnapshotSagas
