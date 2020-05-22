import {
  deleteEntitySaga,
  loadEntitySaga,
  postEntitySaga,
  updateEntitySaga,
} from 'store/utils/saga'

import * as actions from './actions'

const updateProjectSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Projects object.',
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

  yield put(clearErrorStatus(actions.updateProject.request))
  yield put(setLoadingStatus(actions.updateProject.request))

  yield updateEntitySaga(
    actions.updateProject,
    ApiUpdateProject,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.updateProject.request))
}

const deleteProjectSaga = function * ({ payload }) {
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

  yield put(clearErrorStatus(actions.deleteProject.request))
  yield put(setLoadingStatus(actions.deleteProject.request))

  yield deleteEntitySaga(
    actions.deleteProject,
    ApiDeleteProject,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.deleteProject.request))
}

const listProjectSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'A list of Projects objects.',
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

  yield put(clearErrorStatus(actions.listProject.request))
  yield put(setLoadingStatus(actions.listProject.request))

  yield loadEntitySaga(
    actions.listProject,
    ApiListProject,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.listProject.request))
}

const findProjectSaga = function * ({ payload }) {
  const responseCodeMessages = {
    200: 'The Projects object.',
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

  yield put(clearErrorStatus(actions.findProject.request))
  yield put(setLoadingStatus(actions.findProject.request))

  yield loadEntitySaga(
    actions.findProject,
    ApiFindProject,
    null,
    null,
    responseCodeMessages,
  )({ payload })

  yield put(clearLoadingStatus(actions.findProject.request))
}

const createProjectSaga = function * ({ payload }) {
  const responseCodeMessages = {
    201: 'The Projects object.',
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

  yield put(clearErrorStatus(actions.createProject.request))
  yield put(setLoadingStatus(actions.createProject.request))

  yield postEntitySaga(
    actions.createProject,
    ApiCreateProject,
    { responseCodeMessages },
  )({ payload })

  yield put(clearLoadingStatus(actions.createProject.request))
}

function * projectSagas() {
  return [
    yield takeLatest(actions.updateProject.request, updateProjectSaga),
    yield takeLatest(actions.deleteProject.request, deleteProjectSaga),

    yield takeLatest(actions.listProject.request, listProjectSaga),
    yield takeLatest(actions.findProject.request, findProjectSaga),
    yield takeLatest(actions.createProject.request, createProjectSaga),
  ]
}

export default projectSagas
