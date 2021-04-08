# frozen_string_literal: true

module Files
  class Payment
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

    # Associated invoice line items
    def invoice_line_items
      @attributes[:invoice_line_items]
    end

    # string - Line item payment method
    def method
      @attributes[:method]
    end

    # Associated payment line items
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
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)

      List.new(AccountLineItem, params) do
        Api.send_request("/payments", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Payment ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/payments/#{params[:id]}", :get, params, options)
      AccountLineItem.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
