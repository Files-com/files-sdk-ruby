# frozen_string_literal: true

module Files
  class UsageSnapshot
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Usage snapshot ID
    def id
      @attributes[:id]
    end

    # date-time - Usage snapshot start date/time
    def start_at
      @attributes[:start_at]
    end

    # date-time - Usage snapshot end date/time
    def end_at
      @attributes[:end_at]
    end

    # double - Highest user count number in time period
    def high_water_user_count
      @attributes[:high_water_user_count]
    end

    # double - Current total Storage Usage GB as of end date (not necessarily high water mark, which is used for billing)
    def current_storage
      @attributes[:current_storage]
    end

    # double - Highest Storage Usage GB recorded in time period (used for billing)
    def high_water_storage
      @attributes[:high_water_storage]
    end

    # object - Storage Usage - map of root folders to their usage as of end date (not necessarily high water mark, which is used for billing)
    def usage_by_top_level_dir
      @attributes[:usage_by_top_level_dir]
    end

    # double - Storage Usage for root folder as of end date (not necessarily high water mark, which is used for billing)
    def root_storage
      @attributes[:root_storage]
    end

    # double - Storage Usage for files that are deleted but uploaded within last 30 days as of end date (not necessarily high water mark, which is used for billing)
    def deleted_files_counted_in_minimum
      @attributes[:deleted_files_counted_in_minimum]
    end

    # double - Storage Usage for files that are deleted but retained as backups as of end date (not necessarily high water mark, which is used for billing)
    def deleted_files_storage
      @attributes[:deleted_files_storage]
    end

    # double - Storage + Transfer Usage - Total Billable amount
    def total_billable_usage
      @attributes[:total_billable_usage]
    end

    # double - Transfer usage for period - Total Billable amount
    def total_billable_transfer_usage
      @attributes[:total_billable_transfer_usage]
    end

    # double - Transfer Usage for period - Outbound GB from Files Native Storage
    def bytes_sent
      @attributes[:bytes_sent]
    end

    # double - Transfer Usage for period - Inbound GB to Remote Servers (Sync/Mount)
    def sync_bytes_received
      @attributes[:sync_bytes_received]
    end

    # double - Transfer Usage for period - Outbound GB from Remote Servers (Sync/Mount)
    def sync_bytes_sent
      @attributes[:sync_bytes_sent]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string
    #   page - int64
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params[:action] and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params[:page] and !params[:page].is_a?(Integer)

      List.new(UsageSnapshot, params) do
        Api.send_request("/usage_snapshots", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
