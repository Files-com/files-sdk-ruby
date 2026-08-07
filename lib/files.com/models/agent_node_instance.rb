# frozen_string_literal: true

module Files
  class AgentNodeInstance
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Ephemeral ID for this running Agent process
    def instance_id
      @attributes[:instance_id]
    end

    # string - Role of this process during an Agent update
    def process_state
      @attributes[:process_state]
    end

    # string - Whether this process has an available proxy connection
    def status
      @attributes[:status]
    end

    # boolean - Whether this process receives new unscoped work for its node
    def is_default
      @attributes[:is_default]
    end

    # string - Agent version reported by this process
    def agent_version
      @attributes[:agent_version]
    end

    # date-time - Most recent successful observation for this process
    def last_seen_at
      @attributes[:last_seen_at]
    end

    # array(object) - Proxy connections observed for this process
    def connections
      @attributes[:connections]
    end
  end
end
