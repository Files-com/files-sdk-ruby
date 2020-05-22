import { createActions } from 'utils/actions'
import Api from 'utils/api'


// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Action to take.  Can be `count`, `count_nrs` (non recursive), `size`, `permissions`, or blank.
//   path (required) - string - Path to operate on.
//   cursor - string - Send cursor to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor header.
//   filter - string - If specified, will to filter folders/files list by this string.  Wildcards of `*` and `?` are acceptable here.
//   preview_size - string - Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
//   search - string - If `search_all` is `true`, provide the search string here.  Otherwise, this parameter acts like an alias of `filter`.
//   search_all - boolean - Search entire site?
//   with_priority_color - boolean - Include file priority color information?

const ApiListForFolder = params => Api.get(`/folders/" . rawurlencode($params['path']) . "`, params)
const list_forFolder = createActions('FOLDER_LIST_FOR')

// Parameters:
//   path (required) - string - Path to operate on.

const ApiCreateFolder = params => Api.post(`/folders/" . rawurlencode($params['path']) . "`, params)
const createFolder = createActions('FOLDER_CREATE')

export {

  list_forFolder, ApiListForFolder,
  createFolder, ApiCreateFolder,
}
