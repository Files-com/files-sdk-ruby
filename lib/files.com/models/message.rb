# frozen_string_literal: true

module Files
  class Message
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Message ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Message subject.
    def subject
      @attributes[:subject]
    end

    def subject=(value)
      @attributes[:subject] = value
    end

    # string - Message body.
    def body
      @attributes[:body]
    end

    def body=(value)
      @attributes[:body] = value
    end

    # Comments.
    def comments
      @attributes[:comments]
    end

    def comments=(value)
      @attributes[:comments] = value
    end

    # int64 - User ID.  Provide a value of `0` to operate the current session's user.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # int64 - Project to which the message should be attached.
    def project_id
      @attributes[:project_id]
    end

    def project_id=(value)
      @attributes[:project_id] = value
    end

    # Parameters:
    #   project_id (required) - int64 - Project to which the message should be attached.
    #   subject (required) - string - Message subject.
    #   body (required) - string - Message body.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: project_id must be an Integer") if params.dig(:project_id) and !params.dig(:project_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: subject must be an String") if params.dig(:subject) and !params.dig(:subject).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if params.dig(:body) and !params.dig(:body).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: project_id") unless params.dig(:project_id)
      raise MissingParameterError.new("Parameter missing: subject") unless params.dig(:subject)
      raise MissingParameterError.new("Parameter missing: body") unless params.dig(:body)

      Api.send_request("/messages/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/messages/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = Message.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   project_id (required) - int64 - Project for which to return messages.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: project_id must be an Integer") if params.dig(:project_id) and !params.dig(:project_id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: project_id") unless params.dig(:project_id)

      List.new(Message, params) do
        Api.send_request("/messages", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Message ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/messages/#{params[:id]}", :get, params, options)
      Message.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   project_id (required) - int64 - Project to which the message should be attached.
    #   subject (required) - string - Message subject.
    #   body (required) - string - Message body.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: project_id must be an Integer") if params.dig(:project_id) and !params.dig(:project_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: subject must be an String") if params.dig(:subject) and !params.dig(:subject).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if params.dig(:body) and !params.dig(:body).is_a?(String)
      raise MissingParameterError.new("Parameter missing: project_id") unless params.dig(:project_id)
      raise MissingParameterError.new("Parameter missing: subject") unless params.dig(:subject)
      raise MissingParameterError.new("Parameter missing: body") unless params.dig(:body)

      response, options = Api.send_request("/messages", :post, params, options)
      Message.new(response.data, options)
    end

    # Parameters:
    #   project_id (required) - int64 - Project to which the message should be attached.
    #   subject (required) - string - Message subject.
    #   body (required) - string - Message body.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: project_id must be an Integer") if params.dig(:project_id) and !params.dig(:project_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: subject must be an String") if params.dig(:subject) and !params.dig(:subject).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if params.dig(:body) and !params.dig(:body).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: project_id") unless params.dig(:project_id)
      raise MissingParameterError.new("Parameter missing: subject") unless params.dig(:subject)
      raise MissingParameterError.new("Parameter missing: body") unless params.dig(:body)

      response, options = Api.send_request("/messages/#{params[:id]}", :patch, params, options)
      Message.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/messages/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
