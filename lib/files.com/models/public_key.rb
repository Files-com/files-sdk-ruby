# frozen_string_literal: true

module Files
  class PublicKey
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Public key ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Public key title
    def title
      @attributes[:title]
    end

    def title=(value)
      @attributes[:title] = value
    end

    # date-time - Public key created at date/time
    def created_at
      @attributes[:created_at]
    end

    # string - Public key fingerprint
    def fingerprint
      @attributes[:fingerprint]
    end

    def fingerprint=(value)
      @attributes[:fingerprint] = value
    end

    # int64 - User ID.  Provide a value of `0` to operate the current session's user.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # string - Actual contents of SSH key.
    def public_key
      @attributes[:public_key]
    end

    def public_key=(value)
      @attributes[:public_key] = value
    end

    # Parameters:
    #   title (required) - string - Internal reference for key.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: title must be an String") if params.dig(:title) and !params.dig(:title).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: title") unless params.dig(:title)

      Api.send_request("/public_keys/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/public_keys/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = PublicKey.create(@attributes, @options)
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

      response, options = Api.send_request("/public_keys", :get, params, options)
      response.data.map { |object| PublicKey.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - integer - Public Key ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/public_keys/#{params[:id]}", :get, params, options)
      PublicKey.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
    #   title (required) - string - Internal reference for key.
    #   public_key (required) - string - Actual contents of SSH key.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: title must be an String") if params.dig(:title) and !params.dig(:title).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if params.dig(:public_key) and !params.dig(:public_key).is_a?(String)
      raise MissingParameterError.new("Parameter missing: title") unless params.dig(:title)
      raise MissingParameterError.new("Parameter missing: public_key") unless params.dig(:public_key)

      response, options = Api.send_request("/public_keys", :post, params, options)
      PublicKey.new(response.data, options)
    end

    # Parameters:
    #   title (required) - string - Internal reference for key.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: title must be an String") if params.dig(:title) and !params.dig(:title).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: title") unless params.dig(:title)

      response, options = Api.send_request("/public_keys/#{params[:id]}", :patch, params, options)
      PublicKey.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/public_keys/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
