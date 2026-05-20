# frozen_string_literal: true

module Files
  class EventDeliveryAttempt
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Event Delivery Attempt ID
    def id
      @attributes[:id]
    end

    # int64 - Event Record ID
    def event_record_id
      @attributes[:event_record_id]
    end

    # int64 - Event Subscription ID
    def event_subscription_id
      @attributes[:event_subscription_id]
    end

    # int64 - Event Target ID
    def event_target_id
      @attributes[:event_target_id]
    end

    # int64 - Workspace ID. 0 means the default workspace or site-wide.
    def workspace_id
      @attributes[:workspace_id]
    end

    # string - Delivery status.
    def status
      @attributes[:status]
    end

    # int64 - Number of delivery attempts made.
    def attempt_number
      @attributes[:attempt_number]
    end

    # int64 - HTTP response code, if applicable.
    def response_code
      @attributes[:response_code]
    end

    # string - Delivery error message, if applicable.
    def error_message
      @attributes[:error_message]
    end

    # string - Delivery response body, if applicable.
    def response_body
      @attributes[:response_body]
    end

    # int64 - Delivery latency in milliseconds.
    def latency_ms
      @attributes[:latency_ms]
    end

    # date-time - Successful delivery date/time.
    def delivered_at
      @attributes[:delivered_at]
    end

    # date-time - Most recent attempt date/time.
    def last_attempted_at
      @attributes[:last_attempted_at]
    end

    # date-time - Next scheduled attempt date/time.
    def next_attempt_at
      @attributes[:next_attempt_at]
    end

    # date-time - Delivery Attempt create date/time.
    def created_at
      @attributes[:created_at]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `status`, `event_record_id`, `event_target_id` or `workspace_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `status`, `workspace_id`, `event_record_id` or `event_target_id`. Valid field combinations are `[ workspace_id, status ]`, `[ workspace_id, event_record_id ]` or `[ workspace_id, event_target_id ]`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(EventDeliveryAttempt, params) do
        Api.send_request("/event_delivery_attempts", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Event Delivery Attempt ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/event_delivery_attempts/#{params[:id]}", :get, params, options)
      EventDeliveryAttempt.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
