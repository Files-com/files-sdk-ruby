# frozen_string_literal: true

module Files
  class Style
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Style ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # Logo
    def logo
      @attributes[:logo]
    end

    def logo=(value)
      @attributes[:logo] = value
    end

    # Logo thumbnail
    def thumbnail
      @attributes[:thumbnail]
    end

    def thumbnail=(value)
      @attributes[:thumbnail] = value
    end

    # file - Logo for custom branding.
    def file
      @attributes[:file]
    end

    def file=(value)
      @attributes[:file] = value
    end

    # Parameters:
    #   file (required) - file - Logo for custom branding.
    def update(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: file") unless params.dig(:file)

      Api.send_request("/styles/#{Addressable::URI.encode_component(params[:path])}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      Api.send_request("/styles/#{Addressable::URI.encode_component(params[:path])}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      update(@attributes)
    end

    # Parameters:
    #   path (required) - string - Style path.
    def self.list(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, options = Api.send_request("/styles/#{Addressable::URI.encode_component(params[:path])}", :get, params, options)
      Style.new(response.data, options)
    end

    def self.all(path, params = {}, options = {})
      list(path, params, options)
    end

    # Parameters:
    #   file (required) - file - Logo for custom branding.
    def self.update(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: file") unless params.dig(:file)

      response, options = Api.send_request("/styles/#{Addressable::URI.encode_component(params[:path])}", :patch, params, options)
      Style.new(response.data, options)
    end

    def self.delete(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, _options = Api.send_request("/styles/#{Addressable::URI.encode_component(params[:path])}", :delete, params, options)
      response.data
    end

    def self.destroy(path, params = {}, options = {})
      delete(path, params, options)
    end
  end
end
