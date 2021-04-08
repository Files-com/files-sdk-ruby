# frozen_string_literal: true

module Files
  class FileComment
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - File Comment ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Comment body.
    def body
      @attributes[:body]
    end

    def body=(value)
      @attributes[:body] = value
    end

    # Reactions to this comment.
    def reactions
      @attributes[:reactions]
    end

    def reactions=(value)
      @attributes[:reactions] = value
    end

    # string - File path.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # Parameters:
    #   body (required) - string - Comment body.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if params.dig(:body) and !params.dig(:body).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: body") unless params.dig(:body)

      Api.send_request("/file_comments/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/file_comments/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = FileComment.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   path (required) - string - Path to operate on.
    def self.list_for(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      List.new(FileComment, params) do
        Api.send_request("/file_comments/files/#{params[:path]}", :get, params, options)
      end
    end

    # Parameters:
    #   body (required) - string - Comment body.
    #   path (required) - string - File path.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: body must be an String") if params.dig(:body) and !params.dig(:body).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: body") unless params.dig(:body)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, options = Api.send_request("/file_comments", :post, params, options)
      FileComment.new(response.data, options)
    end

    # Parameters:
    #   body (required) - string - Comment body.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if params.dig(:body) and !params.dig(:body).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: body") unless params.dig(:body)

      response, options = Api.send_request("/file_comments/#{params[:id]}", :patch, params, options)
      FileComment.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/file_comments/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
