# frozen_string_literal: true

module Files
  # Files::Sync is the Ruby SDK's representation of Files.com API Sync objects.
  # Each instance keeps its API field values in +attributes+.
  class Sync
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Sync ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def id=(value)
      @attributes[:id] = value
    end

    # Name for this sync job
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def name=(value)
      @attributes[:name] = value
    end

    # Description for this sync job
    # @return [String, nil] the field value, or nil when absent.
    def description
      @attributes[:description]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def description=(value)
      @attributes[:description] = value
    end

    # Site ID this sync belongs to
    # @return [Integer, nil] the field value, or nil when absent.
    def site_id
      @attributes[:site_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def site_id=(value)
      @attributes[:site_id] = value
    end

    # Workspace ID this sync belongs to
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # User who created or owns this sync
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def user_id=(value)
      @attributes[:user_id] = value
    end

    # Absolute source path for the sync
    # @return [String, nil] the field value, or nil when absent.
    def src_path
      @attributes[:src_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def src_path=(value)
      @attributes[:src_path] = value
    end

    # Absolute destination path for the sync
    # @return [String, nil] the field value, or nil when absent.
    def dest_path
      @attributes[:dest_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def dest_path=(value)
      @attributes[:dest_path] = value
    end

    # Remote server ID for the source (if remote)
    # @return [Integer, nil] the field value, or nil when absent.
    def src_remote_server_id
      @attributes[:src_remote_server_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def src_remote_server_id=(value)
      @attributes[:src_remote_server_id] = value
    end

    # Remote server ID for the destination (if remote)
    # @return [Integer, nil] the field value, or nil when absent.
    def dest_remote_server_id
      @attributes[:dest_remote_server_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def dest_remote_server_id=(value)
      @attributes[:dest_remote_server_id] = value
    end

    # Source site ID if syncing from a child or partner site
    # @return [Integer, nil] the field value, or nil when absent.
    def src_site_id
      @attributes[:src_site_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def src_site_id=(value)
      @attributes[:src_site_id] = value
    end

    # Destination site ID if syncing to a child or partner site
    # @return [Integer, nil] the field value, or nil when absent.
    def dest_site_id
      @attributes[:dest_site_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def dest_site_id=(value)
      @attributes[:dest_site_id] = value
    end

    # Is this a two-way sync?
    # @return [Boolean, nil] the field value, or nil when absent.
    def two_way
      @attributes[:two_way]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def two_way=(value)
      @attributes[:two_way] = value
    end

    # Keep files after copying?
    # @return [Boolean, nil] the field value, or nil when absent.
    def keep_after_copy
      @attributes[:keep_after_copy]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def keep_after_copy=(value)
      @attributes[:keep_after_copy] = value
    end

    # Delete empty folders after sync?
    # @return [Boolean, nil] the field value, or nil when absent.
    def delete_empty_folders
      @attributes[:delete_empty_folders]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def delete_empty_folders=(value)
      @attributes[:delete_empty_folders] = value
    end

    # Is this sync disabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def disabled
      @attributes[:disabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def disabled=(value)
      @attributes[:disabled] = value
    end

    # Trigger type: daily, custom_schedule, or manual
    # @return [String, nil] the field value, or nil when absent.
    def trigger
      @attributes[:trigger]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def trigger=(value)
      @attributes[:trigger] = value
    end

    # Some MFT services request an empty file (known as a trigger file) to signal the sync is complete and they can begin further processing. If trigger_file is set, a zero-byte file will be sent at the end of the sync.
    # @return [String, nil] the field value, or nil when absent.
    def trigger_file
      @attributes[:trigger_file]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def trigger_file=(value)
      @attributes[:trigger_file] = value
    end

    # If true, the trigger file will be sent at the end of a successful sync even when no files were transferred.
    # @return [Boolean, nil] the field value, or nil when absent.
    def always_write_trigger_file
      @attributes[:always_write_trigger_file]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def always_write_trigger_file=(value)
      @attributes[:always_write_trigger_file] = value
    end

    # Array of glob patterns to include
    # @return [Array<String>, nil] the field value, or nil when absent.
    def include_patterns
      @attributes[:include_patterns]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def include_patterns=(value)
      @attributes[:include_patterns] = value
    end

    # Array of glob patterns to exclude
    # @return [Array<String>, nil] the field value, or nil when absent.
    def exclude_patterns
      @attributes[:exclude_patterns]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def exclude_patterns=(value)
      @attributes[:exclude_patterns] = value
    end

    # When this sync was created
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # When this sync was last updated
    # @return [String, nil] the field value, or nil when absent.
    def updated_at
      @attributes[:updated_at]
    end

    # Frequency in minutes between syncs. If set, this value must be greater than or equal to the `remote_sync_interval` value for the site's plan. If left blank, the plan's `remote_sync_interval` will be used. This setting is only used if `trigger` is empty.
    # @return [Integer, nil] the field value, or nil when absent.
    def sync_interval_minutes
      @attributes[:sync_interval_minutes]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def sync_interval_minutes=(value)
      @attributes[:sync_interval_minutes] = value
    end

    # If trigger is `daily`, this specifies how often to run this sync.  One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    # @return [String, nil] the field value, or nil when absent.
    def interval
      @attributes[:interval]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def interval=(value)
      @attributes[:interval] = value
    end

    # If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @return [Integer, nil] the field value, or nil when absent.
    def recurring_day
      @attributes[:recurring_day]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def recurring_day=(value)
      @attributes[:recurring_day] = value
    end

    # If trigger type is `daily`, this specifies one or more day numbers to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def recurring_days
      @attributes[:recurring_days]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def recurring_days=(value)
      @attributes[:recurring_days] = value
    end

    # If trigger is `custom_schedule`, the reusable Schedule used instead of the sync's schedule fields.
    # @return [Integer, nil] the field value, or nil when absent.
    def schedule_id
      @attributes[:schedule_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def schedule_id=(value)
      @attributes[:schedule_id] = value
    end

    # If trigger is `custom_schedule`, Custom schedule description for when the sync should be run. 0-based days of the week. 0 is Sunday, 1 is Monday, etc.
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def schedule_days_of_week
      @attributes[:schedule_days_of_week]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def schedule_days_of_week=(value)
      @attributes[:schedule_days_of_week] = value
    end

    # Times of day to run in HH:MM format. For `custom_schedule`, run at these times on specified days of week. For `daily`, run at these times on the scheduled interval date.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def schedule_times_of_day
      @attributes[:schedule_times_of_day]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def schedule_times_of_day=(value)
      @attributes[:schedule_times_of_day] = value
    end

    # Time zone for the schedule. If not set, times are interpreted as UTC.
    # @return [String, nil] the field value, or nil when absent.
    def schedule_time_zone
      @attributes[:schedule_time_zone]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def schedule_time_zone=(value)
      @attributes[:schedule_time_zone] = value
    end

    # Skip the sync if there is a formal, observed holiday for this region.
    # @return [String, nil] the field value, or nil when absent.
    def holiday_region
      @attributes[:holiday_region]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def holiday_region=(value)
      @attributes[:holiday_region] = value
    end

    # The latest run of this sync
    # @return [Hash, nil] the field value, or nil when absent.
    def latest_sync_run
      @attributes[:latest_sync_run]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def latest_sync_run=(value)
      @attributes[:latest_sync_run] = value
    end

    # Dry Run Sync
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def dry_run(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/syncs/#{@attributes[:id]}/dry_run", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Manually Run Sync
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def manual_run(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/syncs/#{@attributes[:id]}/manual_run", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Update Sync
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] delete_empty_folders Delete empty folders after sync?
    # @option params [String] description Description for this sync job
    # @option params [String] dest_path Absolute destination path for the sync
    # @option params [Integer] dest_remote_server_id Remote server ID for the destination (if remote)
    # @option params [Boolean] disabled Is this sync disabled?
    # @option params [Array<String>] exclude_patterns Array of glob patterns to exclude
    # @option params [String] holiday_region Skip the sync if there is a formal, observed holiday for this region.
    # @option params [Array<String>] include_patterns Array of glob patterns to include
    # @option params [String] interval If trigger is `daily`, this specifies how often to run this sync.  One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    # @option params [Boolean] keep_after_copy Keep files after copying?
    # @option params [String] name Name for this sync job
    # @option params [Integer] recurring_day If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @option params [Array<Integer>] recurring_days If trigger type is `daily`, this specifies one or more day numbers to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @option params [Integer] schedule_id If trigger is `custom_schedule`, the reusable Schedule used instead of the sync's schedule fields.
    # @option params [Array<Integer>] schedule_days_of_week If trigger is `custom_schedule`, Custom schedule description for when the sync should be run. 0-based days of the week. 0 is Sunday, 1 is Monday, etc.
    # @option params [String] schedule_time_zone Time zone for the schedule. If not set, times are interpreted as UTC.
    # @option params [Array<String>] schedule_times_of_day Times of day to run in HH:MM format. For `custom_schedule`, run at these times on specified days of week. For `daily`, run at these times on the scheduled interval date.
    # @option params [String] src_path Absolute source path for the sync
    # @option params [Integer] src_remote_server_id Remote server ID for the source (if remote)
    # @option params [Integer] sync_interval_minutes Frequency in minutes between syncs. If set, this value must be greater than or equal to the `remote_sync_interval` value for the site's plan. If left blank, the plan's `remote_sync_interval` will be used. This setting is only used if `trigger` is empty.
    # @option params [String] trigger Trigger type: daily, custom_schedule, or manual
    # @option params [String] trigger_file Some MFT services request an empty file (known as a trigger file) to signal the sync is complete and they can begin further processing. If trigger_file is set, a zero-byte file will be sent at the end of the sync.
    # @option params [Boolean] always_write_trigger_file If true, the trigger file will be sent at the end of a successful sync even when no files were transferred.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: delete_empty_folders must be a single value, not #{params[:delete_empty_folders].class}") if [ Array, Hash ].any? { |klass| params[:delete_empty_folders].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dest_path must be an String") if !params[:dest_path].nil? and !params[:dest_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dest_remote_server_id must be an Integer") if !params[:dest_remote_server_id].nil? and !params[:dest_remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: disabled must be a single value, not #{params[:disabled].class}") if [ Array, Hash ].any? { |klass| params[:disabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: exclude_patterns must be an Array") if !params[:exclude_patterns].nil? and !params[:exclude_patterns].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if !params[:holiday_region].nil? and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: include_patterns must be an Array") if !params[:include_patterns].nil? and !params[:include_patterns].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if !params[:interval].nil? and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: keep_after_copy must be a single value, not #{params[:keep_after_copy].class}") if [ Array, Hash ].any? { |klass| params[:keep_after_copy].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if !params[:recurring_day].nil? and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recurring_days must be an Array") if !params[:recurring_days].nil? and !params[:recurring_days].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_id must be an Integer") if !params[:schedule_id].nil? and !params[:schedule_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if !params[:schedule_days_of_week].nil? and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if !params[:schedule_time_zone].nil? and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if !params[:schedule_times_of_day].nil? and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: src_path must be an String") if !params[:src_path].nil? and !params[:src_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: src_remote_server_id must be an Integer") if !params[:src_remote_server_id].nil? and !params[:src_remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sync_interval_minutes must be an Integer") if !params[:sync_interval_minutes].nil? and !params[:sync_interval_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if !params[:trigger].nil? and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_file must be an String") if !params[:trigger_file].nil? and !params[:trigger_file].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: always_write_trigger_file must be a single value, not #{params[:always_write_trigger_file].class}") if [ Array, Hash ].any? { |klass| params[:always_write_trigger_file].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/syncs/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("Sync") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Sync
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/syncs/#{@attributes[:id]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Calls {#delete} and discards its response.
    # @param (see #delete)
    # @option (see #delete)
    # @raise (see #delete)
    # @return [nil]
    def destroy(params = {})
      delete(params)
      nil
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = Sync.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Syncs
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `site_id`, `workspace_id` or `name`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id`, `disabled`, `src_remote_server_id` or `dest_remote_server_id`. Valid field combinations are `[ workspace_id, disabled ]`, `[ workspace_id, src_remote_server_id ]`, `[ workspace_id, dest_remote_server_id ]`, `[ disabled, src_remote_server_id ]`, `[ disabled, dest_remote_server_id ]`, `[ workspace_id, disabled, src_remote_server_id ]` or `[ workspace_id, disabled, dest_remote_server_id ]`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)

      list_options = options.dup
      List.new(Sync, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/syncs", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Sync
    #
    # @param id [Integer] Sync ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Sync] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/syncs/#{params[:id]}", :get, params, options) { |reply| reply.require_object("Sync") }
      Sync.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Sync
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] delete_empty_folders Delete empty folders after sync?
    # @option params [String] description Description for this sync job
    # @option params [String] dest_path Absolute destination path for the sync
    # @option params [Integer] dest_remote_server_id Remote server ID for the destination (if remote)
    # @option params [Boolean] disabled Is this sync disabled?
    # @option params [Array<String>] exclude_patterns Array of glob patterns to exclude
    # @option params [String] holiday_region Skip the sync if there is a formal, observed holiday for this region.
    # @option params [Array<String>] include_patterns Array of glob patterns to include
    # @option params [String] interval If trigger is `daily`, this specifies how often to run this sync.  One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    # @option params [Boolean] keep_after_copy Keep files after copying?
    # @option params [String] name Name for this sync job
    # @option params [Integer] recurring_day If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @option params [Array<Integer>] recurring_days If trigger type is `daily`, this specifies one or more day numbers to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @option params [Integer] schedule_id If trigger is `custom_schedule`, the reusable Schedule used instead of the sync's schedule fields.
    # @option params [Array<Integer>] schedule_days_of_week If trigger is `custom_schedule`, Custom schedule description for when the sync should be run. 0-based days of the week. 0 is Sunday, 1 is Monday, etc.
    # @option params [String] schedule_time_zone Time zone for the schedule. If not set, times are interpreted as UTC.
    # @option params [Array<String>] schedule_times_of_day Times of day to run in HH:MM format. For `custom_schedule`, run at these times on specified days of week. For `daily`, run at these times on the scheduled interval date.
    # @option params [String] src_path Absolute source path for the sync
    # @option params [Integer] src_remote_server_id Remote server ID for the source (if remote)
    # @option params [Integer] sync_interval_minutes Frequency in minutes between syncs. If set, this value must be greater than or equal to the `remote_sync_interval` value for the site's plan. If left blank, the plan's `remote_sync_interval` will be used. This setting is only used if `trigger` is empty.
    # @option params [String] trigger Trigger type: daily, custom_schedule, or manual
    # @option params [String] trigger_file Some MFT services request an empty file (known as a trigger file) to signal the sync is complete and they can begin further processing. If trigger_file is set, a zero-byte file will be sent at the end of the sync.
    # @option params [Boolean] always_write_trigger_file If true, the trigger file will be sent at the end of a successful sync even when no files were transferred.
    # @option params [Integer] workspace_id Workspace ID this sync belongs to
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Sync] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: delete_empty_folders must be a single value, not #{params[:delete_empty_folders].class}") if [ Array, Hash ].any? { |klass| params[:delete_empty_folders].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dest_path must be an String") if !params[:dest_path].nil? and !params[:dest_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dest_remote_server_id must be an Integer") if !params[:dest_remote_server_id].nil? and !params[:dest_remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: disabled must be a single value, not #{params[:disabled].class}") if [ Array, Hash ].any? { |klass| params[:disabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: exclude_patterns must be an Array") if !params[:exclude_patterns].nil? and !params[:exclude_patterns].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if !params[:holiday_region].nil? and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: include_patterns must be an Array") if !params[:include_patterns].nil? and !params[:include_patterns].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if !params[:interval].nil? and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: keep_after_copy must be a single value, not #{params[:keep_after_copy].class}") if [ Array, Hash ].any? { |klass| params[:keep_after_copy].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if !params[:recurring_day].nil? and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recurring_days must be an Array") if !params[:recurring_days].nil? and !params[:recurring_days].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_id must be an Integer") if !params[:schedule_id].nil? and !params[:schedule_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if !params[:schedule_days_of_week].nil? and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if !params[:schedule_time_zone].nil? and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if !params[:schedule_times_of_day].nil? and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: src_path must be an String") if !params[:src_path].nil? and !params[:src_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: src_remote_server_id must be an Integer") if !params[:src_remote_server_id].nil? and !params[:src_remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sync_interval_minutes must be an Integer") if !params[:sync_interval_minutes].nil? and !params[:sync_interval_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if !params[:trigger].nil? and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_file must be an String") if !params[:trigger_file].nil? and !params[:trigger_file].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: always_write_trigger_file must be a single value, not #{params[:always_write_trigger_file].class}") if [ Array, Hash ].any? { |klass| params[:always_write_trigger_file].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)

      response, options = Api.send_request("/syncs", :post, params, options) { |reply| reply.require_object("Sync") }
      Sync.new(response.data, options)
    end

    # Dry Run Sync
    #
    # @param id [Integer] Sync ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.dry_run(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/syncs/#{params[:id]}/dry_run", :post, params, options)
      nil
    end

    # Manually Run Sync
    #
    # @param id [Integer] Sync ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.manual_run(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/syncs/#{params[:id]}/manual_run", :post, params, options)
      nil
    end

    # Update Sync
    #
    # @param id [Integer] Sync ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] delete_empty_folders Delete empty folders after sync?
    # @option params [String] description Description for this sync job
    # @option params [String] dest_path Absolute destination path for the sync
    # @option params [Integer] dest_remote_server_id Remote server ID for the destination (if remote)
    # @option params [Boolean] disabled Is this sync disabled?
    # @option params [Array<String>] exclude_patterns Array of glob patterns to exclude
    # @option params [String] holiday_region Skip the sync if there is a formal, observed holiday for this region.
    # @option params [Array<String>] include_patterns Array of glob patterns to include
    # @option params [String] interval If trigger is `daily`, this specifies how often to run this sync.  One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    # @option params [Boolean] keep_after_copy Keep files after copying?
    # @option params [String] name Name for this sync job
    # @option params [Integer] recurring_day If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @option params [Array<Integer>] recurring_days If trigger type is `daily`, this specifies one or more day numbers to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @option params [Integer] schedule_id If trigger is `custom_schedule`, the reusable Schedule used instead of the sync's schedule fields.
    # @option params [Array<Integer>] schedule_days_of_week If trigger is `custom_schedule`, Custom schedule description for when the sync should be run. 0-based days of the week. 0 is Sunday, 1 is Monday, etc.
    # @option params [String] schedule_time_zone Time zone for the schedule. If not set, times are interpreted as UTC.
    # @option params [Array<String>] schedule_times_of_day Times of day to run in HH:MM format. For `custom_schedule`, run at these times on specified days of week. For `daily`, run at these times on the scheduled interval date.
    # @option params [String] src_path Absolute source path for the sync
    # @option params [Integer] src_remote_server_id Remote server ID for the source (if remote)
    # @option params [Integer] sync_interval_minutes Frequency in minutes between syncs. If set, this value must be greater than or equal to the `remote_sync_interval` value for the site's plan. If left blank, the plan's `remote_sync_interval` will be used. This setting is only used if `trigger` is empty.
    # @option params [String] trigger Trigger type: daily, custom_schedule, or manual
    # @option params [String] trigger_file Some MFT services request an empty file (known as a trigger file) to signal the sync is complete and they can begin further processing. If trigger_file is set, a zero-byte file will be sent at the end of the sync.
    # @option params [Boolean] always_write_trigger_file If true, the trigger file will be sent at the end of a successful sync even when no files were transferred.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Sync] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: delete_empty_folders must be a single value, not #{params[:delete_empty_folders].class}") if [ Array, Hash ].any? { |klass| params[:delete_empty_folders].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dest_path must be an String") if !params[:dest_path].nil? and !params[:dest_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dest_remote_server_id must be an Integer") if !params[:dest_remote_server_id].nil? and !params[:dest_remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: disabled must be a single value, not #{params[:disabled].class}") if [ Array, Hash ].any? { |klass| params[:disabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: exclude_patterns must be an Array") if !params[:exclude_patterns].nil? and !params[:exclude_patterns].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if !params[:holiday_region].nil? and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: include_patterns must be an Array") if !params[:include_patterns].nil? and !params[:include_patterns].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if !params[:interval].nil? and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: keep_after_copy must be a single value, not #{params[:keep_after_copy].class}") if [ Array, Hash ].any? { |klass| params[:keep_after_copy].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if !params[:recurring_day].nil? and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recurring_days must be an Array") if !params[:recurring_days].nil? and !params[:recurring_days].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_id must be an Integer") if !params[:schedule_id].nil? and !params[:schedule_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if !params[:schedule_days_of_week].nil? and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if !params[:schedule_time_zone].nil? and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if !params[:schedule_times_of_day].nil? and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: src_path must be an String") if !params[:src_path].nil? and !params[:src_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: src_remote_server_id must be an Integer") if !params[:src_remote_server_id].nil? and !params[:src_remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sync_interval_minutes must be an Integer") if !params[:sync_interval_minutes].nil? and !params[:sync_interval_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if !params[:trigger].nil? and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_file must be an String") if !params[:trigger_file].nil? and !params[:trigger_file].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: always_write_trigger_file must be a single value, not #{params[:always_write_trigger_file].class}") if [ Array, Hash ].any? { |klass| params[:always_write_trigger_file].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/syncs/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("Sync") }
      Sync.new(response.data, options)
    end

    # Delete Sync
    #
    # @param id [Integer] Sync ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/syncs/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
