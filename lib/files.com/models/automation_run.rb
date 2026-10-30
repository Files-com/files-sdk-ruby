# frozen_string_literal: true

module Files
  # Files::AutomationRun is the Ruby SDK's representation of Files.com API AutomationRun objects.
  # Each instance keeps its API field values in +attributes+.
  class AutomationRun
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

    # ID.
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # ID of the associated Automation.
    # @return [Integer, nil] the field value, or nil when absent.
    def automation_id
      @attributes[:automation_id]
    end

    # ID of the immutable Automation version pinned by this run.
    # @return [Integer, nil] the field value, or nil when absent.
    def automation_version_id
      @attributes[:automation_version_id]
    end

    # Pinned Automation v2 definition version.
    # @return [Integer, nil] the field value, or nil when absent.
    def version
      @attributes[:version]
    end

    # Workspace ID.
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Date/time at which cancellation was requested.
    # @return [String, nil] the field value, or nil when absent.
    def cancel_requested_at
      @attributes[:cancel_requested_at]
    end

    # Automation run completion/failure date/time.
    # @return [String, nil] the field value, or nil when absent.
    def completed_at
      @attributes[:completed_at]
    end

    # Automation run start date/time.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # If set, this automation will be retried at this date/time due to `failure` or `partial_failure`.
    # @return [String, nil] the field value, or nil when absent.
    def retry_at
      @attributes[:retry_at]
    end

    # If set, this Automation run was retried due to `failure` or `partial_failure`.
    # @return [String, nil] the field value, or nil when absent.
    def retried_at
      @attributes[:retried_at]
    end

    # ID of the run that is or will be retrying this run.
    # @return [Integer, nil] the field value, or nil when absent.
    def retried_in_run_id
      @attributes[:retried_in_run_id]
    end

    # ID of the original run that this run is retrying.
    # @return [Integer, nil] the field value, or nil when absent.
    def retry_of_run_id
      @attributes[:retry_of_run_id]
    end

    # ID of the run whose persisted node outputs this run reused.
    # @return [Integer, nil] the field value, or nil when absent.
    def rerun_of_run_id
      @attributes[:rerun_of_run_id]
    end

    # Node at which this run resumed execution.
    # @return [String, nil] the field value, or nil when absent.
    def rerun_from_node_id
      @attributes[:rerun_from_node_id]
    end

    # Automation run runtime.
    # @return [Float, nil] the field value, or nil when absent.
    def runtime
      @attributes[:runtime]
    end

    # The status of the AutomationRun. One of `queued`, `running`, `success`, `partial_failure`, `failure`, `skipped`, or `canceled`.
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Count of successful operations.
    # @return [Integer, nil] the field value, or nil when absent.
    def successful_operations
      @attributes[:successful_operations]
    end

    # Count of failed operations.
    # @return [Integer, nil] the field value, or nil when absent.
    def failed_operations
      @attributes[:failed_operations]
    end

    # Automation definition snapshot pinned by this run. For performance reasons, this is not provided when listing Automation runs.
    # @return [Hash, nil] the field value, or nil when absent.
    def definition
      @attributes[:definition]
    end

    # Status and execution stage for each node in this run. For performance reasons, this is not provided when listing Automation runs.
    # @return [Hash, nil] the field value, or nil when absent.
    def node_states
      @attributes[:node_states]
    end

    # Execution status, timing, and bounded output summaries for each node. For performance reasons, this is not provided when listing Automation runs.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def execution_nodes
      @attributes[:execution_nodes]
    end

    # Link to the run journal artifact.
    # @return [String, nil] the field value, or nil when absent.
    def journal_url
      @attributes[:journal_url]
    end

    # Link to status messages log file.
    # @return [String, nil] the field value, or nil when absent.
    def status_messages_url
      @attributes[:status_messages_url]
    end

    # Cancel Automation Run
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def cancel(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/automation_runs/#{@attributes[:id]}/cancel", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Re-run Automation from Node
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] node_id Required. Node ID at which execution should resume.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def rerun(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: node_id must be an String") if !params[:node_id].nil? and !params[:node_id].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: node_id") if params[:node_id].nil?

      response, options = Api.send_request("/automation_runs/#{@attributes[:id]}/rerun", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # List Automation Runs
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `automation_id`, `created_at` or `status`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `status`, `workspace_id` or `automation_id`. Valid field combinations are `[ workspace_id, status ]`, `[ automation_id, status ]`, `[ workspace_id, automation_id ]` or `[ workspace_id, automation_id, status ]`.
    # @option params [Integer] automation_id Required. ID of the associated Automation.
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
      raise InvalidParameterError.new("Bad parameter: automation_id must be an Integer") if !params[:automation_id].nil? and !params[:automation_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: automation_id") if params[:automation_id].nil?

      list_options = options.dup
      List.new(AutomationRun, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/automation_runs", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Automation Run
    #
    # @param id [Integer] Automation Run ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AutomationRun] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/automation_runs/#{params[:id]}", :get, params, options) { |reply| reply.require_object("AutomationRun") }
      AutomationRun.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Show Automation Run Node
    #
    # @param id [Integer] Automation Run ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] node_id Required. Node ID from the pinned Automation definition.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AutomationExecutionNode] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find_node(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: node_id must be an String") if !params[:node_id].nil? and !params[:node_id].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: node_id") if params[:node_id].nil?

      response, options = Api.send_request("/automation_runs/#{params[:id]}/node", :get, params, options) { |reply| reply.require_object("AutomationExecutionNode") }
      AutomationExecutionNode.new(response.data, options)
    end

    # Cancel Automation Run
    #
    # @param id [Integer] Automation Run ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AutomationRun] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.cancel(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/automation_runs/#{params[:id]}/cancel", :post, params, options) { |reply| reply.require_object("AutomationRun") }
      AutomationRun.new(response.data, options)
    end

    # Re-run Automation from Node
    #
    # @param id [Integer] Automation Run ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] node_id Required. Node ID at which execution should resume.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AutomationRun] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.rerun(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: node_id must be an String") if !params[:node_id].nil? and !params[:node_id].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: node_id") if params[:node_id].nil?

      response, options = Api.send_request("/automation_runs/#{params[:id]}/rerun", :post, params, options) { |reply| reply.require_object("AutomationRun") }
      AutomationRun.new(response.data, options)
    end
  end
end
