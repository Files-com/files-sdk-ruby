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

    # date-time - Automation run completion/failure date/time.
    def completed_at
      @attributes[:completed_at]
    end

    # date-time - Automation run start date/time.
    def created_at
      @attributes[:created_at]
    end

    # string - The success status of the AutomationRun. One of `running`, `success`, `partial_failure`, or `failure`.
    def status
      @attributes[:status]
    end

    # string - Link to status messages log file.
    def status_messages_url
      @attributes[:status_messages_url]
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `created_at` and `status`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `status`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `status`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal to the supplied value. Valid fields are `status`.
    #   filter_like - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `status`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `status`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal to the supplied value. Valid fields are `status`.
    #   automation_id (required) - int64 - ID of the associated Automation.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params[:filter_like] and !params[:filter_like].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)
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
  end
end
