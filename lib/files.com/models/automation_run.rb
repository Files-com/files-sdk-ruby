# frozen_string_literal: true

module Files
  class AutomationRun
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - ID of the associated Automation.
    def automation_id
      @attributes[:automation_id]
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
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   automation_id (required) - int64 - ID of the associated Automation.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: automation_id must be an Integer") if params.dig(:automation_id) and !params.dig(:automation_id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: automation_id") unless params.dig(:automation_id)

      List.new(AutomationRun, params) do
        Api.send_request("/automation_runs", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
