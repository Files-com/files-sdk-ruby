# frozen_string_literal: true

module Files
  class AiTask
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - AI Task ID.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Workspace ID. `0` means the default workspace.
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # string - AI Task name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - AI Task description.
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # string - Prompt sent when this AI Task is invoked.
    def prompt
      @attributes[:prompt]
    end

    def prompt=(value)
      @attributes[:prompt] = value
    end

    # string - Permissions used by the internal API key for this AI Task. Valid values are `full` and `files_only`.
    def permission_set
      @attributes[:permission_set]
    end

    def permission_set=(value)
      @attributes[:permission_set] = value
    end

    # string - Path scope used for action-triggered AI Tasks. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # string - Source glob used with `path` for action-triggered AI Tasks.
    def source
      @attributes[:source]
    end

    def source=(value)
      @attributes[:source] = value
    end

    # boolean - If true, this AI Task will not run.
    def disabled
      @attributes[:disabled]
    end

    def disabled=(value)
      @attributes[:disabled] = value
    end

    # string - How this AI Task is triggered.
    def trigger
      @attributes[:trigger]
    end

    def trigger=(value)
      @attributes[:trigger] = value
    end

    # array(string) - If trigger is `action`, the file action types that invoke this AI Task. Valid actions are create, copy, move, archived_delete, update, read, destroy.
    def trigger_actions
      @attributes[:trigger_actions]
    end

    def trigger_actions=(value)
      @attributes[:trigger_actions] = value
    end

    # string - If trigger is `daily`, this specifies how often to run the AI Task.
    def interval
      @attributes[:interval]
    end

    def interval=(value)
      @attributes[:interval] = value
    end

    # int64 - If trigger is `daily`, this selects the day number inside the chosen interval.
    def recurring_day
      @attributes[:recurring_day]
    end

    def recurring_day=(value)
      @attributes[:recurring_day] = value
    end

    # array(int64) - If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    def schedule_days_of_week
      @attributes[:schedule_days_of_week]
    end

    def schedule_days_of_week=(value)
      @attributes[:schedule_days_of_week] = value
    end

    # array(string) - Times of day in HH:MM format for scheduled AI Tasks.
    def schedule_times_of_day
      @attributes[:schedule_times_of_day]
    end

    def schedule_times_of_day=(value)
      @attributes[:schedule_times_of_day] = value
    end

    # string - Time zone used by the AI Task schedule.
    def schedule_time_zone
      @attributes[:schedule_time_zone]
    end

    def schedule_time_zone=(value)
      @attributes[:schedule_time_zone] = value
    end

    # string - Optional holiday region used by scheduled AI Tasks.
    def holiday_region
      @attributes[:holiday_region]
    end

    def holiday_region=(value)
      @attributes[:holiday_region] = value
    end

    # string - Human-readable schedule description.
    def human_readable_schedule
      @attributes[:human_readable_schedule]
    end

    def human_readable_schedule=(value)
      @attributes[:human_readable_schedule] = value
    end

    # date-time - Most recent successful invocation time.
    def last_run_at
      @attributes[:last_run_at]
    end

    def last_run_at=(value)
      @attributes[:last_run_at] = value
    end

    # int64 - Master User ID used for AI Task invocations.
    def master_admin_user_id
      @attributes[:master_admin_user_id]
    end

    def master_admin_user_id=(value)
      @attributes[:master_admin_user_id] = value
    end

    # date-time - Creation time.
    def created_at
      @attributes[:created_at]
    end

    # date-time - Last update time.
    def updated_at
      @attributes[:updated_at]
    end

    # Manually Run AI Task
    def manual_run(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/ai_tasks/#{@attributes[:id]}/manual_run", :post, params, @options)
    end

    # Parameters:
    #   description - string - AI Task description.
    #   disabled - boolean - If true, this AI Task will not run.
    #   holiday_region - string - Optional holiday region used by scheduled AI Tasks.
    #   interval - string - If trigger is `daily`, this specifies how often to run the AI Task.
    #   name - string - AI Task name.
    #   path - string - Path scope used for action-triggered AI Tasks.
    #   permission_set - string - Permissions used by the internal API key for this AI Task. Valid values are `full` and `files_only`.
    #   prompt - string - Prompt sent when this AI Task is invoked.
    #   recurring_day - int64 - If trigger is `daily`, this selects the day number inside the chosen interval.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    #   schedule_time_zone - string - Time zone used by the AI Task schedule.
    #   schedule_times_of_day - array(string) - Times of day in HH:MM format for scheduled AI Tasks.
    #   source - string - Source glob used with `path` for action-triggered AI Tasks.
    #   trigger - string - How this AI Task is triggered.
    #   trigger_actions - array(string) - If trigger is `action`, the file action types that invoke this AI Task. Valid actions are create, copy, move, archived_delete, update, read, destroy.
    #   workspace_id - int64 - Workspace ID. `0` means the default workspace.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if params[:holiday_region] and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params[:interval] and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if params[:permission_set] and !params[:permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: prompt must be an String") if params[:prompt] and !params[:prompt].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params[:source] and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_actions must be an Array") if params[:trigger_actions] and !params[:trigger_actions].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/ai_tasks/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/ai_tasks/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = AiTask.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `id`, `disabled` or `updated_at`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `disabled`, `trigger` or `workspace_id`. Valid field combinations are `[ workspace_id, disabled ]`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(AiTask, params) do
        Api.send_request("/ai_tasks", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Ai Task ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/ai_tasks/#{params[:id]}", :get, params, options)
      AiTask.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   description - string - AI Task description.
    #   disabled - boolean - If true, this AI Task will not run.
    #   holiday_region - string - Optional holiday region used by scheduled AI Tasks.
    #   interval - string - If trigger is `daily`, this specifies how often to run the AI Task.
    #   name (required) - string - AI Task name.
    #   path - string - Path scope used for action-triggered AI Tasks.
    #   permission_set - string - Permissions used by the internal API key for this AI Task. Valid values are `full` and `files_only`.
    #   prompt (required) - string - Prompt sent when this AI Task is invoked.
    #   recurring_day - int64 - If trigger is `daily`, this selects the day number inside the chosen interval.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    #   schedule_time_zone - string - Time zone used by the AI Task schedule.
    #   schedule_times_of_day - array(string) - Times of day in HH:MM format for scheduled AI Tasks.
    #   source - string - Source glob used with `path` for action-triggered AI Tasks.
    #   trigger - string - How this AI Task is triggered.
    #   trigger_actions - array(string) - If trigger is `action`, the file action types that invoke this AI Task. Valid actions are create, copy, move, archived_delete, update, read, destroy.
    #   workspace_id - int64 - Workspace ID. `0` means the default workspace.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if params[:holiday_region] and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params[:interval] and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if params[:permission_set] and !params[:permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: prompt must be an String") if params[:prompt] and !params[:prompt].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params[:source] and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_actions must be an Array") if params[:trigger_actions] and !params[:trigger_actions].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]
      raise MissingParameterError.new("Parameter missing: prompt") unless params[:prompt]

      response, options = Api.send_request("/ai_tasks", :post, params, options)
      AiTask.new(response.data, options)
    end

    # Manually Run AI Task
    def self.manual_run(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/ai_tasks/#{params[:id]}/manual_run", :post, params, options)
      nil
    end

    # Parameters:
    #   description - string - AI Task description.
    #   disabled - boolean - If true, this AI Task will not run.
    #   holiday_region - string - Optional holiday region used by scheduled AI Tasks.
    #   interval - string - If trigger is `daily`, this specifies how often to run the AI Task.
    #   name - string - AI Task name.
    #   path - string - Path scope used for action-triggered AI Tasks.
    #   permission_set - string - Permissions used by the internal API key for this AI Task. Valid values are `full` and `files_only`.
    #   prompt - string - Prompt sent when this AI Task is invoked.
    #   recurring_day - int64 - If trigger is `daily`, this selects the day number inside the chosen interval.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    #   schedule_time_zone - string - Time zone used by the AI Task schedule.
    #   schedule_times_of_day - array(string) - Times of day in HH:MM format for scheduled AI Tasks.
    #   source - string - Source glob used with `path` for action-triggered AI Tasks.
    #   trigger - string - How this AI Task is triggered.
    #   trigger_actions - array(string) - If trigger is `action`, the file action types that invoke this AI Task. Valid actions are create, copy, move, archived_delete, update, read, destroy.
    #   workspace_id - int64 - Workspace ID. `0` means the default workspace.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if params[:holiday_region] and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params[:interval] and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if params[:permission_set] and !params[:permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: prompt must be an String") if params[:prompt] and !params[:prompt].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params[:source] and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_actions must be an Array") if params[:trigger_actions] and !params[:trigger_actions].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/ai_tasks/#{params[:id]}", :patch, params, options)
      AiTask.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/ai_tasks/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
