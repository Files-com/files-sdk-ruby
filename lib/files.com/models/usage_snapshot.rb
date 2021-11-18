# frozen_string_literal: true

module Files
  class UsageSnapshot
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Site usage ID
    def id
      @attributes[:id]
    end

    # date-time - Site usage report start date/time
    def start_at
      @attributes[:start_at]
    end

    # date-time - Site usage report end date/time
    def end_at
      @attributes[:end_at]
    end

    # date-time - Site usage report created at date/time
    def created_at
      @attributes[:created_at]
    end

    # double - Site usage report highest usage in time period
    def high_water_user_count
      @attributes[:high_water_user_count]
    end

    # double - Current site usage as of report
    def current_storage
      @attributes[:current_storage]
    end

    # double - Site usage report highest usage in time period
    def high_water_storage
      @attributes[:high_water_storage]
    end

    # int64 - Number of downloads in report time period
    def total_downloads
      @attributes[:total_downloads]
    end

    # int64 - Number of uploads in time period
    def total_uploads
      @attributes[:total_uploads]
    end

    # date-time - The last time this site usage report was updated
    def updated_at
      @attributes[:updated_at]
    end

    # object - A map of root folders to their total usage
    def usage_by_top_level_dir
      @attributes[:usage_by_top_level_dir]
    end

    # double - Usage for root folder
    def root_storage
      @attributes[:root_storage]
    end

    # double - Usage for files that are deleted but uploaded within last 30 days
    def deleted_files_counted_in_minimum
      @attributes[:deleted_files_counted_in_minimum]
    end

    # double - Usage for files that are deleted but retained as backups
    def deleted_files_storage
      @attributes[:deleted_files_storage]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)

      List.new(UsageSnapshot, params) do
        Api.send_request("/usage_snapshots", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
