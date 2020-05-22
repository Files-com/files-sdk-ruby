import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   body (required) - string - Comment body.

const ApiUpdateFileComment = params => Api.patch(`/file_comments/${params.id}`, params)
const updateFileComment = createActions('FILECOMMENT_UPDATE')

const ApiDeleteFileComment = params => Api.delete(`/file_comments/${params.id}`, params)
const deleteFileComment = createActions('FILECOMMENT_DELETE')

// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   path (required) - string - Path to operate on.

const ApiListForFileComment = params => Api.get(`/file_comments/files/" . rawurlencode($params['path']) . "`, params)
const list_forFileComment = createActions('FILECOMMENT_LIST_FOR')

// Parameters:
//   body (required) - string - Comment body.
//   path (required) - string - File path.

const ApiCreateFileComment = params => Api.post(`/file_comments`, params)
const createFileComment = createActions('FILECOMMENT_CREATE')

export {
  updateFileComment, ApiUpdateFileComment,
  deleteFileComment, ApiDeleteFileComment,

  list_forFileComment, ApiListForFileComment,
  createFileComment, ApiCreateFileComment,
}
