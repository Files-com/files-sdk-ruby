import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Copy file/folder
//
// Parameters:
//   destination (required) - string - Copy destination path.

const ApiCopyFileAction = params => Api.post(`/file_actions/copy/" . rawurlencode($params['path']) . "`, params)
const copyFileAction = createActions('FILEACTION_COPY')
// Move file/folder
//
// Parameters:
//   destination (required) - string - Move destination path.

const ApiMoveFileAction = params => Api.post(`/file_actions/move/" . rawurlencode($params['path']) . "`, params)
const moveFileAction = createActions('FILEACTION_MOVE')
// Begin file upload
//
// Parameters:
//   mkdir_parents - boolean - Create parent directories if they do not exist?
//   part - integer - Part if uploading a part.
//   parts - integer - How many parts to fetch?
//   ref - string -
//   restart - integer - File byte offset to restart from.
//   with_rename - boolean - Allow file rename instead of overwrite?

const ApiBeginUploadFileAction = params => Api.post(`/file_actions/begin_upload/" . rawurlencode($params['path']) . "`, params)
const begin_uploadFileAction = createActions('FILEACTION_BEGIN_UPLOAD')

export {
  copyFileAction, ApiCopyFileAction,
  moveFileAction, ApiMoveFileAction,
  begin_uploadFileAction, ApiBeginUploadFileAction,

}
