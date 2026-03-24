# frozen_string_literal: true

module Files
  class ExpectationIncident
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Expectation Incident ID
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

    # string - Incident status.
    def status
      @attributes[:status]
    end

    # date-time - When the incident was opened.
    def opened_at
      @attributes[:opened_at]
    end

    # date-time - When the most recent failing evaluation contributing to the incident occurred.
    def last_failed_at
      @attributes[:last_failed_at]
    end

    # date-time - When the incident was acknowledged.
    def acknowledged_at
      @attributes[:acknowledged_at]
    end

    # date-time - When the current snooze expires.
    def snoozed_until
      @attributes[:snoozed_until]
    end

    # date-time - When the incident was resolved.
    def resolved_at
      @attributes[:resolved_at]
    end

    # int64 - Evaluation that first opened the incident.
    def opened_by_evaluation_id
      @attributes[:opened_by_evaluation_id]
    end

    # int64 - Most recent evaluation linked to the incident.
    def last_evaluation_id
      @attributes[:last_evaluation_id]
    end

    # int64 - Evaluation that resolved the incident.
    def resolved_by_evaluation_id
      @attributes[:resolved_by_evaluation_id]
    end

    # object - Compact incident summary payload.
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

    # Resolve an expectation incident
    def resolve(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/expectation_incidents/#{@attributes[:id]}/resolve", :post, params, @options)
    end

    # Snooze an expectation incident until a specified time
    #
    # Parameters:
    #   snoozed_until (required) - string - Time until which the incident should remain snoozed.
    def snooze(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: snoozed_until must be an String") if params[:snoozed_until] and !params[:snoozed_until].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: snoozed_until") unless params[:snoozed_until]

      Api.send_request("/expectation_incidents/#{@attributes[:id]}/snooze", :post, params, @options)
    end

    # Acknowledge an expectation incident
    def acknowledge(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/expectation_incidents/#{@attributes[:id]}/acknowledge", :post, params, @options)
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

      List.new(ExpectationIncident, params) do
        Api.send_request("/expectation_incidents", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Expectation Incident ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/expectation_incidents/#{params[:id]}", :get, params, options)
      ExpectationIncident.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Resolve an expectation incident
    def self.resolve(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/expectation_incidents/#{params[:id]}/resolve", :post, params, options)
      ExpectationIncident.new(response.data, options)
    end

    # Snooze an expectation incident until a specified time
    #
    # Parameters:
    #   snoozed_until (required) - string - Time until which the incident should remain snoozed.
    def self.snooze(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: snoozed_until must be an String") if params[:snoozed_until] and !params[:snoozed_until].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: snoozed_until") unless params[:snoozed_until]

      response, options = Api.send_request("/expectation_incidents/#{params[:id]}/snooze", :post, params, options)
      ExpectationIncident.new(response.data, options)
    end

    # Acknowledge an expectation incident
    def self.acknowledge(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/expectation_incidents/#{params[:id]}/acknowledge", :post, params, options)
      ExpectationIncident.new(response.data, options)
    end
  end
end
