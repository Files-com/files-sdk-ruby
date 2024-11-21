# frozen_string_literal: true

module Files
  class RemoteBandwidthSnapshot
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Site bandwidth ID
    def id
      @attributes[:id]
    end

    # double - Site sync bandwidth report bytes received
    def sync_bytes_received
      @attributes[:sync_bytes_received]
    end

    # double - Site sync bandwidth report bytes sent
    def sync_bytes_sent
      @attributes[:sync_bytes_sent]
    end

    # date-time - Time the site bandwidth report was logged
    def logged_at
      @attributes[:logged_at]
    end

    # int64 - ID of related Remote Server
    def remote_server_id
      @attributes[:remote_server_id]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `logged_at`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `logged_at`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `logged_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `logged_at`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `logged_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `logged_at`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)

      List.new(RemoteBandwidthSnapshot, params) do
        Api.send_request("/remote_bandwidth_snapshots", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `logged_at`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `logged_at`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `logged_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `logged_at`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `logged_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `logged_at`.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)

      response, options = Api.send_request("/remote_bandwidth_snapshots/create_export", :post, params, options)
      response.data.map do |entity_data|
        Export.new(entity_data, options)
      end
    end
  end
end
