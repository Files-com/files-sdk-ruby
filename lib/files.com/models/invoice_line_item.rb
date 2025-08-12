# frozen_string_literal: true

module Files
  class InvoiceLineItem
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Invoice Line item Id
    def id
      @attributes[:id]
    end

    # double - Invoice line item amount
    def amount
      @attributes[:amount]
    end

    # date-time - Invoice line item created at date/time
    def created_at
      @attributes[:created_at]
    end

    # string - Invoice line item description
    def description
      @attributes[:description]
    end

    # string - Invoice line item type
    def type
      @attributes[:type]
    end

    # date-time - Invoice line item service end date/time
    def service_end_at
      @attributes[:service_end_at]
    end

    # date-time - Invoice line item service start date/time
    def service_start_at
      @attributes[:service_start_at]
    end

    # string - Plan name
    def plan
      @attributes[:plan]
    end

    # string - Site name
    def site
      @attributes[:site]
    end

    # int64 - Prepaid bytes purchased for this invoice line item
    def prepaid_bytes
      @attributes[:prepaid_bytes]
    end

    # date-time - When the prepaid bytes expire
    def prepaid_bytes_expire_at
      @attributes[:prepaid_bytes_expire_at]
    end

    # int64 - Total prepaid bytes used for this invoice line item
    def prepaid_bytes_used
      @attributes[:prepaid_bytes_used]
    end

    # int64 - Available prepaid bytes for this invoice line item
    def prepaid_bytes_available
      @attributes[:prepaid_bytes_available]
    end
  end
end
