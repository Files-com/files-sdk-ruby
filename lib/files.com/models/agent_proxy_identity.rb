# frozen_string_literal: true

module Files
  class AgentProxyIdentity
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Libp2p peer ID for this identity candidate.
    def peer_id
      @attributes[:peer_id]
    end

    # array(object) - Protocol-specific endpoints for this peer ID.
    def endpoints
      @attributes[:endpoints]
    end

    # Parameters:
    #   ips (required) - array(string) - One or more public IPv4 addresses to resolve
    def self.lookup(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: ips must be an Array") if params[:ips] and !params[:ips].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: ips") unless params[:ips]

      response, options = Api.send_request("/agent_proxy_identities/lookup", :post, params, options)
      response.data.map do |entity_data|
        AgentProxyIdentityResult.new(entity_data, options)
      end
    end

    # Parameters:
    #   private_ip (required) - string - Proxy private IPv4 address
    #   peer_id (required) - string - Libp2p peer ID currently served by the proxy
    def self.report(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: private_ip must be an String") if params[:private_ip] and !params[:private_ip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: peer_id must be an String") if params[:peer_id] and !params[:peer_id].is_a?(String)
      raise MissingParameterError.new("Parameter missing: private_ip") unless params[:private_ip]
      raise MissingParameterError.new("Parameter missing: peer_id") unless params[:peer_id]

      Api.send_request("/agent_proxy_identities/report", :post, params, options)
      nil
    end
  end
end
