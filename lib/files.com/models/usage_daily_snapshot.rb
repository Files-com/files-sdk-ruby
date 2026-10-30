# frozen_string_literal: true

module Files
  # Files::UsageDailySnapshot is the Ruby SDK's representation of Files.com API UsageDailySnapshot objects.
  # Each instance keeps its API field values in +attributes+.
  class UsageDailySnapshot
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # ID of the usage record
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # The date of this usage record
    # @return [Hash, nil] the field value, or nil when absent.
    def date
      @attributes[:date]
    end

    # True if the API usage fields `read_api_usage` and `write_api_usage` can be relied upon.  If this is false, we suggest hiding that value from any UI.
    # @return [Boolean, nil] the field value, or nil when absent.
    def api_usage_available
      @attributes[:api_usage_available]
    end

    # Read API Calls used on this day. Note: only updated for days before the current day.
    # @return [Integer, nil] the field value, or nil when absent.
    def read_api_usage
      @attributes[:read_api_usage]
    end

    # Write API Calls used on this day. Note: only updated for days before the current day.
    # @return [Integer, nil] the field value, or nil when absent.
    def write_api_usage
      @attributes[:write_api_usage]
    end

    # Transformation and AI credits used on this day. Note: only updated for days before the current day.
    # @return [Integer, nil] the field value, or nil when absent.
    def transformation_credits_usage
      @attributes[:transformation_credits_usage]
    end

    # Number of billable users as of this day.
    # @return [Integer, nil] the field value, or nil when absent.
    def user_count
      @attributes[:user_count]
    end

    # GB of Files Native Storage used on this day.
    # @return [Integer, nil] the field value, or nil when absent.
    def current_storage
      @attributes[:current_storage]
    end

    # GB of Files Native Storage used on this day for files that have been deleted and are stored as backups.
    # @return [Integer, nil] the field value, or nil when absent.
    def deleted_files_storage
      @attributes[:deleted_files_storage]
    end

    # GB of Files Native Storage used on this day for files that have been permanently deleted but were uploaded less than 30 days ago, and are still billable.
    # @return [Integer, nil] the field value, or nil when absent.
    def deleted_files_counted_in_minimum
      @attributes[:deleted_files_counted_in_minimum]
    end

    # GB of Files Native Storage used for the root folder.  Included here because this value will not be part of `usage_by_top_level_dir`
    # @return [Integer, nil] the field value, or nil when absent.
    def root_storage
      @attributes[:root_storage]
    end

    # Usage broken down by each top-level folder
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def usage_by_top_level_dir
      @attributes[:usage_by_top_level_dir]
    end

    # List Usage Daily Snapshots
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `date`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `date` and `usage_snapshot_id`. Valid field combinations are `[ usage_snapshot_id, date ]`.
    # @option params [Hash] filter_gt If set, return records where the specified field is greater than the supplied value. Valid fields are `date`.
    # @option params [Hash] filter_gteq If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `date`.
    # @option params [Hash] filter_lt If set, return records where the specified field is less than the supplied value. Valid fields are `date`.
    # @option params [Hash] filter_lteq If set, return records where the specified field is less than or equal the supplied value. Valid fields are `date`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
      List.new(UsageDailySnapshot, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/usage_daily_snapshots", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
