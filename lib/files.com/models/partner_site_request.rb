# frozen_string_literal: true

module Files
  class PartnerSiteRequest
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Partner Site Request ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Partner ID
    def partner_id
      @attributes[:partner_id]
    end

    def partner_id=(value)
      @attributes[:partner_id] = value
    end

    # int64 - Linked Site ID
    def linked_site_id
      @attributes[:linked_site_id]
    end

    def linked_site_id=(value)
      @attributes[:linked_site_id] = value
    end

    # string - Request status (pending, approved, rejected)
    def status
      @attributes[:status]
    end

    def status=(value)
      @attributes[:status] = value
    end

    # string - Pairing key used to approve this request on the target site
    def pairing_key
      @attributes[:pairing_key]
    end

    def pairing_key=(value)
      @attributes[:pairing_key] = value
    end

    # date-time - Request creation date/time
    def created_at
      @attributes[:created_at]
    end

    # date-time - Request last updated date/time
    def updated_at
      @attributes[:updated_at]
    end

    # string - Site URL to link to
    def site_url
      @attributes[:site_url]
    end

    def site_url=(value)
      @attributes[:site_url] = value
    end

    # Reject partner site request
    def reject(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partner_site_requests/#{@attributes[:id]}/reject", :post, params, @options)
    end

    # Approve partner site request
    def approve(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partner_site_requests/#{@attributes[:id]}/approve", :post, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partner_site_requests/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The PartnerSiteRequest object doesn't support updates.")
      else
        new_obj = PartnerSiteRequest.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(PartnerSiteRequest, params) do
        Api.send_request("/partner_site_requests", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   pairing_key (required) - string - Pairing key for the partner site request
    def self.find_by_pairing_key(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: pairing_key must be an String") if params[:pairing_key] and !params[:pairing_key].is_a?(String)
      raise MissingParameterError.new("Parameter missing: pairing_key") unless params[:pairing_key]

      Api.send_request("/partner_site_requests/find_by_pairing_key", :get, params, options)
      nil
    end

    # Parameters:
    #   partner_id (required) - int64 - Partner ID to link with
    #   site_url (required) - string - Site URL to link to
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if params[:partner_id] and !params[:partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: site_url must be an String") if params[:site_url] and !params[:site_url].is_a?(String)
      raise MissingParameterError.new("Parameter missing: partner_id") unless params[:partner_id]
      raise MissingParameterError.new("Parameter missing: site_url") unless params[:site_url]

      response, options = Api.send_request("/partner_site_requests", :post, params, options)
      PartnerSiteRequest.new(response.data, options)
    end

    # Reject partner site request
    def self.reject(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partner_site_requests/#{params[:id]}/reject", :post, params, options)
      nil
    end

    # Approve partner site request
    def self.approve(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partner_site_requests/#{params[:id]}/approve", :post, params, options)
      nil
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partner_site_requests/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
