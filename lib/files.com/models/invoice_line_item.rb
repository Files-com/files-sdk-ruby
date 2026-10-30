# frozen_string_literal: true

require "bigdecimal"

module Files
  # Files::InvoiceLineItem is the Ruby SDK's representation of Files.com API InvoiceLineItem objects.
  # Each instance keeps its API field values in +attributes+.
  class InvoiceLineItem
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

    # Invoice Line item Id
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Invoice line item amount
    # @return [BigDecimal, nil] the field value, or nil when absent.
    def amount
      value = @attributes[:amount]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    # Invoice line item created at date/time
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Invoice line item description
    # @return [String, nil] the field value, or nil when absent.
    def description
      @attributes[:description]
    end

    # Invoice line item type
    # @return [String, nil] the field value, or nil when absent.
    def type
      @attributes[:type]
    end

    # Invoice line item service end date/time
    # @return [String, nil] the field value, or nil when absent.
    def service_end_at
      @attributes[:service_end_at]
    end

    # Invoice line item service start date/time
    # @return [String, nil] the field value, or nil when absent.
    def service_start_at
      @attributes[:service_start_at]
    end

    # Plan name
    # @return [String, nil] the field value, or nil when absent.
    def plan
      @attributes[:plan]
    end

    # Site name
    # @return [String, nil] the field value, or nil when absent.
    def site
      @attributes[:site]
    end

    # Prepaid bytes purchased for this invoice line item
    # @return [Integer, nil] the field value, or nil when absent.
    def prepaid_bytes
      @attributes[:prepaid_bytes]
    end

    # When the prepaid bytes expire
    # @return [String, nil] the field value, or nil when absent.
    def prepaid_bytes_expire_at
      @attributes[:prepaid_bytes_expire_at]
    end

    # Total prepaid bytes used for this invoice line item
    # @return [Integer, nil] the field value, or nil when absent.
    def prepaid_bytes_used
      @attributes[:prepaid_bytes_used]
    end

    # Available prepaid bytes for this invoice line item
    # @return [Integer, nil] the field value, or nil when absent.
    def prepaid_bytes_available
      @attributes[:prepaid_bytes_available]
    end
  end
end
