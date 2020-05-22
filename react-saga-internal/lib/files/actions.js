import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Download file
//
// Parameters:
//   action - string - Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
//   id - integer - If provided, lookup the file by id instead of path.
//   with_previews - boolean - Include file preview information?
//   with_priority_color - boolean - Include file priority color information?

const ApiDownloadFile = params => Api.get(`/files/" . rawurlencode($params['path']) . "`, params)
const downloadFile = createActions('FILE_DOWNLOAD')
// Parameters:
//   provided_mtime - string - Modified time of file.
//   priority_color - string - Priority/Bookmark color of file.

const ApiUpdateFile = params => Api.patch(`/files/" . rawurlencode($params['path']) . "`, params)
const updateFile = createActions('FILE_UPDATE')
// Parameters:
//   recursive - boolean - If true, will recursively delete folers.  Otherwise, will error on non-empty folders.  For legacy reasons, this parameter may also be provided as the HTTP header `Depth: Infinity`

const ApiDeleteFile = params => Api.delete(`/files/" . rawurlencode($params['path']) . "`, params)
const deleteFile = createActions('FILE_DELETE')

// Parameters:
//   path (required) - string - Path to operate on.
//   action - string - The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
//   etags[etag] (required) - array - etag identifier.
//   etags[part] (required) - array - Part number.
//   length - integer - Length of file.
//   mkdir_parents - boolean - Create parent directories if they do not exist?
//   part - integer - Part if uploading a part.
//   parts - integer - How many parts to fetch?
//   provided_mtime - string - User provided modification time.
//   ref - string -
//   restart - integer - File byte offset to restart from.
//   size - integer - Size of file.
//   structure - string - If copying folder, copy just the structure?
//   with_rename - boolean - Allow file rename instead of overwrite?

const ApiCreateFile = params => Api.post(`/files/" . rawurlencode($params['path']) . "`, params)
const createFile = createActions('FILE_CREATE')

export {
  downloadFile, ApiDownloadFile,
  updateFile, ApiUpdateFile,
  deleteFile, ApiDeleteFile,

  createFile, ApiCreateFile,
}
