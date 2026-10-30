# frozen_string_literal: true

module Files
  # Files::EventDeliveryAttempt is the Ruby SDK's representation of Files.com API EventDeliveryAttempt objects.
  # Each instance keeps its API field values in +attributes+.
  class EventDeliveryAttempt
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

    # Event Delivery Attempt ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Event Record ID
    # @return [Integer, nil] the field value, or nil when absent.
    def event_record_id
      @attributes[:event_record_id]
    end

    # Event Subscription ID
    # @return [Integer, nil] the field value, or nil when absent.
    def event_subscription_id
      @attributes[:event_subscription_id]
    end

    # Event Target ID
    # @return [Integer, nil] the field value, or nil when absent.
    def event_target_id
      @attributes[:event_target_id]
    end

    # Shared summary ID when this event is delivered in a Slack or Teams subfolder summary. All events in a summary share its delivery outcome.
    # @return [Integer, nil] the field value, or nil when absent.
    def activity_notification_batch_id
      @attributes[:activity_notification_batch_id]
    end

    # Workspace ID. 0 means the default workspace or site-wide.
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Delivery status.
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Number of delivery attempts made.
    # @return [Integer, nil] the field value, or nil when absent.
    def attempt_number
      @attributes[:attempt_number]
    end

    # HTTP response code, if applicable.
    # @return [Integer, nil] the field value, or nil when absent.
    def response_code
      @attributes[:response_code]
    end

    # Delivery error message, if applicable.
    # @return [String, nil] the field value, or nil when absent.
    def error_message
      @attributes[:error_message]
    end

    # Delivery response body, if applicable.
    # @return [String, nil] the field value, or nil when absent.
    def response_body
      @attributes[:response_body]
    end

    # Delivery latency in milliseconds.
    # @return [Integer, nil] the field value, or nil when absent.
    def latency_ms
      @attributes[:latency_ms]
    end

    # Successful delivery date/time.
    # @return [String, nil] the field value, or nil when absent.
    def delivered_at
      @attributes[:delivered_at]
    end

    # Most recent attempt date/time.
    # @return [String, nil] the field value, or nil when absent.
    def last_attempted_at
      @attributes[:last_attempted_at]
    end

    # Next scheduled attempt date/time.
    # @return [String, nil] the field value, or nil when absent.
    def next_attempt_at
      @attributes[:next_attempt_at]
    end

    # Delivery Attempt create date/time.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # List Event Delivery Attempts
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`, `status`, `event_record_id`, `event_target_id` or `workspace_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `status`, `workspace_id`, `event_record_id` or `event_target_id`. Valid field combinations are `[ workspace_id, status ]`, `[ workspace_id, event_record_id ]` or `[ workspace_id, event_target_id ]`.
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
      List.new(EventDeliveryAttempt, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/event_delivery_attempts", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Event Delivery Attempt
    #
    # @param id [Integer] Event Delivery Attempt ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::EventDeliveryAttempt] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/event_delivery_attempts/#{params[:id]}", :get, params, options) { |reply| reply.require_object("EventDeliveryAttempt") }
      EventDeliveryAttempt.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
