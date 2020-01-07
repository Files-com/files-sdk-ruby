# frozen_string_literal: true

module Files
  class Upsell
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Available plan object
    def plan
      @attributes[:plan]
    end

    # string - Salesletter name
    def sales_letter_name
      @attributes[:sales_letter_name]
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   plan_id (required) - integer - Plan ID.
    def self.on_initial_sale(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: plan_id must be an Integer") if params.dig(:plan_id) and !params.dig(:plan_id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: plan_id") unless params.dig(:plan_id)

      response, options = Api.send_request("/upsells/on_initial_sale", :post, params, options)
      response.data.map { |object| Upsell.new(object, options) }
    end
  end
end
