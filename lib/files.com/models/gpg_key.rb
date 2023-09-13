# frozen_string_literal: true

module Files
  class GpgKey
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Your GPG key ID.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # date-time - Your GPG key expiration date.
    def expires_at
      @attributes[:expires_at]
    end

    def expires_at=(value)
      @attributes[:expires_at] = value
    end

    # string - Your GPG key name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # int64 - GPG owner's user id
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # string - Your GPG public key
    def public_key
      @attributes[:public_key]
    end

    def public_key=(value)
      @attributes[:public_key] = value
    end

    # string - Your GPG private key.
    def private_key
      @attributes[:private_key]
    end

    def private_key=(value)
      @attributes[:private_key] = value
    end

    # string - Your GPG private key password. Only required for password protected keys.
    def private_key_password
      @attributes[:private_key_password]
    end

    def private_key_password=(value)
      @attributes[:private_key_password] = value
    end

    # Parameters:
    #   public_key - string - Your GPG public key
    #   private_key - string - Your GPG private key.
    #   private_key_password - string - Your GPG private key password. Only required for password protected keys.
    #   name - string - Your GPG key name.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if params[:public_key] and !params[:public_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if params[:private_key_password] and !params[:private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/gpg_keys/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/gpg_keys/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = GpgKey.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction (e.g. `sort_by[name]=desc`). Valid fields are `name` and `expires_at`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)

      List.new(GpgKey, params) do
        Api.send_request("/gpg_keys", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Gpg Key ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/gpg_keys/#{params[:id]}", :get, params, options)
      GpgKey.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   public_key - string - Your GPG public key
    #   private_key - string - Your GPG private key.
    #   private_key_password - string - Your GPG private key password. Only required for password protected keys.
    #   name (required) - string - Your GPG key name.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if params[:public_key] and !params[:public_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if params[:private_key_password] and !params[:private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]

      response, options = Api.send_request("/gpg_keys", :post, params, options)
      GpgKey.new(response.data, options)
    end

    # Parameters:
    #   public_key - string - Your GPG public key
    #   private_key - string - Your GPG private key.
    #   private_key_password - string - Your GPG private key password. Only required for password protected keys.
    #   name - string - Your GPG key name.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if params[:public_key] and !params[:public_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if params[:private_key_password] and !params[:private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/gpg_keys/#{params[:id]}", :patch, params, options)
      GpgKey.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, _options = Api.send_request("/gpg_keys/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
