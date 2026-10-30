# frozen_string_literal: true

require "bigdecimal"

module Files
  # Files::AccountLineItem is the Ruby SDK's representation of Files.com API AccountLineItem objects.
  # Each instance keeps its API field values in +attributes+.
  class AccountLineItem
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

    # Line item Id
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Line item amount
    # @return [BigDecimal, nil] the field value, or nil when absent.
    def amount
      value = @attributes[:amount]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    # Line item balance
    # @return [BigDecimal, nil] the field value, or nil when absent.
    def balance
      value = @attributes[:balance]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    # Line item created at
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Line item currency
    # @return [String, nil] the field value, or nil when absent.
    def currency
      @attributes[:currency]
    end

    # Line item download uri
    # @return [String, nil] the field value, or nil when absent.
    def download_uri
      @attributes[:download_uri]
    end

    # Associated invoice line items
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def invoice_line_items
      @attributes[:invoice_line_items]
    end

    # Line item payment method
    # @return [String, nil] the field value, or nil when absent.
    def method
      @attributes[:method]
    end

    # Associated payment line items
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def payment_line_items
      @attributes[:payment_line_items]
    end

    # Date/time payment was reversed if applicable
    # @return [String, nil] the field value, or nil when absent.
    def payment_reversed_at
      @attributes[:payment_reversed_at]
    end

    # Type of payment if applicable
    # @return [String, nil] the field value, or nil when absent.
    def payment_type
      @attributes[:payment_type]
    end

    # Site name this line item is for
    # @return [String, nil] the field value, or nil when absent.
    def site_name
      @attributes[:site_name]
    end

    # Type of line item, either payment or invoice
    # @return [String, nil] the field value, or nil when absent.
    def type
      @attributes[:type]
    end
  end
end
