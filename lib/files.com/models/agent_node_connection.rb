# frozen_string_literal: true

module Files
  class AgentNodeConnection
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - How the Agent process uses this proxy connection
    def mode
      @attributes[:mode]
    end

    # string - Whether this connection was observed recently and has not disconnected
    def status
      @attributes[:status]
    end

    # date-time - Most recent successful observation for this connection
    def last_seen_at
      @attributes[:last_seen_at]
    end
  end
end
