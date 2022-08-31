# frozen_string_literal: true

module Files
  class ActionNotificationExportResult
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Notification ID
    def id
      @attributes[:id]
    end

    # int64 - When the notification was sent.
    def created_at
      @attributes[:created_at]
    end

    # int64 - HTTP status code returned in the webhook response.
    def status
      @attributes[:status]
    end

    # string - A message indicating the overall status of the webhook notification.
    def message
      @attributes[:message]
    end

    # boolean - `true` if the webhook succeeded by receiving a 200 or 204 response.
    def success
      @attributes[:success]
    end

    # string - A JSON-encoded string with headers that were sent with the webhook.
    def request_headers
      @attributes[:request_headers]
    end

    # string - The HTTP verb used to perform the webhook.
    def request_method
      @attributes[:request_method]
    end

    # string - The webhook request URL.
    def request_url
      @attributes[:request_url]
    end

    # string - The path to the actual file that triggered this notification. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # string - The folder associated with the triggering action for this notification.
    def folder
      @attributes[:folder]
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action_notification_export_id (required) - int64 - ID of the associated action notification export.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action_notification_export_id must be an Integer") if params[:action_notification_export_id] and !params[:action_notification_export_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: action_notification_export_id") unless params[:action_notification_export_id]

      List.new(ActionNotificationExportResult, params) do
        Api.send_request("/action_notification_export_results", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
