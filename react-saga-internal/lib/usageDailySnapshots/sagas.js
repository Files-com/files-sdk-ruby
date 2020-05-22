import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const listUsageDailySnapshotSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of UsageDailySnapshots objects.',
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

  yield put(clearErrorStatus(actions.listUsageDailySnapshot.request))
  yield put(setLoadingStatus(actions.listUsageDailySnapshot.request))

  yield loadEntitySaga(
    actions.listUsageDailySnapshot,
    ApiListUsageDailySnapshot,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listUsageDailySnapshot.request))
}

function * usageDailySnapshotSagas() {
  return [

    yield takeLatest(actions.listUsageDailySnapshot.request, listUsageDailySnapshotSaga),
  ]
}

export default usageDailySnapshotSagas
