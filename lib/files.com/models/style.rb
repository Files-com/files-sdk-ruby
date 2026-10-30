# frozen_string_literal: true

module Files
  # Files::Style is the Ruby SDK's representation of Files.com API Style objects.
  # Each instance keeps its API field values in +attributes+.
  class Style
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

    # Style ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def id=(value)
      @attributes[:id] = value
    end

    # Folder path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def path=(value)
      @attributes[:path] = value
    end

    # Logo
    # @return [Hash, nil] the field value, or nil when absent.
    def logo
      @attributes[:logo]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def logo=(value)
      @attributes[:logo] = value
    end

    # URL to open when a public visitor clicks the logo
    # @return [String, nil] the field value, or nil when absent.
    def logo_click_href
      @attributes[:logo_click_href]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def logo_click_href=(value)
      @attributes[:logo_click_href] = value
    end

    # Logo thumbnail
    # @return [Hash, nil] the field value, or nil when absent.
    def thumbnail
      @attributes[:thumbnail]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def thumbnail=(value)
      @attributes[:thumbnail] = value
    end

    # Logo for custom branding. Required when creating a new style.
    # @return [Hash, nil] the field value, or nil when absent.
    def file
      @attributes[:file]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def file=(value)
      @attributes[:file] = value
    end

    # Update Style
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Object] file Logo for custom branding. Required when creating a new style.
    # @option params [String] logo_click_href URL to open when a public visitor clicks the logo.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: logo_click_href must be an String") if !params[:logo_click_href].nil? and !params[:logo_click_href].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/styles/#{@attributes[:path]}", :patch, params, @options) { |reply| reply.require_object("Style") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Style
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/styles/#{@attributes[:path]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Calls {#delete} and discards its response.
    # @param (see #delete)
    # @option (see #delete)
    # @raise (see #delete)
    # @return [nil]
    def destroy(params = {})
      delete(params)
      nil
    end

    # Persists local attributes with {#update}.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    def save
      update(@attributes)
      true
    end

    # Show Style
    #
    # @param path [String] Style path.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Style] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/styles/#{params[:path]}", :get, params, options) { |reply| reply.require_object("Style") }
      Style.new(response.data, options)
    end

    # (see .find)
    def self.get(path, params = {}, options = {})
      find(path, params, options)
    end

    # Update Style
    #
    # @param path [String] Style path.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Object] file Logo for custom branding. Required when creating a new style.
    # @option params [String] logo_click_href URL to open when a public visitor clicks the logo.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Style] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: logo_click_href must be an String") if !params[:logo_click_href].nil? and !params[:logo_click_href].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/styles/#{params[:path]}", :patch, params, options) { |reply| reply.require_object("Style") }
      Style.new(response.data, options)
    end

    # Delete Style
    #
    # @param path [String] Style path.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      Api.send_request("/styles/#{params[:path]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(path, params = {}, options = {})
      delete(path, params, options)
      nil
    end
  end
end
