# frozen_string_literal: true

module Files
  class PaymentLineItem
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # float - Payment line item amount
    def amount
      @attributes[:amount]
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

    # date-time - Payment line item updated at date/time
    def updated_at
      @attributes[:updated_at]
    end
  end
end
