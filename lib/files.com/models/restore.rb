# frozen_string_literal: true

module Files
  # Files::Restore is the Ruby SDK's representation of Files.com API Restore objects.
  # Each instance keeps its API field values in +attributes+.
  class Restore
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # date-time - Restore files or users deleted on or after this date/time. Don't set this earlier than you need. Can not be greater than 365 days prior to the restore request.
    def earliest_date
      @attributes[:earliest_date]
    end

    def earliest_date=(value)
      @attributes[:earliest_date] = value
    end

    # int64 - Restore Record ID.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Number of directories that were successfully restored.
    def dirs_restored
      @attributes[:dirs_restored]
    end

    def dirs_restored=(value)
      @attributes[:dirs_restored] = value
    end

    # int64 - Number of directories that were not able to be restored.
    def dirs_errored
      @attributes[:dirs_errored]
    end

    def dirs_errored=(value)
      @attributes[:dirs_errored] = value
    end

    # int64 - Total number of directories processed.
    def dirs_total
      @attributes[:dirs_total]
    end

    def dirs_total=(value)
      @attributes[:dirs_total] = value
    end

    # int64 - Number of files successfully restored.
    def files_restored
      @attributes[:files_restored]
    end

    def files_restored=(value)
      @attributes[:files_restored] = value
    end

    # int64 - Number of files that were not able to be restored.
    def files_errored
      @attributes[:files_errored]
    end

    def files_errored=(value)
      @attributes[:files_errored] = value
    end

    # int64 - Total number of files processed.
    def files_total
      @attributes[:files_total]
    end

    def files_total=(value)
      @attributes[:files_total] = value
    end

    # string - Prefix of the files/folders to restore, or a case-insensitive username prefix for a user restore. A trailing slash selects that folder and its contents only; without it, the prefix matches any path beginning with that text. Do not use a leading slash. To restore all deleted items of the selected restoration type within the selected site or workspace scope, specify an empty string (`''`) or omit the field.
    def prefix
      @attributes[:prefix]
    end

    def prefix=(value)
      @attributes[:prefix] = value
    end

    # string - Type of restoration to perform. `files` restores deleted filesystem items. `users` restores deleted users and associated authentication records, plus permissions when `restore_deleted_permissions=true`. A 5-minute grace period allows for batch deletion processes: associated records deleted within the 5 minutes before the user are included, even if removed independently. Records deleted earlier, or before `earliest_date`, remain deleted.
    def restoration_type
      @attributes[:restoration_type]
    end

    def restoration_type=(value)
      @attributes[:restoration_type] = value
    end

    # boolean - If true, we will restore the files in place (into their original paths). If false, we will create a new restoration folder in the root and restore files there.
    def restore_in_place
      @attributes[:restore_in_place]
    end

    def restore_in_place=(value)
      @attributes[:restore_in_place] = value
    end

    # boolean - If true, a user restore restores permissions deleted along with the selected users, including permissions removed independently within the 5 minutes before user deletion. Permissions deleted earlier, or before `earliest_date`, remain deleted. An in-place file restore restores user and group permissions on returned folders and their subfolders that were deleted from the time of the folder's deletion through 24 hours afterward, including permissions removed independently within that window. File restores into a new folder do not restore permissions.
    def restore_deleted_permissions
      @attributes[:restore_deleted_permissions]
    end

    def restore_deleted_permissions=(value)
      @attributes[:restore_deleted_permissions] = value
    end

    # int64 - Number of users successfully restored (only present for `restoration_type=users`).
    def users_restored
      @attributes[:users_restored]
    end

    def users_restored=(value)
      @attributes[:users_restored] = value
    end

    # int64 - Number of users that failed to restore (only present for `restoration_type=users`).
    def users_errored
      @attributes[:users_errored]
    end

    def users_errored=(value)
      @attributes[:users_errored] = value
    end

    # int64 - Total number of users processed (only present for `restoration_type=users`).
    def users_total
      @attributes[:users_total]
    end

    def users_total=(value)
      @attributes[:users_total] = value
    end

    # int64 - Number of API keys restored (only present for `restoration_type=users`).
    def api_keys_restored
      @attributes[:api_keys_restored]
    end

    def api_keys_restored=(value)
      @attributes[:api_keys_restored] = value
    end

    # int64 - Number of public keys restored (only present for `restoration_type=users`).
    def public_keys_restored
      @attributes[:public_keys_restored]
    end

    def public_keys_restored=(value)
      @attributes[:public_keys_restored] = value
    end

    # int64 - Number of two factor authentication methods restored (only present for `restoration_type=users`).
    def two_factor_authentication_methods_restored
      @attributes[:two_factor_authentication_methods_restored]
    end

    def two_factor_authentication_methods_restored=(value)
      @attributes[:two_factor_authentication_methods_restored] = value
    end

    # string - Status of the restoration process.
    def status
      @attributes[:status]
    end

    def status=(value)
      @attributes[:status] = value
    end

    # boolean - If true, we will update the last modified timestamp of restored files to today's date. If false, we might trigger File Expiration to delete the file again.
    def update_timestamps
      @attributes[:update_timestamps]
    end

    def update_timestamps=(value)
      @attributes[:update_timestamps] = value
    end

    # int64 - Workspace ID for a workspace-scoped restore. `0` means the default site-wide scope.
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # array(string) - Error messages received while restoring files and/or directories. Only present if there were errors.
    def error_messages
      @attributes[:error_messages]
    end

    def error_messages=(value)
      @attributes[:error_messages] = value
    end

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

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `restoration_type`.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::Restore objects.
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

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   earliest_date (required) - string - Restore files or users deleted on or after this date/time. Don't set this earlier than you need. Can not be greater than 365 days prior to the restore request.
    #   prefix - string - Prefix of the files/folders to restore, or a case-insensitive username prefix for a user restore. A trailing slash selects that folder and its contents only; without it, the prefix matches any path beginning with that text. Do not use a leading slash. To restore all deleted items of the selected restoration type within the selected site or workspace scope, specify an empty string (`''`) or omit the field.
    #   restoration_type - string - Type of restoration to perform. `files` restores deleted filesystem items. `users` restores deleted users and associated authentication records, plus permissions when `restore_deleted_permissions=true`. A 5-minute grace period allows for batch deletion processes: associated records deleted within the 5 minutes before the user are included, even if removed independently. Records deleted earlier, or before `earliest_date`, remain deleted.
    #   restore_deleted_permissions - boolean - If true, a user restore restores permissions deleted along with the selected users, including permissions removed independently within the 5 minutes before user deletion. Permissions deleted earlier, or before `earliest_date`, remain deleted. An in-place file restore restores user and group permissions on returned folders and their subfolders that were deleted from the time of the folder's deletion through 24 hours afterward, including permissions removed independently within that window. File restores into a new folder do not restore permissions.
    #   restore_in_place - boolean - If true, we will restore the files in place (into their original paths). If false, we will create a new restoration folder in the root and restore files there.
    #   update_timestamps - boolean - If true, we will update the last modified timestamp of restored files to today's date. If false, we might trigger File Expiration to delete the file again.
    #   workspace_id - int64 - Workspace ID for a workspace-scoped restore. `0` means the default site-wide scope.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::Restore.
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
