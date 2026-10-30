# frozen_string_literal: true

module Files
  # Files::UsageSnapshot is the Ruby SDK's representation of Files.com API UsageSnapshot objects.
  # Each instance keeps its API field values in +attributes+.
  class UsageSnapshot
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

    # Usage snapshot ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Usage snapshot start date/time
    # @return [String, nil] the field value, or nil when absent.
    def start_at
      @attributes[:start_at]
    end

    # Usage snapshot end date/time
    # @return [String, nil] the field value, or nil when absent.
    def end_at
      @attributes[:end_at]
    end

    # Highest user count number in time period
    # @return [Integer, nil] the field value, or nil when absent.
    def high_water_user_count
      @attributes[:high_water_user_count]
    end

    # Total Transformation and AI credits used in this usage period. Updated daily. Does not include credits consumed today.
    # @return [Integer, nil] the field value, or nil when absent.
    def transformation_credits_usage
      @attributes[:transformation_credits_usage]
    end

    # Current total Storage Usage GB as of end date (not necessarily high water mark, which is used for billing)
    # @return [Integer, nil] the field value, or nil when absent.
    def current_storage
      @attributes[:current_storage]
    end

    # Highest Storage Usage GB recorded in time period (used for billing)
    # @return [Integer, nil] the field value, or nil when absent.
    def high_water_storage
      @attributes[:high_water_storage]
    end

    # Storage Usage for root folder as of end date (not necessarily high water mark, which is used for billing)
    # @return [Integer, nil] the field value, or nil when absent.
    def root_storage
      @attributes[:root_storage]
    end

    # Storage Usage for files that are deleted but uploaded within last 30 days as of end date (not necessarily high water mark, which is used for billing)
    # @return [Integer, nil] the field value, or nil when absent.
    def deleted_files_counted_in_minimum
      @attributes[:deleted_files_counted_in_minimum]
    end

    # Storage Usage for files that are deleted but retained as backups as of end date (not necessarily high water mark, which is used for billing)
    # @return [Integer, nil] the field value, or nil when absent.
    def deleted_files_storage
      @attributes[:deleted_files_storage]
    end

    # Storage + Transfer Usage - Total Billable amount
    # @return [Integer, nil] the field value, or nil when absent.
    def total_billable_usage
      @attributes[:total_billable_usage]
    end

    # Transfer usage for period - Total Billable amount
    # @return [Integer, nil] the field value, or nil when absent.
    def total_billable_transfer_usage
      @attributes[:total_billable_transfer_usage]
    end

    # Transfer Usage for period - Outbound GB from Files Native Storage
    # @return [Integer, nil] the field value, or nil when absent.
    def bytes_sent
      @attributes[:bytes_sent]
    end

    # Transfer Usage for period - Inbound GB to Remote Servers (Sync/Mount)
    # @return [Integer, nil] the field value, or nil when absent.
    def sync_bytes_received
      @attributes[:sync_bytes_received]
    end

    # Transfer Usage for period - Outbound GB from Remote Servers (Sync/Mount)
    # @return [Integer, nil] the field value, or nil when absent.
    def sync_bytes_sent
      @attributes[:sync_bytes_sent]
    end

    # Storage Usage - map of root folders to their usage as of end date (not necessarily high water mark, which is used for billing)
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def usage_by_top_level_dir
      @attributes[:usage_by_top_level_dir]
    end

    # List Usage Snapshots
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)

      list_options = options.dup
      List.new(UsageSnapshot, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/usage_snapshots", :get, page_params, list_options, &check_page)
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
