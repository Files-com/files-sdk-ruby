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

    # date-time - Site usage report created at date/time
    def created_at
      @attributes[:created_at]
    end

    # float - Current site usage as of report
    def current_storage
      @attributes[:current_storage]
    end

    # date-time - Site usage report end date/time
    def end_at
      @attributes[:end_at]
    end

    # float - Site usage report highest usage in time period
    def high_water_storage
      @attributes[:high_water_storage]
    end

    # date-time - Site usage report start date/time
    def start_at
      @attributes[:start_at]
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

    # float - Usage for root folder
    def root_storage
      @attributes[:root_storage]
    end

    # float - Usage for files that are deleted but uploaded within last 30 days
    def deleted_files_counted_in_minimum
      @attributes[:deleted_files_counted_in_minimum]
    end

    # float - Usage for files that are deleted but retained as backups
    def deleted_files_storage
      @attributes[:deleted_files_storage]
    end
  end
end
