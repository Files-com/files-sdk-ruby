import { createActions } from 'utils/actions'
import Api from 'utils/api'

// Parameters:
//   automation (required) - string - Type of automation.  One of: `create_folder`, `request_file`, `request_move`
//   source - string - Source Path
//   destination - string - Destination Path
//   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
//   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
//   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
//   path - string - Path on which this Automation runs.  Supports globs.
//   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
//   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.

const ApiUpdateAutomation = params => Api.patch(`/automations/${params.id}`, params)
const updateAutomation = createActions('AUTOMATION_UPDATE')

const ApiDeleteAutomation = params => Api.delete(`/automations/${params.id}`, params)
const deleteAutomation = createActions('AUTOMATION_DELETE')

// Parameters:
//   page - integer - Current page number.
//   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
//   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
//   automation - string - Type of automation to filter by.

const ApiListAutomation = params => Api.get(`/automations`, params)
const listAutomation = createActions('AUTOMATION_LIST')

// Parameters:
//   id (required) - integer - Automation ID.

const ApiFindAutomation = params => Api.get(`/automations/${params.id}`, params)
const findAutomation = createActions('AUTOMATION_FIND')

// Parameters:
//   automation (required) - string - Type of automation.  One of: `create_folder`, `request_file`, `request_move`
//   source - string - Source Path
//   destination - string - Destination Path
//   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
//   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
//   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
//   path - string - Path on which this Automation runs.  Supports globs.
//   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
//   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.

const ApiCreateAutomation = params => Api.post(`/automations`, params)
const createAutomation = createActions('AUTOMATION_CREATE')

export {
  updateAutomation, ApiUpdateAutomation,
  deleteAutomation, ApiDeleteAutomation,

  listAutomation, ApiListAutomation,
  findAutomation, ApiFindAutomation,
  createAutomation, ApiCreateAutomation,
}
