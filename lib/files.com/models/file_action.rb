# frozen_string_literal: true

module Files
  class FileAction
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Copy file/folder
    #
    # Parameters:
    #   destination (required) - string - Copy destination path.
    #   structure - boolean - Copy structure only?
    def copy(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params.dig(:destination) and !params.dig(:destination).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: destination") unless params.dig(:destination)

      Api.send_request("/file_actions/copy/#{@attributes[:path]}", :post, params, @options)
    end

    # Move file/folder
    #
    # Parameters:
    #   destination (required) - string - Move destination path.
    def move(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params.dig(:destination) and !params.dig(:destination).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: destination") unless params.dig(:destination)

      Api.send_request("/file_actions/move/#{@attributes[:path]}", :post, params, @options)
    end

    # Begin file upload
    #
    # Parameters:
    #   mkdir_parents - boolean - Create parent directories if they do not exist?
    #   part - int64 - Part if uploading a part.
    #   parts - int64 - How many parts to fetch?
    #   ref - string -
    #   restart - int64 - File byte offset to restart from.
    #   with_rename - boolean - Allow file rename instead of overwrite?
    def begin_upload(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: part must be an Integer") if params.dig(:part) and !params.dig(:part).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: parts must be an Integer") if params.dig(:parts) and !params.dig(:parts).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ref must be an String") if params.dig(:ref) and !params.dig(:ref).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: restart must be an Integer") if params.dig(:restart) and !params.dig(:restart).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      Api.send_request("/file_actions/begin_upload/#{@attributes[:path]}", :post, params, @options)
    end

    # Copy file/folder
    #
    # Parameters:
    #   destination (required) - string - Copy destination path.
    #   structure - boolean - Copy structure only?
    def self.copy(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params.dig(:destination) and !params.dig(:destination).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: destination") unless params.dig(:destination)

      response, _options = Api.send_request("/file_actions/copy/#{params[:path]}", :post, params, options)
      response.data
    end

    # Move file/folder
    #
    # Parameters:
    #   destination (required) - string - Move destination path.
    def self.move(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params.dig(:destination) and !params.dig(:destination).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: destination") unless params.dig(:destination)

      response, _options = Api.send_request("/file_actions/move/#{params[:path]}", :post, params, options)
      response.data
    end

    # Begin file upload
    #
    # Parameters:
    #   mkdir_parents - boolean - Create parent directories if they do not exist?
    #   part - int64 - Part if uploading a part.
    #   parts - int64 - How many parts to fetch?
    #   ref - string -
    #   restart - int64 - File byte offset to restart from.
    #   with_rename - boolean - Allow file rename instead of overwrite?
    def self.begin_upload(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: part must be an Integer") if params.dig(:part) and !params.dig(:part).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: parts must be an Integer") if params.dig(:parts) and !params.dig(:parts).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ref must be an String") if params.dig(:ref) and !params.dig(:ref).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: restart must be an Integer") if params.dig(:restart) and !params.dig(:restart).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, options = Api.send_request("/file_actions/begin_upload/#{params[:path]}", :post, params, options)
      response.data.map do |entity_data|
        FilePartUpload.new(entity_data, options)
      end
    end
  end
end
