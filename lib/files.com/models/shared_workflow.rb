# frozen_string_literal: true

module Files
  # Files::SharedWorkflow is the Ruby SDK's representation of Files.com API SharedWorkflow objects.
  # Each instance keeps its API field values in +attributes+.
  class SharedWorkflow
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

    # Shared Workflow ID.
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Name displayed to recipients.
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Description displayed to recipients.
    # @return [String, nil] the field value, or nil when absent.
    def description
      @attributes[:description]
    end

    # Revision required when submitting a Shared Workflow run.
    # @return [String, nil] the field value, or nil when absent.
    def submission_revision
      @attributes[:submission_revision]
    end

    # Current custom questions in display order.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def form_fields
      @attributes[:form_fields]
    end

    # Run a Shared Workflow
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] submission_revision Required. Revision returned when opening the Shared Workflow.
    # @option params [String] submission_id Required. Client-generated UUID used to retry the same submission without starting another run.
    # @option params [String] file_path Required. Path of a file the recipient can read, including a file uploaded to a Snapshot created for this workflow.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def run_workflow(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: submission_revision must be an String") if !params[:submission_revision].nil? and !params[:submission_revision].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: submission_id must be an String") if !params[:submission_id].nil? and !params[:submission_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_path must be an String") if !params[:file_path].nil? and !params[:file_path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: submission_revision") if params[:submission_revision].nil?
      raise MissingParameterError.new("Parameter missing: submission_id") if params[:submission_id].nil?
      raise MissingParameterError.new("Parameter missing: file_path") if params[:file_path].nil?

      response, options = Api.send_request("/shared_workflows/#{@attributes[:id]}/run_workflow", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # List Shared Workflows
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)

      list_options = options.dup
      List.new(SharedWorkflow, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/shared_workflows", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Shared Workflow
    #
    # @param id [Integer] Shared Workflow ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::SharedWorkflow] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/shared_workflows/#{params[:id]}", :get, params, options) { |reply| reply.require_object("SharedWorkflow") }
      SharedWorkflow.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Show a Shared Workflow run started by the recipient
    #
    # @param id [Integer] Shared Workflow ID.
    # @param run_id [Integer] ID of the run returned by the Shared Workflow submission.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AutomationRun] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find_run(id, run_id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      params[:run_id] = run_id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: run_id must be an Integer") if !params[:run_id].nil? and !params[:run_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: run_id") if params[:run_id].nil?

      response, options = Api.send_request("/shared_workflows/#{params[:id]}/runs/#{params[:run_id]}", :get, params, options) { |reply| reply.require_object("AutomationRun") }
      AutomationRun.new(response.data, options)
    end

    # Run a Shared Workflow
    #
    # @param id [Integer] Shared Workflow ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] submission_revision Required. Revision returned when opening the Shared Workflow.
    # @option params [String] submission_id Required. Client-generated UUID used to retry the same submission without starting another run.
    # @option params [String] file_path Required. Path of a file the recipient can read, including a file uploaded to a Snapshot created for this workflow.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AutomationRun] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.run_workflow(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: submission_revision must be an String") if !params[:submission_revision].nil? and !params[:submission_revision].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: submission_id must be an String") if !params[:submission_id].nil? and !params[:submission_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_path must be an String") if !params[:file_path].nil? and !params[:file_path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: submission_revision") if params[:submission_revision].nil?
      raise MissingParameterError.new("Parameter missing: submission_id") if params[:submission_id].nil?
      raise MissingParameterError.new("Parameter missing: file_path") if params[:file_path].nil?

      response, options = Api.send_request("/shared_workflows/#{params[:id]}/run_workflow", :post, params, options) { |reply| reply.require_object("AutomationRun") }
      AutomationRun.new(response.data, options)
    end
  end
end
