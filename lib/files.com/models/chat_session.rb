# frozen_string_literal: true

module Files
  # Files::ChatSession is the Ruby SDK's representation of Files.com API ChatSession objects.
  # Each instance keeps its API field values in +attributes+.
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

    # string - Short AI-generated chat title.
    def title
      @attributes[:title]
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
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::ChatSession objects.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)

      list_options = options.dup
      List.new(ChatSession, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/chat_sessions", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - string - Chat Session ID.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::ChatSession.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an String") if !params[:id].nil? and !params[:id].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/chat_sessions/#{params[:id]}", :get, params, options) { |reply| reply.require_object("ChatSession") }
      ChatSession.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
