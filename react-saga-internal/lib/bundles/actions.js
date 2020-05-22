import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Send email(s) with a link to bundle
//
// Parameters:
//   to (required) - array - A list of email addresses to share this bundle with.
//   note - string - Note to include in email.

const ApiShareBundle = params => Api.post(`/bundles/${params.id}/share`, params)
const shareBundle = createActions('BUNDLE_SHARE')

const ApiDeleteBundle = params => Api.delete(`/bundles/${params.id}`, params)
const deleteBundle = createActions('BUNDLE_DELETE')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.

const ApiListBundle = params => Api.get(`/bundles`, params)
const listBundle = createActions('BUNDLE_LIST')

// Parameters:
//   id (required) - integer - Bundle ID.

const ApiFindBundle = params => Api.get(`/bundles/${params.id}`, params)
const findBundle = createActions('BUNDLE_FIND')

// Parameters:
//   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
//   paths (required) - array - A list of paths to include in this bundle.
//   password - string - Password for this bundle.
//   expires_at - string - Bundle expiration date/time.
//   description - string - Bundle public description
//   note - string - Bundle internal note
//   code - string - Bundle name

const ApiCreateBundle = params => Api.post(`/bundles`, params)
const createBundle = createActions('BUNDLE_CREATE')

export {
  shareBundle, ApiShareBundle,
  deleteBundle, ApiDeleteBundle,

  listBundle, ApiListBundle,
  findBundle, ApiFindBundle,
  createBundle, ApiCreateBundle,
}
