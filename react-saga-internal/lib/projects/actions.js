import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   global_access (required) - string - Global permissions.  Can be: `none`, `anyone_with_read`, `anyone_with_full`.

const ApiUpdateProject = params => Api.patch(`/projects/${params.id}`, params)
const updateProject = createActions('PROJECT_UPDATE')

const ApiDeleteProject = params => Api.delete(`/projects/${params.id}`, params)
const deleteProject = createActions('PROJECT_DELETE')

// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.

const ApiListProject = params => Api.get(`/projects`, params)
const listProject = createActions('PROJECT_LIST')

// Parameters:
//   id (required) - integer - Project ID.

const ApiFindProject = params => Api.get(`/projects/${params.id}`, params)
const findProject = createActions('PROJECT_FIND')

// Parameters:
//   global_access (required) - string - Global permissions.  Can be: `none`, `anyone_with_read`, `anyone_with_full`.

const ApiCreateProject = params => Api.post(`/projects`, params)
const createProject = createActions('PROJECT_CREATE')

export {
  updateProject, ApiUpdateProject,
  deleteProject, ApiDeleteProject,

  listProject, ApiListProject,
  findProject, ApiFindProject,
  createProject, ApiCreateProject,
}
