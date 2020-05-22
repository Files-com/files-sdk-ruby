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
  "bypass_inactive_disable": true,
  "created_at": "2000-01-01T01:00:00Z",
  "dav_permission": true,
  "disabled": true,
  "email": "john.doe@files.com",
  "ftp_permission": true,
  "group_ids": [

  ],
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
  "receive_admin_alerts": true,
  "require_2fa": true,
  "require_password_change": true,
  "restapi_permission": true,
  "self_managed": true,
  "sftp_permission": true,
  "site_admin": true,
  "skip_welcome_screen": true,
  "ssl_required": "always_require",
  "sso_strategy_id": 1,
  "subscribe_to_newsletter": true,
  "externally_managed": true,
  "time_zone": "Pacific Time (US & Canada)",
  "type_of_2fa": "",
  "user_root": ""
}

const searchUser = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/users/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'user',
  noun: 'User',

  display: {
    label: 'Find User',
    description: 'Find a single user.',
    important: true,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: "User ID.",
        required: true,
        type: 'integer',
        dynamic: 'user.id',
      },
    ],
    perform: searchUser,
    sample: sample
  }
}
