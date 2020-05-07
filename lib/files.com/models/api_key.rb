# frozen_string_literal: true

module Files
  class ApiKey
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - API Key ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Unique label that describes this API key.  Useful for external systems where you may have API keys from multiple accounts and want a human-readable label for each key.
    def descriptive_label
      @attributes[:descriptive_label]
    end

    def descriptive_label=(value)
      @attributes[:descriptive_label] = value
    end

    # date-time - Time which API Key was created
    def created_at
      @attributes[:created_at]
    end

    # date-time - API Key expiration date
    def expires_at
      @attributes[:expires_at]
    end

    def expires_at=(value)
      @attributes[:expires_at] = value
    end

    # string - API Key actual key string
    def key
      @attributes[:key]
    end

    def key=(value)
      @attributes[:key] = value
    end

    # date-time - API Key last used - note this value is only updated once per 3 hour period, so the 'actual' time of last use may be up to 3 hours later than this timestamp.
    def last_use_at
      @attributes[:last_use_at]
    end

    def last_use_at=(value)
      @attributes[:last_use_at] = value
    end

    # string - Internal name for the API Key.  For your use.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Permissions for this API Key.  Keys with the `desktop_app` permission set only have the ability to do the functions provided in our Desktop App (File and Share Link operations.)  We hope to offer additional permission sets in the future, such as for a Site Admin to give a key with no administrator privileges.  If you have ideas for permission sets, please let us know.
    def permission_set
      @attributes[:permission_set]
    end

    def permission_set=(value)
      @attributes[:permission_set] = value
    end

    # string - If this API key represents a Desktop app, what platform was it created on?
    def platform
      @attributes[:platform]
    end

    def platform=(value)
      @attributes[:platform] = value
    end

    # int64 - User ID for the owner of this API Key.  May be blank for Site-wide API Keys.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # Parameters:
    #   name - string - Internal name for key.  For your reference only.
    #   permission_set - string - Leave blank, or set to 'desktop_app' to restrict the key to only desktop app functions.
    #   expires_at - string - Have the key expire at this date/time.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if params.dig(:permission_set) and !params.dig(:permission_set).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params.dig(:expires_at) and !params.dig(:expires_at).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/api_keys/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/api_keys/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = ApiKey.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/api_keys", :get, params, options)
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    def self.get(params = {}, options = {})
      response, options = Api.send_request("/api_key", :get, params, options)
      ApiKey.new(response.data, options)
    end

    # Parameters:
    #   id (required) - integer - Api Key ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/api_keys/#{params[:id]}", :get, params, options)
      ApiKey.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
    #   name - string - Internal name for key.  For your reference only.
    #   permission_set - string - Leave blank, or set to 'desktop_app' to restrict the key to only desktop app functions.
    #   expires_at - string - Have the key expire at this date/time.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if params.dig(:permission_set) and !params.dig(:permission_set).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params.dig(:expires_at) and !params.dig(:expires_at).is_a?(String)

      response, options = Api.send_request("/api_keys", :post, params, options)
      ApiKey.new(response.data, options)
    end

    # Parameters:
    #   name - string - Internal name for key.  For your reference only.
    #   permission_set - string - Leave blank, or set to `desktop_app` to restrict the key to only desktop app functions.
    #   expires_at - string - Have the key expire at this date/time.
    def self.update(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if params.dig(:permission_set) and !params.dig(:permission_set).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params.dig(:expires_at) and !params.dig(:expires_at).is_a?(String)

      response, options = Api.send_request("/api_key", :patch, params, options)
      ApiKey.new(response.data, options)
    end

    def self.delete(params = {}, options = {})
      response, _options = Api.send_request("/api_key", :delete, params, options)
      response.data
    end

    def self.destroy(params = {}, options = {})
      delete(params, options)
    end
  end
end
