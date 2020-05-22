import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   project_id (required) - integer - Project to attach the message to.
//   subject (required) - string - Message subject.
//   body (required) - string - Message body.

const ApiUpdateMessage = params => Api.patch(`/messages/${params.id}`, params)
const updateMessage = createActions('MESSAGE_UPDATE')

const ApiDeleteMessage = params => Api.delete(`/messages/${params.id}`, params)
const deleteMessage = createActions('MESSAGE_DELETE')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   project_id (required) - integer - Project to return messages for.

const ApiListMessage = params => Api.get(`/messages`, params)
const listMessage = createActions('MESSAGE_LIST')

// Parameters:
//   id (required) - integer - Message ID.

const ApiFindMessage = params => Api.get(`/messages/${params.id}`, params)
const findMessage = createActions('MESSAGE_FIND')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   project_id (required) - integer - Project to attach the message to.
//   subject (required) - string - Message subject.
//   body (required) - string - Message body.

const ApiCreateMessage = params => Api.post(`/messages`, params)
const createMessage = createActions('MESSAGE_CREATE')

export {
  updateMessage, ApiUpdateMessage,
  deleteMessage, ApiDeleteMessage,

  listMessage, ApiListMessage,
  findMessage, ApiFindMessage,
  createMessage, ApiCreateMessage,
}
