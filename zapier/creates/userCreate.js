const sample = {
  "avatar_delete": true,
  "email": "john.doe@files.com",
  "group_id": 1,
  "announcements_read": true,
  "allowed_ips": "127.0.0.1",
  "attachments_permission": true,
  "authenticate_until": "2000-01-01T01:00:00Z",
  "authentication_method": "password",
  "billing_permission": true,
  "bypass_inactive_disable": true,
  "bypass_site_allowed_ips": true,
  "dav_permission": true,
  "disabled": true,
  "ftp_permission": true,
  "language": "en",
  "notification_daily_send_time": 18,
  "name": "John Doe",
  "notes": "Internal notes on this user.",
  "password_validity_days": 1,
  "receive_admin_alerts": true,
  "require_password_change": true,
  "restapi_permission": true,
  "self_managed": true,
  "sftp_permission": true,
  "site_admin": true,
  "skip_welcome_screen": true,
  "ssl_required": "always_require",
  "sso_strategy_id": 1,
  "subscribe_to_newsletter": true,
  "time_zone": "Pacific Time (US & Canada)",
  "username": "user"
}

const operationImportant = true
const operationLabel = 'Create User'
const validParams = ["avatar_file", "avatar_delete", "change_password", "change_password_confirmation", "email", "grant_permission", "group_id", "group_ids", "password", "password_confirmation", "announcements_read", "allowed_ips", "attachments_permission", "authenticate_until", "authentication_method", "billing_permission", "bypass_inactive_disable", "bypass_site_allowed_ips", "dav_permission", "disabled", "ftp_permission", "language", "notification_daily_send_time", "name", "notes", "password_validity_days", "receive_admin_alerts", "require_password_change", "restapi_permission", "self_managed", "sftp_permission", "site_admin", "skip_welcome_screen", "ssl_required", "sso_strategy_id", "subscribe_to_newsletter", "time_zone", "user_root", "username"]

const extraInputFields = []
const modelName = 'User'

const perform = (z, bundle) => {
  const requestParams = validParams.reduce((params, paramName) => {
    if (Boolean(bundle.inputData[paramName])) {
      params[paramName] = bundle.inputData[paramName]
    }
    return params
  }, [])

  const responsePromise = z.request({
    method: 'POST',
    url: 'https://app.files.com/api/rest/v1/users.json',
    body: JSON.stringify({
      ...requestParams,
    })
  })
  return responsePromise
    .then(response => JSON.parse(response.content));
}

const inputFields = [
      {
        key: 'avatar_file',
        label: 'Avatar File',
        helpText: "An image file for your user avatar.",
        required: false,
        type: 'file',
      },
      {
        key: 'avatar_delete',
        label: 'Avatar Delete',
        helpText: "If true, the avatar will be deleted.",
        required: false,
        type: 'boolean',
      },
      {
        key: 'change_password',
        label: 'Change Password',
        helpText: "Used for changing a password on an existing user.",
        required: false,
        type: 'string',
      },
      {
        key: 'change_password_confirmation',
        label: 'Change Password Confirmation',
        helpText: "Optional, but if provided, we will ensure that it matches the value sent in `change_password`.",
        required: false,
        type: 'string',
      },
      {
        key: 'email',
        label: 'Email',
        helpText: "User's email.",
        required: false,
        type: 'string',
      },
      {
        key: 'grant_permission',
        label: 'Grant Permission',
        helpText: "Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.",
        required: false,
        type: 'string',
      },
      {
        key: 'group_id',
        label: 'Group',
        helpText: "Group ID to associate this user with.",
        required: false,
        type: 'integer',
        dynamic: 'group.id',
      },
      {
        key: 'group_ids',
        label: 'Group Ids',
        helpText: "A list of group ids to associate this user with.  Comma delimited.",
        required: false,
        type: 'string',
      },
      {
        key: 'password',
        label: 'Password',
        helpText: "User password.",
        required: false,
        type: 'string',
      },
      {
        key: 'password_confirmation',
        label: 'Password Confirmation',
        helpText: "Optional, but if provided, we will ensure that it matches the value sent in `password`.",
        required: false,
        type: 'string',
      },
      {
        key: 'announcements_read',
        label: 'Announcements Read',
        helpText: "Signifies that the user has read all the announcements in the UI.",
        required: false,
        type: 'boolean',
      },
      {
        key: 'allowed_ips',
        label: 'Allowed Ips',
        helpText: "A list of allowed IPs if applicable.  Newline delimited",
        required: false,
        type: 'string',
      },
      {
        key: 'attachments_permission',
        label: 'Attachments Permission',
        helpText: "Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.",
        required: false,
        type: 'boolean',
      },
      {
        key: 'authenticate_until',
        label: 'Authenticate Until',
        helpText: "Scheduled Date/Time at which user will be deactivated",
        required: false,
        type: 'string',
      },
      {
        key: 'authentication_method',
        label: 'Authentication Method',
        helpText: "How is this user authenticated?",
        required: false,
        type: 'string',
        choices: {password: 'password', ldap: 'ldap', sso: 'sso', none: 'none'},
      },
      {
        key: 'billing_permission',
        label: 'Billing Permission',
        helpText: "Allow this user to perform operations on the account, payments, and invoices?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'bypass_inactive_disable',
        label: 'Bypass Inactive Disable',
        helpText: "Exempt this user from being disabled based on inactivity?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'bypass_site_allowed_ips',
        label: 'Bypass Site Allowed Ips',
        helpText: "Allow this user to skip site-wide IP blacklists?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'dav_permission',
        label: 'Dav Permission',
        helpText: "Can the user connect with WebDAV?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'disabled',
        label: 'Disabled',
        helpText: "Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.",
        required: false,
        type: 'boolean',
      },
      {
        key: 'ftp_permission',
        label: 'Ftp Permission',
        helpText: "Can the user access with FTP/FTPS?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'language',
        label: 'Language',
        helpText: "Preferred language",
        required: false,
        type: 'string',
      },
      {
        key: 'notification_daily_send_time',
        label: 'Notification Daily Send Time',
        helpText: "Hour of the day at which daily notifications should be sent. Can be in range 0 to 23",
        required: false,
        type: 'integer',
      },
      {
        key: 'name',
        label: 'Name',
        helpText: "User's full name",
        required: false,
        type: 'string',
      },
      {
        key: 'notes',
        label: 'Notes',
        helpText: "Any internal notes on the user",
        required: false,
        type: 'string',
      },
      {
        key: 'password_validity_days',
        label: 'Password Validity Days',
        helpText: "Number of days to allow user to use the same password",
        required: false,
        type: 'integer',
      },
      {
        key: 'receive_admin_alerts',
        label: 'Receive Admin Alerts',
        helpText: "Should the user receive admin alerts such a certificate expiration notifications and overages?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'require_password_change',
        label: 'Require Password Change',
        helpText: "Is a password change required upon next user login?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'restapi_permission',
        label: 'Restapi Permission',
        helpText: "Can this user access the REST API?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'self_managed',
        label: 'Self Managed',
        helpText: "Does this user manage it's own credentials or is it a shared/bot user?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'sftp_permission',
        label: 'Sftp Permission',
        helpText: "Can the user access with SFTP?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'site_admin',
        label: 'Site Admin',
        helpText: "Is the user an administrator for this site?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'skip_welcome_screen',
        label: 'Skip Welcome Screen',
        helpText: "Skip Welcome page in the UI?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'ssl_required',
        label: 'Ssl Required',
        helpText: "SSL required setting",
        required: false,
        type: 'string',
        choices: {use_system_setting: 'use_system_setting', always_require: 'always_require', never_require: 'never_require'},
      },
      {
        key: 'sso_strategy_id',
        label: 'Sso Strategy',
        helpText: "SSO (Single Sign On) strategy ID for the user, if applicable.",
        required: false,
        type: 'integer',
        dynamic: 'sso_strategy.id',
      },
      {
        key: 'subscribe_to_newsletter',
        label: 'Subscribe To Newsletter',
        helpText: "Is the user subscribed to the newsletter?",
        required: false,
        type: 'boolean',
      },
      {
        key: 'time_zone',
        label: 'Time Zone',
        helpText: "User time zone",
        required: false,
        type: 'string',
      },
      {
        key: 'user_root',
        label: 'User Root',
        helpText: "Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.",
        required: false,
        type: 'string',
      },
      {
        key: 'username',
        label: 'Username',
        helpText: "User's username",
        required: false,
        type: 'string',
      },
].filter(field => validParams.includes(field.key))

module.exports = {
  key: modelName.toLowerCase(),
  noun: modelName,

  display: {
    label: operationLabel,
    description: "Create User.",
    important: operationImportant,
  },

  operation: {
    inputFields: [...inputFields, ...extraInputFields],
    perform: perform,
    sample: sample
  }
}
