import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const getSiteSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Site object.',
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

  yield put(clearErrorStatus(actions.getSite.request))
  yield put(setLoadingStatus(actions.getSite.request))

  yield loadEntitySaga(
    actions.getSite,
    ApiGetSite,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.getSite.request))
}

const get_usageSiteSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Site object.',
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

  yield put(clearErrorStatus(actions.get_usageSite.request))
  yield put(setLoadingStatus(actions.get_usageSite.request))

  yield loadEntitySaga(
    actions.get_usageSite,
    ApiGetUsageSite,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.get_usageSite.request))
}

const updateSiteSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Site object.',
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

  yield put(clearErrorStatus(actions.updateSite.request))
  yield put(setLoadingStatus(actions.updateSite.request))

  yield updateEntitySaga(
    actions.updateSite,
    ApiUpdateSite,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateSite.request))
}

function * siteSagas() {
  return [

    yield takeLatest(actions.getSite.request, getSiteSaga),
    yield takeLatest(actions.get_usageSite.request, get_usageSiteSaga),
    yield takeLatest(actions.updateSite.request, updateSiteSaga),
  ]
}

export default siteSagas
