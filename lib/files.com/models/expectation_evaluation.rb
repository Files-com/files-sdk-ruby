# frozen_string_literal: true

module Files
  # Files::ExpectationEvaluation is the Ruby SDK's representation of Files.com API ExpectationEvaluation objects.
  # Each instance keeps its API field values in +attributes+.
  class ExpectationEvaluation
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

    # ExpectationEvaluation ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Workspace ID. `0` means the default workspace.
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Expectation ID.
    # @return [Integer, nil] the field value, or nil when absent.
    def expectation_id
      @attributes[:expectation_id]
    end

    # Evaluation status.
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # How the evaluation window was opened.
    # @return [String, nil] the field value, or nil when absent.
    def opened_via
      @attributes[:opened_via]
    end

    # When the evaluation row was opened.
    # @return [String, nil] the field value, or nil when absent.
    def opened_at
      @attributes[:opened_at]
    end

    # Logical start of the candidate window.
    # @return [String, nil] the field value, or nil when absent.
    def window_start_at
      @attributes[:window_start_at]
    end

    # Actual candidate cutoff boundary for the window.
    # @return [String, nil] the field value, or nil when absent.
    def window_end_at
      @attributes[:window_end_at]
    end

    # Logical due boundary for schedule-driven windows.
    # @return [String, nil] the field value, or nil when absent.
    def deadline_at
      @attributes[:deadline_at]
    end

    # Logical cutoff for late acceptance, when present.
    # @return [String, nil] the field value, or nil when absent.
    def late_acceptance_cutoff_at
      @attributes[:late_acceptance_cutoff_at]
    end

    # Hard stop after which the window may not remain open.
    # @return [String, nil] the field value, or nil when absent.
    def hard_close_at
      @attributes[:hard_close_at]
    end

    # When the evaluation row was finalized.
    # @return [String, nil] the field value, or nil when absent.
    def closed_at
      @attributes[:closed_at]
    end

    # Captured evidence for files that matched the window.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def matched_files
      @attributes[:matched_files]
    end

    # Captured evidence for required files that were missing.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def missing_files
      @attributes[:missing_files]
    end

    # Captured criteria failures for the window, including file-scoped FTS errors and returned validation details.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def criteria_errors
      @attributes[:criteria_errors]
    end

    # Compact evaluator summary payload.
    # @return [Hash, nil] the field value, or nil when absent.
    def summary
      @attributes[:summary]
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

    # List Expectation Evaluations
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `created_at` or `expectation_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `expectation_id` and `workspace_id`. Valid field combinations are `[ workspace_id, expectation_id ]`.
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
      List.new(ExpectationEvaluation, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/expectation_evaluations", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Expectation Evaluation
    #
    # @param id [Integer] Expectation Evaluation ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ExpectationEvaluation] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/expectation_evaluations/#{params[:id]}", :get, params, options) { |reply| reply.require_object("ExpectationEvaluation") }
      ExpectationEvaluation.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
