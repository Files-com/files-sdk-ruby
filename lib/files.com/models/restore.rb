# frozen_string_literal: true

module Files
  # Files::Restore is the Ruby SDK's representation of Files.com API Restore objects.
  # Each instance keeps its API field values in +attributes+.
  class Restore
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

    # Restore files or users deleted on or after this date/time. Don't set this earlier than you need. Can not be greater than 365 days prior to the restore request.
    # @return [String, nil] the field value, or nil when absent.
    def earliest_date
      @attributes[:earliest_date]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def earliest_date=(value)
      @attributes[:earliest_date] = value
    end

    # Restore Record ID.
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

    # Number of directories that were successfully restored.
    # @return [Integer, nil] the field value, or nil when absent.
    def dirs_restored
      @attributes[:dirs_restored]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def dirs_restored=(value)
      @attributes[:dirs_restored] = value
    end

    # Number of directories that were not able to be restored.
    # @return [Integer, nil] the field value, or nil when absent.
    def dirs_errored
      @attributes[:dirs_errored]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def dirs_errored=(value)
      @attributes[:dirs_errored] = value
    end

    # Total number of directories processed.
    # @return [Integer, nil] the field value, or nil when absent.
    def dirs_total
      @attributes[:dirs_total]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def dirs_total=(value)
      @attributes[:dirs_total] = value
    end

    # Number of files successfully restored.
    # @return [Integer, nil] the field value, or nil when absent.
    def files_restored
      @attributes[:files_restored]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def files_restored=(value)
      @attributes[:files_restored] = value
    end

    # Number of files that were not able to be restored.
    # @return [Integer, nil] the field value, or nil when absent.
    def files_errored
      @attributes[:files_errored]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def files_errored=(value)
      @attributes[:files_errored] = value
    end

    # Total number of files processed.
    # @return [Integer, nil] the field value, or nil when absent.
    def files_total
      @attributes[:files_total]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def files_total=(value)
      @attributes[:files_total] = value
    end

    # Prefix of the files/folders to restore, or a case-insensitive username prefix for a user restore. A trailing slash selects that folder and its contents only; without it, the prefix matches any path beginning with that text. Do not use a leading slash. To restore all deleted items of the selected restoration type within the selected site or workspace scope, specify an empty string (`''`) or omit the field.
    # @return [String, nil] the field value, or nil when absent.
    def prefix
      @attributes[:prefix]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def prefix=(value)
      @attributes[:prefix] = value
    end

    # Type of restoration to perform. `files` restores deleted filesystem items. `users` restores deleted users and associated authentication records, plus permissions when `restore_deleted_permissions=true`. A 5-minute grace period allows for batch deletion processes: associated records deleted within the 5 minutes before the user are included, even if removed independently. Records deleted earlier, or before `earliest_date`, remain deleted.
    # @return [String, nil] the field value, or nil when absent.
    def restoration_type
      @attributes[:restoration_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def restoration_type=(value)
      @attributes[:restoration_type] = value
    end

    # If true, we will restore the files in place (into their original paths). If false, we will create a new restoration folder in the root and restore files there.
    # @return [Boolean, nil] the field value, or nil when absent.
    def restore_in_place
      @attributes[:restore_in_place]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def restore_in_place=(value)
      @attributes[:restore_in_place] = value
    end

    # If true, a user restore restores permissions deleted along with the selected users, including permissions removed independently within the 5 minutes before user deletion. Permissions deleted earlier, or before `earliest_date`, remain deleted. An in-place file restore restores user and group permissions on returned folders and their subfolders that were deleted from the time of the folder's deletion through 24 hours afterward, including permissions removed independently within that window. File restores into a new folder do not restore permissions.
    # @return [Boolean, nil] the field value, or nil when absent.
    def restore_deleted_permissions
      @attributes[:restore_deleted_permissions]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def restore_deleted_permissions=(value)
      @attributes[:restore_deleted_permissions] = value
    end

    # Number of users successfully restored (only present for `restoration_type=users`).
    # @return [Integer, nil] the field value, or nil when absent.
    def users_restored
      @attributes[:users_restored]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def users_restored=(value)
      @attributes[:users_restored] = value
    end

    # Number of users that failed to restore (only present for `restoration_type=users`).
    # @return [Integer, nil] the field value, or nil when absent.
    def users_errored
      @attributes[:users_errored]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def users_errored=(value)
      @attributes[:users_errored] = value
    end

    # Total number of users processed (only present for `restoration_type=users`).
    # @return [Integer, nil] the field value, or nil when absent.
    def users_total
      @attributes[:users_total]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def users_total=(value)
      @attributes[:users_total] = value
    end

    # Number of API keys restored (only present for `restoration_type=users`).
    # @return [Integer, nil] the field value, or nil when absent.
    def api_keys_restored
      @attributes[:api_keys_restored]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def api_keys_restored=(value)
      @attributes[:api_keys_restored] = value
    end

    # Number of public keys restored (only present for `restoration_type=users`).
    # @return [Integer, nil] the field value, or nil when absent.
    def public_keys_restored
      @attributes[:public_keys_restored]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def public_keys_restored=(value)
      @attributes[:public_keys_restored] = value
    end

    # Number of two factor authentication methods restored (only present for `restoration_type=users`).
    # @return [Integer, nil] the field value, or nil when absent.
    def two_factor_authentication_methods_restored
      @attributes[:two_factor_authentication_methods_restored]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def two_factor_authentication_methods_restored=(value)
      @attributes[:two_factor_authentication_methods_restored] = value
    end

    # Status of the restoration process.
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def status=(value)
      @attributes[:status] = value
    end

    # If true, we will update the last modified timestamp of restored files to today's date. If false, we might trigger File Expiration to delete the file again.
    # @return [Boolean, nil] the field value, or nil when absent.
    def update_timestamps
      @attributes[:update_timestamps]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def update_timestamps=(value)
      @attributes[:update_timestamps] = value
    end

    # Workspace ID for a workspace-scoped restore. `0` means the default site-wide scope.
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

    # Error messages received while restoring files and/or directories. Only present if there were errors.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def error_messages
      @attributes[:error_messages]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def error_messages=(value)
      @attributes[:error_messages] = value
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    # @raise [Files::NotImplementedError] if this record already has an id; updates are unsupported.
    def save
      if @attributes[:id]
        raise NotImplementedError.new("The Restore object doesn't support updates.")
      else
        new_obj = Restore.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Restores
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `restoration_type`.
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
      List.new(Restore, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/restores", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Create Restore
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] earliest_date Required. Restore files or users deleted on or after this date/time. Don't set this earlier than you need. Can not be greater than 365 days prior to the restore request.
    # @option params [String] prefix Prefix of the files/folders to restore, or a case-insensitive username prefix for a user restore. A trailing slash selects that folder and its contents only; without it, the prefix matches any path beginning with that text. Do not use a leading slash. To restore all deleted items of the selected restoration type within the selected site or workspace scope, specify an empty string (`''`) or omit the field.
    # @option params [String] restoration_type Type of restoration to perform. `files` restores deleted filesystem items. `users` restores deleted users and associated authentication records, plus permissions when `restore_deleted_permissions=true`. A 5-minute grace period allows for batch deletion processes: associated records deleted within the 5 minutes before the user are included, even if removed independently. Records deleted earlier, or before `earliest_date`, remain deleted.
    # @option params [Boolean] restore_deleted_permissions If true, a user restore restores permissions deleted along with the selected users, including permissions removed independently within the 5 minutes before user deletion. Permissions deleted earlier, or before `earliest_date`, remain deleted. An in-place file restore restores user and group permissions on returned folders and their subfolders that were deleted from the time of the folder's deletion through 24 hours afterward, including permissions removed independently within that window. File restores into a new folder do not restore permissions.
    # @option params [Boolean] restore_in_place If true, we will restore the files in place (into their original paths). If false, we will create a new restoration folder in the root and restore files there.
    # @option params [Boolean] update_timestamps If true, we will update the last modified timestamp of restored files to today's date. If false, we might trigger File Expiration to delete the file again.
    # @option params [Integer] workspace_id Workspace ID for a workspace-scoped restore. `0` means the default site-wide scope.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Restore] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: earliest_date must be an String") if !params[:earliest_date].nil? and !params[:earliest_date].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: prefix must be an String") if !params[:prefix].nil? and !params[:prefix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: restoration_type must be an String") if !params[:restoration_type].nil? and !params[:restoration_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: restore_deleted_permissions must be a single value, not #{params[:restore_deleted_permissions].class}") if [ Array, Hash ].any? { |klass| params[:restore_deleted_permissions].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: restore_in_place must be a single value, not #{params[:restore_in_place].class}") if [ Array, Hash ].any? { |klass| params[:restore_in_place].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: update_timestamps must be a single value, not #{params[:update_timestamps].class}") if [ Array, Hash ].any? { |klass| params[:update_timestamps].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: earliest_date") if params[:earliest_date].nil?

      response, options = Api.send_request("/restores", :post, params, options) { |reply| reply.require_object("Restore") }
      Restore.new(response.data, options)
    end
  end
end
