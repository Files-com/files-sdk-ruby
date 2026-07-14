# frozen_string_literal: true

module Files
  class AutomationRun
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - ID.
    def id
      @attributes[:id]
    end

    # int64 - ID of the associated Automation.
    def automation_id
      @attributes[:automation_id]
    end

    # int64 - ID of the immutable Automation version pinned by this run.
    def automation_version_id
      @attributes[:automation_version_id]
    end

    # int64 - Workspace ID.
    def workspace_id
      @attributes[:workspace_id]
    end

    # date-time - Date/time at which cancellation was requested.
    def cancel_requested_at
      @attributes[:cancel_requested_at]
    end

    # date-time - Automation run completion/failure date/time.
    def completed_at
      @attributes[:completed_at]
    end

    # date-time - Automation run start date/time.
    def created_at
      @attributes[:created_at]
    end

    # date-time - If set, this automation will be retried at this date/time due to `failure` or `partial_failure`.
    def retry_at
      @attributes[:retry_at]
    end

    # date-time - If set, this Automation run was retried due to `failure` or `partial_failure`.
    def retried_at
      @attributes[:retried_at]
    end

    # int64 - ID of the run that is or will be retrying this run.
    def retried_in_run_id
      @attributes[:retried_in_run_id]
    end

    # int64 - ID of the original run that this run is retrying.
    def retry_of_run_id
      @attributes[:retry_of_run_id]
    end

    # int64 - ID of the run whose persisted node outputs this run reused.
    def rerun_of_run_id
      @attributes[:rerun_of_run_id]
    end

    # string - Node at which this run resumed execution.
    def rerun_from_node_id
      @attributes[:rerun_from_node_id]
    end

    # double - Automation run runtime.
    def runtime
      @attributes[:runtime]
    end

    # string - The status of the AutomationRun. One of `queued`, `running`, `success`, `partial_failure`, `failure`, `skipped`, or `canceled`.
    def status
      @attributes[:status]
    end

    # int64 - Count of successful operations.
    def successful_operations
      @attributes[:successful_operations]
    end

    # int64 - Count of failed operations.
    def failed_operations
      @attributes[:failed_operations]
    end

    # object - Automation definition snapshot pinned by this run. For performance reasons, this is not provided when listing Automation runs.
    def definition
      @attributes[:definition]
    end

    # object - Status and execution stage for each node in this run. For performance reasons, this is not provided when listing Automation runs.
    def node_states
      @attributes[:node_states]
    end

    # array(object) - Execution status, timing, and bounded output summaries for each node. For performance reasons, this is not provided when listing Automation runs.
    def execution_nodes
      @attributes[:execution_nodes]
    end

    # string - Link to the run journal artifact.
    def journal_url
      @attributes[:journal_url]
    end

    # string - Link to status messages log file.
    def status_messages_url
      @attributes[:status_messages_url]
    end

    # Cancel Automation Run
    def cancel(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/automation_runs/#{@attributes[:id]}/cancel", :post, params, @options)
    end

    # Re-run Automation from Node
    #
    # Parameters:
    #   node_id (required) - string - Node ID at which execution should resume.
    def rerun(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: node_id must be an String") if params[:node_id] and !params[:node_id].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: node_id") unless params[:node_id]

      Api.send_request("/automation_runs/#{@attributes[:id]}/rerun", :post, params, @options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `automation_id`, `created_at` or `status`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `status`, `workspace_id` or `automation_id`. Valid field combinations are `[ workspace_id, status ]`, `[ automation_id, status ]`, `[ workspace_id, automation_id ]` or `[ workspace_id, automation_id, status ]`.
    #   automation_id (required) - int64 - ID of the associated Automation.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: automation_id must be an Integer") if params[:automation_id] and !params[:automation_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: automation_id") unless params[:automation_id]

      List.new(AutomationRun, params) do
        Api.send_request("/automation_runs", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Automation Run ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/automation_runs/#{params[:id]}", :get, params, options)
      AutomationRun.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   id (required) - int64 - Automation Run ID.
    #   node_id (required) - string - Node ID from the pinned Automation definition.
    def self.find_node(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: node_id must be an String") if params[:node_id] and !params[:node_id].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: node_id") unless params[:node_id]

      response, options = Api.send_request("/automation_runs/#{params[:id]}/node", :get, params, options)
      AutomationExecutionNode.new(response.data, options)
    end

    # Cancel Automation Run
    def self.cancel(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/automation_runs/#{params[:id]}/cancel", :post, params, options)
      AutomationRun.new(response.data, options)
    end

    # Re-run Automation from Node
    #
    # Parameters:
    #   node_id (required) - string - Node ID at which execution should resume.
    def self.rerun(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: node_id must be an String") if params[:node_id] and !params[:node_id].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: node_id") unless params[:node_id]

      response, options = Api.send_request("/automation_runs/#{params[:id]}/rerun", :post, params, options)
      AutomationRun.new(response.data, options)
    end
  end
end
