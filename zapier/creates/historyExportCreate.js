const sample = {
  "user_id": 1,
  "start_at": "2000-01-01T01:00:00Z",
  "end_at": "2000-01-01T01:00:00Z",
  "query_action": "read",
  "query_interface": "ftp",
  "query_user_id": 1,
  "query_file_id": 1,
  "query_parent_id": 1,
  "query_path": "MyFile.txt",
  "query_folder": "Folder",
  "query_src": "SrcFolder",
  "query_destination": "DestFolder",
  "query_ip": "127.0.0.1",
  "query_username": "jerry",
  "query_failure_type": "bad_password",
  "query_target_id": 1,
  "query_target_name": "full",
  "query_target_permission": "full",
  "query_target_user_id": 1,
  "query_target_username": "jerry",
  "query_target_platform": "windows",
  "query_target_permission_set": "desktop_app"
}


const operationLabel = 'Create HistoryExport'
const operationImportant = false
const validParams = ["user_id", "start_at", "end_at", "query_action", "query_interface", "query_user_id", "query_file_id", "query_parent_id", "query_path", "query_folder", "query_src", "query_destination", "query_ip", "query_username", "query_failure_type", "query_target_id", "query_target_name", "query_target_permission", "query_target_user_id", "query_target_username", "query_target_platform", "query_target_permission_set"]

const extraInputFields = []
const modelName = 'History Export'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/history_exports.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'user_id',
        label: 'User',
        helpText: "User ID.  Provide a value of `0` to operate the current session's user.",
        required: false,
        type: 'integer',
        dynamic: 'user.id',
      },
      {
        key: 'start_at',
        label: 'Start At',
        helpText: "Start date/time of export range.",
        required: false,
        type: 'string',
      },
      {
        key: 'end_at',
        label: 'End At',
        helpText: "End date/time of export range.",
        required: false,
        type: 'string',
      },
      {
        key: 'query_action',
        label: 'Query Action',
        helpText: "Filter results by this this action type. Valid values: `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, `api_key_destroy`",
        required: false,
        type: 'string',
      },
      {
        key: 'query_interface',
        label: 'Query Interface',
        helpText: "Filter results by this this interface type. Valid values: `web`, `ftp`, `robot`, `jsapi`, `webdesktopapi`, `sftp`, `dav`, `desktop`, `restapi`, `scim`",
        required: false,
        type: 'string',
      },
      {
        key: 'query_user_id',
        label: 'Query User',
        helpText: "Return results that are actions performed by the user indiciated by this User ID",
        required: false,
        type: 'integer',
        dynamic: 'query_user.id',
      },
      {
        key: 'query_file_id',
        label: 'Query File',
        helpText: "Return results that are file actions related to the file indicated by this File ID",
        required: false,
        type: 'integer',
        dynamic: 'query_file.id',
      },
      {
        key: 'query_parent_id',
        label: 'Query Parent',
        helpText: "Return results that are file actions inside the parent folder specified by this folder ID",
        required: false,
        type: 'integer',
        dynamic: 'query_parent.id',
      },
      {
        key: 'query_path',
        label: 'Query Path',
        helpText: "Return results that are file actions related to this path.",
        required: false,
        type: 'string',
      },
      {
        key: 'query_folder',
        label: 'Query Folder',
        helpText: "Return results that are file actions related to files or folders inside this folder path.",
        required: false,
        type: 'string',
      },
      {
        key: 'query_src',
        label: 'Query Src',
        helpText: "Return results that are file moves originating from this path.",
        required: false,
        type: 'string',
      },
      {
        key: 'query_destination',
        label: 'Query Destination',
        helpText: "Return results that are file moves with this path as destination.",
        required: false,
        type: 'string',
      },
      {
        key: 'query_ip',
        label: 'Query Ip',
        helpText: "Filter results by this IP address.",
        required: false,
        type: 'string',
      },
      {
        key: 'query_username',
        label: 'Query Username',
        helpText: "Filter results by this username.",
        required: false,
        type: 'string',
      },
      {
        key: 'query_failure_type',
        label: 'Query Failure Type',
        helpText: "If searching for Histories about login failures, this parameter restricts results to failures of this specific type.  Valid values: `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, `expired_access`, `desktop_ip_mismatch`, `desktop_api_key_not_used_quickly_enough`, `disabled`",
        required: false,
        type: 'string',
      },
      {
        key: 'query_target_id',
        label: 'Query Target',
        helpText: "If searching for Histories about specific objects (such as Users, or API Keys), this paremeter restricts results to objects that match this ID.",
        required: false,
        type: 'integer',
        dynamic: 'query_target.id',
      },
      {
        key: 'query_target_name',
        label: 'Query Target Name',
        helpText: "If searching for Histories about Users, Groups or other objects with names, this parameter restricts results to objects with this name/username.",
        required: false,
        type: 'string',
      },
      {
        key: 'query_target_permission',
        label: 'Query Target Permission',
        helpText: "If searching for Histories about Permisisons, this parameter restricts results to permissions of this level.",
        required: false,
        type: 'string',
      },
      {
        key: 'query_target_user_id',
        label: 'Query Target User',
        helpText: "If searching for Histories about API keys, this parameter restricts results to API keys created by/for this user ID.",
        required: false,
        type: 'integer',
        dynamic: 'query_target_user.id',
      },
      {
        key: 'query_target_username',
        label: 'Query Target Username',
        helpText: "If searching for Histories about API keys, this parameter restricts results to API keys created by/for this username.",
        required: false,
        type: 'string',
      },
      {
        key: 'query_target_platform',
        label: 'Query Target Platform',
        helpText: "If searching for Histories about API keys, this parameter restricts results to API keys associated with this platform.",
        required: false,
        type: 'string',
      },
      {
        key: 'query_target_permission_set',
        label: 'Query Target Permission Set',
        helpText: "If searching for Histories about API keys, this parameter restricts results to API keys with this permission set.",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create History Export.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
