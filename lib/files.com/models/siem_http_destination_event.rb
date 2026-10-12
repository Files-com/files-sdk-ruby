# frozen_string_literal: true

module Files
  # Files::SiemHttpDestinationEvent is the Ruby SDK's representation of Files.com API SiemHttpDestinationEvent objects.
  # Each instance keeps its API field values in +attributes+.
  class SiemHttpDestinationEvent
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Event ID
    def id
      @attributes[:id]
    end

    # string - Type of SIEM event being recorded.
    def event_type
      @attributes[:event_type]
    end

    # string - Status of event.
    def status
      @attributes[:status]
    end

    # string - Event body.
    def body
      @attributes[:body]
    end

    # array(string) - Event errors.
    def event_errors
      @attributes[:event_errors]
    end

    # date-time - Event create date/time.
    def created_at
      @attributes[:created_at]
    end

    # string - Link to log file.
    def body_url
      @attributes[:body_url]
    end

    # int64 - SIEM ID.
    def siem_http_destination_id
      @attributes[:siem_http_destination_id]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`, `status` or `siem_http_destination_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at`, `siem_http_destination_id` or `status`. Valid field combinations are `[ siem_http_destination_id, created_at ]`, `[ status, created_at ]`, `[ siem_http_destination_id, status ]` or `[ siem_http_destination_id, status, created_at ]`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `created_at`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `created_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `created_at`.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::SiemHttpDestinationEvent objects.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if !params[:filter_gt].nil? and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if !params[:filter_gteq].nil? and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if !params[:filter_lt].nil? and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if !params[:filter_lteq].nil? and !params[:filter_lteq].is_a?(Hash)

      list_options = options.dup
      List.new(SiemHttpDestinationEvent, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/siem_http_destination_events", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Siem Http Destination Event ID.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::SiemHttpDestinationEvent.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/siem_http_destination_events/#{params[:id]}", :get, params, options) { |reply| reply.require_object("SiemHttpDestinationEvent") }
      SiemHttpDestinationEvent.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
