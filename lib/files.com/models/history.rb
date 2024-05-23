# frozen_string_literal: true

module Files
  class History
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Action ID
    def id
      @attributes[:id]
    end

    # string - Path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # date-time - Action occurrence date/time
    def when
      @attributes[:when]
    end

    # string - The destination path for this action, if applicable
    def destination
      @attributes[:destination]
    end

    # string - Friendly displayed output
    def display
      @attributes[:display]
    end

    # string - IP Address that performed this action
    def ip
      @attributes[:ip]
    end

    # string - The source path for this action, if applicable
    def source
      @attributes[:source]
    end

    # array(object) - Targets
    def targets
      @attributes[:targets]
    end

    # int64 - User ID
    def user_id
      @attributes[:user_id]
    end

    # string - Username
    def username
      @attributes[:username]
    end

    # string - Type of action
    def action
      @attributes[:action]
    end

    # string - Failure type.  If action was a user login or session failure, why did it fail?
    def failure_type
      @attributes[:failure_type]
    end

    # string - Interface on which this action occurred.
    def interface
      @attributes[:interface]
    end

    # Parameters:
    #   start_at - string - Leave blank or set to a date/time to filter earlier entries.
    #   end_at - string - Leave blank or set to a date/time to filter later entries.
    #   display - string - Display format. Leave blank or set to `full` or `parent`.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction (e.g. `sort_by[user_id]=desc`). Valid fields are `user_id` and `created_at`.
    #   path (required) - string - Path to operate on.
    def self.list_for_file(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if params[:start_at] and !params[:start_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if params[:end_at] and !params[:end_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: display must be an String") if params[:display] and !params[:display].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      List.new(Action, params) do
        Api.send_request("/history/files/#{params[:path]}", :get, params, options)
      end
    end

    # Parameters:
    #   start_at - string - Leave blank or set to a date/time to filter earlier entries.
    #   end_at - string - Leave blank or set to a date/time to filter later entries.
    #   display - string - Display format. Leave blank or set to `full` or `parent`.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction (e.g. `sort_by[user_id]=desc`). Valid fields are `user_id` and `created_at`.
    #   path (required) - string - Path to operate on.
    def self.list_for_folder(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if params[:start_at] and !params[:start_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if params[:end_at] and !params[:end_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: display must be an String") if params[:display] and !params[:display].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      List.new(Action, params) do
        Api.send_request("/history/folders/#{params[:path]}", :get, params, options)
      end
    end

    # Parameters:
    #   start_at - string - Leave blank or set to a date/time to filter earlier entries.
    #   end_at - string - Leave blank or set to a date/time to filter later entries.
    #   display - string - Display format. Leave blank or set to `full` or `parent`.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction (e.g. `sort_by[user_id]=desc`). Valid fields are `user_id` and `created_at`.
    #   user_id (required) - int64 - User ID.
    def self.list_for_user(user_id, params = {}, options = {})
      params ||= {}
      params[:user_id] = user_id
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if params[:start_at] and !params[:start_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if params[:end_at] and !params[:end_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: display must be an String") if params[:display] and !params[:display].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: user_id") unless params[:user_id]

      List.new(Action, params) do
        Api.send_request("/history/users/#{params[:user_id]}", :get, params, options)
      end
    end

    # Parameters:
    #   start_at - string - Leave blank or set to a date/time to filter earlier entries.
    #   end_at - string - Leave blank or set to a date/time to filter later entries.
    #   display - string - Display format. Leave blank or set to `full` or `parent`.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction (e.g. `sort_by[user_id]=desc`). Valid fields are `user_id` and `created_at`.
    def self.list_logins(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if params[:start_at] and !params[:start_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if params[:end_at] and !params[:end_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: display must be an String") if params[:display] and !params[:display].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)

      List.new(Action, params) do
        Api.send_request("/history/login", :get, params, options)
      end
    end

    # Parameters:
    #   start_at - string - Leave blank or set to a date/time to filter earlier entries.
    #   end_at - string - Leave blank or set to a date/time to filter later entries.
    #   display - string - Display format. Leave blank or set to `full` or `parent`.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction (e.g. `sort_by[path]=desc`). Valid fields are `path`, `folder`, `user_id` or `created_at`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `user_id`, `folder` or `path`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `path`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if params[:start_at] and !params[:start_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if params[:end_at] and !params[:end_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: display must be an String") if params[:display] and !params[:display].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

      List.new(Action, params) do
        Api.send_request("/history", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
