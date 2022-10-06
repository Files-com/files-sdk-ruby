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

    # string - User-supplied description of API key.
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
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

    # string - Folder path restriction for this api key. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # string - Permissions for this API Key.  Keys with the `desktop_app` permission set only have the ability to do the functions provided in our Desktop App (File and Share Link operations).  Additional permission sets may become available in the future, such as for a Site Admin to give a key with no administrator privileges.  If you have ideas for permission sets, please let us know.
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

    # string - URL for API host.
    def url
      @attributes[:url]
    end

    def url=(value)
      @attributes[:url] = value
    end

    # int64 - User ID for the owner of this API Key.  May be blank for Site-wide API Keys.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # Parameters:
    #   name - string - Internal name for the API Key.  For your use.
    #   description - string - User-supplied description of API key.
    #   expires_at - string - API Key expiration date
    #   permission_set - string - Permissions for this API Key.  Keys with the `desktop_app` permission set only have the ability to do the functions provided in our Desktop App (File and Share Link operations).  Additional permission sets may become available in the future, such as for a Site Admin to give a key with no administrator privileges.  If you have ideas for permission sets, please let us know.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params[:expires_at] and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if params[:permission_set] and !params[:permission_set].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/api_keys/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

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
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `expires_at`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `expires_at`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `expires_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal to the supplied value. Valid fields are `expires_at`.
    #   filter_like - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `expires_at`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `expires_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal to the supplied value. Valid fields are `expires_at`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params[:filter_like] and !params[:filter_like].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)

      List.new(ApiKey, params) do
        Api.send_request("/api_keys", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    def self.find_current(params = {}, options = {})
      response, options = Api.send_request("/api_key", :get, params, options)
      ApiKey.new(response.data, options)
    end

    # Parameters:
    #   id (required) - int64 - Api Key ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/api_keys/#{params[:id]}", :get, params, options)
      ApiKey.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   name - string - Internal name for the API Key.  For your use.
    #   description - string - User-supplied description of API key.
    #   expires_at - string - API Key expiration date
    #   permission_set - string - Permissions for this API Key.  Keys with the `desktop_app` permission set only have the ability to do the functions provided in our Desktop App (File and Share Link operations).  Additional permission sets may become available in the future, such as for a Site Admin to give a key with no administrator privileges.  If you have ideas for permission sets, please let us know.
    #   path - string - Folder path restriction for this api key.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params[:expires_at] and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if params[:permission_set] and !params[:permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)

      response, options = Api.send_request("/api_keys", :post, params, options)
      ApiKey.new(response.data, options)
    end

    # Parameters:
    #   expires_at - string - API Key expiration date
    #   name - string - Internal name for the API Key.  For your use.
    #   permission_set - string - Permissions for this API Key.  Keys with the `desktop_app` permission set only have the ability to do the functions provided in our Desktop App (File and Share Link operations).  Additional permission sets may become available in the future, such as for a Site Admin to give a key with no administrator privileges.  If you have ideas for permission sets, please let us know.
    def self.update_current(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params[:expires_at] and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if params[:permission_set] and !params[:permission_set].is_a?(String)

      response, options = Api.send_request("/api_key", :patch, params, options)
      ApiKey.new(response.data, options)
    end

    # Parameters:
    #   name - string - Internal name for the API Key.  For your use.
    #   description - string - User-supplied description of API key.
    #   expires_at - string - API Key expiration date
    #   permission_set - string - Permissions for this API Key.  Keys with the `desktop_app` permission set only have the ability to do the functions provided in our Desktop App (File and Share Link operations).  Additional permission sets may become available in the future, such as for a Site Admin to give a key with no administrator privileges.  If you have ideas for permission sets, please let us know.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params[:expires_at] and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if params[:permission_set] and !params[:permission_set].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/api_keys/#{params[:id]}", :patch, params, options)
      ApiKey.new(response.data, options)
    end

    def self.delete_current(params = {}, options = {})
      response, _options = Api.send_request("/api_key", :delete, params, options)
      response.data
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, _options = Api.send_request("/api_keys/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
