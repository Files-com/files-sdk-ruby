# frozen_string_literal: true

module Files
  class SyncRun
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - SyncRun ID
    def id
      @attributes[:id]
    end

    # int64 - ID of the Sync this run belongs to
    def sync_id
      @attributes[:sync_id]
    end

    # int64 - Site ID
    def site_id
      @attributes[:site_id]
    end

    # string - Status of the sync run (success, failure, partial_failure, in_progress, skipped)
    def status
      @attributes[:status]
    end

    # string - Type of remote server used, if any
    def remote_server_type
      @attributes[:remote_server_type]
    end

    # string - Log or summary body for this run
    def body
      @attributes[:body]
    end

    # array(string) - Array of errors encountered during the run
    def event_errors
      @attributes[:event_errors]
    end

    # int64 - Total bytes synced in this run
    def bytes_synced
      @attributes[:bytes_synced]
    end

    # int64 - Number of files compared
    def compared_files
      @attributes[:compared_files]
    end

    # int64 - Number of folders compared
    def compared_folders
      @attributes[:compared_folders]
    end

    # int64 - Number of files that errored
    def errored_files
      @attributes[:errored_files]
    end

    # int64 - Number of files successfully synced
    def successful_files
      @attributes[:successful_files]
    end

    # double - Total runtime in seconds
    def runtime
      @attributes[:runtime]
    end

    # string - S3 path to the main log file
    def s3_body_path
      @attributes[:s3_body_path]
    end

    # string - S3 path to the internal log file
    def s3_internal_body_path
      @attributes[:s3_internal_body_path]
    end

    # date-time - When this run was completed
    def completed_at
      @attributes[:completed_at]
    end

    # boolean - Whether notifications were sent for this run
    def notified
      @attributes[:notified]
    end

    # date-time - When this run was created
    def created_at
      @attributes[:created_at]
    end

    # date-time - When this run was last updated
    def updated_at
      @attributes[:updated_at]
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `sync_id`, `created_at` or `status`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `status` and `sync_id`. Valid field combinations are `[ sync_id, status ]`.
    #   sync_id (required) - int64 - ID of the Sync this run belongs to
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: sync_id must be an Integer") if params[:sync_id] and !params[:sync_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: sync_id") unless params[:sync_id]

      List.new(SyncRun, params) do
        Api.send_request("/sync_runs", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Sync Run ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/sync_runs/#{params[:id]}", :get, params, options)
      SyncRun.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
