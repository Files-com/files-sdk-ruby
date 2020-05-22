import { createActions } from 'utils/actions'
import Api from 'utils/api'


const ApiDeleteHistoryExport = params => Api.delete(`/history_exports/${params.id}`, params)
const deleteHistoryExport = createActions('HISTORYEXPORT_DELETE')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.

const ApiListHistoryExport = params => Api.get(`/history_exports`, params)
const listHistoryExport = createActions('HISTORYEXPORT_LIST')

// Parameters:
//   id (required) - integer - History Export ID.

const ApiFindHistoryExport = params => Api.get(`/history_exports/${params.id}`, params)
const findHistoryExport = createActions('HISTORYEXPORT_FIND')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   start_at - string - Start date/time of export range.
//   end_at - string - End date/time of export range.
//   query_action - string - Filter results by this this action type. Valid values: `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, `api_key_destroy`
//   query_interface - string - Filter results by this this interface type. Valid values: `web`, `ftp`, `robot`, `jsapi`, `webdesktopapi`, `sftp`, `dav`, `desktop`, `restapi`, `scim`
//   query_user_id - integer - Return results that are actions performed by the user indiciated by this User ID
//   query_file_id - integer - Return results that are file actions related to the file indicated by this File ID
//   query_parent_id - integer - Return results that are file actions inside the parent folder specified by this folder ID
//   query_path - string - Return results that are file actions related to this path.
//   query_folder - string - Return results that are file actions related to files or folders inside this folder path.
//   query_src - string - Return results that are file moves originating from this path.
//   query_destination - string - Return results that are file moves with this path as destination.
//   query_ip - string - Filter results by this IP address.
//   query_username - string - Filter results by this username.
//   query_failure_type - string - If searching for Histories about login failures, this parameter restricts results to failures of this specific type.  Valid values: `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, `expired_access`, `desktop_ip_mismatch`, `desktop_api_key_not_used_quickly_enough`, `disabled`
//   query_target_id - integer - If searching for Histories about specific objects (such as Users, or API Keys), this paremeter restricts results to objects that match this ID.
//   query_target_name - string - If searching for Histories about Users, Groups or other objects with names, this parameter restricts results to objects with this name/username.
//   query_target_permission - string - If searching for Histories about Permisisons, this parameter restricts results to permissions of this level.
//   query_target_user_id - integer - If searching for Histories about API keys, this parameter restricts results to API keys created by/for this user ID.
//   query_target_username - string - If searching for Histories about API keys, this parameter restricts results to API keys created by/for this username.
//   query_target_platform - string - If searching for Histories about API keys, this parameter restricts results to API keys associated with this platform.
//   query_target_permission_set - string - If searching for Histories about API keys, this parameter restricts results to API keys with this permission set.

const ApiCreateHistoryExport = params => Api.post(`/history_exports`, params)
const createHistoryExport = createActions('HISTORYEXPORT_CREATE')

export {
  deleteHistoryExport, ApiDeleteHistoryExport,

  listHistoryExport, ApiListHistoryExport,
  findHistoryExport, ApiFindHistoryExport,
  createHistoryExport, ApiCreateHistoryExport,
}
