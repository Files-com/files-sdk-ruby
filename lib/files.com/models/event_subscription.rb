# frozen_string_literal: true

module Files
  class EventSubscription
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Event Subscription ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Event Channel ID
    def event_channel_id
      @attributes[:event_channel_id]
    end

    def event_channel_id=(value)
      @attributes[:event_channel_id] = value
    end

    # int64 - Workspace ID. 0 means the default workspace or site-wide.
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # boolean - If true, this default-workspace subscription applies to events from all workspaces.
    def apply_to_all_workspaces
      @attributes[:apply_to_all_workspaces]
    end

    def apply_to_all_workspaces=(value)
      @attributes[:apply_to_all_workspaces] = value
    end

    # string - Event Subscription name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # boolean - Whether this Event Subscription can dispatch events.
    def enabled
      @attributes[:enabled]
    end

    def enabled=(value)
      @attributes[:enabled] = value
    end

    # array(string) - Event type strings matched by this subscription. Blank means all event types.
    def event_types
      @attributes[:event_types]
    end

    def event_types=(value)
      @attributes[:event_types] = value
    end

    # object - Structured event payload filter.
    def filter
      @attributes[:filter]
    end

    def filter=(value)
      @attributes[:filter] = value
    end

    # object - Event Subscription delivery policy.
    def delivery_policy
      @attributes[:delivery_policy]
    end

    def delivery_policy=(value)
      @attributes[:delivery_policy] = value
    end

    # array(int64) - Event Target IDs this subscription sends to.
    def event_target_ids
      @attributes[:event_target_ids]
    end

    def event_target_ids=(value)
      @attributes[:event_target_ids] = value
    end

    # date-time - Event Subscription create date/time.
    def created_at
      @attributes[:created_at]
    end

    # date-time - Event Subscription update date/time.
    def updated_at
      @attributes[:updated_at]
    end

    # Parameters:
    #   event_channel_id - int64 - Event Channel ID
    #   workspace_id - int64 - Workspace ID. 0 means the default workspace or site-wide.
    #   apply_to_all_workspaces - boolean - If true, this default-workspace subscription applies to events from all workspaces.
    #   name - string - Event Subscription name.
    #   enabled - boolean - Whether this Event Subscription can dispatch events.
    #   event_types - array(string) - Event type strings matched by this subscription. Blank means all event types.
    #   filter - object - Structured event payload filter.
    #   delivery_policy - object - Event Subscription delivery policy.
    #   event_target_ids - array(int64) - Event Target IDs this subscription sends to.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: event_channel_id must be an Integer") if params[:event_channel_id] and !params[:event_channel_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: event_types must be an Array") if params[:event_types] and !params[:event_types].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: event_target_ids must be an Array") if params[:event_target_ids] and !params[:event_target_ids].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/event_subscriptions/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/event_subscriptions/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = EventSubscription.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `enabled`, `event_channel_id` or `workspace_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `enabled`, `event_channel_id` or `workspace_id`. Valid field combinations are `[ enabled, event_channel_id ]`, `[ workspace_id, enabled ]` or `[ workspace_id, enabled, event_channel_id ]`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(EventSubscription, params) do
        Api.send_request("/event_subscriptions", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Event Subscription ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/event_subscriptions/#{params[:id]}", :get, params, options)
      EventSubscription.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   event_channel_id - int64 - Event Channel ID
    #   workspace_id - int64 - Workspace ID. 0 means the default workspace or site-wide.
    #   apply_to_all_workspaces - boolean - If true, this default-workspace subscription applies to events from all workspaces.
    #   name (required) - string - Event Subscription name.
    #   enabled - boolean - Whether this Event Subscription can dispatch events.
    #   event_types - array(string) - Event type strings matched by this subscription. Blank means all event types.
    #   filter - object - Structured event payload filter.
    #   delivery_policy - object - Event Subscription delivery policy.
    #   event_target_ids - array(int64) - Event Target IDs this subscription sends to.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: event_channel_id must be an Integer") if params[:event_channel_id] and !params[:event_channel_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: event_types must be an Array") if params[:event_types] and !params[:event_types].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: delivery_policy must be an Hash") if params[:delivery_policy] and !params[:delivery_policy].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: event_target_ids must be an Array") if params[:event_target_ids] and !params[:event_target_ids].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]

      response, options = Api.send_request("/event_subscriptions", :post, params, options)
      EventSubscription.new(response.data, options)
    end

    # Parameters:
    #   event_channel_id - int64 - Event Channel ID
    #   workspace_id - int64 - Workspace ID. 0 means the default workspace or site-wide.
    #   apply_to_all_workspaces - boolean - If true, this default-workspace subscription applies to events from all workspaces.
    #   name - string - Event Subscription name.
    #   enabled - boolean - Whether this Event Subscription can dispatch events.
    #   event_types - array(string) - Event type strings matched by this subscription. Blank means all event types.
    #   filter - object - Structured event payload filter.
    #   delivery_policy - object - Event Subscription delivery policy.
    #   event_target_ids - array(int64) - Event Target IDs this subscription sends to.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: event_channel_id must be an Integer") if params[:event_channel_id] and !params[:event_channel_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: event_types must be an Array") if params[:event_types] and !params[:event_types].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: delivery_policy must be an Hash") if params[:delivery_policy] and !params[:delivery_policy].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: event_target_ids must be an Array") if params[:event_target_ids] and !params[:event_target_ids].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/event_subscriptions/#{params[:id]}", :patch, params, options)
      EventSubscription.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/event_subscriptions/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
