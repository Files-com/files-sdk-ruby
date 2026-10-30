# frozen_string_literal: true

module Files
  # Files::SftpHostKey is the Ruby SDK's representation of Files.com API SftpHostKey objects.
  # Each instance keeps its API field values in +attributes+.
  class SftpHostKey
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

    # If true, use this SFTP Host Key.
    # @return [Boolean, nil] the field value, or nil when absent.
    def active
      @attributes[:active]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def active=(value)
      @attributes[:active] = value
    end

    # Custom Domain ID. If set, this key is used only for that Custom Domain.
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

    # SFTP Host Key ID
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

    # The friendly name of this SFTP Host Key.
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

    # SSH key type
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

    # MD5 Fingerprint of the public key
    # @return [String, nil] the field value, or nil when absent.
    def fingerprint_md5
      @attributes[:fingerprint_md5]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def fingerprint_md5=(value)
      @attributes[:fingerprint_md5] = value
    end

    # SHA256 Fingerprint of the public key
    # @return [String, nil] the field value, or nil when absent.
    def fingerprint_sha256
      @attributes[:fingerprint_sha256]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def fingerprint_sha256=(value)
      @attributes[:fingerprint_sha256] = value
    end

    # The private key data.
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

    # Update SFTP Host Key
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] active If true, use this SFTP Host Key.
    # @option params [Integer] custom_domain_id Custom Domain ID. If set, this key is used only for that Custom Domain.
    # @option params [String] name The friendly name of this SFTP Host Key.
    # @option params [String] private_key The private key data.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: active must be a single value, not #{params[:active].class}") if [ Array, Hash ].any? { |klass| params[:active].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: custom_domain_id must be an Integer") if !params[:custom_domain_id].nil? and !params[:custom_domain_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/sftp_host_keys/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("SftpHostKey") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete SFTP Host Key
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

      response, options = Api.send_request("/sftp_host_keys/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = SftpHostKey.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List SFTP Host Keys
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
      List.new(SftpHostKey, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/sftp_host_keys", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show SFTP Host Key
    #
    # @param id [Integer] Sftp Host Key ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::SftpHostKey] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/sftp_host_keys/#{params[:id]}", :get, params, options) { |reply| reply.require_object("SftpHostKey") }
      SftpHostKey.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create SFTP Host Key
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] active If true, use this SFTP Host Key.
    # @option params [Integer] custom_domain_id Custom Domain ID. If set, this key is used only for that Custom Domain.
    # @option params [String] name The friendly name of this SFTP Host Key.
    # @option params [String] private_key The private key data.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::SftpHostKey] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: active must be a single value, not #{params[:active].class}") if [ Array, Hash ].any? { |klass| params[:active].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: custom_domain_id must be an Integer") if !params[:custom_domain_id].nil? and !params[:custom_domain_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)

      response, options = Api.send_request("/sftp_host_keys", :post, params, options) { |reply| reply.require_object("SftpHostKey") }
      SftpHostKey.new(response.data, options)
    end

    # Update SFTP Host Key
    #
    # @param id [Integer] Sftp Host Key ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] active If true, use this SFTP Host Key.
    # @option params [Integer] custom_domain_id Custom Domain ID. If set, this key is used only for that Custom Domain.
    # @option params [String] name The friendly name of this SFTP Host Key.
    # @option params [String] private_key The private key data.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::SftpHostKey] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: active must be a single value, not #{params[:active].class}") if [ Array, Hash ].any? { |klass| params[:active].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: custom_domain_id must be an Integer") if !params[:custom_domain_id].nil? and !params[:custom_domain_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/sftp_host_keys/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("SftpHostKey") }
      SftpHostKey.new(response.data, options)
    end

    # Delete SFTP Host Key
    #
    # @param id [Integer] Sftp Host Key ID.
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

      Api.send_request("/sftp_host_keys/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
