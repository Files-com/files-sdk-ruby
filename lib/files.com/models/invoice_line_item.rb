# frozen_string_literal: true

module Files
  class InvoiceLineItem
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
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

    # date-time - Invoice line item updated date/time
    def updated_at
      @attributes[:updated_at]
    end

    # string - Plan name
    def plan
      @attributes[:plan]
    end

    # string - Site name
    def site
      @attributes[:site]
    end
  end
end
