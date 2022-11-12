# frozen_string_literal: true

module Files
  class RemoteServerConfigurationFile
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Agent ID
    def id
      @attributes[:id]
    end

    # string -
    def permission_set
      @attributes[:permission_set]
    end

    # string - Files Agent API Token
    def api_token
      @attributes[:api_token]
    end

    # string - Agent local root path
    def root
      @attributes[:root]
    end

    # int64 - Incoming port for files agent connections
    def port
      @attributes[:port]
    end

    # string
    def hostname
      @attributes[:hostname]
    end

    # string - public key
    def public_key
      @attributes[:public_key]
    end

    # string - private key
    def private_key
      @attributes[:private_key]
    end

    # string - either running or shutdown
    def status
      @attributes[:status]
    end

    # string - agent config version
    def config_version
      @attributes[:config_version]
    end

    # string
    def server_host_key
      @attributes[:server_host_key]
    end
  end
end
