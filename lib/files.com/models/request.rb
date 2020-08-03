# frozen_string_literal: true

module Files
  class Request
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Request ID
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

    # string - Source filename, if applicable
    def source
      @attributes[:source]
    end

    def source=(value)
      @attributes[:source] = value
    end

    # string - Destination filename
    def destination
      @attributes[:destination]
    end

    def destination=(value)
      @attributes[:destination] = value
    end

    # string - ID of automation that created request
    def automation_id
      @attributes[:automation_id]
    end

    def automation_id=(value)
      @attributes[:automation_id] = value
    end

    # string - User making the request (if applicable)
    def user_display_name
      @attributes[:user_display_name]
    end

    def user_display_name=(value)
      @attributes[:user_display_name] = value
    end

    # string - A list of user IDs to request the file from. If sent as a string, it should be comma-delimited.
    def user_ids
      @attributes[:user_ids]
    end

    def user_ids=(value)
      @attributes[:user_ids] = value
    end

    # string - A list of group IDs to request the file from. If sent as a string, it should be comma-delimited.
    def group_ids
      @attributes[:group_ids]
    end

    def group_ids=(value)
      @attributes[:group_ids] = value
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/requests/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The Request object doesn't support updates.")
      else
        new_obj = Request.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   page - int64 - Current page number.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   cursor - string - Send cursor to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `site_id`, `folder_id` or `destination`.
    #   mine - boolean - Only show requests of the current user?  (Defaults to true if current user is not a site admin.)
    #   path - string - Path to show requests for.  If omitted, shows all paths. Send `/` to represent the root directory.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params.dig(:sort_by) and !params.dig(:sort_by).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)

      List.new(Request, params) do
        Api.send_request("/requests", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   page - int64 - Current page number.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   cursor - string - Send cursor to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `site_id`, `folder_id` or `destination`.
    #   mine - boolean - Only show requests of the current user?  (Defaults to true if current user is not a site admin.)
    #   path (required) - string - Path to show requests for.  If omitted, shows all paths. Send `/` to represent the root directory.
    def self.get_folder(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params.dig(:sort_by) and !params.dig(:sort_by).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      List.new(Request, params) do
        Api.send_request("/requests/folders/#{params[:path]}", :get, params, options)
      end
    end

    # Parameters:
    #   path (required) - string - Folder path on which to request the file.
    #   destination (required) - string - Destination filename (without extension) to request.
    #   user_ids - string - A list of user IDs to request the file from. If sent as a string, it should be comma-delimited.
    #   group_ids - string - A list of group IDs to request the file from. If sent as a string, it should be comma-delimited.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params.dig(:destination) and !params.dig(:destination).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params.dig(:user_ids) and !params.dig(:user_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params.dig(:group_ids) and !params.dig(:group_ids).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: destination") unless params.dig(:destination)

      response, options = Api.send_request("/requests", :post, params, options)
      Request.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/requests/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
