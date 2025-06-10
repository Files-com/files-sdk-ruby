# frozen_string_literal: true

module Files
  class Sync
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Sync ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Name for this sync job
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Description for this sync job
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # int64 - Site ID this sync belongs to
    def site_id
      @attributes[:site_id]
    end

    def site_id=(value)
      @attributes[:site_id] = value
    end

    # int64 - User who created or owns this sync
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # string - Absolute source path for the sync
    def src_path
      @attributes[:src_path]
    end

    def src_path=(value)
      @attributes[:src_path] = value
    end

    # string - Absolute destination path for the sync
    def dest_path
      @attributes[:dest_path]
    end

    def dest_path=(value)
      @attributes[:dest_path] = value
    end

    # int64 - Remote server ID for the source (if remote)
    def src_remote_server_id
      @attributes[:src_remote_server_id]
    end

    def src_remote_server_id=(value)
      @attributes[:src_remote_server_id] = value
    end

    # int64 - Remote server ID for the destination (if remote)
    def dest_remote_server_id
      @attributes[:dest_remote_server_id]
    end

    def dest_remote_server_id=(value)
      @attributes[:dest_remote_server_id] = value
    end

    # boolean - Is this a two-way sync?
    def two_way
      @attributes[:two_way]
    end

    def two_way=(value)
      @attributes[:two_way] = value
    end

    # boolean - Keep files after copying?
    def keep_after_copy
      @attributes[:keep_after_copy]
    end

    def keep_after_copy=(value)
      @attributes[:keep_after_copy] = value
    end

    # boolean - Delete empty folders after sync?
    def delete_empty_folders
      @attributes[:delete_empty_folders]
    end

    def delete_empty_folders=(value)
      @attributes[:delete_empty_folders] = value
    end

    # boolean - Is this sync disabled?
    def disabled
      @attributes[:disabled]
    end

    def disabled=(value)
      @attributes[:disabled] = value
    end

    # string - If trigger is `daily`, this specifies how often to run this sync.  One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    def interval
      @attributes[:interval]
    end

    def interval=(value)
      @attributes[:interval] = value
    end

    # string - Trigger type: daily, custom_schedule, or manual
    def trigger
      @attributes[:trigger]
    end

    def trigger=(value)
      @attributes[:trigger] = value
    end

    # string - Some MFT services request an empty file (known as a trigger file) to signal the sync is complete and they can begin further processing. If trigger_file is set, a zero-byte file will be sent at the end of the sync.
    def trigger_file
      @attributes[:trigger_file]
    end

    def trigger_file=(value)
      @attributes[:trigger_file] = value
    end

    # array(array) - Array of glob patterns to include
    def include_patterns
      @attributes[:include_patterns]
    end

    def include_patterns=(value)
      @attributes[:include_patterns] = value
    end

    # array(array) - Array of glob patterns to exclude
    def exclude_patterns
      @attributes[:exclude_patterns]
    end

    def exclude_patterns=(value)
      @attributes[:exclude_patterns] = value
    end

    # date-time - When this sync was created
    def created_at
      @attributes[:created_at]
    end

    # date-time - When this sync was last updated
    def updated_at
      @attributes[:updated_at]
    end

    # int64 - Frequency in minutes between syncs. If set, this value must be greater than or equal to the `remote_sync_interval` value for the site's plan. If left blank, the plan's `remote_sync_interval` will be used. This setting is only used if `trigger` is empty.
    def sync_interval_minutes
      @attributes[:sync_interval_minutes]
    end

    def sync_interval_minutes=(value)
      @attributes[:sync_interval_minutes] = value
    end

    # int64 - If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    def recurring_day
      @attributes[:recurring_day]
    end

    def recurring_day=(value)
      @attributes[:recurring_day] = value
    end

    # array(int64) - If trigger is `custom_schedule`, Custom schedule description for when the sync should be run. 0-based days of the week. 0 is Sunday, 1 is Monday, etc.
    def schedule_days_of_week
      @attributes[:schedule_days_of_week]
    end

    def schedule_days_of_week=(value)
      @attributes[:schedule_days_of_week] = value
    end

    # array(string) - If trigger is `custom_schedule`, Custom schedule description for when the sync should be run. Times of day in HH:MM format.
    def schedule_times_of_day
      @attributes[:schedule_times_of_day]
    end

    def schedule_times_of_day=(value)
      @attributes[:schedule_times_of_day] = value
    end

    # string - If trigger is `custom_schedule`, Custom schedule Time Zone for when the sync should be run.
    def schedule_time_zone
      @attributes[:schedule_time_zone]
    end

    def schedule_time_zone=(value)
      @attributes[:schedule_time_zone] = value
    end

    # Parameters:
    #   name - string - Name for this sync job
    #   description - string - Description for this sync job
    #   src_path - string - Absolute source path
    #   dest_path - string - Absolute destination path
    #   src_remote_server_id - int64 - Remote server ID for the source
    #   dest_remote_server_id - int64 - Remote server ID for the destination
    #   two_way - boolean - Is this a two-way sync?
    #   keep_after_copy - boolean - Keep files after copying?
    #   delete_empty_folders - boolean - Delete empty folders after sync?
    #   disabled - boolean - Is this sync disabled?
    #   interval - int64 - Interval in minutes for sync (if scheduled)
    #   trigger - string - Trigger type: daily, custom_schedule, or manual
    #   trigger_file - string - Some MFT services request an empty file (known as a trigger file) to signal the sync is complete and they can begin further processing. If trigger_file is set, a zero-byte file will be sent at the end of the sync.
    #   recurring_day - int64 - If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    #   schedule_time_zone - string - If trigger is `custom_schedule`, Custom schedule Time Zone for when the sync should be run.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`, Custom schedule description for when the sync should be run. 0-based days of the week. 0 is Sunday, 1 is Monday, etc.
    #   schedule_times_of_day - array(string) - If trigger is `custom_schedule`, Custom schedule description for when the sync should be run. Times of day in HH:MM format.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: src_path must be an String") if params[:src_path] and !params[:src_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dest_path must be an String") if params[:dest_path] and !params[:dest_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: src_remote_server_id must be an Integer") if params[:src_remote_server_id] and !params[:src_remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: dest_remote_server_id must be an Integer") if params[:dest_remote_server_id] and !params[:dest_remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: interval must be an Integer") if params[:interval] and !params[:interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_file must be an String") if params[:trigger_file] and !params[:trigger_file].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/syncs/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/syncs/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = Sync.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(Sync, params) do
        Api.send_request("/syncs", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Sync ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/syncs/#{params[:id]}", :get, params, options)
      Sync.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name - string - Name for this sync job
    #   description - string - Description for this sync job
    #   src_path - string - Absolute source path
    #   dest_path - string - Absolute destination path
    #   src_remote_server_id - int64 - Remote server ID for the source
    #   dest_remote_server_id - int64 - Remote server ID for the destination
    #   two_way - boolean - Is this a two-way sync?
    #   keep_after_copy - boolean - Keep files after copying?
    #   delete_empty_folders - boolean - Delete empty folders after sync?
    #   disabled - boolean - Is this sync disabled?
    #   interval - int64 - Interval in minutes for sync (if scheduled)
    #   trigger - string - Trigger type: daily, custom_schedule, or manual
    #   trigger_file - string - Some MFT services request an empty file (known as a trigger file) to signal the sync is complete and they can begin further processing. If trigger_file is set, a zero-byte file will be sent at the end of the sync.
    #   recurring_day - int64 - If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    #   schedule_time_zone - string - If trigger is `custom_schedule`, Custom schedule Time Zone for when the sync should be run.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`, Custom schedule description for when the sync should be run. 0-based days of the week. 0 is Sunday, 1 is Monday, etc.
    #   schedule_times_of_day - array(string) - If trigger is `custom_schedule`, Custom schedule description for when the sync should be run. Times of day in HH:MM format.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: src_path must be an String") if params[:src_path] and !params[:src_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dest_path must be an String") if params[:dest_path] and !params[:dest_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: src_remote_server_id must be an Integer") if params[:src_remote_server_id] and !params[:src_remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: dest_remote_server_id must be an Integer") if params[:dest_remote_server_id] and !params[:dest_remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: interval must be an Integer") if params[:interval] and !params[:interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_file must be an String") if params[:trigger_file] and !params[:trigger_file].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)

      response, options = Api.send_request("/syncs", :post, params, options)
      Sync.new(response.data, options)
    end

    def self.create_migrate_to(params = {}, options = {})
      Api.send_request("/syncs/migrate_to_syncs", :post, params, options)
      nil
    end

    # Parameters:
    #   name - string - Name for this sync job
    #   description - string - Description for this sync job
    #   src_path - string - Absolute source path
    #   dest_path - string - Absolute destination path
    #   src_remote_server_id - int64 - Remote server ID for the source
    #   dest_remote_server_id - int64 - Remote server ID for the destination
    #   two_way - boolean - Is this a two-way sync?
    #   keep_after_copy - boolean - Keep files after copying?
    #   delete_empty_folders - boolean - Delete empty folders after sync?
    #   disabled - boolean - Is this sync disabled?
    #   interval - int64 - Interval in minutes for sync (if scheduled)
    #   trigger - string - Trigger type: daily, custom_schedule, or manual
    #   trigger_file - string - Some MFT services request an empty file (known as a trigger file) to signal the sync is complete and they can begin further processing. If trigger_file is set, a zero-byte file will be sent at the end of the sync.
    #   recurring_day - int64 - If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    #   schedule_time_zone - string - If trigger is `custom_schedule`, Custom schedule Time Zone for when the sync should be run.
    #   schedule_days_of_week - array(int64) - If trigger is `custom_schedule`, Custom schedule description for when the sync should be run. 0-based days of the week. 0 is Sunday, 1 is Monday, etc.
    #   schedule_times_of_day - array(string) - If trigger is `custom_schedule`, Custom schedule description for when the sync should be run. Times of day in HH:MM format.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: src_path must be an String") if params[:src_path] and !params[:src_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dest_path must be an String") if params[:dest_path] and !params[:dest_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: src_remote_server_id must be an Integer") if params[:src_remote_server_id] and !params[:src_remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: dest_remote_server_id must be an Integer") if params[:dest_remote_server_id] and !params[:dest_remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: interval must be an Integer") if params[:interval] and !params[:interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params[:trigger] and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_file must be an String") if params[:trigger_file] and !params[:trigger_file].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if params[:recurring_day] and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if params[:schedule_time_zone] and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if params[:schedule_days_of_week] and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if params[:schedule_times_of_day] and !params[:schedule_times_of_day].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/syncs/#{params[:id]}", :patch, params, options)
      Sync.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/syncs/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
