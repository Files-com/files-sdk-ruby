import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const listPaymentSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Payments objects.',
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

  yield put(clearErrorStatus(actions.listPayment.request))
  yield put(setLoadingStatus(actions.listPayment.request))

  yield loadEntitySaga(
    actions.listPayment,
    ApiListPayment,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listPayment.request))
}

const findPaymentSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Payments object.',
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

  yield put(clearErrorStatus(actions.findPayment.request))
  yield put(setLoadingStatus(actions.findPayment.request))

  yield loadEntitySaga(
    actions.findPayment,
    ApiFindPayment,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findPayment.request))
}

function * paymentSagas() {
  return [

    yield takeLatest(actions.listPayment.request, listPaymentSaga),
    yield takeLatest(actions.findPayment.request, findPaymentSaga),
  ]
}

export default paymentSagas
