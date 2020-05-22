import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   notify_on_copy - boolean - If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
//   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
//   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.

const ApiUpdateNotification = params => Api.patch(`/notifications/${params.id}`, params)
const updateNotification = createActions('NOTIFICATION_UPDATE')

const ApiDeleteNotification = params => Api.delete(`/notifications/${params.id}`, params)
const deleteNotification = createActions('NOTIFICATION_DELETE')

// Parameters:
//   user_id - integer - Show notifications for this User ID.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   group_id - integer - Show notifications for this Group ID.

const ApiListNotification = params => Api.get(`/notifications`, params)
const listNotification = createActions('NOTIFICATION_LIST')

// Parameters:
//   id (required) - integer - Notification ID.

const ApiFindNotification = params => Api.get(`/notifications/${params.id}`, params)
const findNotification = createActions('NOTIFICATION_FIND')

// Parameters:
//   user_id - integer - The id of the user to notify. Provide `user_id`, `username` or `group_id`.
//   notify_on_copy - boolean - If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
//   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
//   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
//   group_id - integer - The ID of the group to notify.  Provide `user_id`, `username` or `group_id`.
//   path - string - Path
//   username - string - The username of the user to notify.  Provide `user_id`, `username` or `group_id`.

const ApiCreateNotification = params => Api.post(`/notifications`, params)
const createNotification = createActions('NOTIFICATION_CREATE')

export {
  updateNotification, ApiUpdateNotification,
  deleteNotification, ApiDeleteNotification,

  listNotification, ApiListNotification,
  findNotification, ApiFindNotification,
  createNotification, ApiCreateNotification,
}
