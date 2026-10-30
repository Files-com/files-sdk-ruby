# frozen_string_literal: true

module Files
  # Files::EventTarget is the Ruby SDK's representation of Files.com API EventTarget objects.
  # Each instance keeps its API field values in +attributes+.
  class EventTarget
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Event Target ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def id=(value)
      @attributes[:id] = value
    end

    # Event Target name.
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def name=(value)
      @attributes[:name] = value
    end

    # Event Target type.
    # @return [String, nil] the field value, or nil when absent.
    def target_type
      @attributes[:target_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def target_type=(value)
      @attributes[:target_type] = value
    end

    # Workspace ID. 0 means the default workspace or site-wide.
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # If true, this default-workspace target can receive events from all workspaces.
    # @return [Boolean, nil] the field value, or nil when absent.
    def apply_to_all_workspaces
      @attributes[:apply_to_all_workspaces]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def apply_to_all_workspaces=(value)
      @attributes[:apply_to_all_workspaces] = value
    end

    # Whether this Event Target can receive events.
    # @return [Boolean, nil] the field value, or nil when absent.
    def enabled
      @attributes[:enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def enabled=(value)
      @attributes[:enabled] = value
    end

    # Event Target configuration. Fields depend on target_type.
    # @return [Hash, nil] the field value, or nil when absent.
    def config
      @attributes[:config]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def config=(value)
      @attributes[:config] = value
    end

    # Event Target delivery policy. Email and folder targets support batch_interval in seconds, between 600 and 86400. Slack and Teams support delivery_mode (immediate or subfolder_summary), summary_path (empty string means root), and summary_delay (15–300 seconds, default 60). The summary applies to matching file activity under summary_path; other matching events retain immediate delivery.
    # @return [Hash, nil] the field value, or nil when absent.
    def delivery_policy
      @attributes[:delivery_policy]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def delivery_policy=(value)
      @attributes[:delivery_policy] = value
    end

    # Event Target create date/time.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Event Target update date/time.
    # @return [String, nil] the field value, or nil when absent.
    def updated_at
      @attributes[:updated_at]
    end

    # Update Event Target
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Event Target name.
    # @option params [Integer] workspace_id Workspace ID. 0 means the default workspace or site-wide.
    # @option params [Boolean] apply_to_all_workspaces If true, this default-workspace target can receive events from all workspaces.
    # @option params [Boolean] enabled Whether this Event Target can receive events.
    # @option params [Hash] config Event Target configuration. Fields depend on target_type.
    # @option params [Hash] delivery_policy Event Target delivery policy. Email and folder targets support batch_interval in seconds, between 600 and 86400. Slack and Teams support delivery_mode (immediate or subfolder_summary), summary_path (empty string means root), and summary_delay (15–300 seconds, default 60). The summary applies to matching file activity under summary_path; other matching events retain immediate delivery.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: apply_to_all_workspaces must be a single value, not #{params[:apply_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:apply_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: enabled must be a single value, not #{params[:enabled].class}") if [ Array, Hash ].any? { |klass| params[:enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: config must be an Hash") if !params[:config].nil? and !params[:config].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: delivery_policy must be an Hash") if !params[:delivery_policy].nil? and !params[:delivery_policy].is_a?(Hash)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/event_targets/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("EventTarget") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Event Target
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/event_targets/#{@attributes[:id]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Calls {#delete} and discards its response.
    # @param (see #delete)
    # @option (see #delete)
    # @raise (see #delete)
    # @return [nil]
    def destroy(params = {})
      delete(params)
      nil
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = EventTarget.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Event Targets
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `name`, `enabled` or `workspace_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `enabled`, `target_type` or `workspace_id`. Valid field combinations are `[ enabled, target_type ]`, `[ workspace_id, enabled ]` or `[ workspace_id, enabled, target_type ]`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)

      list_options = options.dup
      List.new(EventTarget, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/event_targets", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Event Target
    #
    # @param id [Integer] Event Target ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::EventTarget] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/event_targets/#{params[:id]}", :get, params, options) { |reply| reply.require_object("EventTarget") }
      EventTarget.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Event Target
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Required. Event Target name.
    # @option params [Integer] workspace_id Workspace ID. 0 means the default workspace or site-wide.
    # @option params [Boolean] apply_to_all_workspaces If true, this default-workspace target can receive events from all workspaces.
    # @option params [Boolean] enabled Whether this Event Target can receive events.
    # @option params [Hash] config Required. Event Target configuration. Fields depend on target_type.
    # @option params [Hash] delivery_policy Event Target delivery policy. Email and folder targets support batch_interval in seconds, between 600 and 86400. Slack and Teams support delivery_mode (immediate or subfolder_summary), summary_path (empty string means root), and summary_delay (15–300 seconds, default 60). The summary applies to matching file activity under summary_path; other matching events retain immediate delivery.
    # @option params [String] target_type Required. Event Target type.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::EventTarget] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: apply_to_all_workspaces must be a single value, not #{params[:apply_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:apply_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: enabled must be a single value, not #{params[:enabled].class}") if [ Array, Hash ].any? { |klass| params[:enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: config must be an Hash") if !params[:config].nil? and !params[:config].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: delivery_policy must be an Hash") if !params[:delivery_policy].nil? and !params[:delivery_policy].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: target_type must be an String") if !params[:target_type].nil? and !params[:target_type].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?
      raise MissingParameterError.new("Parameter missing: config") if params[:config].nil?
      raise MissingParameterError.new("Parameter missing: target_type") if params[:target_type].nil?

      response, options = Api.send_request("/event_targets", :post, params, options) { |reply| reply.require_object("EventTarget") }
      EventTarget.new(response.data, options)
    end

    # Update Event Target
    #
    # @param id [Integer] Event Target ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Event Target name.
    # @option params [Integer] workspace_id Workspace ID. 0 means the default workspace or site-wide.
    # @option params [Boolean] apply_to_all_workspaces If true, this default-workspace target can receive events from all workspaces.
    # @option params [Boolean] enabled Whether this Event Target can receive events.
    # @option params [Hash] config Event Target configuration. Fields depend on target_type.
    # @option params [Hash] delivery_policy Event Target delivery policy. Email and folder targets support batch_interval in seconds, between 600 and 86400. Slack and Teams support delivery_mode (immediate or subfolder_summary), summary_path (empty string means root), and summary_delay (15–300 seconds, default 60). The summary applies to matching file activity under summary_path; other matching events retain immediate delivery.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::EventTarget] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: apply_to_all_workspaces must be a single value, not #{params[:apply_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:apply_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: enabled must be a single value, not #{params[:enabled].class}") if [ Array, Hash ].any? { |klass| params[:enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: config must be an Hash") if !params[:config].nil? and !params[:config].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: delivery_policy must be an Hash") if !params[:delivery_policy].nil? and !params[:delivery_policy].is_a?(Hash)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/event_targets/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("EventTarget") }
      EventTarget.new(response.data, options)
    end

    # Delete Event Target
    #
    # @param id [Integer] Event Target ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/event_targets/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
