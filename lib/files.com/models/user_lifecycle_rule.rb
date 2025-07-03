# frozen_string_literal: true

module Files
  class UserLifecycleRule
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - User Lifecycle Rule ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - User authentication method for the rule
    def authentication_method
      @attributes[:authentication_method]
    end

    def authentication_method=(value)
      @attributes[:authentication_method] = value
    end

    # int64 - Number of days of inactivity before the rule applies
    def inactivity_days
      @attributes[:inactivity_days]
    end

    def inactivity_days=(value)
      @attributes[:inactivity_days] = value
    end

    # boolean - Include folder admins in the rule
    def include_folder_admins
      @attributes[:include_folder_admins]
    end

    def include_folder_admins=(value)
      @attributes[:include_folder_admins] = value
    end

    # boolean - Include site admins in the rule
    def include_site_admins
      @attributes[:include_site_admins]
    end

    def include_site_admins=(value)
      @attributes[:include_site_admins] = value
    end

    # string - Action to take on inactive users (disable or delete)
    def action
      @attributes[:action]
    end

    def action=(value)
      @attributes[:action] = value
    end

    # string - State of the users to apply the rule to (inactive or disabled)
    def user_state
      @attributes[:user_state]
    end

    def user_state=(value)
      @attributes[:user_state] = value
    end

    # string - User Lifecycle Rule name
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # int64 - Site ID
    def site_id
      @attributes[:site_id]
    end

    def site_id=(value)
      @attributes[:site_id] = value
    end

    # Parameters:
    #   action - string - Action to take on inactive users (disable or delete)
    #   authentication_method - string - User authentication method for the rule
    #   inactivity_days - int64 - Number of days of inactivity before the rule applies
    #   include_site_admins - boolean - Include site admins in the rule
    #   include_folder_admins - boolean - Include folder admins in the rule
    #   user_state - string - State of the users to apply the rule to (inactive or disabled)
    #   name - string - User Lifecycle Rule name
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params[:action] and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if params[:authentication_method] and !params[:authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: inactivity_days must be an Integer") if params[:inactivity_days] and !params[:inactivity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_state must be an String") if params[:user_state] and !params[:user_state].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/user_lifecycle_rules/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/user_lifecycle_rules/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = UserLifecycleRule.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(UserLifecycleRule, params) do
        Api.send_request("/user_lifecycle_rules", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - User Lifecycle Rule ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/user_lifecycle_rules/#{params[:id]}", :get, params, options)
      UserLifecycleRule.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   action - string - Action to take on inactive users (disable or delete)
    #   authentication_method - string - User authentication method for the rule
    #   inactivity_days - int64 - Number of days of inactivity before the rule applies
    #   include_site_admins - boolean - Include site admins in the rule
    #   include_folder_admins - boolean - Include folder admins in the rule
    #   user_state - string - State of the users to apply the rule to (inactive or disabled)
    #   name - string - User Lifecycle Rule name
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params[:action] and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if params[:authentication_method] and !params[:authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: inactivity_days must be an Integer") if params[:inactivity_days] and !params[:inactivity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_state must be an String") if params[:user_state] and !params[:user_state].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)

      response, options = Api.send_request("/user_lifecycle_rules", :post, params, options)
      UserLifecycleRule.new(response.data, options)
    end

    # Parameters:
    #   action - string - Action to take on inactive users (disable or delete)
    #   authentication_method - string - User authentication method for the rule
    #   inactivity_days - int64 - Number of days of inactivity before the rule applies
    #   include_site_admins - boolean - Include site admins in the rule
    #   include_folder_admins - boolean - Include folder admins in the rule
    #   user_state - string - State of the users to apply the rule to (inactive or disabled)
    #   name - string - User Lifecycle Rule name
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params[:action] and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: authentication_method must be an String") if params[:authentication_method] and !params[:authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: inactivity_days must be an Integer") if params[:inactivity_days] and !params[:inactivity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: user_state must be an String") if params[:user_state] and !params[:user_state].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/user_lifecycle_rules/#{params[:id]}", :patch, params, options)
      UserLifecycleRule.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/user_lifecycle_rules/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
