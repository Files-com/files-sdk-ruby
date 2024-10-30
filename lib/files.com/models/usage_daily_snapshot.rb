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

    # boolean - True if the API usage fields `read_api_usage` and `write_api_usage` can be relied upon.  If this is false, we suggest hiding that value from any UI.
    def api_usage_available
      @attributes[:api_usage_available]
    end

    # int64 - Read API Calls used on this day. Note: only updated for days before the current day.
    def read_api_usage
      @attributes[:read_api_usage]
    end

    # int64 - Write API Calls used on this day. Note: only updated for days before the current day.
    def write_api_usage
      @attributes[:write_api_usage]
    end

    # int64 - Number of billable users as of this day.
    def user_count
      @attributes[:user_count]
    end

    # int64 - GB of Files Native Storage used on this day.
    def current_storage
      @attributes[:current_storage]
    end

    # int64 - GB of Files Native Storage used on this day for files that have been deleted and are stored as backups.
    def deleted_files_storage
      @attributes[:deleted_files_storage]
    end

    # int64 - GB of Files Native Storage used on this day for files that have been permanently deleted but were uploaded less than 30 days ago, and are still billable.
    def deleted_files_counted_in_minimum
      @attributes[:deleted_files_counted_in_minimum]
    end

    # int64 - GB of Files Native Storage used for the root folder.  Included here because this value will not be part of `usage_by_top_level_dir`
    def root_storage
      @attributes[:root_storage]
    end

    # object - Usage broken down by each top-level folder
    def usage_by_top_level_dir
      @attributes[:usage_by_top_level_dir]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `date`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `date` and `usage_snapshot_id`. Valid field combinations are `[ date, usage_snapshot_id ]`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `date`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `date`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `date`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `date`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)

      List.new(UsageDailySnapshot, params) do
        Api.send_request("/usage_daily_snapshots", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
