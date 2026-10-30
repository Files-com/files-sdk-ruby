# frozen_string_literal: true

module Files
  # Files::ExpectationIncident is the Ruby SDK's representation of Files.com API ExpectationIncident objects.
  # Each instance keeps its API field values in +attributes+.
  class ExpectationIncident
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

    # Expectation Incident ID
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

    # Incident status.
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # When the incident was opened.
    # @return [String, nil] the field value, or nil when absent.
    def opened_at
      @attributes[:opened_at]
    end

    # When the most recent failing evaluation contributing to the incident occurred.
    # @return [String, nil] the field value, or nil when absent.
    def last_failed_at
      @attributes[:last_failed_at]
    end

    # When the incident was acknowledged.
    # @return [String, nil] the field value, or nil when absent.
    def acknowledged_at
      @attributes[:acknowledged_at]
    end

    # When the current snooze expires.
    # @return [String, nil] the field value, or nil when absent.
    def snoozed_until
      @attributes[:snoozed_until]
    end

    # When the incident was resolved.
    # @return [String, nil] the field value, or nil when absent.
    def resolved_at
      @attributes[:resolved_at]
    end

    # Evaluation that first opened the incident.
    # @return [Integer, nil] the field value, or nil when absent.
    def opened_by_evaluation_id
      @attributes[:opened_by_evaluation_id]
    end

    # Most recent evaluation linked to the incident.
    # @return [Integer, nil] the field value, or nil when absent.
    def last_evaluation_id
      @attributes[:last_evaluation_id]
    end

    # Evaluation that resolved the incident.
    # @return [Integer, nil] the field value, or nil when absent.
    def resolved_by_evaluation_id
      @attributes[:resolved_by_evaluation_id]
    end

    # Compact incident summary payload.
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

    # Resolve an expectation incident
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def resolve(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/expectation_incidents/#{@attributes[:id]}/resolve", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Snooze an expectation incident until a specified time
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] snoozed_until Required. Time until which the incident should remain snoozed.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def snooze(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: snoozed_until must be an String") if !params[:snoozed_until].nil? and !params[:snoozed_until].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: snoozed_until") if params[:snoozed_until].nil?

      response, options = Api.send_request("/expectation_incidents/#{@attributes[:id]}/snooze", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Acknowledge an expectation incident
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def acknowledge(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/expectation_incidents/#{@attributes[:id]}/acknowledge", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # List Expectation Incidents
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
      List.new(ExpectationIncident, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/expectation_incidents", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Expectation Incident
    #
    # @param id [Integer] Expectation Incident ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ExpectationIncident] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/expectation_incidents/#{params[:id]}", :get, params, options) { |reply| reply.require_object("ExpectationIncident") }
      ExpectationIncident.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Resolve an expectation incident
    #
    # @param id [Integer] Expectation Incident ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ExpectationIncident] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.resolve(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/expectation_incidents/#{params[:id]}/resolve", :post, params, options) { |reply| reply.require_object("ExpectationIncident") }
      ExpectationIncident.new(response.data, options)
    end

    # Snooze an expectation incident until a specified time
    #
    # @param id [Integer] Expectation Incident ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] snoozed_until Required. Time until which the incident should remain snoozed.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ExpectationIncident] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.snooze(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: snoozed_until must be an String") if !params[:snoozed_until].nil? and !params[:snoozed_until].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: snoozed_until") if params[:snoozed_until].nil?

      response, options = Api.send_request("/expectation_incidents/#{params[:id]}/snooze", :post, params, options) { |reply| reply.require_object("ExpectationIncident") }
      ExpectationIncident.new(response.data, options)
    end

    # Acknowledge an expectation incident
    #
    # @param id [Integer] Expectation Incident ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ExpectationIncident] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.acknowledge(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/expectation_incidents/#{params[:id]}/acknowledge", :post, params, options) { |reply| reply.require_object("ExpectationIncident") }
      ExpectationIncident.new(response.data, options)
    end
  end
end
