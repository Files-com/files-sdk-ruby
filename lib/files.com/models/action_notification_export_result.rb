# frozen_string_literal: true

module Files
  # Files::ActionNotificationExportResult is the Ruby SDK's representation of Files.com API ActionNotificationExportResult objects.
  # Each instance keeps its API field values in +attributes+.
  class ActionNotificationExportResult
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

    # Notification ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # When the notification was sent.
    # @return [Integer, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # HTTP status code returned in the webhook response.
    # @return [Integer, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # A message indicating the overall status of the webhook notification.
    # @return [String, nil] the field value, or nil when absent.
    def message
      @attributes[:message]
    end

    # `true` if the webhook succeeded by receiving a 200 or 204 response.
    # @return [Boolean, nil] the field value, or nil when absent.
    def success
      @attributes[:success]
    end

    # A JSON-encoded string with headers that were sent with the webhook.
    # @return [String, nil] the field value, or nil when absent.
    def request_headers
      @attributes[:request_headers]
    end

    # The HTTP verb used to perform the webhook.
    # @return [String, nil] the field value, or nil when absent.
    def request_method
      @attributes[:request_method]
    end

    # The webhook request URL.
    # @return [String, nil] the field value, or nil when absent.
    def request_url
      @attributes[:request_url]
    end

    # The path to the actual file that triggered this notification. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # The folder associated with the triggering action for this notification.
    # @return [String, nil] the field value, or nil when absent.
    def folder
      @attributes[:folder]
    end

    # List Action Notification Export Results
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Integer] action_notification_export_id Required. ID of the associated action notification export.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action_notification_export_id must be an Integer") if !params[:action_notification_export_id].nil? and !params[:action_notification_export_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: action_notification_export_id") if params[:action_notification_export_id].nil?

      list_options = options.dup
      List.new(ActionNotificationExportResult, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/action_notification_export_results", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
