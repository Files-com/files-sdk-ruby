# frozen_string_literal: true

module Files
  class Partner
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # boolean - Allow users created under this Partner to bypass Two-Factor Authentication policies.
    def allow_bypassing_2fa_policies
      @attributes[:allow_bypassing_2fa_policies]
    end

    def allow_bypassing_2fa_policies=(value)
      @attributes[:allow_bypassing_2fa_policies] = value
    end

    # boolean - Allow Partner Admins to change or reset credentials for users belonging to this Partner.
    def allow_credential_changes
      @attributes[:allow_credential_changes]
    end

    def allow_credential_changes=(value)
      @attributes[:allow_credential_changes] = value
    end

    # boolean - Allow Partner Admins to provide GPG keys.
    def allow_providing_gpg_keys
      @attributes[:allow_providing_gpg_keys]
    end

    def allow_providing_gpg_keys=(value)
      @attributes[:allow_providing_gpg_keys] = value
    end

    # boolean - Allow Partner Admins to create users.
    def allow_user_creation
      @attributes[:allow_user_creation]
    end

    def allow_user_creation=(value)
      @attributes[:allow_user_creation] = value
    end

    # int64 - The unique ID of the Partner.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - The name of the Partner.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Notes about this Partner.
    def notes
      @attributes[:notes]
    end

    def notes=(value)
      @attributes[:notes] = value
    end

    # string - The root folder path for this Partner.
    def root_folder
      @attributes[:root_folder]
    end

    def root_folder=(value)
      @attributes[:root_folder] = value
    end

    # string - Comma-separated list of Tags for this Partner. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    def tags
      @attributes[:tags]
    end

    def tags=(value)
      @attributes[:tags] = value
    end

    # array(int64) - Array of User IDs that belong to this Partner.
    def user_ids
      @attributes[:user_ids]
    end

    def user_ids=(value)
      @attributes[:user_ids] = value
    end

    # Parameters:
    #   name - string - The name of the Partner.
    #   allow_bypassing_2fa_policies - boolean - Allow users created under this Partner to bypass Two-Factor Authentication policies.
    #   allow_credential_changes - boolean - Allow Partner Admins to change or reset credentials for users belonging to this Partner.
    #   allow_providing_gpg_keys - boolean - Allow Partner Admins to provide GPG keys.
    #   allow_user_creation - boolean - Allow Partner Admins to create users.
    #   notes - string - Notes about this Partner.
    #   root_folder - string - The root folder path for this Partner.
    #   tags - string - Comma-separated list of Tags for this Partner. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params[:notes] and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: root_folder must be an String") if params[:root_folder] and !params[:root_folder].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: tags must be an String") if params[:tags] and !params[:tags].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partners/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partners/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = Partner.create(@attributes, @options)
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

      List.new(Partner, params) do
        Api.send_request("/partners", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Partner ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/partners/#{params[:id]}", :get, params, options)
      Partner.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name - string - The name of the Partner.
    #   allow_bypassing_2fa_policies - boolean - Allow users created under this Partner to bypass Two-Factor Authentication policies.
    #   allow_credential_changes - boolean - Allow Partner Admins to change or reset credentials for users belonging to this Partner.
    #   allow_providing_gpg_keys - boolean - Allow Partner Admins to provide GPG keys.
    #   allow_user_creation - boolean - Allow Partner Admins to create users.
    #   notes - string - Notes about this Partner.
    #   root_folder - string - The root folder path for this Partner.
    #   tags - string - Comma-separated list of Tags for this Partner. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params[:notes] and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: root_folder must be an String") if params[:root_folder] and !params[:root_folder].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: tags must be an String") if params[:tags] and !params[:tags].is_a?(String)

      response, options = Api.send_request("/partners", :post, params, options)
      Partner.new(response.data, options)
    end

    # Parameters:
    #   name - string - The name of the Partner.
    #   allow_bypassing_2fa_policies - boolean - Allow users created under this Partner to bypass Two-Factor Authentication policies.
    #   allow_credential_changes - boolean - Allow Partner Admins to change or reset credentials for users belonging to this Partner.
    #   allow_providing_gpg_keys - boolean - Allow Partner Admins to provide GPG keys.
    #   allow_user_creation - boolean - Allow Partner Admins to create users.
    #   notes - string - Notes about this Partner.
    #   root_folder - string - The root folder path for this Partner.
    #   tags - string - Comma-separated list of Tags for this Partner. Tags are used for other features, such as UserLifecycleRules, which can target specific tags.  Tags must only contain lowercase letters, numbers, and hyphens.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params[:notes] and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: root_folder must be an String") if params[:root_folder] and !params[:root_folder].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: tags must be an String") if params[:tags] and !params[:tags].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/partners/#{params[:id]}", :patch, params, options)
      Partner.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partners/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
