import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   value - string - The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior.
//   attachment_file - file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image

const ApiUpdateBehavior = params => Api.patch(`/behaviors/${params.id}`, params)
const updateBehavior = createActions('BEHAVIOR_UPDATE')

const ApiDeleteBehavior = params => Api.delete(`/behaviors/${params.id}`, params)
const deleteBehavior = createActions('BEHAVIOR_DELETE')

// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   behavior - string - If set, only shows folder behaviors matching this behavior type.

const ApiListBehavior = params => Api.get(`/behaviors`, params)
const listBehavior = createActions('BEHAVIOR_LIST')

// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   path (required) - string - Path to operate on.
//   recursive - string - Show behaviors below this path?
//   behavior - string - If set only shows folder behaviors matching this behavior type.

const ApiListForBehavior = params => Api.get(`/behaviors/folders/" . rawurlencode($params['path']) . "`, params)
const list_forBehavior = createActions('BEHAVIOR_LIST_FOR')

// Parameters:
//   id (required) - integer - Behavior ID.

const ApiFindBehavior = params => Api.get(`/behaviors/${params.id}`, params)
const findBehavior = createActions('BEHAVIOR_FIND')

// Parameters:
//   value - string - The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior.
//   attachment_file - file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
//   path (required) - string - Folder behaviors path.
//   behavior (required) - string - Behavior type.

const ApiCreateBehavior = params => Api.post(`/behaviors`, params)
const createBehavior = createActions('BEHAVIOR_CREATE')

// Parameters:
//   url (required) - string - URL for testing the webhook.
//   method - string - HTTP method(GET or POST).
//   encoding - string - HTTP encoding method.  Can be JSON, XML, or RAW (form data).

const ApiWebhookTestBehavior = params => Api.post(`/behaviors/webhook/test`, params)
const webhook_testBehavior = createActions('BEHAVIOR_WEBHOOK_TEST')

export {
  updateBehavior, ApiUpdateBehavior,
  deleteBehavior, ApiDeleteBehavior,

  listBehavior, ApiListBehavior,
  list_forBehavior, ApiListForBehavior,
  findBehavior, ApiFindBehavior,
  createBehavior, ApiCreateBehavior,
  webhook_testBehavior, ApiWebhookTestBehavior,
}
