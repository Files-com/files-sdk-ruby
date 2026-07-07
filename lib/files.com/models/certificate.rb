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

    # string - Descriptive name of certificate
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
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

    # array(string) - Domains on this certificate other than files.com domains
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

    # array(string) - A list of IP addresses associated with this SSL Certificate
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

    # string - Domain for certificate.
    def certificate_domain
      @attributes[:certificate_domain]
    end

    def certificate_domain=(value)
      @attributes[:certificate_domain] = value
    end

    # array(string) - Additional domains for the certificate CSR.
    def certificate_extra_domains
      @attributes[:certificate_extra_domains]
    end

    def certificate_extra_domains=(value)
      @attributes[:certificate_extra_domains] = value
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
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/certificates/#{@attributes[:id]}/deactivate", :post, params, @options)
    end

    # Activate SSL Certificate
    #
    # Parameters:
    #   replace_cert - string - Leave blank or set to `any` to replace any currently active certificate, if applicable.  Set to `new_ips` to activate this certificate as an additional certificate on your Site by allocating a new set of Dedicated IPs (may require a Plan upgrade).  Set to the ID of a currently active certificate to replace that certificate on its set of dedicated IPs.
    def activate(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: replace_cert must be an String") if params[:replace_cert] and !params[:replace_cert].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

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
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: intermediates must be an String") if params[:intermediates] and !params[:intermediates].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate must be an String") if params[:certificate] and !params[:certificate].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/certificates/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/certificates/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = Certificate.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(Certificate, params) do
        Api.send_request("/certificates", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Certificate ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/certificates/#{params[:id]}", :get, params, options)
      Certificate.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name (required) - string - Internal name of the SSL certificate.
    #   certificate_domain - string - Domain for certificate.
    #   certificate_extra_domains - array(string) - Additional domains for the certificate CSR.
    #   certificate_country - string - Country.
    #   certificate_state_or_province - string - State or province.
    #   certificate_city_or_locale - string - City or locale.
    #   certificate_company_name - string - Company name.
    #   csr_ou1 - string - Department name or organization unit 1
    #   csr_ou2 - string - Department name or organization unit 2
    #   csr_ou3 - string - Department name or organization unit 3
    #   certificate_email_address - string - Email address for the certificate owner.
    #   key_type - string - Any supported key type.  Defaults to `RSA-4096`.
    #   certificate - string - The certificate.  PEM or PKCS7 formats accepted.
    #   private_key - string - Certificate private key.
    #   password - string - Certificate password.
    #   intermediates - string - Intermediate certificates.  PEM or PKCS7 formats accepted.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_domain must be an String") if params[:certificate_domain] and !params[:certificate_domain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_extra_domains must be an Array") if params[:certificate_extra_domains] and !params[:certificate_extra_domains].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: certificate_country must be an String") if params[:certificate_country] and !params[:certificate_country].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_state_or_province must be an String") if params[:certificate_state_or_province] and !params[:certificate_state_or_province].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_city_or_locale must be an String") if params[:certificate_city_or_locale] and !params[:certificate_city_or_locale].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_company_name must be an String") if params[:certificate_company_name] and !params[:certificate_company_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: csr_ou1 must be an String") if params[:csr_ou1] and !params[:csr_ou1].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: csr_ou2 must be an String") if params[:csr_ou2] and !params[:csr_ou2].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: csr_ou3 must be an String") if params[:csr_ou3] and !params[:csr_ou3].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_email_address must be an String") if params[:certificate_email_address] and !params[:certificate_email_address].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: key_type must be an String") if params[:key_type] and !params[:key_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate must be an String") if params[:certificate] and !params[:certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: intermediates must be an String") if params[:intermediates] and !params[:intermediates].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]

      response, options = Api.send_request("/certificates", :post, params, options)
      Certificate.new(response.data, options)
    end

    # Deactivate SSL Certificate
    def self.deactivate(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/certificates/#{params[:id]}/deactivate", :post, params, options)
      nil
    end

    # Activate SSL Certificate
    #
    # Parameters:
    #   replace_cert - string - Leave blank or set to `any` to replace any currently active certificate, if applicable.  Set to `new_ips` to activate this certificate as an additional certificate on your Site by allocating a new set of Dedicated IPs (may require a Plan upgrade).  Set to the ID of a currently active certificate to replace that certificate on its set of dedicated IPs.
    def self.activate(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: replace_cert must be an String") if params[:replace_cert] and !params[:replace_cert].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/certificates/#{params[:id]}/activate", :post, params, options)
      nil
    end

    def self.create_export(params = {}, options = {})
      response, options = Api.send_request("/certificates/create_export", :post, params, options)
      Export.new(response.data, options)
    end

    # Parameters:
    #   name - string - Internal certificate name.
    #   intermediates - string - Any intermediate certificates.  PEM or PKCS7 formats accepted.
    #   certificate - string - The certificate.  PEM or PKCS7 formats accepted.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: intermediates must be an String") if params[:intermediates] and !params[:intermediates].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate must be an String") if params[:certificate] and !params[:certificate].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/certificates/#{params[:id]}", :patch, params, options)
      Certificate.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/certificates/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
