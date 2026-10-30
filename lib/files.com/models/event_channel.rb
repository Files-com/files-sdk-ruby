# frozen_string_literal: true

module Files
  # Files::EventChannel is the Ruby SDK's representation of Files.com API EventChannel objects.
  # Each instance keeps its API field values in +attributes+.
  class EventChannel
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

    # Event Channel ID
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

    # Event Channel name.
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

    # Workspace ID. 0 means the default workspace.
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

    # Event Channel description.
    # @return [String, nil] the field value, or nil when absent.
    def description
      @attributes[:description]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def description=(value)
      @attributes[:description] = value
    end

    # Whether this Event Channel can dispatch events.
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

    # Whether this Event Channel is the default destination for newly published events.
    # @return [Boolean, nil] the field value, or nil when absent.
    def default_channel
      @attributes[:default_channel]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def default_channel=(value)
      @attributes[:default_channel] = value
    end

    # Event Channel create date/time.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Event Channel update date/time.
    # @return [String, nil] the field value, or nil when absent.
    def updated_at
      @attributes[:updated_at]
    end

    # Update Event Channel
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Event Channel name.
    # @option params [Integer] workspace_id Workspace ID. 0 means the default workspace.
    # @option params [String] description Event Channel description.
    # @option params [Boolean] enabled Whether this Event Channel can dispatch events.
    # @option params [Boolean] default_channel Whether this Event Channel is the default destination for newly published events.
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
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: enabled must be a single value, not #{params[:enabled].class}") if [ Array, Hash ].any? { |klass| params[:enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: default_channel must be a single value, not #{params[:default_channel].class}") if [ Array, Hash ].any? { |klass| params[:default_channel].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/event_channels/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("EventChannel") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Event Channel
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

      response, options = Api.send_request("/event_channels/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = EventChannel.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Event Channels
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `name`, `enabled`, `default_channel` or `workspace_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `enabled`, `default_channel` or `workspace_id`. Valid field combinations are `[ workspace_id, enabled ]` and `[ workspace_id, default_channel ]`.
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
      List.new(EventChannel, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/event_channels", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Event Channel
    #
    # @param id [Integer] Event Channel ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::EventChannel] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/event_channels/#{params[:id]}", :get, params, options) { |reply| reply.require_object("EventChannel") }
      EventChannel.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Event Channel
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Required. Event Channel name.
    # @option params [Integer] workspace_id Workspace ID. 0 means the default workspace.
    # @option params [String] description Event Channel description.
    # @option params [Boolean] enabled Whether this Event Channel can dispatch events.
    # @option params [Boolean] default_channel Whether this Event Channel is the default destination for newly published events.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::EventChannel] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: enabled must be a single value, not #{params[:enabled].class}") if [ Array, Hash ].any? { |klass| params[:enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: default_channel must be a single value, not #{params[:default_channel].class}") if [ Array, Hash ].any? { |klass| params[:default_channel].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?

      response, options = Api.send_request("/event_channels", :post, params, options) { |reply| reply.require_object("EventChannel") }
      EventChannel.new(response.data, options)
    end

    # Update Event Channel
    #
    # @param id [Integer] Event Channel ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Event Channel name.
    # @option params [Integer] workspace_id Workspace ID. 0 means the default workspace.
    # @option params [String] description Event Channel description.
    # @option params [Boolean] enabled Whether this Event Channel can dispatch events.
    # @option params [Boolean] default_channel Whether this Event Channel is the default destination for newly published events.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::EventChannel] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: enabled must be a single value, not #{params[:enabled].class}") if [ Array, Hash ].any? { |klass| params[:enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: default_channel must be a single value, not #{params[:default_channel].class}") if [ Array, Hash ].any? { |klass| params[:default_channel].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/event_channels/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("EventChannel") }
      EventChannel.new(response.data, options)
    end

    # Delete Event Channel
    #
    # @param id [Integer] Event Channel ID.
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

      Api.send_request("/event_channels/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
