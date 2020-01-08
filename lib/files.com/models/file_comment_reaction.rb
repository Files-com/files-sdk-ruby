# frozen_string_literal: true

module Files
  class FileCommentReaction
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Reaction ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Emoji used in the reaction.
    def emoji
      @attributes[:emoji]
    end

    def emoji=(value)
      @attributes[:emoji] = value
    end

    # int64 - User ID.  Provide a value of `0` to operate the current session's user.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # int64 - ID of file comment to attach reaction to.
    def file_comment_id
      @attributes[:file_comment_id]
    end

    def file_comment_id=(value)
      @attributes[:file_comment_id] = value
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/file_comment_reactions/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The FileCommentReaction object doesn't support updates.")
      else
        new_obj = FileCommentReaction.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
    #   file_comment_id (required) - integer - ID of file comment to attach reaction to.
    #   emoji (required) - string - Emoji to react with.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: file_comment_id must be an Integer") if params.dig(:file_comment_id) and !params.dig(:file_comment_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: emoji must be an String") if params.dig(:emoji) and !params.dig(:emoji).is_a?(String)
      raise MissingParameterError.new("Parameter missing: file_comment_id") unless params.dig(:file_comment_id)
      raise MissingParameterError.new("Parameter missing: emoji") unless params.dig(:emoji)

      response, options = Api.send_request("/file_comment_reactions", :post, params, options)
      FileCommentReaction.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/file_comment_reactions/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
