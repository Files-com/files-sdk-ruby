# frozen_string_literal: true

module Files
  # Files::PublicIpAddress is the Ruby SDK's representation of Files.com API PublicIpAddress objects.
  # Each instance keeps its API field values in +attributes+.
  class PublicIpAddress
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

    # The public IP address.
    # @return [String, nil] the field value, or nil when absent.
    def ip_address
      @attributes[:ip_address]
    end

    # The name of the frontend server.
    # @return [String, nil] the field value, or nil when absent.
    def server_name
      @attributes[:server_name]
    end

    #
    # @return [Boolean, nil] the field value, or nil when absent.
    def ftp_enabled
      @attributes[:ftp_enabled]
    end

    #
    # @return [Boolean, nil] the field value, or nil when absent.
    def sftp_enabled
      @attributes[:sftp_enabled]
    end
  end
end
