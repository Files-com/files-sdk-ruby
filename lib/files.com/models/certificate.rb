# frozen_string_literal: true

module Files
  class Certificate
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Certificate ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Full text of SSL certificate
    def certificate
      @attributes[:certificate]
    end

    def certificate=(value)
      @attributes[:certificate] = value
    end

    # date-time - Certificate created at
    def created_at
      @attributes[:created_at]
    end

    # string - Certificate status. (One of `Request Generated`, `New`, `Active`, `Active/Expired`, `Expired`, or `Available`)
    def display_status
      @attributes[:display_status]
    end

    def display_status=(value)
      @attributes[:display_status] = value
    end

    # array - Domains on this certificate other than files.com domains
    def domains
      @attributes[:domains]
    end

    def domains=(value)
      @attributes[:domains] = value
    end

    # date-time - Certificate expiration date/time
    def expires_at
      @attributes[:expires_at]
    end

    def expires_at=(value)
      @attributes[:expires_at] = value
    end

    # boolean - Is this certificate automatically managed and renewed by Files.com?
    def brick_managed
      @attributes[:brick_managed]
    end

    def brick_managed=(value)
      @attributes[:brick_managed] = value
    end

    # string - Intermediate certificates
    def intermediates
      @attributes[:intermediates]
    end

    def intermediates=(value)
      @attributes[:intermediates] = value
    end

    # array - A list of IP addresses associated with this SSL Certificate
    def ip_addresses
      @attributes[:ip_addresses]
    end

    def ip_addresses=(value)
      @attributes[:ip_addresses] = value
    end

    # string - X509 issuer
    def issuer
      @attributes[:issuer]
    end

    def issuer=(value)
      @attributes[:issuer] = value
    end

    # string - Descriptive name of certificate
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Type of key
    def key_type
      @attributes[:key_type]
    end

    def key_type=(value)
      @attributes[:key_type] = value
    end

    # string - Certificate signing request text
    def request
      @attributes[:request]
    end

    def request=(value)
      @attributes[:request] = value
    end

    # string - Certificate status (Request Generated, New, Active, Active/Expired, Expired, or Available)
    def status
      @attributes[:status]
    end

    def status=(value)
      @attributes[:status] = value
    end

    # string - X509 Subject name
    def subject
      @attributes[:subject]
    end

    def subject=(value)
      @attributes[:subject] = value
    end

    # date-time - Certificated last updated at
    def updated_at
      @attributes[:updated_at]
    end

    # string - Domain for certificate.
    def certificate_domain
      @attributes[:certificate_domain]
    end

    def certificate_domain=(value)
      @attributes[:certificate_domain] = value
    end

    # string - Country.
    def certificate_country
      @attributes[:certificate_country]
    end

    def certificate_country=(value)
      @attributes[:certificate_country] = value
    end

    # string - State or province.
    def certificate_state_or_province
      @attributes[:certificate_state_or_province]
    end

    def certificate_state_or_province=(value)
      @attributes[:certificate_state_or_province] = value
    end

    # string - City or locale.
    def certificate_city_or_locale
      @attributes[:certificate_city_or_locale]
    end

    def certificate_city_or_locale=(value)
      @attributes[:certificate_city_or_locale] = value
    end

    # string - Company name.
    def certificate_company_name
      @attributes[:certificate_company_name]
    end

    def certificate_company_name=(value)
      @attributes[:certificate_company_name] = value
    end

    # string - Department name or organization unit 1
    def csr_ou1
      @attributes[:csr_ou1]
    end

    def csr_ou1=(value)
      @attributes[:csr_ou1] = value
    end

    # string - Department name or organization unit 2
    def csr_ou2
      @attributes[:csr_ou2]
    end

    def csr_ou2=(value)
      @attributes[:csr_ou2] = value
    end

    # string - Department name or organization unit 3
    def csr_ou3
      @attributes[:csr_ou3]
    end

    def csr_ou3=(value)
      @attributes[:csr_ou3] = value
    end

    # string - Email address for the certificate owner.
    def certificate_email_address
      @attributes[:certificate_email_address]
    end

    def certificate_email_address=(value)
      @attributes[:certificate_email_address] = value
    end

    # string - Confirms the key type.
    def key_type_confirm_given
      @attributes[:key_type_confirm_given]
    end

    def key_type_confirm_given=(value)
      @attributes[:key_type_confirm_given] = value
    end

    # string - Certificate private key.
    def private_key
      @attributes[:private_key]
    end

    def private_key=(value)
      @attributes[:private_key] = value
    end

    # string - Certificate password.
    def password
      @attributes[:password]
    end

    def password=(value)
      @attributes[:password] = value
    end

    # Deactivate SSL Certificate
    def deactivate(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/certificates/#{@attributes[:id]}/deactivate", :post, params, @options)
    end

    # Activate SSL Certificate
    #
    # Parameters:
    #   replace_cert - string - Leave blank, set to `any` or `new_ips`.
    def activate(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: replace_cert must be an String") if params.dig(:replace_cert) and !params.dig(:replace_cert).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/certificates/#{@attributes[:id]}/activate", :post, params, @options)
    end

    # Parameters:
    #   name - string - Internal certificate name.
    #   intermediates - string - Any intermediate certificates.  PEM or PKCS7 formats accepted.
    #   certificate - string - The certificate.  PEM or PKCS7 formats accepted.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: intermediates must be an String") if params.dig(:intermediates) and !params.dig(:intermediates).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate must be an String") if params.dig(:certificate) and !params.dig(:certificate).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/certificates/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/certificates/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = Certificate.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/certificates", :get, params, options)
      response.data.map { |object| Certificate.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - integer - Certificate ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/certificates/#{params[:id]}", :get, params, options)
      Certificate.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name (required) - string - Internal name of the SSL certificate.
    #   certificate_domain - string - Domain for certificate.
    #   certificate_country - string - Country.
    #   certificate_state_or_province - string - State or province.
    #   certificate_city_or_locale - string - City or locale.
    #   certificate_company_name - string - Company name.
    #   csr_ou1 - string - Department name or organization unit 1
    #   csr_ou2 - string - Department name or organization unit 2
    #   csr_ou3 - string - Department name or organization unit 3
    #   certificate_email_address - string - Email address for the certificate owner.
    #   key_type - string - Any supported key type.  Defaults to `RSA-4096`.
    #   key_type_confirm_given - string - Confirms the key type.
    #   certificate - string - The certificate.  PEM or PKCS7 formats accepted.
    #   private_key - string - Certificate private key.
    #   password - string - Certificate password.
    #   intermediates - string - Intermediate certificates.  PEM or PKCS7 formats accepted.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_domain must be an String") if params.dig(:certificate_domain) and !params.dig(:certificate_domain).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_country must be an String") if params.dig(:certificate_country) and !params.dig(:certificate_country).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_state_or_province must be an String") if params.dig(:certificate_state_or_province) and !params.dig(:certificate_state_or_province).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_city_or_locale must be an String") if params.dig(:certificate_city_or_locale) and !params.dig(:certificate_city_or_locale).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_company_name must be an String") if params.dig(:certificate_company_name) and !params.dig(:certificate_company_name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: csr_ou1 must be an String") if params.dig(:csr_ou1) and !params.dig(:csr_ou1).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: csr_ou2 must be an String") if params.dig(:csr_ou2) and !params.dig(:csr_ou2).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: csr_ou3 must be an String") if params.dig(:csr_ou3) and !params.dig(:csr_ou3).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_email_address must be an String") if params.dig(:certificate_email_address) and !params.dig(:certificate_email_address).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: key_type must be an String") if params.dig(:key_type) and !params.dig(:key_type).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: key_type_confirm_given must be an String") if params.dig(:key_type_confirm_given) and !params.dig(:key_type_confirm_given).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate must be an String") if params.dig(:certificate) and !params.dig(:certificate).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params.dig(:private_key) and !params.dig(:private_key).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params.dig(:password) and !params.dig(:password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: intermediates must be an String") if params.dig(:intermediates) and !params.dig(:intermediates).is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") unless params.dig(:name)

      response, options = Api.send_request("/certificates", :post, params, options)
      Certificate.new(response.data, options)
    end

    # Deactivate SSL Certificate
    def self.deactivate(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/certificates/#{params[:id]}/deactivate", :post, params, options)
      response.data
    end

    # Activate SSL Certificate
    #
    # Parameters:
    #   replace_cert - string - Leave blank, set to `any` or `new_ips`.
    def self.activate(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: replace_cert must be an String") if params.dig(:replace_cert) and !params.dig(:replace_cert).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/certificates/#{params[:id]}/activate", :post, params, options)
      response.data
    end

    # Parameters:
    #   name - string - Internal certificate name.
    #   intermediates - string - Any intermediate certificates.  PEM or PKCS7 formats accepted.
    #   certificate - string - The certificate.  PEM or PKCS7 formats accepted.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: intermediates must be an String") if params.dig(:intermediates) and !params.dig(:intermediates).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate must be an String") if params.dig(:certificate) and !params.dig(:certificate).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/certificates/#{params[:id]}", :patch, params, options)
      Certificate.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/certificates/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
