# frozen_string_literal: true

module Files
  class BandwidthSnapshot
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Site bandwidth ID
    def id
      @attributes[:id]
    end

    # double - Site bandwidth report bytes received
    def bytes_received
      @attributes[:bytes_received]
    end

    # double - Site bandwidth report bytes sent
    def bytes_sent
      @attributes[:bytes_sent]
    end

    # double - Site sync bandwidth report bytes received
    def sync_bytes_received
      @attributes[:sync_bytes_received]
    end

    # double - Site sync bandwidth report bytes sent
    def sync_bytes_sent
      @attributes[:sync_bytes_sent]
    end

    # double - Site bandwidth report get requests
    def requests_get
      @attributes[:requests_get]
    end

    # double - Site bandwidth report put requests
    def requests_put
      @attributes[:requests_put]
    end

    # double - Site bandwidth report other requests
    def requests_other
      @attributes[:requests_other]
    end

    # date-time - Time the site bandwidth report was logged
    def logged_at
      @attributes[:logged_at]
    end

    # date-time - Site bandwidth report created at date/time
    def created_at
      @attributes[:created_at]
    end

    # date-time - The last time this site bandwidth report was updated
    def updated_at
      @attributes[:updated_at]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `logged_at`.
    #   filter - object - If set, return records where the specifiied field is equal to the supplied value. Valid fields are `logged_at`.
    #   filter_gt - object - If set, return records where the specifiied field is greater than the supplied value. Valid fields are `logged_at`.
    #   filter_gteq - object - If set, return records where the specifiied field is greater than or equal to the supplied value. Valid fields are `logged_at`.
    #   filter_like - object - If set, return records where the specifiied field is equal to the supplied value. Valid fields are `logged_at`.
    #   filter_lt - object - If set, return records where the specifiied field is less than the supplied value. Valid fields are `logged_at`.
    #   filter_lteq - object - If set, return records where the specifiied field is less than or equal to the supplied value. Valid fields are `logged_at`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params.dig(:sort_by) and !params.dig(:sort_by).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params.dig(:filter) and !params.dig(:filter).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params.dig(:filter_gt) and !params.dig(:filter_gt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params.dig(:filter_gteq) and !params.dig(:filter_gteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params.dig(:filter_like) and !params.dig(:filter_like).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params.dig(:filter_lt) and !params.dig(:filter_lt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params.dig(:filter_lteq) and !params.dig(:filter_lteq).is_a?(Hash)

      List.new(BandwidthSnapshot, params) do
        Api.send_request("/bandwidth_snapshots", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
