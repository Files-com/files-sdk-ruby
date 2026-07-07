# frozen_string_literal: true

module Files
  class ClientLog
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Parameters:
    #   identifier (required) - string - Client log stream identifier
    #   body (required) - string - NDJSON log records
    def self.log(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: identifier must be an String") if params[:identifier] and !params[:identifier].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if params[:body] and !params[:body].is_a?(String)
      raise MissingParameterError.new("Parameter missing: identifier") unless params[:identifier]
      raise MissingParameterError.new("Parameter missing: body") unless params[:body]

      Api.send_request("/client_logs/log", :post, params, options)
      nil
    end
  end
end
