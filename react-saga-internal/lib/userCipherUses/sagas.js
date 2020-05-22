import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const listUserCipherUseSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of UserCipherUses objects.',
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

  yield put(clearErrorStatus(actions.listUserCipherUse.request))
  yield put(setLoadingStatus(actions.listUserCipherUse.request))

  yield loadEntitySaga(
    actions.listUserCipherUse,
    ApiListUserCipherUse,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listUserCipherUse.request))
}

function * userCipherUseSagas() {
  return [

    yield takeLatest(actions.listUserCipherUse.request, listUserCipherUseSaga),
  ]
}

export default userCipherUseSagas
