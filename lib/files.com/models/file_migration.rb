# frozen_string_literal: true

module Files
  # Files::FileMigration is the Ruby SDK's representation of Files.com API FileMigration objects.
  # Each instance keeps its API field values in +attributes+.
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
    #   id (required) - int64 - File Migration ID.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::FileMigration.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/file_migrations/#{params[:id]}", :get, params, options) { |reply| reply.require_object("FileMigration") }
      FileMigration.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
