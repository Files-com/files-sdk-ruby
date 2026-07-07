# frozen_string_literal: true

module Files
  class AgentV2Auth
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Agent ID
    def id
      @attributes[:id]
    end

    # string - authentication nonce
    def nonce
      @attributes[:nonce]
    end

    # string - in_setup: waiting for signed_nonce, complete: authorization approved
    def status
      @attributes[:status]
    end

    # int64 - Agent's site ID
    def site_id
      @attributes[:site_id]
    end
  end
end
