import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Unlock user who has been locked out due to failed logins

const ApiUnlockUser = params => Api.post(`/users/${params.id}/unlock`, params)
const unlockUser = createActions('USER_UNLOCK')
// Resend user welcome email

const ApiResendWelcomeEmailUser = params => Api.post(`/users/${params.id}/resend_welcome_email`, params)
const resend_welcome_emailUser = createActions('USER_RESEND_WELCOME_EMAIL')
// Trigger 2FA Reset process for user who has lost access to their existing 2FA methods

const ApiUser2faResetUser = params => Api.post(`/users/${params.id}/2fa/reset`, params)
const user_2fa_resetUser = createActions('USER_USER_2FA_RESET')
// Parameters:
//   avatar_file - file - An image file for your user avatar.
//   avatar_delete - boolean - If true, the avatar will be deleted.
//   change_password - string - Used for changing a password on an existing user.
//   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
//   email - string - User's email.
//   grant_permission - string - Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
//   group_id - integer - Group ID to associate this user with.
//   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
//   password - string - User password.
//   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
//   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
//   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
//   attachments_permission - boolean - Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
//   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
//   authentication_method - string - How is this user authenticated?
//   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
//   bypass_inactive_disable - boolean - Exempt this user from being disabled based on inactivity?
//   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
//   dav_permission - boolean - Can the user connect with WebDAV?
//   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
//   ftp_permission - boolean - Can the user access with FTP/FTPS?
//   language - string - Preferred language
//   notification_daily_send_time - integer - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
//   name - string - User's full name
//   notes - string - Any internal notes on the user
//   password_validity_days - integer - Number of days to allow user to use the same password
//   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
//   require_password_change - boolean - Is a password change required upon next user login?
//   restapi_permission - boolean - Can this user access the REST API?
//   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
//   sftp_permission - boolean - Can the user access with SFTP?
//   site_admin - boolean - Is the user an administrator for this site?
//   skip_welcome_screen - boolean - Skip Welcome page in the UI?
//   ssl_required - string - SSL required setting
//   sso_strategy_id - integer - SSO (Single Sign On) strategy ID for the user, if applicable.
//   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
//   time_zone - string - User time zone
//   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
//   username - string - User's username

const ApiUpdateUser = params => Api.patch(`/users/${params.id}`, params)
const updateUser = createActions('USER_UPDATE')

const ApiDeleteUser = params => Api.delete(`/users/${params.id}`, params)
const deleteUser = createActions('USER_DELETE')

// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   q[username] - string - List users matching username.
//   q[email] - string - List users matching email.
//   q[notes] - string - List users matching notes field.
//   q[admin] - string - If `true`, list only admin users.
//   q[allowed_ips] - string - If set, list only users with overridden allowed IP setting.
//   q[password_validity_days] - string - If set, list only users with overridden password validity days setting.
//   q[ssl_required] - string - If set, list only users with overridden SSL required setting.
//   search - string - Searches for partial matches of name, username, or email.

const ApiListUser = params => Api.get(`/users`, params)
const listUser = createActions('USER_LIST')

// Parameters:
//   id (required) - integer - User ID.

const ApiFindUser = params => Api.get(`/users/${params.id}`, params)
const findUser = createActions('USER_FIND')

// Parameters:
//   avatar_file - file - An image file for your user avatar.
//   avatar_delete - boolean - If true, the avatar will be deleted.
//   change_password - string - Used for changing a password on an existing user.
//   change_password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `change_password`.
//   email - string - User's email.
//   grant_permission - string - Permission to grant on the user root.  Can be blank or `full`, `read`, `write`, `preview`, or `history`.
//   group_id - integer - Group ID to associate this user with.
//   group_ids - string - A list of group ids to associate this user with.  Comma delimited.
//   password - string - User password.
//   password_confirmation - string - Optional, but if provided, we will ensure that it matches the value sent in `password`.
//   announcements_read - boolean - Signifies that the user has read all the announcements in the UI.
//   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
//   attachments_permission - boolean - Can the user create Bundles (aka Share Links)?  This field will be aliased or renamed in the future to `bundles_permission`.
//   authenticate_until - string - Scheduled Date/Time at which user will be deactivated
//   authentication_method - string - How is this user authenticated?
//   billing_permission - boolean - Allow this user to perform operations on the account, payments, and invoices?
//   bypass_inactive_disable - boolean - Exempt this user from being disabled based on inactivity?
//   bypass_site_allowed_ips - boolean - Allow this user to skip site-wide IP blacklists?
//   dav_permission - boolean - Can the user connect with WebDAV?
//   disabled - boolean - Is user disabled? Disabled users cannot log in, and do not count for billing purposes.  Users can be automatically disabled after an inactivity period via a Site setting.
//   ftp_permission - boolean - Can the user access with FTP/FTPS?
//   language - string - Preferred language
//   notification_daily_send_time - integer - Hour of the day at which daily notifications should be sent. Can be in range 0 to 23
//   name - string - User's full name
//   notes - string - Any internal notes on the user
//   password_validity_days - integer - Number of days to allow user to use the same password
//   receive_admin_alerts - boolean - Should the user receive admin alerts such a certificate expiration notifications and overages?
//   require_password_change - boolean - Is a password change required upon next user login?
//   restapi_permission - boolean - Can this user access the REST API?
//   self_managed - boolean - Does this user manage it's own credentials or is it a shared/bot user?
//   sftp_permission - boolean - Can the user access with SFTP?
//   site_admin - boolean - Is the user an administrator for this site?
//   skip_welcome_screen - boolean - Skip Welcome page in the UI?
//   ssl_required - string - SSL required setting
//   sso_strategy_id - integer - SSO (Single Sign On) strategy ID for the user, if applicable.
//   subscribe_to_newsletter - boolean - Is the user subscribed to the newsletter?
//   time_zone - string - User time zone
//   user_root - string - Root folder for FTP (and optionally SFTP if the appropriate site-wide setting is set.)  Note that this is not used for API, Desktop, or Web interface.
//   username - string - User's username

const ApiCreateUser = params => Api.post(`/users`, params)
const createUser = createActions('USER_CREATE')

export {
  unlockUser, ApiUnlockUser,
  resend_welcome_emailUser, ApiResendWelcomeEmailUser,
  user_2fa_resetUser, ApiUser2faResetUser,
  updateUser, ApiUpdateUser,
  deleteUser, ApiDeleteUser,

  listUser, ApiListUser,
  findUser, ApiFindUser,
  createUser, ApiCreateUser,
}
