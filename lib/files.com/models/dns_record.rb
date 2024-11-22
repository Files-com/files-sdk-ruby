# frozen_string_literal: true

module Files
  class DnsRecord
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Unique label for DNS record; used by Zapier and other integrations.
    def id
      @attributes[:id]
    end

    # string - DNS record domain name
    def domain
      @attributes[:domain]
    end

    # string - DNS record type
    def rrtype
      @attributes[:rrtype]
    end

    # string - DNS record value
    def value
      @attributes[:value]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(DnsRecord, params) do
        Api.send_request("/dns_records", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    def self.create_export(params = {}, options = {})
      response, options = Api.send_request("/dns_records/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
