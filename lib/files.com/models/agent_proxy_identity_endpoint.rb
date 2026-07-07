# frozen_string_literal: true

module Files
  class AgentProxyIdentityEndpoint
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Canonical libp2p multiaddr for this proxy identity endpoint.
    def multiaddr
      @attributes[:multiaddr]
    end
  end
end
