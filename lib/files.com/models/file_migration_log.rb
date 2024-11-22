# frozen_string_literal: true

module Files
  class FileMigrationLog
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # date-time - Start Time of Action
    def timestamp
      @attributes[:timestamp]
    end

    # int64 - File Migration ID
    def file_migration_id
      @attributes[:file_migration_id]
    end

    # string - Destination path, for moves and copies
    def dest_path
      @attributes[:dest_path]
    end

    # string - Error type, if applicable
    def error_type
      @attributes[:error_type]
    end

    # string - Message
    def message
      @attributes[:message]
    end

    # string - Operation type
    def operation
      @attributes[:operation]
    end

    # string - File path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # string - Status
    def status
      @attributes[:status]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `start_date`, `end_date`, `file_migration_id`, `operation`, `status` or `type`. Valid field combinations are `[ start_date ]`, `[ end_date ]`, `[ file_migration_id ]`, `[ operation ]`, `[ status ]`, `[ type ]`, `[ start_date, end_date ]`, `[ start_date, file_migration_id ]`, `[ start_date, operation ]`, `[ start_date, status ]`, `[ start_date, type ]`, `[ end_date, file_migration_id ]`, `[ end_date, operation ]`, `[ end_date, status ]`, `[ end_date, type ]`, `[ file_migration_id, operation ]`, `[ file_migration_id, status ]`, `[ file_migration_id, type ]`, `[ operation, status ]`, `[ operation, type ]`, `[ status, type ]`, `[ start_date, end_date, file_migration_id ]`, `[ start_date, end_date, operation ]`, `[ start_date, end_date, status ]`, `[ start_date, end_date, type ]`, `[ start_date, file_migration_id, operation ]`, `[ start_date, file_migration_id, status ]`, `[ start_date, file_migration_id, type ]`, `[ start_date, operation, status ]`, `[ start_date, operation, type ]`, `[ start_date, status, type ]`, `[ end_date, file_migration_id, operation ]`, `[ end_date, file_migration_id, status ]`, `[ end_date, file_migration_id, type ]`, `[ end_date, operation, status ]`, `[ end_date, operation, type ]`, `[ end_date, status, type ]`, `[ file_migration_id, operation, status ]`, `[ file_migration_id, operation, type ]`, `[ file_migration_id, status, type ]`, `[ operation, status, type ]`, `[ start_date, end_date, file_migration_id, operation ]`, `[ start_date, end_date, file_migration_id, status ]`, `[ start_date, end_date, file_migration_id, type ]`, `[ start_date, end_date, operation, status ]`, `[ start_date, end_date, operation, type ]`, `[ start_date, end_date, status, type ]`, `[ start_date, file_migration_id, operation, status ]`, `[ start_date, file_migration_id, operation, type ]`, `[ start_date, file_migration_id, status, type ]`, `[ start_date, operation, status, type ]`, `[ end_date, file_migration_id, operation, status ]`, `[ end_date, file_migration_id, operation, type ]`, `[ end_date, file_migration_id, status, type ]`, `[ end_date, operation, status, type ]`, `[ file_migration_id, operation, status, type ]`, `[ start_date, end_date, file_migration_id, operation, status ]`, `[ start_date, end_date, file_migration_id, operation, type ]`, `[ start_date, end_date, file_migration_id, status, type ]`, `[ start_date, end_date, operation, status, type ]`, `[ start_date, file_migration_id, operation, status, type ]` or `[ end_date, file_migration_id, operation, status, type ]`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `operation` and `status`. Valid field combinations are `[ start_date ]`, `[ end_date ]`, `[ file_migration_id ]`, `[ operation ]`, `[ status ]`, `[ type ]`, `[ start_date, end_date ]`, `[ start_date, file_migration_id ]`, `[ start_date, operation ]`, `[ start_date, status ]`, `[ start_date, type ]`, `[ end_date, file_migration_id ]`, `[ end_date, operation ]`, `[ end_date, status ]`, `[ end_date, type ]`, `[ file_migration_id, operation ]`, `[ file_migration_id, status ]`, `[ file_migration_id, type ]`, `[ operation, status ]`, `[ operation, type ]`, `[ status, type ]`, `[ start_date, end_date, file_migration_id ]`, `[ start_date, end_date, operation ]`, `[ start_date, end_date, status ]`, `[ start_date, end_date, type ]`, `[ start_date, file_migration_id, operation ]`, `[ start_date, file_migration_id, status ]`, `[ start_date, file_migration_id, type ]`, `[ start_date, operation, status ]`, `[ start_date, operation, type ]`, `[ start_date, status, type ]`, `[ end_date, file_migration_id, operation ]`, `[ end_date, file_migration_id, status ]`, `[ end_date, file_migration_id, type ]`, `[ end_date, operation, status ]`, `[ end_date, operation, type ]`, `[ end_date, status, type ]`, `[ file_migration_id, operation, status ]`, `[ file_migration_id, operation, type ]`, `[ file_migration_id, status, type ]`, `[ operation, status, type ]`, `[ start_date, end_date, file_migration_id, operation ]`, `[ start_date, end_date, file_migration_id, status ]`, `[ start_date, end_date, file_migration_id, type ]`, `[ start_date, end_date, operation, status ]`, `[ start_date, end_date, operation, type ]`, `[ start_date, end_date, status, type ]`, `[ start_date, file_migration_id, operation, status ]`, `[ start_date, file_migration_id, operation, type ]`, `[ start_date, file_migration_id, status, type ]`, `[ start_date, operation, status, type ]`, `[ end_date, file_migration_id, operation, status ]`, `[ end_date, file_migration_id, operation, type ]`, `[ end_date, file_migration_id, status, type ]`, `[ end_date, operation, status, type ]`, `[ file_migration_id, operation, status, type ]`, `[ start_date, end_date, file_migration_id, operation, status ]`, `[ start_date, end_date, file_migration_id, operation, type ]`, `[ start_date, end_date, file_migration_id, status, type ]`, `[ start_date, end_date, operation, status, type ]`, `[ start_date, file_migration_id, operation, status, type ]` or `[ end_date, file_migration_id, operation, status, type ]`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

      List.new(FileMigrationLog, params) do
        Api.send_request("/file_migration_logs", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `start_date`, `end_date`, `file_migration_id`, `operation`, `status` or `type`. Valid field combinations are `[ start_date ]`, `[ end_date ]`, `[ file_migration_id ]`, `[ operation ]`, `[ status ]`, `[ type ]`, `[ start_date, end_date ]`, `[ start_date, file_migration_id ]`, `[ start_date, operation ]`, `[ start_date, status ]`, `[ start_date, type ]`, `[ end_date, file_migration_id ]`, `[ end_date, operation ]`, `[ end_date, status ]`, `[ end_date, type ]`, `[ file_migration_id, operation ]`, `[ file_migration_id, status ]`, `[ file_migration_id, type ]`, `[ operation, status ]`, `[ operation, type ]`, `[ status, type ]`, `[ start_date, end_date, file_migration_id ]`, `[ start_date, end_date, operation ]`, `[ start_date, end_date, status ]`, `[ start_date, end_date, type ]`, `[ start_date, file_migration_id, operation ]`, `[ start_date, file_migration_id, status ]`, `[ start_date, file_migration_id, type ]`, `[ start_date, operation, status ]`, `[ start_date, operation, type ]`, `[ start_date, status, type ]`, `[ end_date, file_migration_id, operation ]`, `[ end_date, file_migration_id, status ]`, `[ end_date, file_migration_id, type ]`, `[ end_date, operation, status ]`, `[ end_date, operation, type ]`, `[ end_date, status, type ]`, `[ file_migration_id, operation, status ]`, `[ file_migration_id, operation, type ]`, `[ file_migration_id, status, type ]`, `[ operation, status, type ]`, `[ start_date, end_date, file_migration_id, operation ]`, `[ start_date, end_date, file_migration_id, status ]`, `[ start_date, end_date, file_migration_id, type ]`, `[ start_date, end_date, operation, status ]`, `[ start_date, end_date, operation, type ]`, `[ start_date, end_date, status, type ]`, `[ start_date, file_migration_id, operation, status ]`, `[ start_date, file_migration_id, operation, type ]`, `[ start_date, file_migration_id, status, type ]`, `[ start_date, operation, status, type ]`, `[ end_date, file_migration_id, operation, status ]`, `[ end_date, file_migration_id, operation, type ]`, `[ end_date, file_migration_id, status, type ]`, `[ end_date, operation, status, type ]`, `[ file_migration_id, operation, status, type ]`, `[ start_date, end_date, file_migration_id, operation, status ]`, `[ start_date, end_date, file_migration_id, operation, type ]`, `[ start_date, end_date, file_migration_id, status, type ]`, `[ start_date, end_date, operation, status, type ]`, `[ start_date, file_migration_id, operation, status, type ]` or `[ end_date, file_migration_id, operation, status, type ]`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `operation` and `status`. Valid field combinations are `[ start_date ]`, `[ end_date ]`, `[ file_migration_id ]`, `[ operation ]`, `[ status ]`, `[ type ]`, `[ start_date, end_date ]`, `[ start_date, file_migration_id ]`, `[ start_date, operation ]`, `[ start_date, status ]`, `[ start_date, type ]`, `[ end_date, file_migration_id ]`, `[ end_date, operation ]`, `[ end_date, status ]`, `[ end_date, type ]`, `[ file_migration_id, operation ]`, `[ file_migration_id, status ]`, `[ file_migration_id, type ]`, `[ operation, status ]`, `[ operation, type ]`, `[ status, type ]`, `[ start_date, end_date, file_migration_id ]`, `[ start_date, end_date, operation ]`, `[ start_date, end_date, status ]`, `[ start_date, end_date, type ]`, `[ start_date, file_migration_id, operation ]`, `[ start_date, file_migration_id, status ]`, `[ start_date, file_migration_id, type ]`, `[ start_date, operation, status ]`, `[ start_date, operation, type ]`, `[ start_date, status, type ]`, `[ end_date, file_migration_id, operation ]`, `[ end_date, file_migration_id, status ]`, `[ end_date, file_migration_id, type ]`, `[ end_date, operation, status ]`, `[ end_date, operation, type ]`, `[ end_date, status, type ]`, `[ file_migration_id, operation, status ]`, `[ file_migration_id, operation, type ]`, `[ file_migration_id, status, type ]`, `[ operation, status, type ]`, `[ start_date, end_date, file_migration_id, operation ]`, `[ start_date, end_date, file_migration_id, status ]`, `[ start_date, end_date, file_migration_id, type ]`, `[ start_date, end_date, operation, status ]`, `[ start_date, end_date, operation, type ]`, `[ start_date, end_date, status, type ]`, `[ start_date, file_migration_id, operation, status ]`, `[ start_date, file_migration_id, operation, type ]`, `[ start_date, file_migration_id, status, type ]`, `[ start_date, operation, status, type ]`, `[ end_date, file_migration_id, operation, status ]`, `[ end_date, file_migration_id, operation, type ]`, `[ end_date, file_migration_id, status, type ]`, `[ end_date, operation, status, type ]`, `[ file_migration_id, operation, status, type ]`, `[ start_date, end_date, file_migration_id, operation, status ]`, `[ start_date, end_date, file_migration_id, operation, type ]`, `[ start_date, end_date, file_migration_id, status, type ]`, `[ start_date, end_date, operation, status, type ]`, `[ start_date, file_migration_id, operation, status, type ]` or `[ end_date, file_migration_id, operation, status, type ]`.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

      response, options = Api.send_request("/file_migration_logs/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
