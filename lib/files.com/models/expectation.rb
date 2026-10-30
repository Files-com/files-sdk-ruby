# frozen_string_literal: true

module Files
  # Files::Expectation is the Ruby SDK's representation of Files.com API Expectation objects.
  # Each instance keeps its API field values in +attributes+.
  class Expectation
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

    # Expectation ID
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

    # Workspace ID. `0` means the default workspace.
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

    # Expectation name.
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

    # Expectation description.
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

    # Path scope for the expectation. Supports workspace-relative presentation. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def path=(value)
      @attributes[:path] = value
    end

    # Source glob used to select candidate files.
    # @return [String, nil] the field value, or nil when absent.
    def source
      @attributes[:source]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def source=(value)
      @attributes[:source] = value
    end

    # Optional source exclusion glob.
    # @return [String, nil] the field value, or nil when absent.
    def exclude_pattern
      @attributes[:exclude_pattern]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def exclude_pattern=(value)
      @attributes[:exclude_pattern] = value
    end

    # If true, the expectation is disabled.
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

    # Criteria schema version for this expectation.
    # @return [Integer, nil] the field value, or nil when absent.
    def expectations_version
      @attributes[:expectations_version]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def expectations_version=(value)
      @attributes[:expectations_version] = value
    end

    # How this expectation opens windows.
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

    # If trigger is `daily`, this specifies how often to run the expectation.
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

    # If trigger is `daily`, this selects the day number inside the chosen interval.
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

    # If trigger is `daily`, this selects one or more day numbers inside a `week`, `month`, `quarter`, or `year` interval.
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

    # If trigger is `custom_schedule`, the reusable Schedule used instead of the Expectation's schedule fields.
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

    # If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
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

    # Times of day in HH:MM format for the Expectation schedule.
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

    # Time zone used by the Expectation schedule.
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

    # Optional holiday region used by the Expectation schedule.
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

    # How many seconds before the due boundary the window starts.
    # @return [Integer, nil] the field value, or nil when absent.
    def lookback_interval
      @attributes[:lookback_interval]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def lookback_interval=(value)
      @attributes[:lookback_interval] = value
    end

    # How many seconds a schedule-driven window may remain eligible to close as late.
    # @return [Integer, nil] the field value, or nil when absent.
    def late_acceptance_interval
      @attributes[:late_acceptance_interval]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def late_acceptance_interval=(value)
      @attributes[:late_acceptance_interval] = value
    end

    # How many quiet seconds are required before final closure.
    # @return [Integer, nil] the field value, or nil when absent.
    def inactivity_interval
      @attributes[:inactivity_interval]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def inactivity_interval=(value)
      @attributes[:inactivity_interval] = value
    end

    # Hard-stop duration in seconds for unscheduled expectations.
    # @return [Integer, nil] the field value, or nil when absent.
    def max_open_interval
      @attributes[:max_open_interval]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def max_open_interval=(value)
      @attributes[:max_open_interval] = value
    end

    # Versioned success criteria definition for the expectation. Criteria v2 supports optional FTS content validation.
    # @return [Hash, nil] the field value, or nil when absent.
    def criteria
      @attributes[:criteria]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def criteria=(value)
      @attributes[:criteria] = value
    end

    # Last time this expectation was evaluated.
    # @return [String, nil] the field value, or nil when absent.
    def last_evaluated_at
      @attributes[:last_evaluated_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_evaluated_at=(value)
      @attributes[:last_evaluated_at] = value
    end

    # Last time this expectation closed successfully.
    # @return [String, nil] the field value, or nil when absent.
    def last_success_at
      @attributes[:last_success_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_success_at=(value)
      @attributes[:last_success_at] = value
    end

    # Last time this expectation closed with a failure result.
    # @return [String, nil] the field value, or nil when absent.
    def last_failure_at
      @attributes[:last_failure_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_failure_at=(value)
      @attributes[:last_failure_at] = value
    end

    # Most recent terminal result for this expectation.
    # @return [String, nil] the field value, or nil when absent.
    def last_result
      @attributes[:last_result]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_result=(value)
      @attributes[:last_result] = value
    end

    # Creation time.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Last update time.
    # @return [String, nil] the field value, or nil when absent.
    def updated_at
      @attributes[:updated_at]
    end

    # Manually open an Expectation window
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def trigger_evaluation(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/expectations/#{@attributes[:id]}/trigger_evaluation", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Update Expectation
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Expectation name.
    # @option params [String] description Expectation description.
    # @option params [String] path Path scope for the expectation. Supports workspace-relative presentation.
    # @option params [String] source Source glob used to select candidate files.
    # @option params [String] exclude_pattern Optional source exclusion glob.
    # @option params [Boolean] disabled If true, the expectation is disabled.
    # @option params [String] trigger How this expectation opens windows.
    # @option params [String] interval If trigger is `daily`, this specifies how often to run the expectation.
    # @option params [Integer] recurring_day If trigger is `daily`, this selects the day number inside the chosen interval.
    # @option params [Array<Integer>] recurring_days If trigger is `daily`, this selects one or more day numbers inside a `week`, `month`, `quarter`, or `year` interval.
    # @option params [Integer] schedule_id If trigger is `custom_schedule`, the reusable Schedule used instead of the Expectation's schedule fields.
    # @option params [Array<Integer>] schedule_days_of_week If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    # @option params [Array<String>] schedule_times_of_day Times of day in HH:MM format for the Expectation schedule.
    # @option params [String] schedule_time_zone Time zone used by the Expectation schedule.
    # @option params [String] holiday_region Optional holiday region used by the Expectation schedule.
    # @option params [Integer] lookback_interval How many seconds before the due boundary the window starts.
    # @option params [Integer] late_acceptance_interval How many seconds a schedule-driven window may remain eligible to close as late.
    # @option params [Integer] inactivity_interval How many quiet seconds are required before final closure.
    # @option params [Integer] max_open_interval Hard-stop duration in seconds for unscheduled expectations.
    # @option params [Hash] criteria Versioned success criteria definition for the expectation, including optional Files Transform Script content validation in criteria v2.
    # @option params [Integer] workspace_id Workspace ID. `0` means the default workspace.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if !params[:source].nil? and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exclude_pattern must be an String") if !params[:exclude_pattern].nil? and !params[:exclude_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: disabled must be a single value, not #{params[:disabled].class}") if [ Array, Hash ].any? { |klass| params[:disabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if !params[:trigger].nil? and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if !params[:interval].nil? and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if !params[:recurring_day].nil? and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recurring_days must be an Array") if !params[:recurring_days].nil? and !params[:recurring_days].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_id must be an Integer") if !params[:schedule_id].nil? and !params[:schedule_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if !params[:schedule_days_of_week].nil? and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if !params[:schedule_times_of_day].nil? and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if !params[:schedule_time_zone].nil? and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if !params[:holiday_region].nil? and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: lookback_interval must be an Integer") if !params[:lookback_interval].nil? and !params[:lookback_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: late_acceptance_interval must be an Integer") if !params[:late_acceptance_interval].nil? and !params[:late_acceptance_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: inactivity_interval must be an Integer") if !params[:inactivity_interval].nil? and !params[:inactivity_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_open_interval must be an Integer") if !params[:max_open_interval].nil? and !params[:max_open_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: criteria must be an Hash") if !params[:criteria].nil? and !params[:criteria].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/expectations/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("Expectation") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Expectation
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

      response, options = Api.send_request("/expectations/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = Expectation.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Expectations
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `name` or `disabled`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `disabled` and `workspace_id`. Valid field combinations are `[ workspace_id, disabled ]`.
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
      List.new(Expectation, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/expectations", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Expectation
    #
    # @param id [Integer] Expectation ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Expectation] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/expectations/#{params[:id]}", :get, params, options) { |reply| reply.require_object("Expectation") }
      Expectation.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Expectation
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Expectation name.
    # @option params [String] description Expectation description.
    # @option params [String] path Path scope for the expectation. Supports workspace-relative presentation.
    # @option params [String] source Source glob used to select candidate files.
    # @option params [String] exclude_pattern Optional source exclusion glob.
    # @option params [Boolean] disabled If true, the expectation is disabled.
    # @option params [String] trigger How this expectation opens windows.
    # @option params [String] interval If trigger is `daily`, this specifies how often to run the expectation.
    # @option params [Integer] recurring_day If trigger is `daily`, this selects the day number inside the chosen interval.
    # @option params [Array<Integer>] recurring_days If trigger is `daily`, this selects one or more day numbers inside a `week`, `month`, `quarter`, or `year` interval.
    # @option params [Integer] schedule_id If trigger is `custom_schedule`, the reusable Schedule used instead of the Expectation's schedule fields.
    # @option params [Array<Integer>] schedule_days_of_week If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    # @option params [Array<String>] schedule_times_of_day Times of day in HH:MM format for the Expectation schedule.
    # @option params [String] schedule_time_zone Time zone used by the Expectation schedule.
    # @option params [String] holiday_region Optional holiday region used by the Expectation schedule.
    # @option params [Integer] lookback_interval How many seconds before the due boundary the window starts.
    # @option params [Integer] late_acceptance_interval How many seconds a schedule-driven window may remain eligible to close as late.
    # @option params [Integer] inactivity_interval How many quiet seconds are required before final closure.
    # @option params [Integer] max_open_interval Hard-stop duration in seconds for unscheduled expectations.
    # @option params [Hash] criteria Versioned success criteria definition for the expectation, including optional Files Transform Script content validation in criteria v2.
    # @option params [Integer] workspace_id Workspace ID. `0` means the default workspace.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Expectation] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if !params[:source].nil? and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exclude_pattern must be an String") if !params[:exclude_pattern].nil? and !params[:exclude_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: disabled must be a single value, not #{params[:disabled].class}") if [ Array, Hash ].any? { |klass| params[:disabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if !params[:trigger].nil? and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if !params[:interval].nil? and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if !params[:recurring_day].nil? and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recurring_days must be an Array") if !params[:recurring_days].nil? and !params[:recurring_days].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_id must be an Integer") if !params[:schedule_id].nil? and !params[:schedule_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if !params[:schedule_days_of_week].nil? and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if !params[:schedule_times_of_day].nil? and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if !params[:schedule_time_zone].nil? and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if !params[:holiday_region].nil? and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: lookback_interval must be an Integer") if !params[:lookback_interval].nil? and !params[:lookback_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: late_acceptance_interval must be an Integer") if !params[:late_acceptance_interval].nil? and !params[:late_acceptance_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: inactivity_interval must be an Integer") if !params[:inactivity_interval].nil? and !params[:inactivity_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_open_interval must be an Integer") if !params[:max_open_interval].nil? and !params[:max_open_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: criteria must be an Hash") if !params[:criteria].nil? and !params[:criteria].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)

      response, options = Api.send_request("/expectations", :post, params, options) { |reply| reply.require_object("Expectation") }
      Expectation.new(response.data, options)
    end

    # Manually open an Expectation window
    #
    # @param id [Integer] Expectation ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ExpectationEvaluation] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.trigger_evaluation(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/expectations/#{params[:id]}/trigger_evaluation", :post, params, options) { |reply| reply.require_object("ExpectationEvaluation") }
      ExpectationEvaluation.new(response.data, options)
    end

    # Update Expectation
    #
    # @param id [Integer] Expectation ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Expectation name.
    # @option params [String] description Expectation description.
    # @option params [String] path Path scope for the expectation. Supports workspace-relative presentation.
    # @option params [String] source Source glob used to select candidate files.
    # @option params [String] exclude_pattern Optional source exclusion glob.
    # @option params [Boolean] disabled If true, the expectation is disabled.
    # @option params [String] trigger How this expectation opens windows.
    # @option params [String] interval If trigger is `daily`, this specifies how often to run the expectation.
    # @option params [Integer] recurring_day If trigger is `daily`, this selects the day number inside the chosen interval.
    # @option params [Array<Integer>] recurring_days If trigger is `daily`, this selects one or more day numbers inside a `week`, `month`, `quarter`, or `year` interval.
    # @option params [Integer] schedule_id If trigger is `custom_schedule`, the reusable Schedule used instead of the Expectation's schedule fields.
    # @option params [Array<Integer>] schedule_days_of_week If trigger is `custom_schedule`, the 0-based weekdays used by the schedule.
    # @option params [Array<String>] schedule_times_of_day Times of day in HH:MM format for the Expectation schedule.
    # @option params [String] schedule_time_zone Time zone used by the Expectation schedule.
    # @option params [String] holiday_region Optional holiday region used by the Expectation schedule.
    # @option params [Integer] lookback_interval How many seconds before the due boundary the window starts.
    # @option params [Integer] late_acceptance_interval How many seconds a schedule-driven window may remain eligible to close as late.
    # @option params [Integer] inactivity_interval How many quiet seconds are required before final closure.
    # @option params [Integer] max_open_interval Hard-stop duration in seconds for unscheduled expectations.
    # @option params [Hash] criteria Versioned success criteria definition for the expectation, including optional Files Transform Script content validation in criteria v2.
    # @option params [Integer] workspace_id Workspace ID. `0` means the default workspace.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Expectation] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if !params[:source].nil? and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exclude_pattern must be an String") if !params[:exclude_pattern].nil? and !params[:exclude_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: disabled must be a single value, not #{params[:disabled].class}") if [ Array, Hash ].any? { |klass| params[:disabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if !params[:trigger].nil? and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if !params[:interval].nil? and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if !params[:recurring_day].nil? and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recurring_days must be an Array") if !params[:recurring_days].nil? and !params[:recurring_days].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_id must be an Integer") if !params[:schedule_id].nil? and !params[:schedule_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if !params[:schedule_days_of_week].nil? and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if !params[:schedule_times_of_day].nil? and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if !params[:schedule_time_zone].nil? and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if !params[:holiday_region].nil? and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: lookback_interval must be an Integer") if !params[:lookback_interval].nil? and !params[:lookback_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: late_acceptance_interval must be an Integer") if !params[:late_acceptance_interval].nil? and !params[:late_acceptance_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: inactivity_interval must be an Integer") if !params[:inactivity_interval].nil? and !params[:inactivity_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_open_interval must be an Integer") if !params[:max_open_interval].nil? and !params[:max_open_interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: criteria must be an Hash") if !params[:criteria].nil? and !params[:criteria].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/expectations/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("Expectation") }
      Expectation.new(response.data, options)
    end

    # Delete Expectation
    #
    # @param id [Integer] Expectation ID.
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

      Api.send_request("/expectations/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
