# frozen_string_literal: true

module Files
  class ChatSession
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Chat Session ID.
    def id
      @attributes[:id]
    end

    # int64 - User ID.
    def user_id
      @attributes[:user_id]
    end

    # int64 - AI Task ID. Present when the conversation was started by an AI Task.
    def ai_task_id
      @attributes[:ai_task_id]
    end

    # int64 - Workspace ID. `0` means the default workspace.
    def workspace_id
      @attributes[:workspace_id]
    end

    # date-time - Most recent chat activity date/time.
    def last_active_at
      @attributes[:last_active_at]
    end

    # date-time - Chat session creation date/time.
    def created_at
      @attributes[:created_at]
    end

    # array(object) - Visible conversation messages in this chat session. For performance reasons, this is not provided when listing chat sessions.
    def messages
      @attributes[:messages]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `ai_task_id`, `user_id` or `workspace_id`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(ChatSession, params) do
        Api.send_request("/chat_sessions", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - string - Chat Session ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an String") if params[:id] and !params[:id].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/chat_sessions/#{params[:id]}", :get, params, options)
      ChatSession.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `ai_task_id`, `user_id` or `workspace_id`.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      response, options = Api.send_request("/chat_sessions/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
