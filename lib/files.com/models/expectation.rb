# frozen_string_literal: true

module Files
  class Expectation
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Expectation ID
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

    # string - Expectation name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Expectation description.
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # string - Path scope for the expectation. Supports workspace-relative presentation. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # string - Source glob used to select candidate files.
    def source
      @attributes[:source]
    end

    def source=(value)
      @attributes[:source] = value
    end

    # string - Optional source exclusion glob.
    def exclude_pattern
      @attributes[:exclude_pattern]
    end

    def exclude_pattern=(value)
      @attributes[:exclude_pattern] = value
    end

    # boolean - If true, the expectation is disabled.
    def disabled
      @attributes[:disabled]
    end

    def disabled=(value)
      @attributes[:disabled] = value
    end

    # int64 - Criteria schema version for this expectation.
    def expectations_version
      @attributes[:expectations_version]
    end

    def expectations_version=(value)
      @attributes[:expectations_version] = value
    end

    # string - How this expectation opens windows.
    def trigger
      @attributes[:trigger]
    end

    def trigger=(value)
      @attributes[:trigger] = value
    end

    # string - If trigger is `daily`, this specifies how often to run the expectation.
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

    # array(string) - Times of day in HH:MM format for schedule-driven expectations.
    def schedule_times_of_day
      @attributes[:schedule_times_of_day]
    end

    def schedule_times_of_day=(value)
      @attributes[:schedule_times_of_day] = value
    end

    # string - Time zone used by the expectation schedule.
    def schedule_time_zone
      @attributes[:schedule_time_zone]
    end

    def schedule_time_zone=(value)
      @attributes[:schedule_time_zone] = value
    end

    # string - Optional holiday region used by schedule-driven expectations.
    def holiday_region
      @attributes[:holiday_region]
    end

    def holiday_region=(value)
      @attributes[:holiday_region] = value
    end

    # int64 - How many seconds before the due boundary the window starts.
    def lookback_interval
      @attributes[:lookback_interval]
    end

    def lookback_interval=(value)
      @attributes[:lookback_interval] = value
    end

    # int64 - How many seconds a schedule-driven window may remain eligible to close as late.
    def late_acceptance_interval
      @attributes[:late_acceptance_interval]
    end

    def late_acceptance_interval=(value)
      @attributes[:late_acceptance_interval] = value
    end

    # int64 - How many quiet seconds are required before final closure.
    def inactivity_interval
      @attributes[:inactivity_interval]
    end

    def inactivity_interval=(value)
      @attributes[:inactivity_interval] = value
    end

    # int64 - Hard-stop duration in seconds for unscheduled expectations.
    def max_open_interval
      @attributes[:max_open_interval]
    end

    def max_open_interval=(value)
      @attributes[:max_open_interval] = value
    end

    # object - Structured criteria v1 definition for the expectation.
    def criteria
      @attributes[:criteria]
    end

    def criteria=(value)
      @attributes[:criteria] = value
    end

    # date-time - Last time this expectation was evaluated.
    def last_evaluated_at
      @attributes[:last_evaluated_at]
    end

    def last_evaluated_at=(value)
      @attributes[:last_evaluated_at] = value
    end

    # date-time - Last time this expectation closed successfully.
    def last_success_at
      @attributes[:last_success_at]
    end

    def last_success_at=(value)
      @attributes[:last_success_at] = value
    end

    # date-time - Last time this expectation closed with a failure result.
    def last_failure_at
      @attributes[:last_failure_at]
    end

    def last_failure_at=(value)
      @attributes[:last_failure_at] = value
    end

    # string - Most recent terminal result for this expectation.
    def last_result
      @attributes[:last_result]
    end

    def last_result=(value)
      @attributes[:last_result] = value
    end

    # date-time - Creation time.
    def created_at
      @attributes[:created_at]
    end

    # date-time - Last update time.
    def updated_at
      @attributes[:updated_at]
    end

    # Manually open an Expectation window
    def trigger_evaluation(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/expectations/#{@attributes[:id]}/trigger_evaluation", :post, params, @options)
    end

    # Parameters:
    #   name - string - Expectation name.
    #   description - string - Expectation description.
    #   path - string - Path scope for the expectation. Supports workspace-relative presentation.
    #   source - string - Source glob used to select candidate files.
    #   exclude_pattern - string - Optional source exclusion glob.
    #   disabled - boolean - If true, the expectation is disabled.
    #   trigger - string - How this expectation opens windows.
    #   interval - string - If trigger is `daily`, this specifies how often to run the expectation.
    #   recurring_day - int64 - If trigger is `daily`, this selects the day number inside the chosen interval.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    #   schedule_times_of_day - array(string) - Times of day in HH:MM format for schedule-driven expectations.
    #   schedule_time_zone - string - Time zone used by the expectation schedule.
    #   holiday_region - string - Optional holiday region used by schedule-driven expectations.
    #   lookback_interval - int64 - How many seconds before the due boundary the window starts.
    #   late_acceptance_interval - int64 - How many seconds a schedule-driven window may remain eligible to close as late.
    #   inactivity_interval - int64 - How many quiet seconds are required before final closure.
    #   max_open_interval - int64 - Hard-stop duration in seconds for unscheduled expectations.
    #   criteria - object - Structured criteria v1 definition for the expectation.
    #   workspace_id - int64 - Workspace ID. `0` means the default workspace.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params[:source] and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exclude_pattern must be an String") if params[:exclude_pattern] and !params[:exclude_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params[:interval] and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if params[:holiday_region] and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: lookback_interval must be an Integer") if params[:lookback_interval] and !params[:lookback_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: late_acceptance_interval must be an Integer") if params[:late_acceptance_interval] and !params[:late_acceptance_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: inactivity_interval must be an Integer") if params[:inactivity_interval] and !params[:inactivity_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_open_interval must be an Integer") if params[:max_open_interval] and !params[:max_open_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/expectations/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/expectations/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = Expectation.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `name` or `disabled`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `disabled` and `workspace_id`. Valid field combinations are `[ workspace_id, disabled ]`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(Expectation, params) do
        Api.send_request("/expectations", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Expectation ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/expectations/#{params[:id]}", :get, params, options)
      Expectation.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name - string - Expectation name.
    #   description - string - Expectation description.
    #   path - string - Path scope for the expectation. Supports workspace-relative presentation.
    #   source - string - Source glob used to select candidate files.
    #   exclude_pattern - string - Optional source exclusion glob.
    #   disabled - boolean - If true, the expectation is disabled.
    #   trigger - string - How this expectation opens windows.
    #   interval - string - If trigger is `daily`, this specifies how often to run the expectation.
    #   recurring_day - int64 - If trigger is `daily`, this selects the day number inside the chosen interval.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    #   schedule_times_of_day - array(string) - Times of day in HH:MM format for schedule-driven expectations.
    #   schedule_time_zone - string - Time zone used by the expectation schedule.
    #   holiday_region - string - Optional holiday region used by schedule-driven expectations.
    #   lookback_interval - int64 - How many seconds before the due boundary the window starts.
    #   late_acceptance_interval - int64 - How many seconds a schedule-driven window may remain eligible to close as late.
    #   inactivity_interval - int64 - How many quiet seconds are required before final closure.
    #   max_open_interval - int64 - Hard-stop duration in seconds for unscheduled expectations.
    #   criteria - object - Structured criteria v1 definition for the expectation.
    #   workspace_id - int64 - Workspace ID. `0` means the default workspace.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params[:source] and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exclude_pattern must be an String") if params[:exclude_pattern] and !params[:exclude_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params[:interval] and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if params[:holiday_region] and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: lookback_interval must be an Integer") if params[:lookback_interval] and !params[:lookback_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: late_acceptance_interval must be an Integer") if params[:late_acceptance_interval] and !params[:late_acceptance_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: inactivity_interval must be an Integer") if params[:inactivity_interval] and !params[:inactivity_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_open_interval must be an Integer") if params[:max_open_interval] and !params[:max_open_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: criteria must be an Hash") if params[:criteria] and !params[:criteria].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)

      response, options = Api.send_request("/expectations", :post, params, options)
      Expectation.new(response.data, options)
    end

    # Manually open an Expectation window
    def self.trigger_evaluation(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/expectations/#{params[:id]}/trigger_evaluation", :post, params, options)
      ExpectationEvaluation.new(response.data, options)
    end

    # Parameters:
    #   name - string - Expectation name.
    #   description - string - Expectation description.
    #   path - string - Path scope for the expectation. Supports workspace-relative presentation.
    #   source - string - Source glob used to select candidate files.
    #   exclude_pattern - string - Optional source exclusion glob.
    #   disabled - boolean - If true, the expectation is disabled.
    #   trigger - string - How this expectation opens windows.
    #   interval - string - If trigger is `daily`, this specifies how often to run the expectation.
    #   recurring_day - int64 - If trigger is `daily`, this selects the day number inside the chosen interval.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    #   schedule_times_of_day - array(string) - Times of day in HH:MM format for schedule-driven expectations.
    #   schedule_time_zone - string - Time zone used by the expectation schedule.
    #   holiday_region - string - Optional holiday region used by schedule-driven expectations.
    #   lookback_interval - int64 - How many seconds before the due boundary the window starts.
    #   late_acceptance_interval - int64 - How many seconds a schedule-driven window may remain eligible to close as late.
    #   inactivity_interval - int64 - How many quiet seconds are required before final closure.
    #   max_open_interval - int64 - Hard-stop duration in seconds for unscheduled expectations.
    #   criteria - object - Structured criteria v1 definition for the expectation.
    #   workspace_id - int64 - Workspace ID. `0` means the default workspace.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params[:source] and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exclude_pattern must be an String") if params[:exclude_pattern] and !params[:exclude_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params[:interval] and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if params[:holiday_region] and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: lookback_interval must be an Integer") if params[:lookback_interval] and !params[:lookback_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: late_acceptance_interval must be an Integer") if params[:late_acceptance_interval] and !params[:late_acceptance_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: inactivity_interval must be an Integer") if params[:inactivity_interval] and !params[:inactivity_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_open_interval must be an Integer") if params[:max_open_interval] and !params[:max_open_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: criteria must be an Hash") if params[:criteria] and !params[:criteria].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/expectations/#{params[:id]}", :patch, params, options)
      Expectation.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/expectations/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
