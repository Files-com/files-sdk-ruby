# frozen_string_literal: true

module Files
  class KeyLifecycleRule
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Key Lifecycle Rule ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Key type for which the rule will apply (gpg or ssh).
    def key_type
      @attributes[:key_type]
    end

    def key_type=(value)
      @attributes[:key_type] = value
    end

    # int64 - Number of days of inactivity before the rule applies.
    def inactivity_days
      @attributes[:inactivity_days]
    end

    def inactivity_days=(value)
      @attributes[:inactivity_days] = value
    end

    # string - Key Lifecycle Rule name
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # Parameters:
    #   key_type - string - Key type for which the rule will apply (gpg or ssh).
    #   inactivity_days - int64 - Number of days of inactivity before the rule applies.
    #   name - string - Key Lifecycle Rule name
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: key_type must be an String") if params[:key_type] and !params[:key_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: inactivity_days must be an Integer") if params[:inactivity_days] and !params[:inactivity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/key_lifecycle_rules/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/key_lifecycle_rules/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = KeyLifecycleRule.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `key_type`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `key_type`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(KeyLifecycleRule, params) do
        Api.send_request("/key_lifecycle_rules", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Key Lifecycle Rule ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/key_lifecycle_rules/#{params[:id]}", :get, params, options)
      KeyLifecycleRule.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   key_type - string - Key type for which the rule will apply (gpg or ssh).
    #   inactivity_days - int64 - Number of days of inactivity before the rule applies.
    #   name - string - Key Lifecycle Rule name
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: key_type must be an String") if params[:key_type] and !params[:key_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: inactivity_days must be an Integer") if params[:inactivity_days] and !params[:inactivity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)

      response, options = Api.send_request("/key_lifecycle_rules", :post, params, options)
      KeyLifecycleRule.new(response.data, options)
    end

    # Parameters:
    #   key_type - string - Key type for which the rule will apply (gpg or ssh).
    #   inactivity_days - int64 - Number of days of inactivity before the rule applies.
    #   name - string - Key Lifecycle Rule name
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: key_type must be an String") if params[:key_type] and !params[:key_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: inactivity_days must be an Integer") if params[:inactivity_days] and !params[:inactivity_days].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/key_lifecycle_rules/#{params[:id]}", :patch, params, options)
      KeyLifecycleRule.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/key_lifecycle_rules/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
