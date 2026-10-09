# frozen_string_literal: true

module Files
  class PartnerSite
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Returns the [response, options] pair from Files::Api.send_request.
    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partner_sites/#{@attributes[:id]}", :delete, params, @options)
    end

    # Alias for #delete. Returns nil.
    def destroy(params = {})
      delete(params)
      nil
    end

    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns nil.
    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partner_sites/#{params[:id]}", :delete, params, options)
      nil
    end

    # Alias for ::delete. Returns nil.
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
