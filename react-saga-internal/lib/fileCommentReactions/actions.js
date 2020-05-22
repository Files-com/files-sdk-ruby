import { createActions } from 'utils/actions'
import Api from 'utils/api'


const ApiDeleteFileCommentReaction = params => Api.delete(`/file_comment_reactions/${params.id}`, params)
const deleteFileCommentReaction = createActions('FILECOMMENTREACTION_DELETE')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   file_comment_id (required) - integer - ID of file comment to attach reaction to.
//   emoji (required) - string - Emoji to react with.

const ApiCreateFileCommentReaction = params => Api.post(`/file_comment_reactions`, params)
const createFileCommentReaction = createActions('FILECOMMENTREACTION_CREATE')

export {
  deleteFileCommentReaction, ApiDeleteFileCommentReaction,

  createFileCommentReaction, ApiCreateFileCommentReaction,
}
