# frozen_string_literal: true

module Files
  # Files::DirectConnectionInfo is the Ruby SDK's representation of Files.com API DirectConnectionInfo objects.
  # Each instance keeps its API field values in +attributes+.
  class DirectConnectionInfo
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

    # Direct connection information schema version.
    # @return [Integer, nil] the field value, or nil when absent.
    def version
      @attributes[:version]
    end

    # TLS server name (SNI and Host header) for the Agent's direct transfer listener.
    # @return [String, nil] the field value, or nil when absent.
    def server_name
      @attributes[:server_name]
    end

    # Validated ip:port candidates that may be dialed over TCP+TLS for this transfer.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def addresses
      @attributes[:addresses]
    end

    # Signed HTTPS URI for direct Agent transfer traffic.
    # @return [String, nil] the field value, or nil when absent.
    def direct_uri
      @attributes[:direct_uri]
    end

    # PEM-encoded CA certificate used to verify the Agent's direct transfer TLS certificate.
    # @return [String, nil] the field value, or nil when absent.
    def ca_pem
      @attributes[:ca_pem]
    end
  end
end
