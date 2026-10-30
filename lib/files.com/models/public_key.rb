# frozen_string_literal: true

module Files
  # Files::PublicKey is the Ruby SDK's representation of Files.com API PublicKey objects.
  # Each instance keeps its API field values in +attributes+.
  class PublicKey
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

    # Public key ID
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

    # Workspace ID (0 for default workspace).
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

    # Public key title
    # @return [String, nil] the field value, or nil when absent.
    def title
      @attributes[:title]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def title=(value)
      @attributes[:title] = value
    end

    # Public key created at date/time
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Public key expiration date/time
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

    # Is this public key expired?
    # @return [Boolean, nil] the field value, or nil when absent.
    def expired
      @attributes[:expired]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def expired=(value)
      @attributes[:expired] = value
    end

    # Public key fingerprint (MD5)
    # @return [String, nil] the field value, or nil when absent.
    def fingerprint
      @attributes[:fingerprint]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def fingerprint=(value)
      @attributes[:fingerprint] = value
    end

    # Public key fingerprint (SHA256)
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

    # Only returned when generating keys. Can be invalid, not_generated, generating, complete
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

    # Key's most recent login time via SFTP
    # @return [String, nil] the field value, or nil when absent.
    def last_login_at
      @attributes[:last_login_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_login_at=(value)
      @attributes[:last_login_at] = value
    end

    # Only returned when generating keys. Private key generated for the user.
    # @return [String, nil] the field value, or nil when absent.
    def generated_private_key
      @attributes[:generated_private_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def generated_private_key=(value)
      @attributes[:generated_private_key] = value
    end

    # Only returned when generating keys. Public key generated for the user.
    # @return [String, nil] the field value, or nil when absent.
    def generated_public_key
      @attributes[:generated_public_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def generated_public_key=(value)
      @attributes[:generated_public_key] = value
    end

    # Username of the user this public key is associated with
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def username=(value)
      @attributes[:username] = value
    end

    # User ID this public key is associated with
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def user_id=(value)
      @attributes[:user_id] = value
    end

    # Actual contents of SSH key.
    # @return [String, nil] the field value, or nil when absent.
    def public_key
      @attributes[:public_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_key=(value)
      @attributes[:public_key] = value
    end

    # If true, generate a new SSH key pair. Can not be used with `public_key`
    # @return [Boolean, nil] the field value, or nil when absent.
    def generate_keypair
      @attributes[:generate_keypair]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def generate_keypair=(value)
      @attributes[:generate_keypair] = value
    end

    # Password for the private key. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    # @return [String, nil] the field value, or nil when absent.
    def generate_private_key_password
      @attributes[:generate_private_key_password]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def generate_private_key_password=(value)
      @attributes[:generate_private_key_password] = value
    end

    # Type of key to generate.  One of rsa, dsa, ecdsa, ed25519. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    # @return [String, nil] the field value, or nil when absent.
    def generate_algorithm
      @attributes[:generate_algorithm]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def generate_algorithm=(value)
      @attributes[:generate_algorithm] = value
    end

    # Length of key to generate. If algorithm is ecdsa, this is the signature size. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    # @return [Integer, nil] the field value, or nil when absent.
    def generate_length
      @attributes[:generate_length]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def generate_length=(value)
      @attributes[:generate_length] = value
    end

    # Update Public Key
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] title Required. Internal reference for key.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: title must be an String") if !params[:title].nil? and !params[:title].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: title") if params[:title].nil?

      response, options = Api.send_request("/public_keys/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("PublicKey") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Public Key
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

      response, options = Api.send_request("/public_keys/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = PublicKey.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Public Keys
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `user_id`, `title` or `created_at`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at` and `workspace_id`. Valid field combinations are `[ workspace_id, created_at ]`.
    # @option params [Hash] filter_gt If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_gteq If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_lt If set, return records where the specified field is less than the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_lteq If set, return records where the specified field is less than or equal the supplied value. Valid fields are `created_at`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if !params[:filter_gt].nil? and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if !params[:filter_gteq].nil? and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if !params[:filter_lt].nil? and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if !params[:filter_lteq].nil? and !params[:filter_lteq].is_a?(Hash)

      list_options = options.dup
      List.new(PublicKey, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/public_keys", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Public Key
    #
    # @param id [Integer] Public Key ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::PublicKey] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/public_keys/#{params[:id]}", :get, params, options) { |reply| reply.require_object("PublicKey") }
      PublicKey.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Public Key
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] title Required. Internal reference for key.
    # @option params [String] public_key Actual contents of SSH key.
    # @option params [Boolean] generate_keypair If true, generate a new SSH key pair. Can not be used with `public_key`
    # @option params [String] generate_private_key_password Password for the private key. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    # @option params [String] generate_algorithm Type of key to generate.  One of rsa, dsa, ecdsa, ed25519. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    # @option params [Integer] generate_length Length of key to generate. If algorithm is ecdsa, this is the signature size. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::PublicKey] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: title must be an String") if !params[:title].nil? and !params[:title].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if !params[:public_key].nil? and !params[:public_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: generate_keypair must be a single value, not #{params[:generate_keypair].class}") if [ Array, Hash ].any? { |klass| params[:generate_keypair].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: generate_private_key_password must be an String") if !params[:generate_private_key_password].nil? and !params[:generate_private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: generate_algorithm must be an String") if !params[:generate_algorithm].nil? and !params[:generate_algorithm].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: generate_length must be an Integer") if !params[:generate_length].nil? and !params[:generate_length].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: title") if params[:title].nil?

      response, options = Api.send_request("/public_keys", :post, params, options) { |reply| reply.require_object("PublicKey") }
      PublicKey.new(response.data, options)
    end

    # Update Public Key
    #
    # @param id [Integer] Public Key ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] title Required. Internal reference for key.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::PublicKey] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: title must be an String") if !params[:title].nil? and !params[:title].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: title") if params[:title].nil?

      response, options = Api.send_request("/public_keys/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("PublicKey") }
      PublicKey.new(response.data, options)
    end

    # Delete Public Key
    #
    # @param id [Integer] Public Key ID.
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

      Api.send_request("/public_keys/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
