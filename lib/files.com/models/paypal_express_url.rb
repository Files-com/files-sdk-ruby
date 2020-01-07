# frozen_string_literal: true

module Files
  class PaypalExpressUrl
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Redirect link
    def redirect_to
      @attributes[:redirect_to]
    end
  end
end
