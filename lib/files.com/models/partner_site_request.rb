# frozen_string_literal: true

module Files
  # Files::PartnerSiteRequest is the Ruby SDK's representation of Files.com API PartnerSiteRequest objects.
  # Each instance keeps its API field values in +attributes+.
  class PartnerSiteRequest
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

    # Partner Site Request ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def id=(value)
      @attributes[:id] = value
    end

    # Host Partner ID
    # @return [Integer, nil] the field value, or nil when absent.
    def host_partner_id
      @attributes[:host_partner_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def host_partner_id=(value)
      @attributes[:host_partner_id] = value
    end

    # Guest Site URL
    # @return [String, nil] the field value, or nil when absent.
    def guest_site_url
      @attributes[:guest_site_url]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def guest_site_url=(value)
      @attributes[:guest_site_url] = value
    end

    # Request status (pending, approved, rejected)
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def status=(value)
      @attributes[:status] = value
    end

    # Host Site Name
    # @return [String, nil] the field value, or nil when absent.
    def host_site_name
      @attributes[:host_site_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def host_site_name=(value)
      @attributes[:host_site_name] = value
    end

    # Pairing key used to approve this request on the Guest Site
    # @return [String, nil] the field value, or nil when absent.
    def pairing_key
      @attributes[:pairing_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def pairing_key=(value)
      @attributes[:pairing_key] = value
    end

    # Request creation date/time
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Request last updated date/time
    # @return [String, nil] the field value, or nil when absent.
    def updated_at
      @attributes[:updated_at]
    end

    # Delete Partner Site Request
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/partner_site_requests/#{@attributes[:id]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Calls {#delete} and discards its response.
    # @param (see #delete)
    # @option (see #delete)
    # @raise (see #delete)
    # @return [nil]
    def destroy(params = {})
      delete(params)
      nil
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    # @raise [Files::NotImplementedError] if this record already has an id; updates are unsupported.
    def save
      if @attributes[:id]
        raise NotImplementedError.new("The PartnerSiteRequest object doesn't support updates.")
      else
        new_obj = PartnerSiteRequest.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Partner Site Requests
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `host_partner_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `host_partner_id`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)

      list_options = options.dup
      List.new(PartnerSiteRequest, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/partner_site_requests", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Find partner site request by pairing key
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] pairing_key Required. Pairing key for the partner site request
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find_by_pairing_key(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: pairing_key must be an String") if !params[:pairing_key].nil? and !params[:pairing_key].is_a?(String)
      raise MissingParameterError.new("Parameter missing: pairing_key") if params[:pairing_key].nil?

      Api.send_request("/partner_site_requests/find_by_pairing_key", :get, params, options)
      nil
    end

    # Create Partner Site Request
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] host_partner_id Required. Host Partner ID to link with
    # @option params [String] guest_site_url Required. Guest Site URL to link to
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::PartnerSiteRequest] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: host_partner_id must be an Integer") if !params[:host_partner_id].nil? and !params[:host_partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: guest_site_url must be an String") if !params[:guest_site_url].nil? and !params[:guest_site_url].is_a?(String)
      raise MissingParameterError.new("Parameter missing: host_partner_id") if params[:host_partner_id].nil?
      raise MissingParameterError.new("Parameter missing: guest_site_url") if params[:guest_site_url].nil?

      response, options = Api.send_request("/partner_site_requests", :post, params, options) { |reply| reply.require_object("PartnerSiteRequest") }
      PartnerSiteRequest.new(response.data, options)
    end

    # Reject partner site request
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] pairing_key Required. Pairing key for the partner site request
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.reject(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: pairing_key must be an String") if !params[:pairing_key].nil? and !params[:pairing_key].is_a?(String)
      raise MissingParameterError.new("Parameter missing: pairing_key") if params[:pairing_key].nil?

      Api.send_request("/partner_site_requests/reject", :post, params, options)
      nil
    end

    # Approve partner site request
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] pairing_key Required. Pairing key for the partner site request
    # @option params [Integer] partner_id ID of an existing Partner on this site, with the host role, that represents the requesting organization. The connection binds to that Partner and makes it host_and_guest. When omitted, a guest Partner named after the host site is created.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.approve(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: pairing_key must be an String") if !params[:pairing_key].nil? and !params[:pairing_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if !params[:partner_id].nil? and !params[:partner_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: pairing_key") if params[:pairing_key].nil?

      Api.send_request("/partner_site_requests/approve", :post, params, options)
      nil
    end

    # Delete Partner Site Request
    #
    # @param id [Integer] Partner Site Request ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/partner_site_requests/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
