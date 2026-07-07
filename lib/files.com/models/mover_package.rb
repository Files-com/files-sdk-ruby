# frozen_string_literal: true

require "bigdecimal"

module Files
  class MoverPackage
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Mover package ID
    def id
      @attributes[:id]
    end

    # int64 - Total prepaid bytes included in this package
    def prepaid_bytes
      @attributes[:prepaid_bytes]
    end

    # int64 - Number of days this package is valid for after purchase
    def prepaid_expire_in_days
      @attributes[:prepaid_expire_in_days]
    end

    # decimal - Price of this mover package in the site's currency
    def price
      value = @attributes[:price]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    # Purchase a Mover package for the current site
    def purchase(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/mover_packages/#{@attributes[:id]}/purchase", :post, params, @options)
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(MoverPackage, params) do
        Api.send_request("/mover_packages", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Purchase a Mover package for the current site
    def self.purchase(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/mover_packages/#{params[:id]}/purchase", :post, params, options)
      MoverPackage.new(response.data, options)
    end

    def self.create_export(params = {}, options = {})
      response, options = Api.send_request("/mover_packages/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
