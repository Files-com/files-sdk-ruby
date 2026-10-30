# frozen_string_literal: true

module Files
  # Files::Schedule is the Ruby SDK's representation of Files.com API Schedule objects.
  # Each instance keeps its API field values in +attributes+.
  class Schedule
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

    # Schedule ID.
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

    # Schedule name.
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

    # 0-based weekdays used by the Schedule. 0 is Sunday.
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

    # Times of day in HH:MM format (24-hour).
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

    # Time zone for scheduled times. If not set, times are interpreted as UTC.
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

    # Optional holiday region on which linked resources do not run.
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

    # Human-readable Schedule description.
    # @return [String, nil] the field value, or nil when absent.
    def human_readable_schedule
      @attributes[:human_readable_schedule]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def human_readable_schedule=(value)
      @attributes[:human_readable_schedule] = value
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

    # Update Schedule
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Schedule name.
    # @option params [Array<Integer>] schedule_days_of_week 0-based weekdays used by the Schedule. 0 is Sunday.
    # @option params [Array<String>] schedule_times_of_day Times of day in HH:MM format (24-hour).
    # @option params [String] schedule_time_zone Time zone for scheduled times. If not set, times are interpreted as UTC.
    # @option params [String] holiday_region Optional holiday region on which linked resources do not run.
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
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if !params[:schedule_days_of_week].nil? and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if !params[:schedule_times_of_day].nil? and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if !params[:schedule_time_zone].nil? and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if !params[:holiday_region].nil? and !params[:holiday_region].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/schedules/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("Schedule") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Schedule
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

      response, options = Api.send_request("/schedules/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = Schedule.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Schedules
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `name`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)

      list_options = options.dup
      List.new(Schedule, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/schedules", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Schedule
    #
    # @param id [Integer] Schedule ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Schedule] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/schedules/#{params[:id]}", :get, params, options) { |reply| reply.require_object("Schedule") }
      Schedule.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Schedule
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Required. Schedule name.
    # @option params [Array<Integer>] schedule_days_of_week Required. 0-based weekdays used by the Schedule. 0 is Sunday.
    # @option params [Array<String>] schedule_times_of_day Required. Times of day in HH:MM format (24-hour).
    # @option params [String] schedule_time_zone Time zone for scheduled times. If not set, times are interpreted as UTC.
    # @option params [String] holiday_region Optional holiday region on which linked resources do not run.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Schedule] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if !params[:schedule_days_of_week].nil? and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if !params[:schedule_times_of_day].nil? and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if !params[:schedule_time_zone].nil? and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if !params[:holiday_region].nil? and !params[:holiday_region].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?
      raise MissingParameterError.new("Parameter missing: schedule_days_of_week") if params[:schedule_days_of_week].nil?
      raise MissingParameterError.new("Parameter missing: schedule_times_of_day") if params[:schedule_times_of_day].nil?

      response, options = Api.send_request("/schedules", :post, params, options) { |reply| reply.require_object("Schedule") }
      Schedule.new(response.data, options)
    end

    # Update Schedule
    #
    # @param id [Integer] Schedule ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Schedule name.
    # @option params [Array<Integer>] schedule_days_of_week 0-based weekdays used by the Schedule. 0 is Sunday.
    # @option params [Array<String>] schedule_times_of_day Times of day in HH:MM format (24-hour).
    # @option params [String] schedule_time_zone Time zone for scheduled times. If not set, times are interpreted as UTC.
    # @option params [String] holiday_region Optional holiday region on which linked resources do not run.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Schedule] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if !params[:schedule_days_of_week].nil? and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if !params[:schedule_times_of_day].nil? and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if !params[:schedule_time_zone].nil? and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if !params[:holiday_region].nil? and !params[:holiday_region].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/schedules/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("Schedule") }
      Schedule.new(response.data, options)
    end

    # Delete Schedule
    #
    # @param id [Integer] Schedule ID.
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

      Api.send_request("/schedules/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
