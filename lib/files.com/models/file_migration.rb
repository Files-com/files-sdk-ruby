# frozen_string_literal: true

module Files
  # Files::FileMigration is the Ruby SDK's representation of Files.com API FileMigration objects.
  # Each instance keeps its API field values in +attributes+.
  class FileMigration
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

    # File migration ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Source path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Destination path
    # @return [String, nil] the field value, or nil when absent.
    def dest_path
      @attributes[:dest_path]
    end

    # Reason for the failure, if applicable.
    # @return [String, nil] the field value, or nil when absent.
    def failure_message
      @attributes[:failure_message]
    end

    # Number of files processed
    # @return [Integer, nil] the field value, or nil when absent.
    def files_moved
      @attributes[:files_moved]
    end

    #
    # @return [Integer, nil] the field value, or nil when absent.
    def files_total
      @attributes[:files_total]
    end

    # The type of operation
    # @return [String, nil] the field value, or nil when absent.
    def operation
      @attributes[:operation]
    end

    # Region
    # @return [String, nil] the field value, or nil when absent.
    def region
      @attributes[:region]
    end

    # Status
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Link to download the log file for this migration.
    # @return [String, nil] the field value, or nil when absent.
    def log_url
      @attributes[:log_url]
    end

    # Show File Migration
    #
    # @param id [Integer] File Migration ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::FileMigration] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/file_migrations/#{params[:id]}", :get, params, options) { |reply| reply.require_object("FileMigration") }
      FileMigration.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
