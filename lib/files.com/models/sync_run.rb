# frozen_string_literal: true

module Files
  # Files::SyncRun is the Ruby SDK's representation of Files.com API SyncRun objects.
  # Each instance keeps its API field values in +attributes+.
  class SyncRun
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

    # SyncRun ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Log or summary body for this run
    # @return [String, nil] the field value, or nil when absent.
    def body
      @attributes[:body]
    end

    # Total bytes synced in this run
    # @return [Integer, nil] the field value, or nil when absent.
    def bytes_synced
      @attributes[:bytes_synced]
    end

    # Number of files compared
    # @return [Integer, nil] the field value, or nil when absent.
    def compared_files
      @attributes[:compared_files]
    end

    # Number of folders compared
    # @return [Integer, nil] the field value, or nil when absent.
    def compared_folders
      @attributes[:compared_folders]
    end

    # When this run was completed
    # @return [String, nil] the field value, or nil when absent.
    def completed_at
      @attributes[:completed_at]
    end

    # When this run was created
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Destination remote server type, if any
    # @return [String, nil] the field value, or nil when absent.
    def dest_remote_server_type
      @attributes[:dest_remote_server_type]
    end

    # Whether this run was a dry run (no actual changes made)
    # @return [Boolean, nil] the field value, or nil when absent.
    def dry_run
      @attributes[:dry_run]
    end

    # Number of files that errored
    # @return [Integer, nil] the field value, or nil when absent.
    def errored_files
      @attributes[:errored_files]
    end

    # Estimated bytes count for this run
    # @return [Integer, nil] the field value, or nil when absent.
    def estimated_bytes_count
      @attributes[:estimated_bytes_count]
    end

    # Array of errors encountered during the run
    # @return [Array<String>, nil] the field value, or nil when absent.
    def event_errors
      @attributes[:event_errors]
    end

    # Link to external log file.
    # @return [String, nil] the field value, or nil when absent.
    def log_url
      @attributes[:log_url]
    end

    # Total runtime in seconds
    # @return [Float, nil] the field value, or nil when absent.
    def runtime
      @attributes[:runtime]
    end

    # Site ID
    # @return [Integer, nil] the field value, or nil when absent.
    def site_id
      @attributes[:site_id]
    end

    # Workspace ID
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Source remote server type, if any
    # @return [String, nil] the field value, or nil when absent.
    def src_remote_server_type
      @attributes[:src_remote_server_type]
    end

    # Status of the sync run (success, failure, partial_failure, in_progress, skipped)
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Number of files successfully synced
    # @return [Integer, nil] the field value, or nil when absent.
    def successful_files
      @attributes[:successful_files]
    end

    # ID of the Sync this run belongs to
    # @return [Integer, nil] the field value, or nil when absent.
    def sync_id
      @attributes[:sync_id]
    end

    # Name of the Sync this run belongs to
    # @return [String, nil] the field value, or nil when absent.
    def sync_name
      @attributes[:sync_name]
    end

    # When this run was last updated
    # @return [String, nil] the field value, or nil when absent.
    def updated_at
      @attributes[:updated_at]
    end

    # Array of in-progress file transfers with progress data. Only present when the sync run status is in_progress.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def live_transfers
      @attributes[:live_transfers]
    end

    # List Sync Runs
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `site_id`, `workspace_id`, `sync_id`, `created_at` or `status`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at`, `status`, `dry_run`, `workspace_id`, `src_remote_server_type`, `dest_remote_server_type` or `sync_id`. Valid field combinations are `[ status, created_at ]`, `[ workspace_id, created_at ]`, `[ src_remote_server_type, created_at ]`, `[ dest_remote_server_type, created_at ]`, `[ sync_id, created_at ]`, `[ workspace_id, status ]`, `[ src_remote_server_type, status ]`, `[ dest_remote_server_type, status ]`, `[ sync_id, status ]`, `[ workspace_id, src_remote_server_type ]`, `[ workspace_id, dest_remote_server_type ]`, `[ workspace_id, sync_id ]`, `[ workspace_id, status, created_at ]`, `[ src_remote_server_type, status, created_at ]`, `[ dest_remote_server_type, status, created_at ]`, `[ sync_id, status, created_at ]`, `[ workspace_id, src_remote_server_type, created_at ]`, `[ workspace_id, dest_remote_server_type, created_at ]`, `[ workspace_id, sync_id, created_at ]`, `[ workspace_id, src_remote_server_type, status ]`, `[ workspace_id, dest_remote_server_type, status ]`, `[ workspace_id, sync_id, status ]`, `[ workspace_id, src_remote_server_type, status, created_at ]`, `[ workspace_id, dest_remote_server_type, status, created_at ]` or `[ workspace_id, sync_id, status, created_at ]`.
    # @option params [Hash] filter_gt If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_gteq If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_lt If set, return records where the specified field is less than the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_lteq If set, return records where the specified field is less than or equal the supplied value. Valid fields are `created_at`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if !params[:filter_gt].nil? and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if !params[:filter_gteq].nil? and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if !params[:filter_lt].nil? and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if !params[:filter_lteq].nil? and !params[:filter_lteq].is_a?(Hash)

      list_options = options.dup
      List.new(SyncRun, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/sync_runs", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Sync Run
    #
    # @param id [Integer] Sync Run ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::SyncRun] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/sync_runs/#{params[:id]}", :get, params, options) { |reply| reply.require_object("SyncRun") }
      SyncRun.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
