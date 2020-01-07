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

    # string - Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
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

    # Create Permission
    #
    # Parameters:
    #   group_id - integer - Group ID
    #   permission - object -  Permission type.  Can be `admin`, `full`, `readonly`, `writeonly`, `previewonly`, or `history`
    #   recursive - boolean - Apply to subfolders recursively?
    #   user_id - integer - User ID.  Provide `username` or `user_id`
    #   username - string - User username.  Provide `username` or `user_id`
    def create(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params.dig(:group_id) and !params.dig(:group_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params.dig(:username) and !params.dig(:username).is_a?(String)

      Api.send_request("/permissions", :post, params, @options)
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
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   path - string - Permission path.  If provided, will scope permissions to this path.
    #   group_id - string - Group ID.  If provided, will scope permissions to this group.
    #   user_id - string - User ID.  If provided, will scope permissions to this user.
    #   include_groups - boolean - If searching by user or group, also include user's permissions that are inherited from its groups?
    def self.list(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an String") if params.dig(:group_id) and !params.dig(:group_id).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_id must be an String") if params.dig(:user_id) and !params.dig(:user_id).is_a?(String)

      response, options = Api.send_request("/permissions", :get, params, options)
      response.data.map { |object| Permission.new(object, options) }
    end

    def self.all(path, params = {}, options = {})
      list(path, params, options)
    end

    # Create Permission
    #
    # Parameters:
    #   group_id - integer - Group ID
    #   permission - object -  Permission type.  Can be `admin`, `full`, `readonly`, `writeonly`, `previewonly`, or `history`
    #   recursive - boolean - Apply to subfolders recursively?
    #   user_id - integer - User ID.  Provide `username` or `user_id`
    #   username - string - User username.  Provide `username` or `user_id`
    def self.create(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params.dig(:group_id) and !params.dig(:group_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params.dig(:username) and !params.dig(:username).is_a?(String)

      response, options = Api.send_request("/permissions", :post, params, options)
      Permission.new(response.data, options)
    end

    # Parameters:
    #   id (required) - integer - Permission ID.
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
