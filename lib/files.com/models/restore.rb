# frozen_string_literal: true

module Files
  class Restore
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # date-time - Restore all files deleted after this date/time. Don't set this earlier than you need. Can not be greater than 365 days prior to the restore request.
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

    # string - Prefix of the files/folders to restore. To restore a folder, add a trailing slash to the folder name. Do not use a leading slash. To restore all deleted items, specify an empty string (`''`) in the prefix field or omit the field from the request.
    def prefix
      @attributes[:prefix]
    end

    def prefix=(value)
      @attributes[:prefix] = value
    end

    # string - Type of restoration to perform. `files` restores deleted filesystem items. `users` restores deleted users and associated access/authentication records.
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

    # boolean - If true, we will also restore any Permissions that match the same path prefix from the same dates.
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

      List.new(Restore, params) do
        Api.send_request("/restores", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   earliest_date (required) - string - Restore all files deleted after this date/time. Don't set this earlier than you need. Can not be greater than 365 days prior to the restore request.
    #   prefix - string - Prefix of the files/folders to restore. To restore a folder, add a trailing slash to the folder name. Do not use a leading slash. To restore all deleted items, specify an empty string (`''`) in the prefix field or omit the field from the request.
    #   restoration_type - string - Type of restoration to perform. `files` restores deleted filesystem items. `users` restores deleted users and associated access/authentication records.
    #   restore_deleted_permissions - boolean - If true, we will also restore any Permissions that match the same path prefix from the same dates.
    #   restore_in_place - boolean - If true, we will restore the files in place (into their original paths). If false, we will create a new restoration folder in the root and restore files there.
    #   update_timestamps - boolean - If true, we will update the last modified timestamp of restored files to today's date. If false, we might trigger File Expiration to delete the file again.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: earliest_date must be an String") if params[:earliest_date] and !params[:earliest_date].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: prefix must be an String") if params[:prefix] and !params[:prefix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: restoration_type must be an String") if params[:restoration_type] and !params[:restoration_type].is_a?(String)
      raise MissingParameterError.new("Parameter missing: earliest_date") unless params[:earliest_date]

      response, options = Api.send_request("/restores", :post, params, options)
      Restore.new(response.data, options)
    end
  end
end
