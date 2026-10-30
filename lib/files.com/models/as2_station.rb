# frozen_string_literal: true

module Files
  # Files::As2Station is the Ruby SDK's representation of Files.com API As2Station objects.
  # Each instance keeps its API field values in +attributes+.
  class As2Station
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

    # Id of the AS2 Station.
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

    # ID of the Workspace associated with this AS2 Station.
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # The station's formal AS2 name.
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

    # Public URI for sending AS2 message to.
    # @return [String, nil] the field value, or nil when absent.
    def uri
      @attributes[:uri]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def uri=(value)
      @attributes[:uri] = value
    end

    # The station's AS2 domain name.
    # @return [String, nil] the field value, or nil when absent.
    def domain
      @attributes[:domain]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def domain=(value)
      @attributes[:domain] = value
    end

    # Serial of public certificate used for message security in hex format.
    # @return [String, nil] the field value, or nil when absent.
    def hex_public_certificate_serial
      @attributes[:hex_public_certificate_serial]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def hex_public_certificate_serial=(value)
      @attributes[:hex_public_certificate_serial] = value
    end

    # MD5 hash of public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate_md5
      @attributes[:public_certificate_md5]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate_md5=(value)
      @attributes[:public_certificate_md5] = value
    end

    # Public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate
      @attributes[:public_certificate]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate=(value)
      @attributes[:public_certificate] = value
    end

    # MD5 hash of private key used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def private_key_md5
      @attributes[:private_key_md5]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def private_key_md5=(value)
      @attributes[:private_key_md5] = value
    end

    # Subject of public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate_subject
      @attributes[:public_certificate_subject]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate_subject=(value)
      @attributes[:public_certificate_subject] = value
    end

    # Issuer of public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate_issuer
      @attributes[:public_certificate_issuer]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate_issuer=(value)
      @attributes[:public_certificate_issuer] = value
    end

    # Serial of public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate_serial
      @attributes[:public_certificate_serial]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate_serial=(value)
      @attributes[:public_certificate_serial] = value
    end

    # Not before value of public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate_not_before
      @attributes[:public_certificate_not_before]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate_not_before=(value)
      @attributes[:public_certificate_not_before] = value
    end

    # Not after value of public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate_not_after
      @attributes[:public_certificate_not_after]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate_not_after=(value)
      @attributes[:public_certificate_not_after] = value
    end

    # MD5 hash of private key password used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def private_key_password_md5
      @attributes[:private_key_password_md5]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def private_key_password_md5=(value)
      @attributes[:private_key_password_md5] = value
    end

    # PEM-encoded private key matching public_certificate.
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

    # Password for the PEM-encoded private key.
    # @return [String, nil] the field value, or nil when absent.
    def private_key_password
      @attributes[:private_key_password]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def private_key_password=(value)
      @attributes[:private_key_password] = value
    end

    # Base64-encoded PKCS#12 (.pfx or .p12) file containing the identity's certificate and private key. Provide this instead of public_certificate and private_key.
    # @return [String, nil] the field value, or nil when absent.
    def pkcs12
      @attributes[:pkcs12]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def pkcs12=(value)
      @attributes[:pkcs12] = value
    end

    # Password for pkcs12. The file and password are used only for import; the extracted certificate and private key are stored as PEM.
    # @return [String, nil] the field value, or nil when absent.
    def pkcs12_password
      @attributes[:pkcs12_password]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def pkcs12_password=(value)
      @attributes[:pkcs12_password] = value
    end

    # Update AS2 Station
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name The station's formal AS2 name.
    # @option params [String] public_certificate Public certificate used for message security.
    # @option params [String] private_key PEM-encoded private key matching public_certificate.
    # @option params [String] private_key_password Password for the PEM-encoded private key.
    # @option params [String] pkcs12 Base64-encoded PKCS#12 (.pfx or .p12) file containing the identity's replacement certificate and private key. Provide this instead of public_certificate and private_key.
    # @option params [String] pkcs12_password Password for pkcs12. The file and password are used only for import; the extracted certificate and private key are stored as PEM.
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
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if !params[:public_certificate].nil? and !params[:public_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if !params[:private_key_password].nil? and !params[:private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pkcs12 must be an String") if !params[:pkcs12].nil? and !params[:pkcs12].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pkcs12_password must be an String") if !params[:pkcs12_password].nil? and !params[:pkcs12_password].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/as2_stations/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("As2Station") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete AS2 Station
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

      response, options = Api.send_request("/as2_stations/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = As2Station.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List AS2 Stations
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `name`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)

      list_options = options.dup
      List.new(As2Station, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/as2_stations", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show AS2 Station
    #
    # @param id [Integer] As2 Station ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::As2Station] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/as2_stations/#{params[:id]}", :get, params, options) { |reply| reply.require_object("As2Station") }
      As2Station.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create AS2 Station
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Required. The station's formal AS2 name.
    # @option params [Integer] workspace_id ID of the Workspace associated with this AS2 Station.
    # @option params [String] public_certificate Public certificate used for message security.
    # @option params [String] private_key PEM-encoded private key matching public_certificate.
    # @option params [String] private_key_password Password for the PEM-encoded private key.
    # @option params [String] pkcs12 Base64-encoded PKCS#12 (.pfx or .p12) file containing the identity's certificate and private key. Provide this instead of public_certificate and private_key.
    # @option params [String] pkcs12_password Password for pkcs12. The file and password are used only for import; the extracted certificate and private key are stored as PEM.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::As2Station] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if !params[:public_certificate].nil? and !params[:public_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if !params[:private_key_password].nil? and !params[:private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pkcs12 must be an String") if !params[:pkcs12].nil? and !params[:pkcs12].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pkcs12_password must be an String") if !params[:pkcs12_password].nil? and !params[:pkcs12_password].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?

      response, options = Api.send_request("/as2_stations", :post, params, options) { |reply| reply.require_object("As2Station") }
      As2Station.new(response.data, options)
    end

    # Update AS2 Station
    #
    # @param id [Integer] As2 Station ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name The station's formal AS2 name.
    # @option params [String] public_certificate Public certificate used for message security.
    # @option params [String] private_key PEM-encoded private key matching public_certificate.
    # @option params [String] private_key_password Password for the PEM-encoded private key.
    # @option params [String] pkcs12 Base64-encoded PKCS#12 (.pfx or .p12) file containing the identity's replacement certificate and private key. Provide this instead of public_certificate and private_key.
    # @option params [String] pkcs12_password Password for pkcs12. The file and password are used only for import; the extracted certificate and private key are stored as PEM.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::As2Station] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if !params[:public_certificate].nil? and !params[:public_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if !params[:private_key_password].nil? and !params[:private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pkcs12 must be an String") if !params[:pkcs12].nil? and !params[:pkcs12].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pkcs12_password must be an String") if !params[:pkcs12_password].nil? and !params[:pkcs12_password].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/as2_stations/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("As2Station") }
      As2Station.new(response.data, options)
    end

    # Delete AS2 Station
    #
    # @param id [Integer] As2 Station ID.
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

      Api.send_request("/as2_stations/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
