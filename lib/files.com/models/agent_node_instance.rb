# frozen_string_literal: true

module Files
  # Files::AgentNodeInstance is the Ruby SDK's representation of Files.com API AgentNodeInstance objects.
  # Each instance keeps its API field values in +attributes+.
  class AgentNodeInstance
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

    # Ephemeral ID for this running Agent process
    # @return [String, nil] the field value, or nil when absent.
    def instance_id
      @attributes[:instance_id]
    end

    # Role of this process during an Agent update
    # @return [String, nil] the field value, or nil when absent.
    def process_state
      @attributes[:process_state]
    end

    # Whether this process has an available proxy connection
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Whether this process receives new unscoped work for its node
    # @return [Boolean, nil] the field value, or nil when absent.
    def is_default
      @attributes[:is_default]
    end

    # Agent version reported by this process
    # @return [String, nil] the field value, or nil when absent.
    def agent_version
      @attributes[:agent_version]
    end

    # Most recent successful observation for this process
    # @return [String, nil] the field value, or nil when absent.
    def last_seen_at
      @attributes[:last_seen_at]
    end

    # Proxy connections observed for this process
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def connections
      @attributes[:connections]
    end
  end
end
