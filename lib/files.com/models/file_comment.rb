# frozen_string_literal: true

module Files
  # Files::FileComment is the Ruby SDK's representation of Files.com API FileComment objects.
  # Each instance keeps its API field values in +attributes+.
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

    # array(object) - Reactions to this comment.
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
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if !params[:body].nil? and !params[:body].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: body") if params[:body].nil?

      response, options = Api.send_request("/file_comments/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("FileComment") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Returns the [response, options] pair from Files::Api.send_request.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/file_comments/#{@attributes[:id]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Alias for #delete. Returns nil.
    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = FileComment.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   path (required) - string - Path to operate on.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::FileComment objects.
    def self.list_for(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      list_options = options.dup
      List.new(FileComment, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/file_comments/files/#{page_params[:path]}", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # Parameters:
    #   body (required) - string - Comment body.
    #   path (required) - string - File path.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::FileComment.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: body must be an String") if !params[:body].nil? and !params[:body].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: body") if params[:body].nil?
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/file_comments", :post, params, options) { |reply| reply.require_object("FileComment") }
      FileComment.new(response.data, options)
    end

    # Parameters:
    #   body (required) - string - Comment body.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::FileComment.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if !params[:body].nil? and !params[:body].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: body") if params[:body].nil?

      response, options = Api.send_request("/file_comments/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("FileComment") }
      FileComment.new(response.data, options)
    end

    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns nil.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/file_comments/#{params[:id]}", :delete, params, options)
      nil
    end

    # Alias for ::delete. Returns nil.
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
