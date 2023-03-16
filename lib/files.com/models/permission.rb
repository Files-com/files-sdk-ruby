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

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/permissions/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The Permission object doesn't support updates.")
      else
        new_obj = Permission.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction (e.g. `sort_by[group_id]=desc`). Valid fields are `group_id`, `path`, `user_id` or `permission`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `group_id`, `user_id` or `path`. Valid field combinations are `[ group_id, path ]` and `[ user_id, path ]`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `path`.
    #   path - string - DEPRECATED: Permission path.  If provided, will scope permissions to this path. Use `filter[path]` instead.
    #   group_id - string - DEPRECATED: Group ID.  If provided, will scope permissions to this group. Use `filter[group_id]` instead.`
    #   user_id - string - DEPRECATED: User ID.  If provided, will scope permissions to this user. Use `filter[user_id]` instead.`
    #   include_groups - boolean - If searching by user or group, also include user's permissions that are inherited from its groups?
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an String") if params[:group_id] and !params[:group_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_id must be an String") if params[:user_id] and !params[:user_id].is_a?(String)

      List.new(Permission, params) do
        Api.send_request("/permissions", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   group_id - int64 - Group ID
    #   path - string - Folder path
    #   permission - string -  Permission type.  Can be `admin`, `full`, `readonly`, `writeonly`, `list`, or `history`
    #   recursive - boolean - Apply to subfolders recursively?
    #   user_id - int64 - User ID.  Provide `username` or `user_id`
    #   username - string - User username.  Provide `username` or `user_id`
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params[:group_id] and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission must be an String") if params[:permission] and !params[:permission].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)

      response, options = Api.send_request("/permissions", :post, params, options)
      Permission.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, _options = Api.send_request("/permissions/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
