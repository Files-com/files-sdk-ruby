# frozen_string_literal: true

module Files
  class EventChannel
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Event Channel ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Event Channel name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Event Channel description.
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # boolean - Whether this Event Channel can dispatch events.
    def enabled
      @attributes[:enabled]
    end

    def enabled=(value)
      @attributes[:enabled] = value
    end

    # boolean - Whether this Event Channel is the default destination for newly published events.
    def default_channel
      @attributes[:default_channel]
    end

    def default_channel=(value)
      @attributes[:default_channel] = value
    end

    # date-time - Event Channel create date/time.
    def created_at
      @attributes[:created_at]
    end

    # date-time - Event Channel update date/time.
    def updated_at
      @attributes[:updated_at]
    end

    # Parameters:
    #   name - string - Event Channel name.
    #   description - string - Event Channel description.
    #   enabled - boolean - Whether this Event Channel can dispatch events.
    #   default_channel - boolean - Whether this Event Channel is the default destination for newly published events.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/event_channels/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/event_channels/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = EventChannel.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `enabled` and `default_channel`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `enabled` and `default_channel`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(EventChannel, params) do
        Api.send_request("/event_channels", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Event Channel ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/event_channels/#{params[:id]}", :get, params, options)
      EventChannel.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name (required) - string - Event Channel name.
    #   description - string - Event Channel description.
    #   enabled - boolean - Whether this Event Channel can dispatch events.
    #   default_channel - boolean - Whether this Event Channel is the default destination for newly published events.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]

      response, options = Api.send_request("/event_channels", :post, params, options)
      EventChannel.new(response.data, options)
    end

    # Parameters:
    #   name - string - Event Channel name.
    #   description - string - Event Channel description.
    #   enabled - boolean - Whether this Event Channel can dispatch events.
    #   default_channel - boolean - Whether this Event Channel is the default destination for newly published events.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/event_channels/#{params[:id]}", :patch, params, options)
      EventChannel.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/event_channels/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
