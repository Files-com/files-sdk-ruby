# frozen_string_literal: true

module Files
  class Automation
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Automation ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Workspace ID
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # boolean - Ordinarily, we will allow automation runs to run in parallel for non-scheduled automations. If this flag is `true` we will force automation runs to be serialized (run one at a time, one after another). This can resolve some issues with race conditions on remote systems at the cost of some performance.
    def always_serialize_jobs
      @attributes[:always_serialize_jobs]
    end

    def always_serialize_jobs=(value)
      @attributes[:always_serialize_jobs] = value
    end

    # boolean - Ordinarily, files with identical size in the source and destination will be skipped from copy operations to prevent wasted transfer.  If this flag is `true` we will overwrite the destination file always.  Note that this may cause large amounts of wasted transfer usage.  This setting has no effect unless `overwrite_files` is also set to `true`.
    def always_overwrite_size_matching_files
      @attributes[:always_overwrite_size_matching_files]
    end

    def always_overwrite_size_matching_files=(value)
      @attributes[:always_overwrite_size_matching_files] = value
    end

    # string - Automation type
    def automation
      @attributes[:automation]
    end

    def automation=(value)
      @attributes[:automation] = value
    end

    # boolean - Indicates if the automation has been deleted.
    def deleted
      @attributes[:deleted]
    end

    def deleted=(value)
      @attributes[:deleted] = value
    end

    # string - Description for the this Automation.
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    def destination_replace_from
      @attributes[:destination_replace_from]
    end

    def destination_replace_from=(value)
      @attributes[:destination_replace_from] = value
    end

    # string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    def destination_replace_to
      @attributes[:destination_replace_to]
    end

    def destination_replace_to=(value)
      @attributes[:destination_replace_to] = value
    end

    # array(string) - Destination Paths
    def destinations
      @attributes[:destinations]
    end

    def destinations=(value)
      @attributes[:destinations] = value
    end

    # boolean - If true, this automation will not run.
    def disabled
      @attributes[:disabled]
    end

    def disabled=(value)
      @attributes[:disabled] = value
    end

    # string - If set, this glob pattern will exclude files from the automation. Supports globs, except on remote mounts.
    def exclude_pattern
      @attributes[:exclude_pattern]
    end

    def exclude_pattern=(value)
      @attributes[:exclude_pattern] = value
    end

    # array(object) - List of URLs to be imported and names to be used.
    def import_urls
      @attributes[:import_urls]
    end

    def import_urls=(value)
      @attributes[:import_urls] = value
    end

    # boolean - Normally copy and move automations that use globs will implicitly preserve the source folder structure in the destination.  If this flag is `true`, the source folder structure will be flattened in the destination.  This is useful for copying or moving files from multiple folders into a single destination folder.
    def flatten_destination_structure
      @attributes[:flatten_destination_structure]
    end

    def flatten_destination_structure=(value)
      @attributes[:flatten_destination_structure] = value
    end

    # array(int64) - IDs of Groups for the Automation (i.e. who to Request File from)
    def group_ids
      @attributes[:group_ids]
    end

    def group_ids=(value)
      @attributes[:group_ids] = value
    end

    # boolean - If true, the Lock Folders behavior will be disregarded for automated actions.
    def ignore_locked_folders
      @attributes[:ignore_locked_folders]
    end

    def ignore_locked_folders=(value)
      @attributes[:ignore_locked_folders] = value
    end

    # string - If trigger is `daily`, this specifies how often to run this automation.  One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    def interval
      @attributes[:interval]
    end

    def interval=(value)
      @attributes[:interval] = value
    end

    # date-time - Time when automation was last modified. Does not change for name or description updates.
    def last_modified_at
      @attributes[:last_modified_at]
    end

    def last_modified_at=(value)
      @attributes[:last_modified_at] = value
    end

    # boolean - If `true`, use the legacy behavior for this automation, where it can operate on folders in addition to just files.  This behavior no longer works and should not be used.
    def legacy_folder_matching
      @attributes[:legacy_folder_matching]
    end

    def legacy_folder_matching=(value)
      @attributes[:legacy_folder_matching] = value
    end

    # string - Name for this automation.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # boolean - If true, existing files will be overwritten with new files on Move/Copy automations.  Note: by default files will not be overwritten on Copy automations if they appear to be the same file size as the newly incoming file.  Use the `always_overwrite_size_matching_files` option in conjunction with `overwrite_files` to override this behavior and overwrite files no matter what.
    def overwrite_files
      @attributes[:overwrite_files]
    end

    def overwrite_files=(value)
      @attributes[:overwrite_files] = value
    end

    # string - Path on which this Automation runs.  Supports globs, except on remote mounts. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # string - Timezone to use when rendering timestamps in paths.
    def path_time_zone
      @attributes[:path_time_zone]
    end

    def path_time_zone=(value)
      @attributes[:path_time_zone] = value
    end

    # int64 - If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    def recurring_day
      @attributes[:recurring_day]
    end

    def recurring_day=(value)
      @attributes[:recurring_day] = value
    end

    # int64 - If the Automation fails, retry at this interval (in minutes).  Acceptable values are 5 through 1440 (one day).  Set to null to disable.
    def retry_on_failure_interval_in_minutes
      @attributes[:retry_on_failure_interval_in_minutes]
    end

    def retry_on_failure_interval_in_minutes=(value)
      @attributes[:retry_on_failure_interval_in_minutes] = value
    end

    # int64 - If the Automation fails, retry at most this many times.  Maximum allowed value: 10.  Set to null to disable.
    def retry_on_failure_number_of_attempts
      @attributes[:retry_on_failure_number_of_attempts]
    end

    def retry_on_failure_number_of_attempts=(value)
      @attributes[:retry_on_failure_number_of_attempts] = value
    end

    # object - If trigger is `custom_schedule`, Custom schedule description for when the automation should be run in json format.
    def schedule
      @attributes[:schedule]
    end

    def schedule=(value)
      @attributes[:schedule] = value
    end

    # string - If trigger is `custom_schedule`, Human readable Custom schedule description for when the automation should be run.
    def human_readable_schedule
      @attributes[:human_readable_schedule]
    end

    def human_readable_schedule=(value)
      @attributes[:human_readable_schedule] = value
    end

    # array(int64) - If trigger is `custom_schedule`, Custom schedule description for when the automation should be run. 0-based days of the week. 0 is Sunday, 1 is Monday, etc.
    def schedule_days_of_week
      @attributes[:schedule_days_of_week]
    end

    def schedule_days_of_week=(value)
      @attributes[:schedule_days_of_week] = value
    end

    # array(string) - If trigger is `custom_schedule`, Custom schedule description for when the automation should be run. Times of day in HH:MM format.
    def schedule_times_of_day
      @attributes[:schedule_times_of_day]
    end

    def schedule_times_of_day=(value)
      @attributes[:schedule_times_of_day] = value
    end

    # string - If trigger is `custom_schedule`, Custom schedule Time Zone for when the automation should be run.
    def schedule_time_zone
      @attributes[:schedule_time_zone]
    end

    def schedule_time_zone=(value)
      @attributes[:schedule_time_zone] = value
    end

    # string - Source path/glob.  See Automation docs for exact description, but this is used to filter for files in the `path` to find files to operate on. Supports globs, except on remote mounts.
    def source
      @attributes[:source]
    end

    def source=(value)
      @attributes[:source] = value
    end

    # array(int64) - IDs of remote sync folder behaviors to run by this Automation
    def legacy_sync_ids
      @attributes[:legacy_sync_ids]
    end

    def legacy_sync_ids=(value)
      @attributes[:legacy_sync_ids] = value
    end

    # array(int64) - IDs of syncs to run by this Automation. This is the new way to specify syncs, and it is recommended to use this instead of `legacy_sync_ids`.
    def sync_ids
      @attributes[:sync_ids]
    end

    def sync_ids=(value)
      @attributes[:sync_ids] = value
    end

    # array(string) - If trigger is `action`, this is the list of action types on which to trigger the automation. Valid actions are create, read, update, destroy, move, archived_delete, copy
    def trigger_actions
      @attributes[:trigger_actions]
    end

    def trigger_actions=(value)
      @attributes[:trigger_actions] = value
    end

    # string - How this automation is triggered to run.
    def trigger
      @attributes[:trigger]
    end

    def trigger=(value)
      @attributes[:trigger] = value
    end

    # int64 - User ID of the Automation's creator.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # array(int64) - IDs of Users for the Automation (i.e. who to Request File from)
    def user_ids
      @attributes[:user_ids]
    end

    def user_ids=(value)
      @attributes[:user_ids] = value
    end

    # object - A Hash of attributes specific to the automation type.
    def value
      @attributes[:value]
    end

    def value=(value)
      @attributes[:value] = value
    end

    # string - If trigger is `webhook`, this is the URL of the webhook to trigger the Automation.
    def webhook_url
      @attributes[:webhook_url]
    end

    def webhook_url=(value)
      @attributes[:webhook_url] = value
    end

    # string - If trigger is `custom_schedule`, the Automation will check if there is a formal, observed holiday for the region, and if so, it will not run.
    def holiday_region
      @attributes[:holiday_region]
    end

    def holiday_region=(value)
      @attributes[:holiday_region] = value
    end

    # Manually Run Automation
    def manual_run(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/automations/#{@attributes[:id]}/manual_run", :post, params, @options)
    end

    # Parameters:
    #   source - string - Source path/glob.  See Automation docs for exact description, but this is used to filter for files in the `path` to find files to operate on. Supports globs, except on remote mounts.
    #   destinations - array(string) - A list of String destination paths or Hash of folder_path and optional file_path.
    #   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    #   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    #   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    #   path - string - Path on which this Automation runs.  Supports globs, except on remote mounts.
    #   legacy_sync_ids - string - A list of legacy sync IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   sync_ids - string - A list of sync IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`. A list of days of the week to run this automation. 0 is Sunday, 1 is Monday, etc.
    #   schedule_times_of_day - array(string) - If trigger is `custom_schedule`. A list of times of day to run this automation. 24-hour time format.
    #   schedule_time_zone - string - If trigger is `custom_schedule`. Time zone for the schedule.
    #   holiday_region - string - If trigger is `custom_schedule`, the Automation will check if there is a formal, observed holiday for the region, and if so, it will not run.
    #   always_overwrite_size_matching_files - boolean - Ordinarily, files with identical size in the source and destination will be skipped from copy operations to prevent wasted transfer.  If this flag is `true` we will overwrite the destination file always.  Note that this may cause large amounts of wasted transfer usage.  This setting has no effect unless `overwrite_files` is also set to `true`.
    #   always_serialize_jobs - boolean - Ordinarily, we will allow automation runs to run in parallel for non-scheduled automations. If this flag is `true` we will force automation runs to be serialized (run one at a time, one after another). This can resolve some issues with race conditions on remote systems at the cost of some performance.
    #   description - string - Description for the this Automation.
    #   disabled - boolean - If true, this automation will not run.
    #   exclude_pattern - string - If set, this glob pattern will exclude files from the automation. Supports globs, except on remote mounts.
    #   import_urls - array(object) - List of URLs to be imported and names to be used.
    #   flatten_destination_structure - boolean - Normally copy and move automations that use globs will implicitly preserve the source folder structure in the destination.  If this flag is `true`, the source folder structure will be flattened in the destination.  This is useful for copying or moving files from multiple folders into a single destination folder.
    #   ignore_locked_folders - boolean - If true, the Lock Folders behavior will be disregarded for automated actions.
    #   legacy_folder_matching - boolean - DEPRECATED: If `true`, use the legacy behavior for this automation, where it can operate on folders in addition to just files.  This behavior no longer works and should not be used.
    #   name - string - Name for this automation.
    #   overwrite_files - boolean - If true, existing files will be overwritten with new files on Move/Copy automations.  Note: by default files will not be overwritten on Copy automations if they appear to be the same file size as the newly incoming file.  Use the `always_overwrite_size_matching_files` option in conjunction with `overwrite_files` to override this behavior and overwrite files no matter what.
    #   path_time_zone - string - Timezone to use when rendering timestamps in paths.
    #   retry_on_failure_interval_in_minutes - int64 - If the Automation fails, retry at this interval (in minutes).  Acceptable values are 5 through 1440 (one day).  Set to null to disable.
    #   retry_on_failure_number_of_attempts - int64 - If the Automation fails, retry at most this many times.  Maximum allowed value: 10.  Set to null to disable.
    #   trigger - string - How this automation is triggered to run.
    #   trigger_actions - array(string) - If trigger is `action`, this is the list of action types on which to trigger the automation. Valid actions are create, read, update, destroy, move, archived_delete, copy
    #   value - object - A Hash of attributes specific to the automation type.
    #   recurring_day - int64 - If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    #   workspace_id - int64 - Workspace ID
    #   automation - string - Automation type
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params[:source] and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destinations must be an Array") if params[:destinations] and !params[:destinations].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: destination_replace_from must be an String") if params[:destination_replace_from] and !params[:destination_replace_from].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_to must be an String") if params[:destination_replace_to] and !params[:destination_replace_to].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params[:interval] and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: legacy_sync_ids must be an String") if params[:legacy_sync_ids] and !params[:legacy_sync_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sync_ids must be an String") if params[:sync_ids] and !params[:sync_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params[:user_ids] and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params[:group_ids] and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if params[:holiday_region] and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exclude_pattern must be an String") if params[:exclude_pattern] and !params[:exclude_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: import_urls must be an Array") if params[:import_urls] and !params[:import_urls].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_time_zone must be an String") if params[:path_time_zone] and !params[:path_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: retry_on_failure_interval_in_minutes must be an Integer") if params[:retry_on_failure_interval_in_minutes] and !params[:retry_on_failure_interval_in_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: retry_on_failure_number_of_attempts must be an Integer") if params[:retry_on_failure_number_of_attempts] and !params[:retry_on_failure_number_of_attempts].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_actions must be an Array") if params[:trigger_actions] and !params[:trigger_actions].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if params[:automation] and !params[:automation].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/automations/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/automations/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = Automation.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `name`, `automation`, `last_modified_at` or `disabled`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `disabled`, `last_modified_at`, `workspace_id` or `automation`. Valid field combinations are `[ disabled, last_modified_at ]`, `[ workspace_id, disabled ]`, `[ disabled, automation ]`, `[ workspace_id, last_modified_at ]`, `[ automation, last_modified_at ]`, `[ workspace_id, automation ]`, `[ workspace_id, disabled, last_modified_at ]`, `[ disabled, automation, last_modified_at ]`, `[ workspace_id, disabled, automation ]`, `[ workspace_id, automation, last_modified_at ]` or `[ workspace_id, disabled, automation, last_modified_at ]`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `last_modified_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `last_modified_at`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `last_modified_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `last_modified_at`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)

      List.new(Automation, params) do
        Api.send_request("/automations", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Automation ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/automations/#{params[:id]}", :get, params, options)
      Automation.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   source - string - Source path/glob.  See Automation docs for exact description, but this is used to filter for files in the `path` to find files to operate on. Supports globs, except on remote mounts.
    #   destinations - array(string) - A list of String destination paths or Hash of folder_path and optional file_path.
    #   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    #   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    #   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    #   path - string - Path on which this Automation runs.  Supports globs, except on remote mounts.
    #   legacy_sync_ids - string - A list of legacy sync IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   sync_ids - string - A list of sync IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`. A list of days of the week to run this automation. 0 is Sunday, 1 is Monday, etc.
    #   schedule_times_of_day - array(string) - If trigger is `custom_schedule`. A list of times of day to run this automation. 24-hour time format.
    #   schedule_time_zone - string - If trigger is `custom_schedule`. Time zone for the schedule.
    #   holiday_region - string - If trigger is `custom_schedule`, the Automation will check if there is a formal, observed holiday for the region, and if so, it will not run.
    #   always_overwrite_size_matching_files - boolean - Ordinarily, files with identical size in the source and destination will be skipped from copy operations to prevent wasted transfer.  If this flag is `true` we will overwrite the destination file always.  Note that this may cause large amounts of wasted transfer usage.  This setting has no effect unless `overwrite_files` is also set to `true`.
    #   always_serialize_jobs - boolean - Ordinarily, we will allow automation runs to run in parallel for non-scheduled automations. If this flag is `true` we will force automation runs to be serialized (run one at a time, one after another). This can resolve some issues with race conditions on remote systems at the cost of some performance.
    #   description - string - Description for the this Automation.
    #   disabled - boolean - If true, this automation will not run.
    #   exclude_pattern - string - If set, this glob pattern will exclude files from the automation. Supports globs, except on remote mounts.
    #   import_urls - array(object) - List of URLs to be imported and names to be used.
    #   flatten_destination_structure - boolean - Normally copy and move automations that use globs will implicitly preserve the source folder structure in the destination.  If this flag is `true`, the source folder structure will be flattened in the destination.  This is useful for copying or moving files from multiple folders into a single destination folder.
    #   ignore_locked_folders - boolean - If true, the Lock Folders behavior will be disregarded for automated actions.
    #   legacy_folder_matching - boolean - DEPRECATED: If `true`, use the legacy behavior for this automation, where it can operate on folders in addition to just files.  This behavior no longer works and should not be used.
    #   name - string - Name for this automation.
    #   overwrite_files - boolean - If true, existing files will be overwritten with new files on Move/Copy automations.  Note: by default files will not be overwritten on Copy automations if they appear to be the same file size as the newly incoming file.  Use the `always_overwrite_size_matching_files` option in conjunction with `overwrite_files` to override this behavior and overwrite files no matter what.
    #   path_time_zone - string - Timezone to use when rendering timestamps in paths.
    #   retry_on_failure_interval_in_minutes - int64 - If the Automation fails, retry at this interval (in minutes).  Acceptable values are 5 through 1440 (one day).  Set to null to disable.
    #   retry_on_failure_number_of_attempts - int64 - If the Automation fails, retry at most this many times.  Maximum allowed value: 10.  Set to null to disable.
    #   trigger - string - How this automation is triggered to run.
    #   trigger_actions - array(string) - If trigger is `action`, this is the list of action types on which to trigger the automation. Valid actions are create, read, update, destroy, move, archived_delete, copy
    #   value - object - A Hash of attributes specific to the automation type.
    #   recurring_day - int64 - If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    #   workspace_id - int64 - Workspace ID
    #   automation (required) - string - Automation type
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params[:source] and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destinations must be an Array") if params[:destinations] and !params[:destinations].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: destination_replace_from must be an String") if params[:destination_replace_from] and !params[:destination_replace_from].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_to must be an String") if params[:destination_replace_to] and !params[:destination_replace_to].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params[:interval] and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: legacy_sync_ids must be an String") if params[:legacy_sync_ids] and !params[:legacy_sync_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sync_ids must be an String") if params[:sync_ids] and !params[:sync_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params[:user_ids] and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params[:group_ids] and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if params[:holiday_region] and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exclude_pattern must be an String") if params[:exclude_pattern] and !params[:exclude_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: import_urls must be an Array") if params[:import_urls] and !params[:import_urls].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_time_zone must be an String") if params[:path_time_zone] and !params[:path_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: retry_on_failure_interval_in_minutes must be an Integer") if params[:retry_on_failure_interval_in_minutes] and !params[:retry_on_failure_interval_in_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: retry_on_failure_number_of_attempts must be an Integer") if params[:retry_on_failure_number_of_attempts] and !params[:retry_on_failure_number_of_attempts].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_actions must be an Array") if params[:trigger_actions] and !params[:trigger_actions].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if params[:value] and !params[:value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if params[:automation] and !params[:automation].is_a?(String)
      raise MissingParameterError.new("Parameter missing: automation") unless params[:automation]

      response, options = Api.send_request("/automations", :post, params, options)
      Automation.new(response.data, options)
    end

    # Manually Run Automation
    def self.manual_run(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/automations/#{params[:id]}/manual_run", :post, params, options)
      nil
    end

    # Parameters:
    #   source - string - Source path/glob.  See Automation docs for exact description, but this is used to filter for files in the `path` to find files to operate on. Supports globs, except on remote mounts.
    #   destinations - array(string) - A list of String destination paths or Hash of folder_path and optional file_path.
    #   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    #   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    #   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    #   path - string - Path on which this Automation runs.  Supports globs, except on remote mounts.
    #   legacy_sync_ids - string - A list of legacy sync IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   sync_ids - string - A list of sync IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`. A list of days of the week to run this automation. 0 is Sunday, 1 is Monday, etc.
    #   schedule_times_of_day - array(string) - If trigger is `custom_schedule`. A list of times of day to run this automation. 24-hour time format.
    #   schedule_time_zone - string - If trigger is `custom_schedule`. Time zone for the schedule.
    #   holiday_region - string - If trigger is `custom_schedule`, the Automation will check if there is a formal, observed holiday for the region, and if so, it will not run.
    #   always_overwrite_size_matching_files - boolean - Ordinarily, files with identical size in the source and destination will be skipped from copy operations to prevent wasted transfer.  If this flag is `true` we will overwrite the destination file always.  Note that this may cause large amounts of wasted transfer usage.  This setting has no effect unless `overwrite_files` is also set to `true`.
    #   always_serialize_jobs - boolean - Ordinarily, we will allow automation runs to run in parallel for non-scheduled automations. If this flag is `true` we will force automation runs to be serialized (run one at a time, one after another). This can resolve some issues with race conditions on remote systems at the cost of some performance.
    #   description - string - Description for the this Automation.
    #   disabled - boolean - If true, this automation will not run.
    #   exclude_pattern - string - If set, this glob pattern will exclude files from the automation. Supports globs, except on remote mounts.
    #   import_urls - array(object) - List of URLs to be imported and names to be used.
    #   flatten_destination_structure - boolean - Normally copy and move automations that use globs will implicitly preserve the source folder structure in the destination.  If this flag is `true`, the source folder structure will be flattened in the destination.  This is useful for copying or moving files from multiple folders into a single destination folder.
    #   ignore_locked_folders - boolean - If true, the Lock Folders behavior will be disregarded for automated actions.
    #   legacy_folder_matching - boolean - DEPRECATED: If `true`, use the legacy behavior for this automation, where it can operate on folders in addition to just files.  This behavior no longer works and should not be used.
    #   name - string - Name for this automation.
    #   overwrite_files - boolean - If true, existing files will be overwritten with new files on Move/Copy automations.  Note: by default files will not be overwritten on Copy automations if they appear to be the same file size as the newly incoming file.  Use the `always_overwrite_size_matching_files` option in conjunction with `overwrite_files` to override this behavior and overwrite files no matter what.
    #   path_time_zone - string - Timezone to use when rendering timestamps in paths.
    #   retry_on_failure_interval_in_minutes - int64 - If the Automation fails, retry at this interval (in minutes).  Acceptable values are 5 through 1440 (one day).  Set to null to disable.
    #   retry_on_failure_number_of_attempts - int64 - If the Automation fails, retry at most this many times.  Maximum allowed value: 10.  Set to null to disable.
    #   trigger - string - How this automation is triggered to run.
    #   trigger_actions - array(string) - If trigger is `action`, this is the list of action types on which to trigger the automation. Valid actions are create, read, update, destroy, move, archived_delete, copy
    #   value - object - A Hash of attributes specific to the automation type.
    #   recurring_day - int64 - If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    #   workspace_id - int64 - Workspace ID
    #   automation - string - Automation type
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params[:source] and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destinations must be an Array") if params[:destinations] and !params[:destinations].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: destination_replace_from must be an String") if params[:destination_replace_from] and !params[:destination_replace_from].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_to must be an String") if params[:destination_replace_to] and !params[:destination_replace_to].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params[:interval] and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: legacy_sync_ids must be an String") if params[:legacy_sync_ids] and !params[:legacy_sync_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sync_ids must be an String") if params[:sync_ids] and !params[:sync_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params[:user_ids] and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params[:group_ids] and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if params[:holiday_region] and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exclude_pattern must be an String") if params[:exclude_pattern] and !params[:exclude_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: import_urls must be an Array") if params[:import_urls] and !params[:import_urls].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_time_zone must be an String") if params[:path_time_zone] and !params[:path_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: retry_on_failure_interval_in_minutes must be an Integer") if params[:retry_on_failure_interval_in_minutes] and !params[:retry_on_failure_interval_in_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: retry_on_failure_number_of_attempts must be an Integer") if params[:retry_on_failure_number_of_attempts] and !params[:retry_on_failure_number_of_attempts].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_actions must be an Array") if params[:trigger_actions] and !params[:trigger_actions].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if params[:value] and !params[:value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if params[:automation] and !params[:automation].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/automations/#{params[:id]}", :patch, params, options)
      Automation.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/automations/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
