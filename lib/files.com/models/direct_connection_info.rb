# frozen_string_literal: true

module Files
  class DirectConnectionInfo
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Direct connection information schema version.
    def version
      @attributes[:version]
    end

    # string - TLS server name (SNI and Host header) for the Agent's direct transfer listener.
    def server_name
      @attributes[:server_name]
    end

    # array(string) - Validated ip:port candidates that may be dialed over TCP+TLS for this transfer.
    def addresses
      @attributes[:addresses]
    end

    # string - Signed HTTPS URI for direct Agent transfer traffic.
    def direct_uri
      @attributes[:direct_uri]
    end

    # string - PEM-encoded CA certificate used to verify the Agent's direct transfer TLS certificate.
    def ca_pem
      @attributes[:ca_pem]
    end
  end
end
