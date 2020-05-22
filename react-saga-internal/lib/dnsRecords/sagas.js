import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const listDnsRecordSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of DnsRecords objects.',
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

  yield put(clearErrorStatus(actions.listDnsRecord.request))
  yield put(setLoadingStatus(actions.listDnsRecord.request))

  yield loadEntitySaga(
    actions.listDnsRecord,
    ApiListDnsRecord,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listDnsRecord.request))
}

function * dnsRecordSagas() {
  return [

    yield takeLatest(actions.listDnsRecord.request, listDnsRecordSaga),
  ]
}

export default dnsRecordSagas
