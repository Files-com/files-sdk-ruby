# frozen_string_literal: true

module Files
  class AgentNode
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Stable Agent installation ID
    def node_id
      @attributes[:node_id]
    end

    # string - Customer-configured Agent node name
    def name
      @attributes[:name]
    end

    # string - Hostname reported by the Agent
    def hostname
      @attributes[:hostname]
    end

    # string - Configured traffic preference
    def availability_role
      @attributes[:availability_role]
    end

    # string - Whether this node currently has an available Agent instance
    def status
      @attributes[:status]
    end

    # boolean - Whether this node is the current default route for new unscoped work
    def is_default
      @attributes[:is_default]
    end

    # boolean - Whether the proxy recently validated a direct connection to this Agent node. False means direct transfers are enabled but not currently available; null means disabled or unsupported.
    def direct_transfer_available
      @attributes[:direct_transfer_available]
    end

    # date-time - Most recent successful node observation
    def last_seen_at
      @attributes[:last_seen_at]
    end

    # array(object) - Current Agent processes for this node
    def instances
      @attributes[:instances]
    end
  end
end
