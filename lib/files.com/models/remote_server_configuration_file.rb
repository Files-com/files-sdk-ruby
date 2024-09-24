# frozen_string_literal: true

module Files
  class RemoteServerConfigurationFile
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - The remote server ID of the agent
    def id
      @attributes[:id]
    end

    # string - The permission set for the agent ['read_write', 'read_only', 'write_only']
    def permission_set
      @attributes[:permission_set]
    end

    # string - The private key for the agent
    def private_key
      @attributes[:private_key]
    end

    # string - Files.com subdomain site name
    def subdomain
      @attributes[:subdomain]
    end

    # string - The root directory for the agent
    def root
      @attributes[:root]
    end

    # boolean - Follow symlinks when traversing directories
    def follow_links
      @attributes[:follow_links]
    end

    # string - Preferred network protocol ['udp', 'tcp'] (default udp)
    def prefer_protocol
      @attributes[:prefer_protocol]
    end

    # string - DNS lookup method ['auto','doh','system'] (default auto)
    def dns
      @attributes[:dns]
    end

    # boolean - Proxy all outbound traffic through files.com proxy server
    def proxy_all_outbound
      @attributes[:proxy_all_outbound]
    end

    # string - Custom site endpoint URL
    def endpoint_override
      @attributes[:endpoint_override]
    end

    # string - Log file name and location
    def log_file
      @attributes[:log_file]
    end

    # string - Log level for the agent logs ['debug', 'info', 'warn', 'error', 'fatal'] (default info)
    def log_level
      @attributes[:log_level]
    end

    # int64 - Log route for agent logs. (default 5)
    def log_rotate_num
      @attributes[:log_rotate_num]
    end

    # int64 - Log route size in MB for agent logs. (default 20)
    def log_rotate_size
      @attributes[:log_rotate_size]
    end

    # int64 - Maximum number of concurrent jobs (default 500)
    def override_max_concurrent_jobs
      @attributes[:override_max_concurrent_jobs]
    end

    # int64 - Graceful shutdown timeout in seconds (default 15)
    def graceful_shutdown_timeout
      @attributes[:graceful_shutdown_timeout]
    end

    # string - File transfer (upload/download) rate limit
    #  `<limit>-<period>`, with the given periods:
    # * 'S': second
    # * 'M': minute
    # * 'H': hour
    # * 'D': day
    # Examples:
    # * 5 requests/second: '5-S'
    # * 10 requests/minute: '10-M'
    # * 1000 requests/hour: '1000-H'
    # * 2000 requests/day: '2000-D'
    def transfer_rate_limit
      @attributes[:transfer_rate_limit]
    end

    # string - Files Agent API Token
    def api_token
      @attributes[:api_token]
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

    # string - either running or shutdown
    def status
      @attributes[:status]
    end

    # string
    def server_host_key
      @attributes[:server_host_key]
    end

    # string - agent config version
    def config_version
      @attributes[:config_version]
    end
  end
end
