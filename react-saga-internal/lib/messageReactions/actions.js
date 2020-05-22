import { createActions } from 'utils/actions'
import Api from 'utils/api'


const ApiDeleteMessageReaction = params => Api.delete(`/message_reactions/${params.id}`, params)
const deleteMessageReaction = createActions('MESSAGEREACTION_DELETE')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   message_id (required) - integer - Message to return reactions for.

const ApiListMessageReaction = params => Api.get(`/message_reactions`, params)
const listMessageReaction = createActions('MESSAGEREACTION_LIST')

// Parameters:
//   id (required) - integer - Message Reaction ID.

const ApiFindMessageReaction = params => Api.get(`/message_reactions/${params.id}`, params)
const findMessageReaction = createActions('MESSAGEREACTION_FIND')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   emoji (required) - string - Emoji to react with.

const ApiCreateMessageReaction = params => Api.post(`/message_reactions`, params)
const createMessageReaction = createActions('MESSAGEREACTION_CREATE')

export {
  deleteMessageReaction, ApiDeleteMessageReaction,

  listMessageReaction, ApiListMessageReaction,
  findMessageReaction, ApiFindMessageReaction,
  createMessageReaction, ApiCreateMessageReaction,
}
