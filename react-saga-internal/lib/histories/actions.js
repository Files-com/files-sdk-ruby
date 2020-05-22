import { createActions } from 'utils/actions'
import Api from 'utils/api'


// Parameters:
//   start_at - string - Leave blank or set to a date/time to filter earlier entries.
//   end_at - string - Leave blank or set to a date/time to filter later entries.
//   display - string - Display format. Leave blank or set to `full` or `parent`.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   path (required) - string - Path to operate on.

const ApiListForFileHistory = params => Api.get(`/history/files(/*path)`, params)
const list_for_fileHistory = createActions('HISTORY_LIST_FOR_FILE')

// Parameters:
//   start_at - string - Leave blank or set to a date/time to filter earlier entries.
//   end_at - string - Leave blank or set to a date/time to filter later entries.
//   display - string - Display format. Leave blank or set to `full` or `parent`.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   path (required) - string - Path to operate on.

const ApiListForFolderHistory = params => Api.get(`/history/folders(/*path)`, params)
const list_for_folderHistory = createActions('HISTORY_LIST_FOR_FOLDER')

// Parameters:
//   start_at - string - Leave blank or set to a date/time to filter earlier entries.
//   end_at - string - Leave blank or set to a date/time to filter later entries.
//   display - string - Display format. Leave blank or set to `full` or `parent`.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   user_id (required) - integer - User ID.

const ApiListForUserHistory = params => Api.get(`/history/users/${params.user_id}`, params)
const list_for_userHistory = createActions('HISTORY_LIST_FOR_USER')

// Parameters:
//   start_at - string - Leave blank or set to a date/time to filter earlier entries.
//   end_at - string - Leave blank or set to a date/time to filter later entries.
//   display - string - Display format. Leave blank or set to `full` or `parent`.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.

const ApiListLoginsHistory = params => Api.get(`/history/login`, params)
const list_loginsHistory = createActions('HISTORY_LIST_LOGINS')

// Parameters:
//   start_at - string - Leave blank or set to a date/time to filter earlier entries.
//   end_at - string - Leave blank or set to a date/time to filter later entries.
//   display - string - Display format. Leave blank or set to `full` or `parent`.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.

const ApiListHistory = params => Api.get(`/history`, params)
const listHistory = createActions('HISTORY_LIST')

export {

  list_for_fileHistory, ApiListForFileHistory,
  list_for_folderHistory, ApiListForFolderHistory,
  list_for_userHistory, ApiListForUserHistory,
  list_loginsHistory, ApiListLoginsHistory,
  listHistory, ApiListHistory,
}
