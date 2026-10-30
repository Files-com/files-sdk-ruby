# frozen_string_literal: true

require "bigdecimal"

module Files
  # Files::PaymentLineItem is the Ruby SDK's representation of Files.com API PaymentLineItem objects.
  # Each instance keeps its API field values in +attributes+.
  class PaymentLineItem
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Payment line item amount
    # @return [BigDecimal, nil] the field value, or nil when absent.
    def amount
      value = @attributes[:amount]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    # Payment line item created at date/time
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Invoice ID
    # @return [Integer, nil] the field value, or nil when absent.
    def invoice_id
      @attributes[:invoice_id]
    end

    # Payment ID
    # @return [Integer, nil] the field value, or nil when absent.
    def payment_id
      @attributes[:payment_id]
    end
  end
end
