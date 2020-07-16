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
    #   page - int64 - Current page number.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   cursor - string - Send cursor to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `site_id`, `date` or `usage_snapshot_id`.
    #   filter - object - If set, return records where the specifiied field is equal to the supplied value. Valid fields are `date` and `usage_snapshot_id`.
    #   filter_gt - object - If set, return records where the specifiied field is greater than the supplied value. Valid fields are `date` and `usage_snapshot_id`.
    #   filter_gteq - object - If set, return records where the specifiied field is greater than or equal to the supplied value. Valid fields are `date` and `usage_snapshot_id`.
    #   filter_like - object - If set, return records where the specifiied field is equal to the supplied value. Valid fields are `date` and `usage_snapshot_id`.
    #   filter_lt - object - If set, return records where the specifiied field is less than the supplied value. Valid fields are `date` and `usage_snapshot_id`.
    #   filter_lteq - object - If set, return records where the specifiied field is less than or equal to the supplied value. Valid fields are `date` and `usage_snapshot_id`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params.dig(:sort_by) and !params.dig(:sort_by).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params.dig(:filter) and !params.dig(:filter).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params.dig(:filter_gt) and !params.dig(:filter_gt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params.dig(:filter_gteq) and !params.dig(:filter_gteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params.dig(:filter_like) and !params.dig(:filter_like).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params.dig(:filter_lt) and !params.dig(:filter_lt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params.dig(:filter_lteq) and !params.dig(:filter_lteq).is_a?(Hash)

      List.new(UsageDailySnapshot, params) do
        Api.send_request("/usage_daily_snapshots", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
