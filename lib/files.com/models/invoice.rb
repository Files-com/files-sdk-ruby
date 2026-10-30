# frozen_string_literal: true

require "bigdecimal"

module Files
  # Files::Invoice is the Ruby SDK's representation of Files.com API Invoice objects.
  # Each instance keeps its API field values in +attributes+.
  class Invoice
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

    # List Invoices
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)

      list_options = options.dup
      List.new(AccountLineItem, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/invoices", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Invoice
    #
    # @param id [Integer] Invoice ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AccountLineItem] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/invoices/#{params[:id]}", :get, params, options) { |reply| reply.require_object("AccountLineItem") }
      AccountLineItem.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
