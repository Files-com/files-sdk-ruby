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

    # array - A list of usernames for users in this group
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
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params.dig(:group_id) and !params.dig(:group_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: group_id") unless params.dig(:group_id)
      raise MissingParameterError.new("Parameter missing: user_id") unless params.dig(:user_id)

      Api.send_request("/group_users/#{@attributes[:id]}", :patch, params, @options)
    end

    # Parameters:
    #   group_id (required) - int64 - Group ID from which to remove user.
    #   user_id (required) - int64 - User ID to remove from group.
    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params.dig(:group_id) and !params.dig(:group_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: group_id") unless params.dig(:group_id)
      raise MissingParameterError.new("Parameter missing: user_id") unless params.dig(:user_id)

      Api.send_request("/group_users/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      update(@attributes)
    end

    # Parameters:
    #   user_id - int64 - User ID.  If provided, will return group_users of this user.
    #   page - int64 - Current page number.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   cursor - string - Send cursor to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   group_id - int64 - Group ID.  If provided, will return group_users of this group.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params.dig(:group_id) and !params.dig(:group_id).is_a?(Integer)

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
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params.dig(:group_id) and !params.dig(:group_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: group_id") unless params.dig(:group_id)
      raise MissingParameterError.new("Parameter missing: user_id") unless params.dig(:user_id)

      response, options = Api.send_request("/group_users/#{params[:id]}", :patch, params, options)
      GroupUser.new(response.data, options)
    end

    # Parameters:
    #   group_id (required) - int64 - Group ID from which to remove user.
    #   user_id (required) - int64 - User ID to remove from group.
    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params.dig(:group_id) and !params.dig(:group_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: group_id") unless params.dig(:group_id)
      raise MissingParameterError.new("Parameter missing: user_id") unless params.dig(:user_id)

      response, _options = Api.send_request("/group_users/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
