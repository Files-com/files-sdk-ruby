# frozen_string_literal: true

module Files
  class PublicIpAddress
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - The public IP address.
    def ip_address
      @attributes[:ip_address]
    end

    # string - The name of the frontend server.
    def server_name
      @attributes[:server_name]
    end

    # string
    def ftp_enabled
      @attributes[:ftp_enabled]
    end

    # string
    def sftp_enabled
      @attributes[:sftp_enabled]
    end
  end
end
