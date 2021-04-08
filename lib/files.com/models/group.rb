# frozen_string_literal: true

module Files
  class Group
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Group ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Group name
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - List of user IDs who are group administrators (separated by commas)
    def admin_ids
      @attributes[:admin_ids]
    end

    def admin_ids=(value)
      @attributes[:admin_ids] = value
    end

    # string - Notes about this group
    def notes
      @attributes[:notes]
    end

    def notes=(value)
      @attributes[:notes] = value
    end

    # array - List of user IDs who belong to this group (separated by commas)
    def user_ids
      @attributes[:user_ids]
    end

    def user_ids=(value)
      @attributes[:user_ids] = value
    end

    # array - List of usernames who belong to this group (separated by commas)
    def usernames
      @attributes[:usernames]
    end

    def usernames=(value)
      @attributes[:usernames] = value
    end

    # Parameters:
    #   name - string - Group name.
    #   notes - string - Group notes.
    #   user_ids - string - A list of user ids. If sent as a string, should be comma-delimited.
    #   admin_ids - string - A list of group admin user ids. If sent as a string, should be comma-delimited.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params.dig(:notes) and !params.dig(:notes).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params.dig(:user_ids) and !params.dig(:user_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: admin_ids must be an String") if params.dig(:admin_ids) and !params.dig(:admin_ids).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/groups/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/groups/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = Group.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `name`.
    #   filter - object - If set, return records where the specifiied field is equal to the supplied value. Valid fields are `name`.
    #   filter_gt - object - If set, return records where the specifiied field is greater than the supplied value. Valid fields are `name`.
    #   filter_gteq - object - If set, return records where the specifiied field is greater than or equal to the supplied value. Valid fields are `name`.
    #   filter_like - object - If set, return records where the specifiied field is equal to the supplied value. Valid fields are `name`.
    #   filter_lt - object - If set, return records where the specifiied field is less than the supplied value. Valid fields are `name`.
    #   filter_lteq - object - If set, return records where the specifiied field is less than or equal to the supplied value. Valid fields are `name`.
    #   ids - string - Comma-separated list of group ids to include in results.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params.dig(:sort_by) and !params.dig(:sort_by).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params.dig(:filter) and !params.dig(:filter).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params.dig(:filter_gt) and !params.dig(:filter_gt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params.dig(:filter_gteq) and !params.dig(:filter_gteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params.dig(:filter_like) and !params.dig(:filter_like).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params.dig(:filter_lt) and !params.dig(:filter_lt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params.dig(:filter_lteq) and !params.dig(:filter_lteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: ids must be an String") if params.dig(:ids) and !params.dig(:ids).is_a?(String)

      List.new(Group, params) do
        Api.send_request("/groups", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Group ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/groups/#{params[:id]}", :get, params, options)
      Group.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name - string - Group name.
    #   notes - string - Group notes.
    #   user_ids - string - A list of user ids. If sent as a string, should be comma-delimited.
    #   admin_ids - string - A list of group admin user ids. If sent as a string, should be comma-delimited.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params.dig(:notes) and !params.dig(:notes).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params.dig(:user_ids) and !params.dig(:user_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: admin_ids must be an String") if params.dig(:admin_ids) and !params.dig(:admin_ids).is_a?(String)

      response, options = Api.send_request("/groups", :post, params, options)
      Group.new(response.data, options)
    end

    # Parameters:
    #   name - string - Group name.
    #   notes - string - Group notes.
    #   user_ids - string - A list of user ids. If sent as a string, should be comma-delimited.
    #   admin_ids - string - A list of group admin user ids. If sent as a string, should be comma-delimited.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params.dig(:notes) and !params.dig(:notes).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params.dig(:user_ids) and !params.dig(:user_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: admin_ids must be an String") if params.dig(:admin_ids) and !params.dig(:admin_ids).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/groups/#{params[:id]}", :patch, params, options)
      Group.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/groups/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
