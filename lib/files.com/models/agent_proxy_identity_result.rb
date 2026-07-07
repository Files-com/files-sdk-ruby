# frozen_string_literal: true

module Files
  class AgentProxyIdentityResult
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Requested public IPv4 address.
    def ip
      @attributes[:ip]
    end

    # string - Lookup status for the requested IP.
    def status
      @attributes[:status]
    end

    # array(object) - Ordered identity candidates for this IP during rotation.
    def identities
      @attributes[:identities]
    end
  end
end
