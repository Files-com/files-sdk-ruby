# frozen_string_literal: true

module Files
  # Files::AgentNodeConnection is the Ruby SDK's representation of Files.com API AgentNodeConnection objects.
  # Each instance keeps its API field values in +attributes+.
  class AgentNodeConnection
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

    # How the Agent process uses this proxy connection
    # @return [String, nil] the field value, or nil when absent.
    def mode
      @attributes[:mode]
    end

    # Whether this connection was observed recently and has not disconnected
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Most recent successful observation for this connection
    # @return [String, nil] the field value, or nil when absent.
    def last_seen_at
      @attributes[:last_seen_at]
    end
  end
end
