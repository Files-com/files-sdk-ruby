import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   body (required) - string - Comment body.

const ApiUpdateMessageComment = params => Api.patch(`/message_comments/${params.id}`, params)
const updateMessageComment = createActions('MESSAGECOMMENT_UPDATE')

const ApiDeleteMessageComment = params => Api.delete(`/message_comments/${params.id}`, params)
const deleteMessageComment = createActions('MESSAGECOMMENT_DELETE')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   message_id (required) - integer - Message comment to return comments for.

const ApiListMessageComment = params => Api.get(`/message_comments`, params)
const listMessageComment = createActions('MESSAGECOMMENT_LIST')

// Parameters:
//   id (required) - integer - Message Comment ID.

const ApiFindMessageComment = params => Api.get(`/message_comments/${params.id}`, params)
const findMessageComment = createActions('MESSAGECOMMENT_FIND')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   body (required) - string - Comment body.

const ApiCreateMessageComment = params => Api.post(`/message_comments`, params)
const createMessageComment = createActions('MESSAGECOMMENT_CREATE')

export {
  updateMessageComment, ApiUpdateMessageComment,
  deleteMessageComment, ApiDeleteMessageComment,

  listMessageComment, ApiListMessageComment,
  findMessageComment, ApiFindMessageComment,
  createMessageComment, ApiCreateMessageComment,
}
