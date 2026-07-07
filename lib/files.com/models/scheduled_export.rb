# frozen_string_literal: true

module Files
  class ScheduledExport
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Scheduled Export ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Name for this scheduled export.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Export report type. Valid values: folder_size_audit, group_membership_audit, permission_audit, share_link_audit
    def export_type
      @attributes[:export_type]
    end

    def export_type=(value)
      @attributes[:export_type] = value
    end

    # string - Human-readable report name.
    def report_name
      @attributes[:report_name]
    end

    def report_name=(value)
      @attributes[:report_name] = value
    end

    # object - Report-specific options. `permission_audit` supports `group_by` with `user` or `path`.
    def export_options
      @attributes[:export_options]
    end

    def export_options=(value)
      @attributes[:export_options] = value
    end

    # int64 - Site Admin user who receives the completed export e-mail.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # boolean - If true, this scheduled export will not run.
    def disabled
      @attributes[:disabled]
    end

    def disabled=(value)
      @attributes[:disabled] = value
    end

    # string - Schedule trigger type: `daily` or `custom_schedule`.
    def trigger
      @attributes[:trigger]
    end

    def trigger=(value)
      @attributes[:trigger] = value
    end

    # string - If trigger is `daily`, this specifies how often to run the scheduled export.
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

    # array(string) - Times of day in HH:MM format for schedule-driven exports.
    def schedule_times_of_day
      @attributes[:schedule_times_of_day]
    end

    def schedule_times_of_day=(value)
      @attributes[:schedule_times_of_day] = value
    end

    # string - Time zone used by the scheduled export.
    def schedule_time_zone
      @attributes[:schedule_time_zone]
    end

    def schedule_time_zone=(value)
      @attributes[:schedule_time_zone] = value
    end

    # string - Optional holiday region used by schedule-driven exports.
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

    # date-time - Most recent scheduled run time.
    def last_run_at
      @attributes[:last_run_at]
    end

    def last_run_at=(value)
      @attributes[:last_run_at] = value
    end

    # int64 - Most recent Export ID created by this schedule.
    def last_export_id
      @attributes[:last_export_id]
    end

    def last_export_id=(value)
      @attributes[:last_export_id] = value
    end

    # date-time - Creation time.
    def created_at
      @attributes[:created_at]
    end

    # date-time - Last update time.
    def updated_at
      @attributes[:updated_at]
    end

    # Parameters:
    #   name - string - Name for this scheduled export.
    #   export_type - string - Export report type. Valid values: folder_size_audit, group_membership_audit, permission_audit, share_link_audit
    #   export_options - object - Report-specific options. `permission_audit` supports `group_by` with `user` or `path`.
    #   user_id - int64 - Site Admin user who receives the completed export e-mail.
    #   disabled - boolean - If true, this scheduled export will not run.
    #   trigger - string - Schedule trigger type: `daily` or `custom_schedule`.
    #   interval - string - If trigger is `daily`, this specifies how often to run the scheduled export.
    #   recurring_day - int64 - If trigger is `daily`, this selects the day number inside the chosen interval.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    #   schedule_times_of_day - array(string) - Times of day in HH:MM format for schedule-driven exports.
    #   schedule_time_zone - string - Time zone used by the scheduled export.
    #   holiday_region - string - Optional holiday region used by schedule-driven exports.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: export_type must be an String") if params[:export_type] and !params[:export_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params[:interval] and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if params[:holiday_region] and !params[:holiday_region].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/scheduled_exports/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/scheduled_exports/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = ScheduledExport.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `name`, `export_type` or `disabled`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `disabled` and `export_type`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `export_type`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

      List.new(ScheduledExport, params) do
        Api.send_request("/scheduled_exports", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Scheduled Export ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/scheduled_exports/#{params[:id]}", :get, params, options)
      ScheduledExport.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name (required) - string - Name for this scheduled export.
    #   export_type (required) - string - Export report type. Valid values: folder_size_audit, group_membership_audit, permission_audit, share_link_audit
    #   export_options - object - Report-specific options. `permission_audit` supports `group_by` with `user` or `path`.
    #   user_id - int64 - Site Admin user who receives the completed export e-mail.
    #   disabled - boolean - If true, this scheduled export will not run.
    #   trigger - string - Schedule trigger type: `daily` or `custom_schedule`.
    #   interval - string - If trigger is `daily`, this specifies how often to run the scheduled export.
    #   recurring_day - int64 - If trigger is `daily`, this selects the day number inside the chosen interval.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    #   schedule_times_of_day - array(string) - Times of day in HH:MM format for schedule-driven exports.
    #   schedule_time_zone - string - Time zone used by the scheduled export.
    #   holiday_region - string - Optional holiday region used by schedule-driven exports.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: export_type must be an String") if params[:export_type] and !params[:export_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: export_options must be an Hash") if params[:export_options] and !params[:export_options].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params[:interval] and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if params[:holiday_region] and !params[:holiday_region].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]
      raise MissingParameterError.new("Parameter missing: export_type") unless params[:export_type]

      response, options = Api.send_request("/scheduled_exports", :post, params, options)
      ScheduledExport.new(response.data, options)
    end

    # Parameters:
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `name`, `export_type` or `disabled`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `disabled` and `export_type`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `export_type`.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

      response, options = Api.send_request("/scheduled_exports/create_export", :post, params, options)
      Export.new(response.data, options)
    end

    # Parameters:
    #   name - string - Name for this scheduled export.
    #   export_type - string - Export report type. Valid values: folder_size_audit, group_membership_audit, permission_audit, share_link_audit
    #   export_options - object - Report-specific options. `permission_audit` supports `group_by` with `user` or `path`.
    #   user_id - int64 - Site Admin user who receives the completed export e-mail.
    #   disabled - boolean - If true, this scheduled export will not run.
    #   trigger - string - Schedule trigger type: `daily` or `custom_schedule`.
    #   interval - string - If trigger is `daily`, this specifies how often to run the scheduled export.
    #   recurring_day - int64 - If trigger is `daily`, this selects the day number inside the chosen interval.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    #   schedule_times_of_day - array(string) - Times of day in HH:MM format for schedule-driven exports.
    #   schedule_time_zone - string - Time zone used by the scheduled export.
    #   holiday_region - string - Optional holiday region used by schedule-driven exports.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: export_type must be an String") if params[:export_type] and !params[:export_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: export_options must be an Hash") if params[:export_options] and !params[:export_options].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params[:interval] and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if params[:holiday_region] and !params[:holiday_region].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/scheduled_exports/#{params[:id]}", :patch, params, options)
      ScheduledExport.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/scheduled_exports/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
