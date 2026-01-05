# frozen_string_literal: true

module Files
  class GpgKey
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - GPG key ID.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Workspace ID (0 for default workspace).
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # date-time - GPG key expiration date.
    def expires_at
      @attributes[:expires_at]
    end

    def expires_at=(value)
      @attributes[:expires_at] = value
    end

    # string - GPG key name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # int64 - Partner ID who owns this GPG Key, if applicable.
    def partner_id
      @attributes[:partner_id]
    end

    def partner_id=(value)
      @attributes[:partner_id] = value
    end

    # string - Name of the Partner who owns this GPG Key, if applicable.
    def partner_name
      @attributes[:partner_name]
    end

    def partner_name=(value)
      @attributes[:partner_name] = value
    end

    # int64 - User ID who owns this GPG Key, if applicable.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # string - MD5 hash of the GPG public key
    def public_key_md5
      @attributes[:public_key_md5]
    end

    def public_key_md5=(value)
      @attributes[:public_key_md5] = value
    end

    # string - MD5 hash of the GPG private key.
    def private_key_md5
      @attributes[:private_key_md5]
    end

    def private_key_md5=(value)
      @attributes[:private_key_md5] = value
    end

    # string - GPG public key
    def generated_public_key
      @attributes[:generated_public_key]
    end

    def generated_public_key=(value)
      @attributes[:generated_public_key] = value
    end

    # string - GPG private key.
    def generated_private_key
      @attributes[:generated_private_key]
    end

    def generated_private_key=(value)
      @attributes[:generated_private_key] = value
    end

    # string - GPG private key password. Only required for password protected keys.
    def private_key_password_md5
      @attributes[:private_key_password_md5]
    end

    def private_key_password_md5=(value)
      @attributes[:private_key_password_md5] = value
    end

    # string - The GPG public key
    def public_key
      @attributes[:public_key]
    end

    def public_key=(value)
      @attributes[:public_key] = value
    end

    # string - The GPG private key
    def private_key
      @attributes[:private_key]
    end

    def private_key=(value)
      @attributes[:private_key] = value
    end

    # string - The GPG private key password
    def private_key_password
      @attributes[:private_key_password]
    end

    def private_key_password=(value)
      @attributes[:private_key_password] = value
    end

    # string - Expiration date of the key. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    def generate_expires_at
      @attributes[:generate_expires_at]
    end

    def generate_expires_at=(value)
      @attributes[:generate_expires_at] = value
    end

    # boolean - If true, generate a new GPG key pair. Can not be used with `public_key`/`private_key`
    def generate_keypair
      @attributes[:generate_keypair]
    end

    def generate_keypair=(value)
      @attributes[:generate_keypair] = value
    end

    # string - Full name of the key owner. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    def generate_full_name
      @attributes[:generate_full_name]
    end

    def generate_full_name=(value)
      @attributes[:generate_full_name] = value
    end

    # string - Email address of the key owner. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    def generate_email
      @attributes[:generate_email]
    end

    def generate_email=(value)
      @attributes[:generate_email] = value
    end

    # Parameters:
    #   partner_id - int64 - Partner ID who owns this GPG Key, if applicable.
    #   public_key - string - The GPG public key
    #   private_key - string - The GPG private key
    #   private_key_password - string - The GPG private key password
    #   name - string - GPG key name.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if params[:partner_id] and !params[:partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if params[:public_key] and !params[:public_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if params[:private_key_password] and !params[:private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/gpg_keys/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/gpg_keys/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = GpgKey.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `name` or `expires_at`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id`, `partner_id` or `expires_at`. Valid field combinations are `[ workspace_id, expires_at ]`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `expires_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `expires_at`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `expires_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `expires_at`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)

      List.new(GpgKey, params) do
        Api.send_request("/gpg_keys", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Gpg Key ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/gpg_keys/#{params[:id]}", :get, params, options)
      GpgKey.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   partner_id - int64 - Partner ID who owns this GPG Key, if applicable.
    #   public_key - string - The GPG public key
    #   private_key - string - The GPG private key
    #   private_key_password - string - The GPG private key password
    #   name (required) - string - GPG key name.
    #   workspace_id - int64 - Workspace ID (0 for default workspace).
    #   generate_expires_at - string - Expiration date of the key. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    #   generate_keypair - boolean - If true, generate a new GPG key pair. Can not be used with `public_key`/`private_key`
    #   generate_full_name - string - Full name of the key owner. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    #   generate_email - string - Email address of the key owner. Used for the generation of the key. Will be ignored if `generate_keypair` is false.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if params[:partner_id] and !params[:partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if params[:public_key] and !params[:public_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if params[:private_key_password] and !params[:private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: generate_expires_at must be an String") if params[:generate_expires_at] and !params[:generate_expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: generate_full_name must be an String") if params[:generate_full_name] and !params[:generate_full_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: generate_email must be an String") if params[:generate_email] and !params[:generate_email].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]

      response, options = Api.send_request("/gpg_keys", :post, params, options)
      GpgKey.new(response.data, options)
    end

    # Parameters:
    #   partner_id - int64 - Partner ID who owns this GPG Key, if applicable.
    #   public_key - string - The GPG public key
    #   private_key - string - The GPG private key
    #   private_key_password - string - The GPG private key password
    #   name - string - GPG key name.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if params[:partner_id] and !params[:partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if params[:public_key] and !params[:public_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_password must be an String") if params[:private_key_password] and !params[:private_key_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/gpg_keys/#{params[:id]}", :patch, params, options)
      GpgKey.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/gpg_keys/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
