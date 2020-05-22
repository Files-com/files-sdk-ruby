import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const listIpAddressSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of IpAddresses objects.',
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

  yield put(clearErrorStatus(actions.listIpAddress.request))
  yield put(setLoadingStatus(actions.listIpAddress.request))

  yield loadEntitySaga(
    actions.listIpAddress,
    ApiListIpAddress,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listIpAddress.request))
}

function * ipAddressSagas() {
  return [

    yield takeLatest(actions.listIpAddress.request, listIpAddressSaga),
  ]
}

export default ipAddressSagas
