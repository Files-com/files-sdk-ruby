# frozen_string_literal: true

module Files
  # Files::RemoteServerConfigurationFile is the Ruby SDK's representation of Files.com API RemoteServerConfigurationFile objects.
  # Each instance keeps its API field values in +attributes+.
  class RemoteServerConfigurationFile
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

    # The remote server ID of the agent
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # The permission set for the agent ['read_write', 'read_only', 'write_only']
    # @return [String, nil] the field value, or nil when absent.
    def permission_set
      @attributes[:permission_set]
    end

    # The private key for the agent
    # @return [String, nil] the field value, or nil when absent.
    def private_key
      @attributes[:private_key]
    end

    # Files.com subdomain site name
    # @return [String, nil] the field value, or nil when absent.
    def subdomain
      @attributes[:subdomain]
    end

    # The root directory for the agent
    # @return [String, nil] the field value, or nil when absent.
    def root
      @attributes[:root]
    end

    # Optional customer-facing name for this Agent installation
    # @return [String, nil] the field value, or nil when absent.
    def node_name
      @attributes[:node_name]
    end

    # Follow symlinks when traversing directories
    # @return [Boolean, nil] the field value, or nil when absent.
    def follow_links
      @attributes[:follow_links]
    end

    # Preferred network protocol ['udp', 'tcp'] (default udp)
    # @return [String, nil] the field value, or nil when absent.
    def prefer_protocol
      @attributes[:prefer_protocol]
    end

    # DNS lookup method ['auto','doh','system'] (default auto)
    # @return [String, nil] the field value, or nil when absent.
    def dns
      @attributes[:dns]
    end

    # Proxy all outbound traffic through files.com proxy server
    # @return [Boolean, nil] the field value, or nil when absent.
    def proxy_all_outbound
      @attributes[:proxy_all_outbound]
    end

    # Custom site endpoint URL
    # @return [String, nil] the field value, or nil when absent.
    def endpoint_override
      @attributes[:endpoint_override]
    end

    # Log file name and location
    # @return [String, nil] the field value, or nil when absent.
    def log_file
      @attributes[:log_file]
    end

    # Log level for the agent logs ['debug', 'info', 'warn', 'error', 'fatal'] (default info)
    # @return [String, nil] the field value, or nil when absent.
    def log_level
      @attributes[:log_level]
    end

    # Log route for agent logs. (default 5)
    # @return [Integer, nil] the field value, or nil when absent.
    def log_rotate_num
      @attributes[:log_rotate_num]
    end

    # Log route size in MB for agent logs. (default 20)
    # @return [Integer, nil] the field value, or nil when absent.
    def log_rotate_size
      @attributes[:log_rotate_size]
    end

    # Maximum number of concurrent jobs (default 500)
    # @return [Integer, nil] the field value, or nil when absent.
    def override_max_concurrent_jobs
      @attributes[:override_max_concurrent_jobs]
    end

    # Graceful shutdown timeout in seconds (default 15)
    # @return [Integer, nil] the field value, or nil when absent.
    def graceful_shutdown_timeout
      @attributes[:graceful_shutdown_timeout]
    end

    # File transfer (upload/download) rate limit
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
    # @return [String, nil] the field value, or nil when absent.
    def transfer_rate_limit
      @attributes[:transfer_rate_limit]
    end

    # Auto update policy ['manual_trigger', 'critical_only', 'always', 'never'] (default always)
    # @return [String, nil] the field value, or nil when absent.
    def auto_update_policy
      @attributes[:auto_update_policy]
    end
  end
end
