# frozen_string_literal: true

module Files
  # Files::RemoteBandwidthSnapshot is the Ruby SDK's representation of Files.com API RemoteBandwidthSnapshot objects.
  # Each instance keeps its API field values in +attributes+.
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

    # int64 - Site sync bandwidth report bytes received
    def sync_bytes_received
      @attributes[:sync_bytes_received]
    end

    # int64 - Site sync bandwidth report bytes sent
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
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `logged_at`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `logged_at`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `logged_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `logged_at`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `logged_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `logged_at`.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::RemoteBandwidthSnapshot objects.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if !params[:filter_gt].nil? and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if !params[:filter_gteq].nil? and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if !params[:filter_lt].nil? and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if !params[:filter_lteq].nil? and !params[:filter_lteq].is_a?(Hash)

      List.new(RemoteBandwidthSnapshot, params) do |page_params, &check_page|
        Api.send_request("/remote_bandwidth_snapshots", :get, page_params, options, &check_page)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
