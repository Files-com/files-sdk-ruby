# frozen_string_literal: true

module Files
  class GroupUser
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Group name
    def group_name
      @attributes[:group_name]
    end

    def group_name=(value)
      @attributes[:group_name] = value
    end

    # int64 - Group ID
    def group_id
      @attributes[:group_id]
    end

    def group_id=(value)
      @attributes[:group_id] = value
    end

    # int64 - User ID
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # boolean - Is this user an administrator of this group?
    def admin
      @attributes[:admin]
    end

    def admin=(value)
      @attributes[:admin] = value
    end

    # string - Comma-delimited list of usernames who belong to this group (separated by commas).
    def usernames
      @attributes[:usernames]
    end

    def usernames=(value)
      @attributes[:usernames] = value
    end

    # int64 - Group User ID.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # Parameters:
    #   group_id (required) - int64 - Group ID to add user to.
    #   user_id (required) - int64 - User ID to add to group.
    #   admin - boolean - Is the user a group administrator?
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params[:group_id] and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: group_id") unless params[:group_id]
      raise MissingParameterError.new("Parameter missing: user_id") unless params[:user_id]

      Api.send_request("/group_users/#{@attributes[:id]}", :patch, params, @options)
    end

    # Parameters:
    #   group_id (required) - int64 - Group ID from which to remove user.
    #   user_id (required) - int64 - User ID to remove from group.
    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params[:group_id] and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: group_id") unless params[:group_id]
      raise MissingParameterError.new("Parameter missing: user_id") unless params[:user_id]

      Api.send_request("/group_users/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = GroupUser.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   user_id - int64 - User ID.  If provided, will return group_users of this user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   group_id - int64 - Group ID.  If provided, will return group_users of this group.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params[:group_id] and !params[:group_id].is_a?(Integer)

      List.new(GroupUser, params) do
        Api.send_request("/group_users", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   group_id (required) - int64 - Group ID to add user to.
    #   user_id (required) - int64 - User ID to add to group.
    #   admin - boolean - Is the user a group administrator?
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params[:group_id] and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: group_id") unless params[:group_id]
      raise MissingParameterError.new("Parameter missing: user_id") unless params[:user_id]

      response, options = Api.send_request("/group_users", :post, params, options)
      GroupUser.new(response.data, options)
    end

    # Parameters:
    #   group_id (required) - int64 - Group ID to add user to.
    #   user_id (required) - int64 - User ID to add to group.
    #   admin - boolean - Is the user a group administrator?
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params[:group_id] and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: group_id") unless params[:group_id]
      raise MissingParameterError.new("Parameter missing: user_id") unless params[:user_id]

      response, options = Api.send_request("/group_users/#{params[:id]}", :patch, params, options)
      GroupUser.new(response.data, options)
    end

    # Parameters:
    #   group_id (required) - int64 - Group ID from which to remove user.
    #   user_id (required) - int64 - User ID to remove from group.
    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params[:group_id] and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: group_id") unless params[:group_id]
      raise MissingParameterError.new("Parameter missing: user_id") unless params[:user_id]

      Api.send_request("/group_users/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
