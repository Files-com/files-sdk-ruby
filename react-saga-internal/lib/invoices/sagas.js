import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const listInvoiceSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Invoices objects.',
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

  yield put(clearErrorStatus(actions.listInvoice.request))
  yield put(setLoadingStatus(actions.listInvoice.request))

  yield loadEntitySaga(
    actions.listInvoice,
    ApiListInvoice,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listInvoice.request))
}

const findInvoiceSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Invoices object.',
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

  yield put(clearErrorStatus(actions.findInvoice.request))
  yield put(setLoadingStatus(actions.findInvoice.request))

  yield loadEntitySaga(
    actions.findInvoice,
    ApiFindInvoice,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findInvoice.request))
}

function * invoiceSagas() {
  return [

    yield takeLatest(actions.listInvoice.request, listInvoiceSaga),
    yield takeLatest(actions.findInvoice.request, findInvoiceSaga),
  ]
}

export default invoiceSagas
