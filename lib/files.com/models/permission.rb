# frozen_string_literal: true

module Files
  class Permission
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Permission ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # int64 - User ID
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # string - User's username
    def username
      @attributes[:username]
    end

    def username=(value)
      @attributes[:username] = value
    end

    # int64 - Group ID
    def group_id
      @attributes[:group_id]
    end

    def group_id=(value)
      @attributes[:group_id] = value
    end

    # string - Group name if applicable
    def group_name
      @attributes[:group_name]
    end

    def group_name=(value)
      @attributes[:group_name] = value
    end

    # string - Permission type
    def permission
      @attributes[:permission]
    end

    def permission=(value)
      @attributes[:permission] = value
    end

    # boolean - Does this permission apply to subfolders?
    def recursive
      @attributes[:recursive]
    end

    def recursive=(value)
      @attributes[:recursive] = value
    end

    def save
      if @attributes[:path]
        raise NotImplementedError.new("The Permission object doesn't support updates.")
      else
        new_obj = Permission.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   page - int64 - Current page number.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   cursor - string - Send cursor to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `deleted_at`, `group_id`, `path`, `user_id` or `permission`.
    #   filter - object - If set, return records where the specifiied field is equal to the supplied value. Valid fields are `group_id`, `user_id` or `path`.
    #   filter_gt - object - If set, return records where the specifiied field is greater than the supplied value. Valid fields are `group_id`, `user_id` or `path`.
    #   filter_gteq - object - If set, return records where the specifiied field is greater than or equal to the supplied value. Valid fields are `group_id`, `user_id` or `path`.
    #   filter_like - object - If set, return records where the specifiied field is equal to the supplied value. Valid fields are `group_id`, `user_id` or `path`.
    #   filter_lt - object - If set, return records where the specifiied field is less than the supplied value. Valid fields are `group_id`, `user_id` or `path`.
    #   filter_lteq - object - If set, return records where the specifiied field is less than or equal to the supplied value. Valid fields are `group_id`, `user_id` or `path`.
    #   path - string - DEPRECATED: Permission path.  If provided, will scope permissions to this path. Use `filter[path]` instead.
    #   group_id - string - DEPRECATED: Group ID.  If provided, will scope permissions to this group. Use `filter[group_id]` instead.`
    #   user_id - string - DEPRECATED: User ID.  If provided, will scope permissions to this user. Use `filter[user_id]` instead.`
    #   include_groups - boolean - If searching by user or group, also include user's permissions that are inherited from its groups?
    def self.list(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params.dig(:sort_by) and !params.dig(:sort_by).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params.dig(:filter) and !params.dig(:filter).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params.dig(:filter_gt) and !params.dig(:filter_gt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params.dig(:filter_gteq) and !params.dig(:filter_gteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params.dig(:filter_like) and !params.dig(:filter_like).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params.dig(:filter_lt) and !params.dig(:filter_lt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params.dig(:filter_lteq) and !params.dig(:filter_lteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an String") if params.dig(:group_id) and !params.dig(:group_id).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_id must be an String") if params.dig(:user_id) and !params.dig(:user_id).is_a?(String)

      List.new(Permission, params) do
        Api.send_request("/permissions", :get, params, options)
      end
    end

    def self.all(path, params = {}, options = {})
      list(path, params, options)
    end

    # Parameters:
    #   group_id - int64 - Group ID
    #   path - string - Folder path
    #   permission - string -  Permission type.  Can be `admin`, `full`, `readonly`, `writeonly`, `list`, or `history`
    #   recursive - boolean - Apply to subfolders recursively?
    #   user_id - int64 - User ID.  Provide `username` or `user_id`
    #   username - string - User username.  Provide `username` or `user_id`
    def self.create(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params.dig(:group_id) and !params.dig(:group_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission must be an String") if params.dig(:permission) and !params.dig(:permission).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params.dig(:username) and !params.dig(:username).is_a?(String)

      response, options = Api.send_request("/permissions", :post, params, options)
      Permission.new(response.data, options)
    end

    # Parameters:
    #   id (required) - int64 - Permission ID.
    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/permissions/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
