import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   file (required) - file - Logo for custom branding.

const ApiUpdateStyle = params => Api.patch(`/styles/" . rawurlencode($params['path']) . "`, params)
const updateStyle = createActions('STYLE_UPDATE')

const ApiDeleteStyle = params => Api.delete(`/styles/" . rawurlencode($params['path']) . "`, params)
const deleteStyle = createActions('STYLE_DELETE')

// Parameters:
//   path (required) - string - Style path.

const ApiListStyle = params => Api.get(`/styles/" . rawurlencode($params['path']) . "`, params)
const listStyle = createActions('STYLE_LIST')

export {
  updateStyle, ApiUpdateStyle,
  deleteStyle, ApiDeleteStyle,

  listStyle, ApiListStyle,
}
