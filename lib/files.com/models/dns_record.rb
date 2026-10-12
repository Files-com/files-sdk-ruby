# frozen_string_literal: true

module Files
  # Files::DnsRecord is the Ruby SDK's representation of Files.com API DnsRecord objects.
  # Each instance keeps its API field values in +attributes+.
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
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::DnsRecord objects.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)

      List.new(DnsRecord, params) do |page_params, &check_page|
        Api.send_request("/dns_records", :get, page_params, options, &check_page)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
