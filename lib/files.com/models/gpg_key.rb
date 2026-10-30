# frozen_string_literal: true

module Files
  # Files::GpgKey is the Ruby SDK's representation of Files.com API GpgKey objects.
  # Each instance keeps its API field values in +attributes+.
  class GpgKey
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

    # GPG key ID.
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

    # GPG key expiration date.
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

    # GPG key name.
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

    # Partner ID who owns this GPG Key, if applicable.
    # @return [Integer, nil] the field value, or nil when absent.
    def partner_id
      @attributes[:partner_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def partner_id=(value)
      @attributes[:partner_id] = value
    end

    # Name of the Partner who owns this GPG Key, if applicable.
    # @return [String, nil] the field value, or nil when absent.
    def partner_name
      @attributes[:partner_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def partner_name=(value)
      @attributes[:partner_name] = value
    end

    # User ID who owns this GPG Key, if applicable.
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

    # MD5 hash of the GPG public key
    # @return [String, nil] the field value, or nil when absent.
    def public_key_md5
      @attributes[:public_key_md5]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_key_md5=(value)
      @attributes[:public_key_md5] = value
    end

    # MD5 hash of the GPG private key.
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

    # GPG public key
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

    # GPG private key.
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

    # GPG private key password. Only required for password protected keys.
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

    # The GPG public key
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

    # The GPG private key
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

    # The GPG private key password
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

    # Expiration date of the key. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    # @return [String, nil] the field value, or nil when absent.
    def generate_expires_at
      @attributes[:generate_expires_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def generate_expires_at=(value)
      @attributes[:generate_expires_at] = value
    end

    # If true, generate a new GPG key pair. Can not be used with `public_key`/`private_key`
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

    # Full name of the key owner. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    # @return [String, nil] the field value, or nil when absent.
    def generate_full_name
      @attributes[:generate_full_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def generate_full_name=(value)
      @attributes[:generate_full_name] = value
    end

    # Email address of the key owner. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    # @return [String, nil] the field value, or nil when absent.
    def generate_email
      @attributes[:generate_email]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def generate_email=(value)
      @attributes[:generate_email] = value
    end

    # Update GPG Key
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] partner_id Partner ID who owns this GPG Key, if applicable.
    # @option params [String] public_key The GPG public key
    # @option params [String] private_key The GPG private key
    # @option params [String] private_key_password The GPG private key password
    # @option params [String] name GPG key name.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if !params[:partner_id].nil? and !params[:partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if !params[:public_key].nil? and !params[:public_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if !params[:private_key_password].nil? and !params[:private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/gpg_keys/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("GpgKey") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete GPG Key
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

      response, options = Api.send_request("/gpg_keys/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = GpgKey.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List GPG Keys
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `name` or `expires_at`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id`, `partner_id` or `expires_at`. Valid field combinations are `[ workspace_id, partner_id ]`, `[ workspace_id, expires_at ]`, `[ partner_id, expires_at ]` or `[ workspace_id, partner_id, expires_at ]`.
    # @option params [Hash] filter_gt If set, return records where the specified field is greater than the supplied value. Valid fields are `expires_at`.
    # @option params [Hash] filter_gteq If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `expires_at`.
    # @option params [Hash] filter_lt If set, return records where the specified field is less than the supplied value. Valid fields are `expires_at`.
    # @option params [Hash] filter_lteq If set, return records where the specified field is less than or equal the supplied value. Valid fields are `expires_at`.
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
      List.new(GpgKey, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/gpg_keys", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show GPG Key
    #
    # @param id [Integer] Gpg Key ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::GpgKey] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/gpg_keys/#{params[:id]}", :get, params, options) { |reply| reply.require_object("GpgKey") }
      GpgKey.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create GPG Key
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [Integer] partner_id Partner ID who owns this GPG Key, if applicable.
    # @option params [String] public_key The GPG public key
    # @option params [String] private_key The GPG private key
    # @option params [String] private_key_password The GPG private key password
    # @option params [String] name Required. GPG key name.
    # @option params [Integer] workspace_id Workspace ID (0 for default workspace).
    # @option params [String] generate_expires_at Expiration date of the key. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    # @option params [Boolean] generate_keypair If true, generate a new GPG key pair. Can not be used with `public_key`/`private_key`
    # @option params [String] generate_full_name Full name of the key owner. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    # @option params [String] generate_email Email address of the key owner. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::GpgKey] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if !params[:partner_id].nil? and !params[:partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if !params[:public_key].nil? and !params[:public_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if !params[:private_key_password].nil? and !params[:private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: generate_expires_at must be an String") if !params[:generate_expires_at].nil? and !params[:generate_expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: generate_keypair must be a single value, not #{params[:generate_keypair].class}") if [ Array, Hash ].any? { |klass| params[:generate_keypair].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: generate_full_name must be an String") if !params[:generate_full_name].nil? and !params[:generate_full_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: generate_email must be an String") if !params[:generate_email].nil? and !params[:generate_email].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?

      response, options = Api.send_request("/gpg_keys", :post, params, options) { |reply| reply.require_object("GpgKey") }
      GpgKey.new(response.data, options)
    end

    # Update GPG Key
    #
    # @param id [Integer] Gpg Key ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] partner_id Partner ID who owns this GPG Key, if applicable.
    # @option params [String] public_key The GPG public key
    # @option params [String] private_key The GPG private key
    # @option params [String] private_key_password The GPG private key password
    # @option params [String] name GPG key name.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::GpgKey] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if !params[:partner_id].nil? and !params[:partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if !params[:public_key].nil? and !params[:public_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if !params[:private_key_password].nil? and !params[:private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/gpg_keys/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("GpgKey") }
      GpgKey.new(response.data, options)
    end

    # Delete GPG Key
    #
    # @param id [Integer] Gpg Key ID.
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

      Api.send_request("/gpg_keys/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
