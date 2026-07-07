# frozen_string_literal: true

module Files
  class ClickwrapAcceptance
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Clickwrap Acceptance ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Clickwrap ID
    def clickwrap_id
      @attributes[:clickwrap_id]
    end

    def clickwrap_id=(value)
      @attributes[:clickwrap_id] = value
    end

    # date-time - Acceptance timestamp
    def created_at
      @attributes[:created_at]
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The ClickwrapAcceptance object doesn't support updates.")
      else
        new_obj = ClickwrapAcceptance.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   clickwrap_id (required) - int64
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: clickwrap_id must be an Integer") if params[:clickwrap_id] and !params[:clickwrap_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: clickwrap_id") unless params[:clickwrap_id]

      response, options = Api.send_request("/clickwrap_acceptances", :post, params, options)
      ClickwrapAcceptance.new(response.data, options)
    end
  end
end
