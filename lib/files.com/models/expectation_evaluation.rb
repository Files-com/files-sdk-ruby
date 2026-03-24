# frozen_string_literal: true

module Files
  class ExpectationEvaluation
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - ExpectationEvaluation ID
    def id
      @attributes[:id]
    end

    # int64 - Workspace ID. `0` means the default workspace.
    def workspace_id
      @attributes[:workspace_id]
    end

    # int64 - Expectation ID.
    def expectation_id
      @attributes[:expectation_id]
    end

    # string - Evaluation status.
    def status
      @attributes[:status]
    end

    # string - How the evaluation window was opened.
    def opened_via
      @attributes[:opened_via]
    end

    # date-time - When the evaluation row was opened.
    def opened_at
      @attributes[:opened_at]
    end

    # date-time - Logical start of the candidate window.
    def window_start_at
      @attributes[:window_start_at]
    end

    # date-time - Actual candidate cutoff boundary for the window.
    def window_end_at
      @attributes[:window_end_at]
    end

    # date-time - Logical due boundary for schedule-driven windows.
    def deadline_at
      @attributes[:deadline_at]
    end

    # date-time - Logical cutoff for late acceptance, when present.
    def late_acceptance_cutoff_at
      @attributes[:late_acceptance_cutoff_at]
    end

    # date-time - Hard stop after which the window may not remain open.
    def hard_close_at
      @attributes[:hard_close_at]
    end

    # date-time - When the evaluation row was finalized.
    def closed_at
      @attributes[:closed_at]
    end

    # array(object) - Captured evidence for files that matched the window.
    def matched_files
      @attributes[:matched_files]
    end

    # array(object) - Captured evidence for required files that were missing.
    def missing_files
      @attributes[:missing_files]
    end

    # array(object) - Captured criteria failures for the window.
    def criteria_errors
      @attributes[:criteria_errors]
    end

    # object - Compact evaluator summary payload.
    def summary
      @attributes[:summary]
    end

    # date-time - Creation time.
    def created_at
      @attributes[:created_at]
    end

    # date-time - Last update time.
    def updated_at
      @attributes[:updated_at]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `created_at` or `expectation_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `expectation_id` and `workspace_id`. Valid field combinations are `[ workspace_id, expectation_id ]`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(ExpectationEvaluation, params) do
        Api.send_request("/expectation_evaluations", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Expectation Evaluation ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/expectation_evaluations/#{params[:id]}", :get, params, options)
      ExpectationEvaluation.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
