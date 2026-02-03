# frozen_string_literal: true

require "bigdecimal"

module Files
  class PaymentLineItem
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # decimal - Payment line item amount
    def amount
      value = @attributes[:amount]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    # date-time - Payment line item created at date/time
    def created_at
      @attributes[:created_at]
    end

    # int64 - Invoice ID
    def invoice_id
      @attributes[:invoice_id]
    end

    # int64 - Payment ID
    def payment_id
      @attributes[:payment_id]
    end
  end
end
