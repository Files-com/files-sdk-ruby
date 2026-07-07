# frozen_string_literal: true

module Files
  class Setting
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    def self.languages(params = {}, options = {})
      Api.send_request("/settings/languages", :get, params, options)
      nil
    end

    def self.list(params = {}, options = {})
      response, options = Api.send_request("/settings", :get, params, options)
      Settings.new(response.data, options)
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   domain (required) - string
    def self.get_domain(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: domain must be an String") if params[:domain] and !params[:domain].is_a?(String)
      raise MissingParameterError.new("Parameter missing: domain") unless params[:domain]

      response, options = Api.send_request("/settings/domain", :get, params, options)
      Settings.new(response.data, options)
    end
  end
end
