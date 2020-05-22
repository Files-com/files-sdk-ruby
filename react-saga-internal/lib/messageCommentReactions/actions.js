import { createActions } from 'utils/actions'
import Api from 'utils/api'


const ApiDeleteMessageCommentReaction = params => Api.delete(`/message_comment_reactions/${params.id}`, params)
const deleteMessageCommentReaction = createActions('MESSAGECOMMENTREACTION_DELETE')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   message_comment_id (required) - integer - Message comment to return reactions for.

const ApiListMessageCommentReaction = params => Api.get(`/message_comment_reactions`, params)
const listMessageCommentReaction = createActions('MESSAGECOMMENTREACTION_LIST')

// Parameters:
//   id (required) - integer - Message Comment Reaction ID.

const ApiFindMessageCommentReaction = params => Api.get(`/message_comment_reactions/${params.id}`, params)
const findMessageCommentReaction = createActions('MESSAGECOMMENTREACTION_FIND')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   emoji (required) - string - Emoji to react with.

const ApiCreateMessageCommentReaction = params => Api.post(`/message_comment_reactions`, params)
const createMessageCommentReaction = createActions('MESSAGECOMMENTREACTION_CREATE')

export {
  deleteMessageCommentReaction, ApiDeleteMessageCommentReaction,

  listMessageCommentReaction, ApiListMessageCommentReaction,
  findMessageCommentReaction, ApiFindMessageCommentReaction,
  createMessageCommentReaction, ApiCreateMessageCommentReaction,
}
