# frozen_string_literal: true

module Files
  # Files::Automation is the Ruby SDK's representation of Files.com API Automation objects.
  # Each instance keeps its API field values in +attributes+.
  class Automation
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

    # Automation ID
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

    # Workspace ID
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

    # Ordinarily, we will allow automation runs to run in parallel for non-scheduled automations. If this flag is `true` we will force automation runs to be serialized (run one at a time, one after another). This can resolve some issues with race conditions on remote systems at the cost of some performance.
    # @return [Boolean, nil] the field value, or nil when absent.
    def always_serialize_jobs
      @attributes[:always_serialize_jobs]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def always_serialize_jobs=(value)
      @attributes[:always_serialize_jobs] = value
    end

    # Ordinarily, files with identical size in the source and destination will be skipped from copy operations to prevent wasted transfer.  If this flag is `true` we will overwrite the destination file always.  Note that this may cause large amounts of wasted transfer usage.  This setting has no effect unless `overwrite_files` is also set to `true`.
    # @return [Boolean, nil] the field value, or nil when absent.
    def always_overwrite_size_matching_files
      @attributes[:always_overwrite_size_matching_files]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def always_overwrite_size_matching_files=(value)
      @attributes[:always_overwrite_size_matching_files] = value
    end

    # Automation type
    # @return [String, nil] the field value, or nil when absent.
    def automation
      @attributes[:automation]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def automation=(value)
      @attributes[:automation] = value
    end

    # Indicates if the automation has been deleted.
    # @return [Boolean, nil] the field value, or nil when absent.
    def deleted
      @attributes[:deleted]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def deleted=(value)
      @attributes[:deleted] = value
    end

    # Description for the this Automation.
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

    # Automation v2 graph definition.
    # @return [Hash, nil] the field value, or nil when absent.
    def definition
      @attributes[:definition]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def definition=(value)
      @attributes[:definition] = value
    end

    # If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    # @return [String, nil] the field value, or nil when absent.
    def destination_replace_from
      @attributes[:destination_replace_from]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def destination_replace_from=(value)
      @attributes[:destination_replace_from] = value
    end

    # If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    # @return [String, nil] the field value, or nil when absent.
    def destination_replace_to
      @attributes[:destination_replace_to]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def destination_replace_to=(value)
      @attributes[:destination_replace_to] = value
    end

    # Destination Paths
    # @return [Array<String>, nil] the field value, or nil when absent.
    def destinations
      @attributes[:destinations]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def destinations=(value)
      @attributes[:destinations] = value
    end

    # If true, this automation will not run.
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

    # If set, this glob pattern will exclude files from the automation. Supports globs, except on remote mounts.
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

    # List of URLs to be imported and names to be used.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def import_urls
      @attributes[:import_urls]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Hash>, nil] the new field value.
    # @return [Array<Hash>, nil] the assigned value.
    def import_urls=(value)
      @attributes[:import_urls] = value
    end

    # If trigger is `email`, this is the address that triggers the Automation.
    # @return [String, nil] the field value, or nil when absent.
    def inbound_email_address
      @attributes[:inbound_email_address]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def inbound_email_address=(value)
      @attributes[:inbound_email_address] = value
    end

    # Normally copy and move automations that use globs will implicitly preserve the source folder structure in the destination.  If this flag is `true`, the source folder structure will be flattened in the destination.  This is useful for copying or moving files from multiple folders into a single destination folder.
    # @return [Boolean, nil] the field value, or nil when absent.
    def flatten_destination_structure
      @attributes[:flatten_destination_structure]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def flatten_destination_structure=(value)
      @attributes[:flatten_destination_structure] = value
    end

    # IDs of Groups for the Automation (i.e. who to Request File from)
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def group_ids
      @attributes[:group_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def group_ids=(value)
      @attributes[:group_ids] = value
    end

    # If true, the Lock Folders behavior will be disregarded for automated actions.
    # @return [Boolean, nil] the field value, or nil when absent.
    def ignore_locked_folders
      @attributes[:ignore_locked_folders]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def ignore_locked_folders=(value)
      @attributes[:ignore_locked_folders] = value
    end

    # If trigger is `daily`, this specifies how often to run this automation.  One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
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

    # Time when automation was last modified. Does not change for name or description updates.
    # @return [String, nil] the field value, or nil when absent.
    def last_modified_at
      @attributes[:last_modified_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_modified_at=(value)
      @attributes[:last_modified_at] = value
    end

    # If `true`, use the legacy behavior for this automation, where it can operate on folders in addition to just files.  This behavior no longer works and should not be used.
    # @return [Boolean, nil] the field value, or nil when absent.
    def legacy_folder_matching
      @attributes[:legacy_folder_matching]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def legacy_folder_matching=(value)
      @attributes[:legacy_folder_matching] = value
    end

    # Name for this automation.
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

    # If true, existing files will be overwritten with new files on Move/Copy automations.  Note: by default files will not be overwritten on Copy automations if they appear to be the same file size as the newly incoming file.  Use the `always_overwrite_size_matching_files` option in conjunction with `overwrite_files` to override this behavior and overwrite files no matter what.
    # @return [Boolean, nil] the field value, or nil when absent.
    def overwrite_files
      @attributes[:overwrite_files]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def overwrite_files=(value)
      @attributes[:overwrite_files] = value
    end

    # Path on which this Automation runs.  Supports globs, except on remote mounts. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
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

    # Timezone to use when rendering timestamps in paths.
    # @return [String, nil] the field value, or nil when absent.
    def path_time_zone
      @attributes[:path_time_zone]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def path_time_zone=(value)
      @attributes[:path_time_zone] = value
    end

    # Current Automation v2 definition version.
    # @return [Integer, nil] the field value, or nil when absent.
    def version
      @attributes[:version]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def version=(value)
      @attributes[:version] = value
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

    # If trigger is `custom_schedule`, the reusable Schedule used instead of the automation's schedule fields.
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

    # If the Automation fails, retry at this interval (in minutes).  Acceptable values are 5 through 1440 (one day).  Set to null to disable.
    # @return [Integer, nil] the field value, or nil when absent.
    def retry_on_failure_interval_in_minutes
      @attributes[:retry_on_failure_interval_in_minutes]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def retry_on_failure_interval_in_minutes=(value)
      @attributes[:retry_on_failure_interval_in_minutes] = value
    end

    # If the Automation fails, retry at most this many times.  Maximum allowed value: 10.  Set to null to disable.
    # @return [Integer, nil] the field value, or nil when absent.
    def retry_on_failure_number_of_attempts
      @attributes[:retry_on_failure_number_of_attempts]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def retry_on_failure_number_of_attempts=(value)
      @attributes[:retry_on_failure_number_of_attempts] = value
    end

    # If trigger is `custom_schedule`, Custom schedule description for when the automation should be run in json format.
    # @return [Hash, nil] the field value, or nil when absent.
    def schedule
      @attributes[:schedule]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def schedule=(value)
      @attributes[:schedule] = value
    end

    # If trigger is `custom_schedule` or `daily` with times, Human readable schedule description for when the automation should be run.
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

    # If trigger is `custom_schedule`, Custom schedule description for when the automation should be run. 0 is Sunday, 1 is Monday, etc.
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

    # Times of day to run in HH:MM format (24-hour). For `custom_schedule`, run at these times on specified days of week. For `daily`, run at these times on the scheduled interval date.
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

    # Source path/glob.  See Automation docs for exact description, but this is used to filter for files in the `path` to find files to operate on. Supports globs, except on remote mounts.
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

    # IDs of Syncs to run by this Automation.
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def sync_ids
      @attributes[:sync_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def sync_ids=(value)
      @attributes[:sync_ids] = value
    end

    # If trigger is `action`, this is the list of action types on which to trigger the automation. Valid actions are create, copy, move, archived_delete, update, read, destroy
    # @return [Array<String>, nil] the field value, or nil when absent.
    def trigger_actions
      @attributes[:trigger_actions]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def trigger_actions=(value)
      @attributes[:trigger_actions] = value
    end

    # How this automation is triggered to run.
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

    # User ID of the Automation's creator.
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

    # IDs of Users for the Automation (i.e. who to Request File from)
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def user_ids
      @attributes[:user_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def user_ids=(value)
      @attributes[:user_ids] = value
    end

    # A Hash of attributes specific to the automation type.
    # @return [Hash, nil] the field value, or nil when absent.
    def value
      @attributes[:value]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def value=(value)
      @attributes[:value] = value
    end

    # If trigger is `webhook`, this is the URL of the webhook to trigger the Automation.
    # @return [String, nil] the field value, or nil when absent.
    def webhook_url
      @attributes[:webhook_url]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def webhook_url=(value)
      @attributes[:webhook_url] = value
    end

    # Skip the automation if there is a formal, observed holiday for this region.
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

    # Upgrade a legacy Automation to Automation v2
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def upgrade(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/automations/#{@attributes[:id]}/upgrade", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Manually Run Automation
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Array<Hash>] items Initial items for a v2 manual trigger. Each item contains exactly one `file` path or `data` object.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def manual_run(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: items must be an Array") if !params[:items].nil? and !params[:items].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/automations/#{@attributes[:id]}/manual_run", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Update Automation
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] source Source path/glob.  See Automation docs for exact description, but this is used to filter for files in the `path` to find files to operate on. Supports globs, except on remote mounts.
    # @option params [Array<String>] destinations A list of destination paths. Use a trailing slash for folder destinations and omit it for file destinations.
    # @option params [String] destination_replace_from If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    # @option params [String] destination_replace_to If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    # @option params [String] interval How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    # @option params [String] path Path on which this Automation runs.  Supports globs, except on remote mounts.
    # @option params [String] sync_ids A list of sync IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    # @option params [String] user_ids A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    # @option params [String] group_ids A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    # @option params [Integer] schedule_id If trigger is `custom_schedule`, the reusable Schedule used instead of the automation's schedule fields.
    # @option params [Array<Integer>] schedule_days_of_week If trigger is `custom_schedule` without `schedule_id`, a list of days of the week to run this automation. 0 is Sunday, 1 is Monday, etc.
    # @option params [Array<String>] schedule_times_of_day Times of day to run in HH:MM format (24-hour). Required for `custom_schedule` without `schedule_id`. Optional for `daily` triggers; if not set, runs at midnight UTC.
    # @option params [String] schedule_time_zone Time zone for schedule fields. Optional for `custom_schedule` without `schedule_id` and for `daily`. If not set, times are interpreted as UTC.
    # @option params [String] holiday_region Skip automation on holidays in this region. Optional for `custom_schedule` without `schedule_id` and for `daily`.
    # @option params [Boolean] always_overwrite_size_matching_files Ordinarily, files with identical size in the source and destination will be skipped from copy operations to prevent wasted transfer.  If this flag is `true` we will overwrite the destination file always.  Note that this may cause large amounts of wasted transfer usage.  This setting has no effect unless `overwrite_files` is also set to `true`.
    # @option params [Boolean] always_serialize_jobs Ordinarily, we will allow automation runs to run in parallel for non-scheduled automations. If this flag is `true` we will force automation runs to be serialized (run one at a time, one after another). This can resolve some issues with race conditions on remote systems at the cost of some performance.
    # @option params [String] description Description for the this Automation.
    # @option params [Hash] definition Automation v2 graph definition.
    # @option params [Boolean] disabled If true, this automation will not run.
    # @option params [String] exclude_pattern If set, this glob pattern will exclude files from the automation. Supports globs, except on remote mounts.
    # @option params [Array<Hash>] import_urls List of URLs to be imported and names to be used.
    # @option params [Boolean] flatten_destination_structure Normally copy and move automations that use globs will implicitly preserve the source folder structure in the destination.  If this flag is `true`, the source folder structure will be flattened in the destination.  This is useful for copying or moving files from multiple folders into a single destination folder.
    # @option params [Boolean] ignore_locked_folders If true, the Lock Folders behavior will be disregarded for automated actions.
    # @option params [Boolean] legacy_folder_matching DEPRECATED: If `true`, use the legacy behavior for this automation, where it can operate on folders in addition to just files.  This behavior no longer works and should not be used.
    # @option params [String] name Name for this automation.
    # @option params [Boolean] overwrite_files If true, existing files will be overwritten with new files on Move/Copy automations.  Note: by default files will not be overwritten on Copy automations if they appear to be the same file size as the newly incoming file.  Use the `always_overwrite_size_matching_files` option in conjunction with `overwrite_files` to override this behavior and overwrite files no matter what.
    # @option params [String] path_time_zone Timezone to use when rendering timestamps in paths.
    # @option params [Integer] retry_on_failure_interval_in_minutes If the Automation fails, retry at this interval (in minutes).  Acceptable values are 5 through 1440 (one day).  Set to null to disable.
    # @option params [Integer] retry_on_failure_number_of_attempts If the Automation fails, retry at most this many times.  Maximum allowed value: 10.  Set to null to disable.
    # @option params [String] trigger How this automation is triggered to run.
    # @option params [Array<String>] trigger_actions If trigger is `action`, this is the list of action types on which to trigger the automation. Valid actions are create, copy, move, archived_delete, update, read, destroy
    # @option params [Hash] value A Hash of attributes specific to the automation type.
    # @option params [Integer] recurring_day If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @option params [Array<Integer>] recurring_days If trigger type is `daily`, this specifies one or more day numbers to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @option params [String] automation Automation type
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if !params[:source].nil? and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destinations must be an Array") if !params[:destinations].nil? and !params[:destinations].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: destination_replace_from must be an String") if !params[:destination_replace_from].nil? and !params[:destination_replace_from].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_to must be an String") if !params[:destination_replace_to].nil? and !params[:destination_replace_to].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if !params[:interval].nil? and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sync_ids must be an String") if !params[:sync_ids].nil? and !params[:sync_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if !params[:user_ids].nil? and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if !params[:group_ids].nil? and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_id must be an Integer") if !params[:schedule_id].nil? and !params[:schedule_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if !params[:schedule_days_of_week].nil? and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if !params[:schedule_times_of_day].nil? and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if !params[:schedule_time_zone].nil? and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if !params[:holiday_region].nil? and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: always_overwrite_size_matching_files must be a single value, not #{params[:always_overwrite_size_matching_files].class}") if [ Array, Hash ].any? { |klass| params[:always_overwrite_size_matching_files].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: always_serialize_jobs must be a single value, not #{params[:always_serialize_jobs].class}") if [ Array, Hash ].any? { |klass| params[:always_serialize_jobs].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: definition must be an Hash") if !params[:definition].nil? and !params[:definition].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: disabled must be a single value, not #{params[:disabled].class}") if [ Array, Hash ].any? { |klass| params[:disabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: exclude_pattern must be an String") if !params[:exclude_pattern].nil? and !params[:exclude_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: import_urls must be an Array") if !params[:import_urls].nil? and !params[:import_urls].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: flatten_destination_structure must be a single value, not #{params[:flatten_destination_structure].class}") if [ Array, Hash ].any? { |klass| params[:flatten_destination_structure].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ignore_locked_folders must be a single value, not #{params[:ignore_locked_folders].class}") if [ Array, Hash ].any? { |klass| params[:ignore_locked_folders].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: legacy_folder_matching must be a single value, not #{params[:legacy_folder_matching].class}") if [ Array, Hash ].any? { |klass| params[:legacy_folder_matching].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: overwrite_files must be a single value, not #{params[:overwrite_files].class}") if [ Array, Hash ].any? { |klass| params[:overwrite_files].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: path_time_zone must be an String") if !params[:path_time_zone].nil? and !params[:path_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: retry_on_failure_interval_in_minutes must be an Integer") if !params[:retry_on_failure_interval_in_minutes].nil? and !params[:retry_on_failure_interval_in_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: retry_on_failure_number_of_attempts must be an Integer") if !params[:retry_on_failure_number_of_attempts].nil? and !params[:retry_on_failure_number_of_attempts].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if !params[:trigger].nil? and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_actions must be an Array") if !params[:trigger_actions].nil? and !params[:trigger_actions].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if !params[:value].nil? and !params[:value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if !params[:recurring_day].nil? and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recurring_days must be an Array") if !params[:recurring_days].nil? and !params[:recurring_days].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if !params[:automation].nil? and !params[:automation].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/automations/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("Automation") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Automation
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

      response, options = Api.send_request("/automations/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = Automation.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Automations
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `name`, `automation`, `last_modified_at` or `disabled`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `disabled`, `last_modified_at`, `workspace_id` or `automation`. Valid field combinations are `[ disabled, last_modified_at ]`, `[ workspace_id, disabled ]`, `[ disabled, automation ]`, `[ workspace_id, last_modified_at ]`, `[ automation, last_modified_at ]`, `[ workspace_id, automation ]`, `[ workspace_id, disabled, last_modified_at ]`, `[ disabled, automation, last_modified_at ]`, `[ workspace_id, disabled, automation ]`, `[ workspace_id, automation, last_modified_at ]` or `[ workspace_id, disabled, automation, last_modified_at ]`.
    # @option params [Hash] filter_gt If set, return records where the specified field is greater than the supplied value. Valid fields are `last_modified_at`.
    # @option params [Hash] filter_gteq If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `last_modified_at`.
    # @option params [Hash] filter_lt If set, return records where the specified field is less than the supplied value. Valid fields are `last_modified_at`.
    # @option params [Hash] filter_lteq If set, return records where the specified field is less than or equal the supplied value. Valid fields are `last_modified_at`.
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
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if !params[:filter_gt].nil? and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if !params[:filter_gteq].nil? and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if !params[:filter_lt].nil? and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if !params[:filter_lteq].nil? and !params[:filter_lteq].is_a?(Hash)

      list_options = options.dup
      List.new(Automation, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/automations", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Automation
    #
    # @param id [Integer] Automation ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Automation] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/automations/#{params[:id]}", :get, params, options) { |reply| reply.require_object("Automation") }
      Automation.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Show the Automation v2 authoring schema and active node catalog
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AutomationAuthoringSchema] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.get_authoring_schema(params = {}, options = {})
      response, options = Api.send_request("/automations/authoring_schema", :get, params, options) { |reply| reply.require_object("AutomationAuthoringSchema") }
      AutomationAuthoringSchema.new(response.data, options)
    end

    # Create Automation
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] source Source path/glob.  See Automation docs for exact description, but this is used to filter for files in the `path` to find files to operate on. Supports globs, except on remote mounts.
    # @option params [Array<String>] destinations A list of destination paths. Use a trailing slash for folder destinations and omit it for file destinations.
    # @option params [String] destination_replace_from If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    # @option params [String] destination_replace_to If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    # @option params [String] interval How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    # @option params [String] path Path on which this Automation runs.  Supports globs, except on remote mounts.
    # @option params [String] sync_ids A list of sync IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    # @option params [String] user_ids A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    # @option params [String] group_ids A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    # @option params [Integer] schedule_id If trigger is `custom_schedule`, the reusable Schedule used instead of the automation's schedule fields.
    # @option params [Array<Integer>] schedule_days_of_week If trigger is `custom_schedule` without `schedule_id`, a list of days of the week to run this automation. 0 is Sunday, 1 is Monday, etc.
    # @option params [Array<String>] schedule_times_of_day Times of day to run in HH:MM format (24-hour). Required for `custom_schedule` without `schedule_id`. Optional for `daily` triggers; if not set, runs at midnight UTC.
    # @option params [String] schedule_time_zone Time zone for schedule fields. Optional for `custom_schedule` without `schedule_id` and for `daily`. If not set, times are interpreted as UTC.
    # @option params [String] holiday_region Skip automation on holidays in this region. Optional for `custom_schedule` without `schedule_id` and for `daily`.
    # @option params [Boolean] always_overwrite_size_matching_files Ordinarily, files with identical size in the source and destination will be skipped from copy operations to prevent wasted transfer.  If this flag is `true` we will overwrite the destination file always.  Note that this may cause large amounts of wasted transfer usage.  This setting has no effect unless `overwrite_files` is also set to `true`.
    # @option params [Boolean] always_serialize_jobs Ordinarily, we will allow automation runs to run in parallel for non-scheduled automations. If this flag is `true` we will force automation runs to be serialized (run one at a time, one after another). This can resolve some issues with race conditions on remote systems at the cost of some performance.
    # @option params [String] description Description for the this Automation.
    # @option params [Hash] definition Automation v2 graph definition.
    # @option params [Boolean] disabled If true, this automation will not run.
    # @option params [String] exclude_pattern If set, this glob pattern will exclude files from the automation. Supports globs, except on remote mounts.
    # @option params [Array<Hash>] import_urls List of URLs to be imported and names to be used.
    # @option params [Boolean] flatten_destination_structure Normally copy and move automations that use globs will implicitly preserve the source folder structure in the destination.  If this flag is `true`, the source folder structure will be flattened in the destination.  This is useful for copying or moving files from multiple folders into a single destination folder.
    # @option params [Boolean] ignore_locked_folders If true, the Lock Folders behavior will be disregarded for automated actions.
    # @option params [Boolean] legacy_folder_matching DEPRECATED: If `true`, use the legacy behavior for this automation, where it can operate on folders in addition to just files.  This behavior no longer works and should not be used.
    # @option params [String] name Name for this automation.
    # @option params [Boolean] overwrite_files If true, existing files will be overwritten with new files on Move/Copy automations.  Note: by default files will not be overwritten on Copy automations if they appear to be the same file size as the newly incoming file.  Use the `always_overwrite_size_matching_files` option in conjunction with `overwrite_files` to override this behavior and overwrite files no matter what.
    # @option params [String] path_time_zone Timezone to use when rendering timestamps in paths.
    # @option params [Integer] retry_on_failure_interval_in_minutes If the Automation fails, retry at this interval (in minutes).  Acceptable values are 5 through 1440 (one day).  Set to null to disable.
    # @option params [Integer] retry_on_failure_number_of_attempts If the Automation fails, retry at most this many times.  Maximum allowed value: 10.  Set to null to disable.
    # @option params [String] trigger How this automation is triggered to run.
    # @option params [Array<String>] trigger_actions If trigger is `action`, this is the list of action types on which to trigger the automation. Valid actions are create, copy, move, archived_delete, update, read, destroy
    # @option params [Hash] value A Hash of attributes specific to the automation type.
    # @option params [Integer] recurring_day If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @option params [Array<Integer>] recurring_days If trigger type is `daily`, this specifies one or more day numbers to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @option params [String] automation Required. Automation type
    # @option params [Integer] workspace_id Workspace ID
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Automation] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: source must be an String") if !params[:source].nil? and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destinations must be an Array") if !params[:destinations].nil? and !params[:destinations].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: destination_replace_from must be an String") if !params[:destination_replace_from].nil? and !params[:destination_replace_from].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_to must be an String") if !params[:destination_replace_to].nil? and !params[:destination_replace_to].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if !params[:interval].nil? and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sync_ids must be an String") if !params[:sync_ids].nil? and !params[:sync_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if !params[:user_ids].nil? and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if !params[:group_ids].nil? and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_id must be an Integer") if !params[:schedule_id].nil? and !params[:schedule_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if !params[:schedule_days_of_week].nil? and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if !params[:schedule_times_of_day].nil? and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if !params[:schedule_time_zone].nil? and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if !params[:holiday_region].nil? and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: always_overwrite_size_matching_files must be a single value, not #{params[:always_overwrite_size_matching_files].class}") if [ Array, Hash ].any? { |klass| params[:always_overwrite_size_matching_files].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: always_serialize_jobs must be a single value, not #{params[:always_serialize_jobs].class}") if [ Array, Hash ].any? { |klass| params[:always_serialize_jobs].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: definition must be an Hash") if !params[:definition].nil? and !params[:definition].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: disabled must be a single value, not #{params[:disabled].class}") if [ Array, Hash ].any? { |klass| params[:disabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: exclude_pattern must be an String") if !params[:exclude_pattern].nil? and !params[:exclude_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: import_urls must be an Array") if !params[:import_urls].nil? and !params[:import_urls].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: flatten_destination_structure must be a single value, not #{params[:flatten_destination_structure].class}") if [ Array, Hash ].any? { |klass| params[:flatten_destination_structure].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ignore_locked_folders must be a single value, not #{params[:ignore_locked_folders].class}") if [ Array, Hash ].any? { |klass| params[:ignore_locked_folders].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: legacy_folder_matching must be a single value, not #{params[:legacy_folder_matching].class}") if [ Array, Hash ].any? { |klass| params[:legacy_folder_matching].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: overwrite_files must be a single value, not #{params[:overwrite_files].class}") if [ Array, Hash ].any? { |klass| params[:overwrite_files].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: path_time_zone must be an String") if !params[:path_time_zone].nil? and !params[:path_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: retry_on_failure_interval_in_minutes must be an Integer") if !params[:retry_on_failure_interval_in_minutes].nil? and !params[:retry_on_failure_interval_in_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: retry_on_failure_number_of_attempts must be an Integer") if !params[:retry_on_failure_number_of_attempts].nil? and !params[:retry_on_failure_number_of_attempts].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if !params[:trigger].nil? and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_actions must be an Array") if !params[:trigger_actions].nil? and !params[:trigger_actions].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if !params[:value].nil? and !params[:value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if !params[:recurring_day].nil? and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recurring_days must be an Array") if !params[:recurring_days].nil? and !params[:recurring_days].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if !params[:automation].nil? and !params[:automation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: automation") if params[:automation].nil?

      response, options = Api.send_request("/automations", :post, params, options) { |reply| reply.require_object("Automation") }
      Automation.new(response.data, options)
    end

    # Upgrade a legacy Automation to Automation v2
    #
    # @param id [Integer] Automation ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Automation] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.upgrade(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/automations/#{params[:id]}/upgrade", :post, params, options) { |reply| reply.require_object("Automation") }
      Automation.new(response.data, options)
    end

    # Manually Run Automation
    #
    # @param id [Integer] Automation ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Array<Hash>] items Initial items for a v2 manual trigger. Each item contains exactly one `file` path or `data` object.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.manual_run(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: items must be an Array") if !params[:items].nil? and !params[:items].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/automations/#{params[:id]}/manual_run", :post, params, options)
      nil
    end

    # Update Automation
    #
    # @param id [Integer] Automation ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] source Source path/glob.  See Automation docs for exact description, but this is used to filter for files in the `path` to find files to operate on. Supports globs, except on remote mounts.
    # @option params [Array<String>] destinations A list of destination paths. Use a trailing slash for folder destinations and omit it for file destinations.
    # @option params [String] destination_replace_from If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    # @option params [String] destination_replace_to If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    # @option params [String] interval How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    # @option params [String] path Path on which this Automation runs.  Supports globs, except on remote mounts.
    # @option params [String] sync_ids A list of sync IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    # @option params [String] user_ids A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    # @option params [String] group_ids A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    # @option params [Integer] schedule_id If trigger is `custom_schedule`, the reusable Schedule used instead of the automation's schedule fields.
    # @option params [Array<Integer>] schedule_days_of_week If trigger is `custom_schedule` without `schedule_id`, a list of days of the week to run this automation. 0 is Sunday, 1 is Monday, etc.
    # @option params [Array<String>] schedule_times_of_day Times of day to run in HH:MM format (24-hour). Required for `custom_schedule` without `schedule_id`. Optional for `daily` triggers; if not set, runs at midnight UTC.
    # @option params [String] schedule_time_zone Time zone for schedule fields. Optional for `custom_schedule` without `schedule_id` and for `daily`. If not set, times are interpreted as UTC.
    # @option params [String] holiday_region Skip automation on holidays in this region. Optional for `custom_schedule` without `schedule_id` and for `daily`.
    # @option params [Boolean] always_overwrite_size_matching_files Ordinarily, files with identical size in the source and destination will be skipped from copy operations to prevent wasted transfer.  If this flag is `true` we will overwrite the destination file always.  Note that this may cause large amounts of wasted transfer usage.  This setting has no effect unless `overwrite_files` is also set to `true`.
    # @option params [Boolean] always_serialize_jobs Ordinarily, we will allow automation runs to run in parallel for non-scheduled automations. If this flag is `true` we will force automation runs to be serialized (run one at a time, one after another). This can resolve some issues with race conditions on remote systems at the cost of some performance.
    # @option params [String] description Description for the this Automation.
    # @option params [Hash] definition Automation v2 graph definition.
    # @option params [Boolean] disabled If true, this automation will not run.
    # @option params [String] exclude_pattern If set, this glob pattern will exclude files from the automation. Supports globs, except on remote mounts.
    # @option params [Array<Hash>] import_urls List of URLs to be imported and names to be used.
    # @option params [Boolean] flatten_destination_structure Normally copy and move automations that use globs will implicitly preserve the source folder structure in the destination.  If this flag is `true`, the source folder structure will be flattened in the destination.  This is useful for copying or moving files from multiple folders into a single destination folder.
    # @option params [Boolean] ignore_locked_folders If true, the Lock Folders behavior will be disregarded for automated actions.
    # @option params [Boolean] legacy_folder_matching DEPRECATED: If `true`, use the legacy behavior for this automation, where it can operate on folders in addition to just files.  This behavior no longer works and should not be used.
    # @option params [String] name Name for this automation.
    # @option params [Boolean] overwrite_files If true, existing files will be overwritten with new files on Move/Copy automations.  Note: by default files will not be overwritten on Copy automations if they appear to be the same file size as the newly incoming file.  Use the `always_overwrite_size_matching_files` option in conjunction with `overwrite_files` to override this behavior and overwrite files no matter what.
    # @option params [String] path_time_zone Timezone to use when rendering timestamps in paths.
    # @option params [Integer] retry_on_failure_interval_in_minutes If the Automation fails, retry at this interval (in minutes).  Acceptable values are 5 through 1440 (one day).  Set to null to disable.
    # @option params [Integer] retry_on_failure_number_of_attempts If the Automation fails, retry at most this many times.  Maximum allowed value: 10.  Set to null to disable.
    # @option params [String] trigger How this automation is triggered to run.
    # @option params [Array<String>] trigger_actions If trigger is `action`, this is the list of action types on which to trigger the automation. Valid actions are create, copy, move, archived_delete, update, read, destroy
    # @option params [Hash] value A Hash of attributes specific to the automation type.
    # @option params [Integer] recurring_day If trigger type is `daily`, this specifies a day number to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @option params [Array<Integer>] recurring_days If trigger type is `daily`, this specifies one or more day numbers to run in one of the supported intervals: `week`, `month`, `quarter`, `year`.
    # @option params [String] automation Automation type
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Automation] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if !params[:source].nil? and !params[:source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destinations must be an Array") if !params[:destinations].nil? and !params[:destinations].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: destination_replace_from must be an String") if !params[:destination_replace_from].nil? and !params[:destination_replace_from].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_to must be an String") if !params[:destination_replace_to].nil? and !params[:destination_replace_to].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if !params[:interval].nil? and !params[:interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sync_ids must be an String") if !params[:sync_ids].nil? and !params[:sync_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if !params[:user_ids].nil? and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if !params[:group_ids].nil? and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule_id must be an Integer") if !params[:schedule_id].nil? and !params[:schedule_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: schedule_days_of_week must be an Array") if !params[:schedule_days_of_week].nil? and !params[:schedule_days_of_week].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_times_of_day must be an Array") if !params[:schedule_times_of_day].nil? and !params[:schedule_times_of_day].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: schedule_time_zone must be an String") if !params[:schedule_time_zone].nil? and !params[:schedule_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: holiday_region must be an String") if !params[:holiday_region].nil? and !params[:holiday_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: always_overwrite_size_matching_files must be a single value, not #{params[:always_overwrite_size_matching_files].class}") if [ Array, Hash ].any? { |klass| params[:always_overwrite_size_matching_files].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: always_serialize_jobs must be a single value, not #{params[:always_serialize_jobs].class}") if [ Array, Hash ].any? { |klass| params[:always_serialize_jobs].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: definition must be an Hash") if !params[:definition].nil? and !params[:definition].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: disabled must be a single value, not #{params[:disabled].class}") if [ Array, Hash ].any? { |klass| params[:disabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: exclude_pattern must be an String") if !params[:exclude_pattern].nil? and !params[:exclude_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: import_urls must be an Array") if !params[:import_urls].nil? and !params[:import_urls].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: flatten_destination_structure must be a single value, not #{params[:flatten_destination_structure].class}") if [ Array, Hash ].any? { |klass| params[:flatten_destination_structure].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ignore_locked_folders must be a single value, not #{params[:ignore_locked_folders].class}") if [ Array, Hash ].any? { |klass| params[:ignore_locked_folders].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: legacy_folder_matching must be a single value, not #{params[:legacy_folder_matching].class}") if [ Array, Hash ].any? { |klass| params[:legacy_folder_matching].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: overwrite_files must be a single value, not #{params[:overwrite_files].class}") if [ Array, Hash ].any? { |klass| params[:overwrite_files].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: path_time_zone must be an String") if !params[:path_time_zone].nil? and !params[:path_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: retry_on_failure_interval_in_minutes must be an Integer") if !params[:retry_on_failure_interval_in_minutes].nil? and !params[:retry_on_failure_interval_in_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: retry_on_failure_number_of_attempts must be an Integer") if !params[:retry_on_failure_number_of_attempts].nil? and !params[:retry_on_failure_number_of_attempts].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if !params[:trigger].nil? and !params[:trigger].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_actions must be an Array") if !params[:trigger_actions].nil? and !params[:trigger_actions].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if !params[:value].nil? and !params[:value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: recurring_day must be an Integer") if !params[:recurring_day].nil? and !params[:recurring_day].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recurring_days must be an Array") if !params[:recurring_days].nil? and !params[:recurring_days].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if !params[:automation].nil? and !params[:automation].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/automations/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("Automation") }
      Automation.new(response.data, options)
    end

    # Delete Automation
    #
    # @param id [Integer] Automation ID.
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

      Api.send_request("/automations/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
