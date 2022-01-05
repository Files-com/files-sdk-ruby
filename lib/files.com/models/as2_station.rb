# frozen_string_literal: true

module Files
  class As2Station
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Id of the AS2 Station.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - The station's formal AS2 name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Public URI for sending AS2 message to.
    def uri
      @attributes[:uri]
    end

    def uri=(value)
      @attributes[:uri] = value
    end

    # string - The station's AS2 domain name.
    def domain
      @attributes[:domain]
    end

    def domain=(value)
      @attributes[:domain] = value
    end

    # string - Public certificate used for message security.
    def public_certificate
      @attributes[:public_certificate]
    end

    def public_certificate=(value)
      @attributes[:public_certificate] = value
    end

    # string - MD5 hash of public certificate used for message security.
    def public_certificate_md5
      @attributes[:public_certificate_md5]
    end

    def public_certificate_md5=(value)
      @attributes[:public_certificate_md5] = value
    end

    # string - MD5 hash of private key used for message security.
    def private_key_md5
      @attributes[:private_key_md5]
    end

    def private_key_md5=(value)
      @attributes[:private_key_md5] = value
    end

    # string
    def private_key
      @attributes[:private_key]
    end

    def private_key=(value)
      @attributes[:private_key] = value
    end

    # Parameters:
    #   name - string - AS2 Name
    #   domain - string - AS2 Domain
    #   uri - string - URL base for AS2 responses
    #   public_certificate - string
    #   private_key - string
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: domain must be an String") if params.dig(:domain) and !params.dig(:domain).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uri must be an String") if params.dig(:uri) and !params.dig(:uri).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if params.dig(:public_certificate) and !params.dig(:public_certificate).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params.dig(:private_key) and !params.dig(:private_key).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/as2_stations/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/as2_stations/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = As2Station.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)

      List.new(As2Station, params) do
        Api.send_request("/as2_stations", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - As2 Station ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/as2_stations/#{params[:id]}", :get, params, options)
      As2Station.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name (required) - string - AS2 Name
    #   domain (required) - string - AS2 Domain
    #   uri (required) - string - URL base for AS2 responses
    #   public_certificate (required) - string
    #   private_key (required) - string
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: domain must be an String") if params.dig(:domain) and !params.dig(:domain).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uri must be an String") if params.dig(:uri) and !params.dig(:uri).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if params.dig(:public_certificate) and !params.dig(:public_certificate).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params.dig(:private_key) and !params.dig(:private_key).is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") unless params.dig(:name)
      raise MissingParameterError.new("Parameter missing: domain") unless params.dig(:domain)
      raise MissingParameterError.new("Parameter missing: uri") unless params.dig(:uri)
      raise MissingParameterError.new("Parameter missing: public_certificate") unless params.dig(:public_certificate)
      raise MissingParameterError.new("Parameter missing: private_key") unless params.dig(:private_key)

      response, options = Api.send_request("/as2_stations", :post, params, options)
      As2Station.new(response.data, options)
    end

    # Parameters:
    #   name - string - AS2 Name
    #   domain - string - AS2 Domain
    #   uri - string - URL base for AS2 responses
    #   public_certificate - string
    #   private_key - string
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: domain must be an String") if params.dig(:domain) and !params.dig(:domain).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uri must be an String") if params.dig(:uri) and !params.dig(:uri).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if params.dig(:public_certificate) and !params.dig(:public_certificate).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params.dig(:private_key) and !params.dig(:private_key).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/as2_stations/#{params[:id]}", :patch, params, options)
      As2Station.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/as2_stations/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
