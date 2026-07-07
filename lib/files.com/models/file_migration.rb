# frozen_string_literal: true

module Files
  class FileMigration
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - File migration ID
    def id
      @attributes[:id]
    end

    # string - Source path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # string - Destination path
    def dest_path
      @attributes[:dest_path]
    end

    # string - Reason for the failure, if applicable.
    def failure_message
      @attributes[:failure_message]
    end

    # int64 - Number of files processed
    def files_moved
      @attributes[:files_moved]
    end

    # int64
    def files_total
      @attributes[:files_total]
    end

    # string - The type of operation
    def operation
      @attributes[:operation]
    end

    # string - Region
    def region
      @attributes[:region]
    end

    # string - Status
    def status
      @attributes[:status]
    end

    # string - Link to download the log file for this migration.
    def log_url
      @attributes[:log_url]
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(FileMigration, params) do
        Api.send_request("/file_migrations", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - File Migration ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/file_migrations/#{params[:id]}", :get, params, options)
      FileMigration.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)

      response, options = Api.send_request("/file_migrations/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
