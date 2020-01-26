# frozen_string_literal: true

module Files
  class UsageDailySnapshot
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - ID of the usage record
    def id
      @attributes[:id]
    end

    # date - The date of this usage record
    def date
      @attributes[:date]
    end

    # int64 - The quantity of storage held for this site
    def current_storage
      @attributes[:current_storage]
    end

    # array - Usage broken down by each top-level folder
    def usage_by_top_level_dir
      @attributes[:usage_by_top_level_dir]
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/usage_daily_snapshots", :get, params, options)
      response.data.map { |object| UsageDailySnapshot.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
