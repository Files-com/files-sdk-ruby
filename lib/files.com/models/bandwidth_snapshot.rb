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
    #   page - int64 - Current page number.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/bandwidth_snapshots", :get, params, options)
      response.data.map do |entity_data|
        BandwidthSnapshot.new(entity_data, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
