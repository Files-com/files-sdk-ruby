# frozen_string_literal: true

module Files
  class IpAddress
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Unique label for list; used by Zapier and other integrations.
    def id
      @attributes[:id]
    end

    # string - The object that this public IP address list is associated with.
    def associated_with
      @attributes[:associated_with]
    end

    # int64 - Group ID
    def group_id
      @attributes[:group_id]
    end

    # array(string) - A list of IP addresses.
    def ip_addresses
      @attributes[:ip_addresses]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(IpAddress, params) do
        Api.send_request("/ip_addresses", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.get_smartfile_reserved(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(PublicIpAddress, params) do
        Api.send_request("/ip_addresses/smartfile-reserved", :get, params, options)
      end
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.get_exavault_reserved(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(PublicIpAddress, params) do
        Api.send_request("/ip_addresses/exavault-reserved", :get, params, options)
      end
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.get_reserved(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(PublicIpAddress, params) do
        Api.send_request("/ip_addresses/reserved", :get, params, options)
      end
    end

    def self.smartfile_reserved_create_export(params = {}, options = {})
      response, options = Api.send_request("/ip_addresses/smartfile-reserved/create_export", :post, params, options)
      Export.new(response.data, options)
    end

    def self.exavault_reserved_create_export(params = {}, options = {})
      response, options = Api.send_request("/ip_addresses/exavault-reserved/create_export", :post, params, options)
      Export.new(response.data, options)
    end

    def self.reserved_create_export(params = {}, options = {})
      response, options = Api.send_request("/ip_addresses/reserved/create_export", :post, params, options)
      Export.new(response.data, options)
    end

    def self.create_export(params = {}, options = {})
      response, options = Api.send_request("/ip_addresses/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
