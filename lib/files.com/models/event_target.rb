# frozen_string_literal: true

module Files
  class EventTarget
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Event Target ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Event Target name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Event Target type.
    def target_type
      @attributes[:target_type]
    end

    def target_type=(value)
      @attributes[:target_type] = value
    end

    # int64 - Workspace ID. 0 means the default workspace or site-wide.
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # boolean - If true, this default-workspace target can receive events from all workspaces.
    def apply_to_all_workspaces
      @attributes[:apply_to_all_workspaces]
    end

    def apply_to_all_workspaces=(value)
      @attributes[:apply_to_all_workspaces] = value
    end

    # boolean - Whether this Event Target can receive events.
    def enabled
      @attributes[:enabled]
    end

    def enabled=(value)
      @attributes[:enabled] = value
    end

    # object - Event Target configuration.
    def config
      @attributes[:config]
    end

    def config=(value)
      @attributes[:config] = value
    end

    # object - Event Target delivery policy. Email targets support batch_interval in seconds, between 600 and 86400.
    def delivery_policy
      @attributes[:delivery_policy]
    end

    def delivery_policy=(value)
      @attributes[:delivery_policy] = value
    end

    # date-time - Event Target create date/time.
    def created_at
      @attributes[:created_at]
    end

    # date-time - Event Target update date/time.
    def updated_at
      @attributes[:updated_at]
    end

    # Parameters:
    #   name - string - Event Target name.
    #   workspace_id - int64 - Workspace ID. 0 means the default workspace or site-wide.
    #   apply_to_all_workspaces - boolean - If true, this default-workspace target can receive events from all workspaces.
    #   target_type - string - Event Target type.
    #   enabled - boolean - Whether this Event Target can receive events.
    #   config - object - Event Target configuration.
    #   delivery_policy - object - Event Target delivery policy. Email targets support batch_interval in seconds, between 600 and 86400.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: target_type must be an String") if params[:target_type] and !params[:target_type].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/event_targets/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/event_targets/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = EventTarget.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `name`, `enabled` or `workspace_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `enabled`, `target_type` or `workspace_id`. Valid field combinations are `[ enabled, target_type ]`, `[ workspace_id, enabled ]` or `[ workspace_id, enabled, target_type ]`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(EventTarget, params) do
        Api.send_request("/event_targets", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Event Target ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/event_targets/#{params[:id]}", :get, params, options)
      EventTarget.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name (required) - string - Event Target name.
    #   workspace_id - int64 - Workspace ID. 0 means the default workspace or site-wide.
    #   apply_to_all_workspaces - boolean - If true, this default-workspace target can receive events from all workspaces.
    #   target_type (required) - string - Event Target type.
    #   enabled - boolean - Whether this Event Target can receive events.
    #   config (required) - object - Event Target configuration.
    #   delivery_policy - object - Event Target delivery policy. Email targets support batch_interval in seconds, between 600 and 86400.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: target_type must be an String") if params[:target_type] and !params[:target_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: config must be an Hash") if params[:config] and !params[:config].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: delivery_policy must be an Hash") if params[:delivery_policy] and !params[:delivery_policy].is_a?(Hash)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]
      raise MissingParameterError.new("Parameter missing: target_type") unless params[:target_type]
      raise MissingParameterError.new("Parameter missing: config") unless params[:config]

      response, options = Api.send_request("/event_targets", :post, params, options)
      EventTarget.new(response.data, options)
    end

    # Parameters:
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `name`, `enabled` or `workspace_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `enabled`, `target_type` or `workspace_id`. Valid field combinations are `[ enabled, target_type ]`, `[ workspace_id, enabled ]` or `[ workspace_id, enabled, target_type ]`.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      response, options = Api.send_request("/event_targets/create_export", :post, params, options)
      Export.new(response.data, options)
    end

    # Parameters:
    #   name - string - Event Target name.
    #   workspace_id - int64 - Workspace ID. 0 means the default workspace or site-wide.
    #   apply_to_all_workspaces - boolean - If true, this default-workspace target can receive events from all workspaces.
    #   target_type - string - Event Target type.
    #   enabled - boolean - Whether this Event Target can receive events.
    #   config - object - Event Target configuration.
    #   delivery_policy - object - Event Target delivery policy. Email targets support batch_interval in seconds, between 600 and 86400.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: target_type must be an String") if params[:target_type] and !params[:target_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: config must be an Hash") if params[:config] and !params[:config].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: delivery_policy must be an Hash") if params[:delivery_policy] and !params[:delivery_policy].is_a?(Hash)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/event_targets/#{params[:id]}", :patch, params, options)
      EventTarget.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/event_targets/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
