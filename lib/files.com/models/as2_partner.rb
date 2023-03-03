# frozen_string_literal: true

module Files
  class As2Partner
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Id of the AS2 Partner.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Id of the AS2 Station associated with this partner.
    def as2_station_id
      @attributes[:as2_station_id]
    end

    def as2_station_id=(value)
      @attributes[:as2_station_id] = value
    end

    # string - The partner's formal AS2 name.
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

    # string - Remote server certificate security setting
    def server_certificate
      @attributes[:server_certificate]
    end

    def server_certificate=(value)
      @attributes[:server_certificate] = value
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

    # string
    def public_certificate
      @attributes[:public_certificate]
    end

    def public_certificate=(value)
      @attributes[:public_certificate] = value
    end

    # Parameters:
    #   name - string - AS2 Name
    #   uri - string - URL base for AS2 responses
    #   server_certificate - string - Remote server certificate security setting
    #   public_certificate - string
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uri must be an String") if params[:uri] and !params[:uri].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params[:server_certificate] and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if params[:public_certificate] and !params[:public_certificate].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/as2_partners/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/as2_partners/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = As2Partner.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(As2Partner, params) do
        Api.send_request("/as2_partners", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - As2 Partner ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/as2_partners/#{params[:id]}", :get, params, options)
      As2Partner.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name (required) - string - AS2 Name
    #   uri (required) - string - URL base for AS2 responses
    #   public_certificate (required) - string
    #   as2_station_id (required) - int64 - Id of As2Station for this partner
    #   server_certificate - string - Remote server certificate security setting
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uri must be an String") if params[:uri] and !params[:uri].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if params[:public_certificate] and !params[:public_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: as2_station_id must be an Integer") if params[:as2_station_id] and !params[:as2_station_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params[:server_certificate] and !params[:server_certificate].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]
      raise MissingParameterError.new("Parameter missing: uri") unless params[:uri]
      raise MissingParameterError.new("Parameter missing: public_certificate") unless params[:public_certificate]
      raise MissingParameterError.new("Parameter missing: as2_station_id") unless params[:as2_station_id]

      response, options = Api.send_request("/as2_partners", :post, params, options)
      As2Partner.new(response.data, options)
    end

    # Parameters:
    #   name - string - AS2 Name
    #   uri - string - URL base for AS2 responses
    #   server_certificate - string - Remote server certificate security setting
    #   public_certificate - string
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uri must be an String") if params[:uri] and !params[:uri].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params[:server_certificate] and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if params[:public_certificate] and !params[:public_certificate].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/as2_partners/#{params[:id]}", :patch, params, options)
      As2Partner.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, _options = Api.send_request("/as2_partners/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
