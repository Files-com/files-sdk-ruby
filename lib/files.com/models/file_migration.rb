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

    # string - Source path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # string - Destination path
    def dest_path
      @attributes[:dest_path]
    end

    # int64 - Number of files processed
    def files_moved
      @attributes[:files_moved]
    end

    # int64 - Total number of files to process
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
  end
end
