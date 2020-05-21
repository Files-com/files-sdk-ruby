# frozen_string_literal: true

module Files
  class Invoice
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Line item Id
    def id
      @attributes[:id]
    end

    # double - Line item amount
    def amount
      @attributes[:amount]
    end

    # double - Line item balance
    def balance
      @attributes[:balance]
    end

    # date-time - Line item created at
    def created_at
      @attributes[:created_at]
    end

    # string - Line item currency
    def currency
      @attributes[:currency]
    end

    # string - Line item download uri
    def download_uri
      @attributes[:download_uri]
    end

    # array - Associated invoice line items
    def invoice_line_items
      @attributes[:invoice_line_items]
    end

    # string - Line item payment method
    def method
      @attributes[:method]
    end

    # array - Associated payment line items
    def payment_line_items
      @attributes[:payment_line_items]
    end

    # date-time - Date/time payment was reversed if applicable
    def payment_reversed_at
      @attributes[:payment_reversed_at]
    end

    # string - Type of payment if applicable
    def payment_type
      @attributes[:payment_type]
    end

    # string - Site name this line item is for
    def site_name
      @attributes[:site_name]
    end

    # string - Type of line item, either payment or invoice
    def type
      @attributes[:type]
    end

    # date-time - Line item updated at
    def updated_at
      @attributes[:updated_at]
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/invoices", :get, params, options)
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - integer - Invoice ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/invoices/#{params[:id]}", :get, params, options)
      AccountLineItem.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
