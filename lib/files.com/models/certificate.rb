# frozen_string_literal: true

module Files
  # Files::Certificate is the Ruby SDK's representation of Files.com API Certificate objects.
  # Each instance keeps its API field values in +attributes+.
  class Certificate
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Certificate ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def id=(value)
      @attributes[:id] = value
    end

    # Descriptive name of certificate
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def name=(value)
      @attributes[:name] = value
    end

    # Custom Domain that owns this certificate, including while the certificate is inactive.
    # @return [Integer, nil] the field value, or nil when absent.
    def custom_domain_id
      @attributes[:custom_domain_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def custom_domain_id=(value)
      @attributes[:custom_domain_id] = value
    end

    # Full text of SSL certificate
    # @return [String, nil] the field value, or nil when absent.
    def certificate
      @attributes[:certificate]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def certificate=(value)
      @attributes[:certificate] = value
    end

    # Certificate created at
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Certificate status. (One of `Request Generated`, `New`, `Active`, `Active/Expired`, `Expired`, or `Available`)
    # @return [String, nil] the field value, or nil when absent.
    def display_status
      @attributes[:display_status]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def display_status=(value)
      @attributes[:display_status] = value
    end

    # Domains on this certificate other than files.com domains
    # @return [Array<String>, nil] the field value, or nil when absent.
    def domains
      @attributes[:domains]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def domains=(value)
      @attributes[:domains] = value
    end

    # Certificate expiration date/time
    # @return [String, nil] the field value, or nil when absent.
    def expires_at
      @attributes[:expires_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def expires_at=(value)
      @attributes[:expires_at] = value
    end

    # Is this certificate automatically managed and renewed by Files.com?
    # @return [Boolean, nil] the field value, or nil when absent.
    def brick_managed
      @attributes[:brick_managed]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def brick_managed=(value)
      @attributes[:brick_managed] = value
    end

    # Intermediate certificates
    # @return [String, nil] the field value, or nil when absent.
    def intermediates
      @attributes[:intermediates]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def intermediates=(value)
      @attributes[:intermediates] = value
    end

    # A list of IP addresses associated with this SSL Certificate
    # @return [Array<String>, nil] the field value, or nil when absent.
    def ip_addresses
      @attributes[:ip_addresses]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def ip_addresses=(value)
      @attributes[:ip_addresses] = value
    end

    # X509 issuer
    # @return [String, nil] the field value, or nil when absent.
    def issuer
      @attributes[:issuer]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def issuer=(value)
      @attributes[:issuer] = value
    end

    # Type of key
    # @return [String, nil] the field value, or nil when absent.
    def key_type
      @attributes[:key_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def key_type=(value)
      @attributes[:key_type] = value
    end

    # Certificate signing request text
    # @return [String, nil] the field value, or nil when absent.
    def request
      @attributes[:request]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def request=(value)
      @attributes[:request] = value
    end

    # Certificate status (Request Generated, New, Active, Active/Expired, Expired, or Available)
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def status=(value)
      @attributes[:status] = value
    end

    # X509 Subject name
    # @return [String, nil] the field value, or nil when absent.
    def subject
      @attributes[:subject]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def subject=(value)
      @attributes[:subject] = value
    end

    # Domain for certificate.
    # @return [String, nil] the field value, or nil when absent.
    def certificate_domain
      @attributes[:certificate_domain]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def certificate_domain=(value)
      @attributes[:certificate_domain] = value
    end

    # Additional domains for the certificate CSR.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def certificate_extra_domains
      @attributes[:certificate_extra_domains]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def certificate_extra_domains=(value)
      @attributes[:certificate_extra_domains] = value
    end

    # Country.
    # @return [String, nil] the field value, or nil when absent.
    def certificate_country
      @attributes[:certificate_country]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def certificate_country=(value)
      @attributes[:certificate_country] = value
    end

    # State or province.
    # @return [String, nil] the field value, or nil when absent.
    def certificate_state_or_province
      @attributes[:certificate_state_or_province]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def certificate_state_or_province=(value)
      @attributes[:certificate_state_or_province] = value
    end

    # City or locale.
    # @return [String, nil] the field value, or nil when absent.
    def certificate_city_or_locale
      @attributes[:certificate_city_or_locale]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def certificate_city_or_locale=(value)
      @attributes[:certificate_city_or_locale] = value
    end

    # Company name.
    # @return [String, nil] the field value, or nil when absent.
    def certificate_company_name
      @attributes[:certificate_company_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def certificate_company_name=(value)
      @attributes[:certificate_company_name] = value
    end

    # Department name or organization unit 1
    # @return [String, nil] the field value, or nil when absent.
    def csr_ou1
      @attributes[:csr_ou1]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def csr_ou1=(value)
      @attributes[:csr_ou1] = value
    end

    # Department name or organization unit 2
    # @return [String, nil] the field value, or nil when absent.
    def csr_ou2
      @attributes[:csr_ou2]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def csr_ou2=(value)
      @attributes[:csr_ou2] = value
    end

    # Department name or organization unit 3
    # @return [String, nil] the field value, or nil when absent.
    def csr_ou3
      @attributes[:csr_ou3]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def csr_ou3=(value)
      @attributes[:csr_ou3] = value
    end

    # Email address for the certificate owner.
    # @return [String, nil] the field value, or nil when absent.
    def certificate_email_address
      @attributes[:certificate_email_address]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def certificate_email_address=(value)
      @attributes[:certificate_email_address] = value
    end

    # Certificate private key.
    # @return [String, nil] the field value, or nil when absent.
    def private_key
      @attributes[:private_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def private_key=(value)
      @attributes[:private_key] = value
    end

    # Certificate password.
    # @return [String, nil] the field value, or nil when absent.
    def password
      @attributes[:password]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def password=(value)
      @attributes[:password] = value
    end

    # Activate SSL Certificate
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] replace_cert Leave blank or set to `any` to replace any currently active certificate, if applicable.  Set to `new_ips` to activate this certificate as an additional certificate on your Site by allocating a new set of Dedicated IPs (may require a Plan upgrade).  Set to the ID of a currently active certificate to replace that certificate on its set of dedicated IPs.  A certificate belonging to a Custom Domain activates only for that domain: leave blank, use `any`, or specify that domain's current certificate ID.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def activate(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: replace_cert must be an String") if !params[:replace_cert].nil? and !params[:replace_cert].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/certificates/#{@attributes[:id]}/activate", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Deactivate SSL Certificate
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def deactivate(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/certificates/#{@attributes[:id]}/deactivate", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Replace this active custom SSL Certificate for the Primary Custom Domain with a Files.com SSL Certificate.  The Primary Custom Domain's CNAME record must point at the Site's subdomain.  The Files.com certificate is issued and activated in the background
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def replace_with_files(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/certificates/#{@attributes[:id]}/replace_with_files_certificate", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Update Certificate
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Internal certificate name.
    # @option params [String] intermediates Any intermediate certificates.  PEM or PKCS7 formats accepted.
    # @option params [String] certificate The certificate.  PEM or PKCS7 formats accepted.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: intermediates must be an String") if !params[:intermediates].nil? and !params[:intermediates].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate must be an String") if !params[:certificate].nil? and !params[:certificate].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/certificates/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("Certificate") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Certificate
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/certificates/#{@attributes[:id]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Calls {#delete} and discards its response.
    # @param (see #delete)
    # @option (see #delete)
    # @raise (see #delete)
    # @return [nil]
    def destroy(params = {})
      delete(params)
      nil
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = Certificate.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Certificates
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)

      list_options = options.dup
      List.new(Certificate, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/certificates", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Certificate
    #
    # @param id [Integer] Certificate ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Certificate] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/certificates/#{params[:id]}", :get, params, options) { |reply| reply.require_object("Certificate") }
      Certificate.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create CSR or import existing SSL Certificate
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Required. Internal name of the SSL certificate.
    # @option params [String] certificate_domain Domain for certificate.
    # @option params [Array<String>] certificate_extra_domains Additional domains for the certificate CSR.
    # @option params [String] certificate_country Country.
    # @option params [String] certificate_state_or_province State or province.
    # @option params [String] certificate_city_or_locale City or locale.
    # @option params [String] certificate_company_name Company name.
    # @option params [String] csr_ou1 Department name or organization unit 1
    # @option params [String] csr_ou2 Department name or organization unit 2
    # @option params [String] csr_ou3 Department name or organization unit 3
    # @option params [String] certificate_email_address Email address for the certificate owner.
    # @option params [String] key_type Any supported key type.  Defaults to `RSA-4096`.
    # @option params [String] certificate The certificate.  PEM or PKCS7 formats accepted.
    # @option params [String] private_key Certificate private key.
    # @option params [String] password Certificate password.
    # @option params [String] intermediates Intermediate certificates.  PEM or PKCS7 formats accepted.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Certificate] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_domain must be an String") if !params[:certificate_domain].nil? and !params[:certificate_domain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_extra_domains must be an Array") if !params[:certificate_extra_domains].nil? and !params[:certificate_extra_domains].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: certificate_country must be an String") if !params[:certificate_country].nil? and !params[:certificate_country].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_state_or_province must be an String") if !params[:certificate_state_or_province].nil? and !params[:certificate_state_or_province].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_city_or_locale must be an String") if !params[:certificate_city_or_locale].nil? and !params[:certificate_city_or_locale].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_company_name must be an String") if !params[:certificate_company_name].nil? and !params[:certificate_company_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: csr_ou1 must be an String") if !params[:csr_ou1].nil? and !params[:csr_ou1].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: csr_ou2 must be an String") if !params[:csr_ou2].nil? and !params[:csr_ou2].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: csr_ou3 must be an String") if !params[:csr_ou3].nil? and !params[:csr_ou3].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate_email_address must be an String") if !params[:certificate_email_address].nil? and !params[:certificate_email_address].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: key_type must be an String") if !params[:key_type].nil? and !params[:key_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate must be an String") if !params[:certificate].nil? and !params[:certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: intermediates must be an String") if !params[:intermediates].nil? and !params[:intermediates].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?

      response, options = Api.send_request("/certificates", :post, params, options) { |reply| reply.require_object("Certificate") }
      Certificate.new(response.data, options)
    end

    # Activate SSL Certificate
    #
    # @param id [Integer] Certificate ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] replace_cert Leave blank or set to `any` to replace any currently active certificate, if applicable.  Set to `new_ips` to activate this certificate as an additional certificate on your Site by allocating a new set of Dedicated IPs (may require a Plan upgrade).  Set to the ID of a currently active certificate to replace that certificate on its set of dedicated IPs.  A certificate belonging to a Custom Domain activates only for that domain: leave blank, use `any`, or specify that domain's current certificate ID.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.activate(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: replace_cert must be an String") if !params[:replace_cert].nil? and !params[:replace_cert].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/certificates/#{params[:id]}/activate", :post, params, options)
      nil
    end

    # Deactivate SSL Certificate
    #
    # @param id [Integer] Certificate ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.deactivate(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/certificates/#{params[:id]}/deactivate", :post, params, options)
      nil
    end

    # Replace this active custom SSL Certificate for the Primary Custom Domain with a Files.com SSL Certificate.  The Primary Custom Domain's CNAME record must point at the Site's subdomain.  The Files.com certificate is issued and activated in the background
    #
    # @param id [Integer] Certificate ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.replace_with_files(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/certificates/#{params[:id]}/replace_with_files_certificate", :post, params, options)
      nil
    end

    # Update Certificate
    #
    # @param id [Integer] Certificate ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Internal certificate name.
    # @option params [String] intermediates Any intermediate certificates.  PEM or PKCS7 formats accepted.
    # @option params [String] certificate The certificate.  PEM or PKCS7 formats accepted.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Certificate] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: intermediates must be an String") if !params[:intermediates].nil? and !params[:intermediates].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: certificate must be an String") if !params[:certificate].nil? and !params[:certificate].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/certificates/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("Certificate") }
      Certificate.new(response.data, options)
    end

    # Delete Certificate
    #
    # @param id [Integer] Certificate ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/certificates/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
