# frozen_string_literal: true

module Files
  # Files::ExternalEvent is the Ruby SDK's representation of Files.com API ExternalEvent objects.
  # Each instance keeps its API field values in +attributes+.
  class ExternalEvent
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Event ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Type of event being recorded.
    def event_type
      @attributes[:event_type]
    end

    def event_type=(value)
      @attributes[:event_type] = value
    end

    # string - Status of event.
    def status
      @attributes[:status]
    end

    def status=(value)
      @attributes[:status] = value
    end

    # string - Event body
    def body
      @attributes[:body]
    end

    def body=(value)
      @attributes[:body] = value
    end

    # date-time - External event create date/time
    def created_at
      @attributes[:created_at]
    end

    # string - Link to log file.
    def body_url
      @attributes[:body_url]
    end

    def body_url=(value)
      @attributes[:body_url] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The ExternalEvent object doesn't support updates.")
      else
        new_obj = ExternalEvent.create(@attributes, @options)
        @attributes = new_obj.attributes
      end

      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`, `status` or `event_type`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at` and `status`. Valid field combinations are `[ status, created_at ]`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `created_at`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `created_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `created_at`.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::ExternalEvent objects.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if !params[:filter_gt].nil? and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if !params[:filter_gteq].nil? and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if !params[:filter_lt].nil? and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if !params[:filter_lteq].nil? and !params[:filter_lteq].is_a?(Hash)

      List.new(ExternalEvent, params) do |page_params, &check_page|
        Api.send_request("/external_events", :get, page_params, options, &check_page)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - External Event ID.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::ExternalEvent.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/external_events/#{params[:id]}", :get, params, options) { |reply| reply.require_object("ExternalEvent") }
      ExternalEvent.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   status (required) - string - Status of event.
    #   body (required) - string - Event body
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::ExternalEvent.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: status must be an String") if !params[:status].nil? and !params[:status].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if !params[:body].nil? and !params[:body].is_a?(String)
      raise MissingParameterError.new("Parameter missing: status") if params[:status].nil?
      raise MissingParameterError.new("Parameter missing: body") if params[:body].nil?

      response, options = Api.send_request("/external_events", :post, params, options) { |reply| reply.require_object("ExternalEvent") }
      ExternalEvent.new(response.data, options)
    end
  end
end
