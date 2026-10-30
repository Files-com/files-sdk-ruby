# frozen_string_literal: true

module Files
  # Files::AgentNode is the Ruby SDK's representation of Files.com API AgentNode objects.
  # Each instance keeps its API field values in +attributes+.
  class AgentNode
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

    # Stable Agent installation ID
    # @return [String, nil] the field value, or nil when absent.
    def node_id
      @attributes[:node_id]
    end

    # Customer-configured Agent node name
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Hostname reported by the Agent
    # @return [String, nil] the field value, or nil when absent.
    def hostname
      @attributes[:hostname]
    end

    # Configured traffic preference
    # @return [String, nil] the field value, or nil when absent.
    def availability_role
      @attributes[:availability_role]
    end

    # Whether this node currently has an available Agent instance
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Whether this node is the current default route for new unscoped work
    # @return [Boolean, nil] the field value, or nil when absent.
    def is_default
      @attributes[:is_default]
    end

    # Whether the proxy recently validated a direct connection to this Agent node. False means direct transfers are enabled but not currently available; null means disabled or unsupported.
    # @return [Boolean, nil] the field value, or nil when absent.
    def direct_transfer_available
      @attributes[:direct_transfer_available]
    end

    # Most recent successful node observation
    # @return [String, nil] the field value, or nil when absent.
    def last_seen_at
      @attributes[:last_seen_at]
    end

    # Current Agent processes for this node
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def instances
      @attributes[:instances]
    end
  end
end
