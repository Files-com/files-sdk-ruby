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

    # string - Serial of public certificate used for message security in hex format.
    def hex_public_certificate_serial
      @attributes[:hex_public_certificate_serial]
    end

    def hex_public_certificate_serial=(value)
      @attributes[:hex_public_certificate_serial] = value
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

    # string - Subject of public certificate used for message security.
    def public_certificate_subject
      @attributes[:public_certificate_subject]
    end

    def public_certificate_subject=(value)
      @attributes[:public_certificate_subject] = value
    end

    # string - Issuer of public certificate used for message security.
    def public_certificate_issuer
      @attributes[:public_certificate_issuer]
    end

    def public_certificate_issuer=(value)
      @attributes[:public_certificate_issuer] = value
    end

    # string - Serial of public certificate used for message security.
    def public_certificate_serial
      @attributes[:public_certificate_serial]
    end

    def public_certificate_serial=(value)
      @attributes[:public_certificate_serial] = value
    end

    # string - Not before value of public certificate used for message security.
    def public_certificate_not_before
      @attributes[:public_certificate_not_before]
    end

    def public_certificate_not_before=(value)
      @attributes[:public_certificate_not_before] = value
    end

    # string - Not after value of public certificate used for message security.
    def public_certificate_not_after
      @attributes[:public_certificate_not_after]
    end

    def public_certificate_not_after=(value)
      @attributes[:public_certificate_not_after] = value
    end

    # string - MD5 hash of private key password used for message security.
    def private_key_password_md5
      @attributes[:private_key_password_md5]
    end

    def private_key_password_md5=(value)
      @attributes[:private_key_password_md5] = value
    end

    # string
    def public_certificate
      @attributes[:public_certificate]
    end

    def public_certificate=(value)
      @attributes[:public_certificate] = value
    end

    # string
    def private_key
      @attributes[:private_key]
    end

    def private_key=(value)
      @attributes[:private_key] = value
    end

    # string
    def private_key_password
      @attributes[:private_key_password]
    end

    def private_key_password=(value)
      @attributes[:private_key_password] = value
    end

    # Parameters:
    #   name - string - AS2 Name
    #   public_certificate - string
    #   private_key - string
    #   private_key_password - string
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if params[:public_certificate] and !params[:public_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if params[:private_key_password] and !params[:private_key_password].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/as2_stations/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/as2_stations/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = As2Station.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `name`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)

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
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/as2_stations/#{params[:id]}", :get, params, options)
      As2Station.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name (required) - string - AS2 Name
    #   public_certificate (required) - string
    #   private_key (required) - string
    #   private_key_password - string
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if params[:public_certificate] and !params[:public_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if params[:private_key_password] and !params[:private_key_password].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]
      raise MissingParameterError.new("Parameter missing: public_certificate") unless params[:public_certificate]
      raise MissingParameterError.new("Parameter missing: private_key") unless params[:private_key]

      response, options = Api.send_request("/as2_stations", :post, params, options)
      As2Station.new(response.data, options)
    end

    # Parameters:
    #   name - string - AS2 Name
    #   public_certificate - string
    #   private_key - string
    #   private_key_password - string
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if params[:public_certificate] and !params[:public_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if params[:private_key_password] and !params[:private_key_password].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/as2_stations/#{params[:id]}", :patch, params, options)
      As2Station.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/as2_stations/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
