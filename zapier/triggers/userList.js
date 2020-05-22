const sample = {
  "id": 1,
  "username": "user",
  "admin_group_ids": [

  ],
  "allowed_ips": "127.0.0.1",
  "attachments_permission": true,
  "api_keys_count": 1,
  "authenticate_until": "2000-01-01T01:00:00Z",
  "authentication_method": "password",
  "avatar_url": "",
  "billing_permission": true,
  "bypass_site_allowed_ips": true,
  "created_at": "2000-01-01T01:00:00Z",
  "dav_permission": true,
  "disabled": true,
  "email": "john.doe@files.com",
  "ftp_permission": true,
  "group_ids": "",
  "language": "en",
  "last_login_at": "2000-01-01T01:00:00Z",
  "last_protocol_cipher": "",
  "lockout_expires": "2000-01-01T01:00:00Z",
  "name": "John Doe",
  "notes": "Internal notes on this user.",
  "notification_daily_send_time": 18,
  "password_set_at": "2000-01-01T01:00:00Z",
  "password_validity_days": 1,
  "public_keys_count": 1,
  "require_2fa": true,
  "require_password_change": true,
  "restapi_permission": true,
  "self_managed": true,
  "sftp_permission": true,
  "site_admin": true,
  "skip_welcome_screen": true,
  "ssl_required": "always_require",
  "sso_strategy_id": 1,
  "externally_managed": true,
  "time_zone": "Pacific Time (US & Canada)",
  "type_of_2fa": "",
  "user_root": ""
}
const validParams = ["search"]
const modelName = 'User'
const noun = modelName
const display = {
  label: `${modelName} Created`,
  description: `Triggers when a new ${modelName.replace(/_/g, ' ')} is created.`,
  important: true,
}

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/users.json',
    params: {
      per_page: 10000,
      page: 1,
      ...requestParams,
    },
  })

  return responsePromise
    .then(response => JSON.parse(response.content))
}

const inputFields = [
      {
        key: 'search',
        label: 'Search',
        helpText: "Searches for partial matches of name, username, or email.",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: noun,
  display: display,

  operation: {
    canPaginate: true,
    inputFields: inputFields,
    perform: perform,
    sample: sample,
  }
}
