# frozen_string_literal: true

module Files
  class PartnerSite
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Host Partner ID
    def host_partner_id
      @attributes[:host_partner_id]
    end

    # string - Host Partner Name
    def host_partner_name
      @attributes[:host_partner_name]
    end

    # int64 - Guest Partner ID
    def guest_partner_id
      @attributes[:guest_partner_id]
    end

    # string - Guest Partner Name
    def guest_partner_name
      @attributes[:guest_partner_name]
    end

    # int64 - Host Site ID
    def host_site_id
      @attributes[:host_site_id]
    end

    # string - Host Site Name
    def host_site_name
      @attributes[:host_site_name]
    end

    # int64 - Guest Site ID
    def guest_site_id
      @attributes[:guest_site_id]
    end

    # string - Guest Site Name
    def guest_site_name
      @attributes[:guest_site_name]
    end

    # int64 - Workspace ID for the Host Partner
    def workspace_id
      @attributes[:workspace_id]
    end

    def self.linkeds(params = {}, options = {})
      response, options = Api.send_request("/partner_sites/linked_partner_sites", :get, params, options)
      response.data.map do |entity_data|
        PartnerSite.new(entity_data, options)
      end
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(PartnerSite, params) do
        Api.send_request("/partner_sites", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
