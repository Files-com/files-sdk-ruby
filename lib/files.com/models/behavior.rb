# frozen_string_literal: true

module Files
  class Behavior
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Folder behavior ID
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

    # string - URL for attached file
    def attachment_url
      @attributes[:attachment_url]
    end

    def attachment_url=(value)
      @attributes[:attachment_url] = value
    end

    # string - Behavior type.
    def behavior
      @attributes[:behavior]
    end

    def behavior=(value)
      @attributes[:behavior] = value
    end

    # object - Settings for this behavior.  See the section above for an example value to provide here.  Formatting is different for each Behavior type.  May be sent as nested JSON or a single JSON-encoded string.  If using XML encoding for the API call, this data must be sent as a JSON-encoded string.
    def value
      @attributes[:value]
    end

    def value=(value)
      @attributes[:value] = value
    end

    # file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
    def attachment_file
      @attributes[:attachment_file]
    end

    def attachment_file=(value)
      @attributes[:attachment_file] = value
    end

    # Parameters:
    #   value - string - The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior.
    #   attachment_file - file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: value must be an String") if params.dig(:value) and !params.dig(:value).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/behaviors/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/behaviors/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = Behavior.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   behavior - string - If set, only shows folder behaviors matching this behavior type.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: behavior must be an String") if params.dig(:behavior) and !params.dig(:behavior).is_a?(String)

      response, options = Api.send_request("/behaviors", :get, params, options)
      response.data.map { |object| Behavior.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   path (required) - string - Path to operate on.
    #   recursive - string - Show behaviors below this path?
    #   behavior - string - If set only shows folder behaviors matching this behavior type.
    def self.list_for(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recursive must be an String") if params.dig(:recursive) and !params.dig(:recursive).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: behavior must be an String") if params.dig(:behavior) and !params.dig(:behavior).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, options = Api.send_request("/behaviors/folders/#{Addressable::URI.encode_component(params[:path])}", :get, params, options)
      response.data.map { |object| Behavior.new(object, options) }
    end

    # Parameters:
    #   id (required) - integer - Behavior ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/behaviors/#{params[:id]}", :get, params, options)
      Behavior.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   value - string - The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior.
    #   attachment_file - file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
    #   path (required) - string - Folder behaviors path.
    #   behavior (required) - string - Behavior type.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: value must be an String") if params.dig(:value) and !params.dig(:value).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: behavior must be an String") if params.dig(:behavior) and !params.dig(:behavior).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: behavior") unless params.dig(:behavior)

      response, options = Api.send_request("/behaviors", :post, params, options)
      Behavior.new(response.data, options)
    end

    # Parameters:
    #   url (required) - string - URL for testing the webhook.
    #   method - string - HTTP method(GET or POST).
    #   encoding - string - HTTP encoding method.  Can be JSON, XML, or RAW (form data).
    def self.webhook_test(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: url must be an String") if params.dig(:url) and !params.dig(:url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: method must be an String") if params.dig(:method) and !params.dig(:method).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: encoding must be an String") if params.dig(:encoding) and !params.dig(:encoding).is_a?(String)
      raise MissingParameterError.new("Parameter missing: url") unless params.dig(:url)

      response, _options = Api.send_request("/behaviors/webhook/test", :post, params, options)
      response.data
    end

    # Parameters:
    #   value - string - The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior.
    #   attachment_file - file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: value must be an String") if params.dig(:value) and !params.dig(:value).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/behaviors/#{params[:id]}", :patch, params, options)
      Behavior.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/behaviors/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
