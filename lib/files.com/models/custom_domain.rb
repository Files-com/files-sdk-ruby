# frozen_string_literal: true

module Files
  class CustomDomain
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Custom Domain ID.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Workspace ID (0 for the default workspace).
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # boolean - Allow all workspaces to use this default-workspace Custom Domain.
    def available_to_all_workspaces
      @attributes[:available_to_all_workspaces]
    end

    def available_to_all_workspaces=(value)
      @attributes[:available_to_all_workspaces] = value
    end

    # array(string) - Eligible public IP addresses for Remote Server outbound connections. Empty when this Custom Domain is not eligible for outbound selection.
    def outbound_ip_addresses
      @attributes[:outbound_ip_addresses]
    end

    def outbound_ip_addresses=(value)
      @attributes[:outbound_ip_addresses] = value
    end

    # string - Customer-owned domain name.
    def domain
      @attributes[:domain]
    end

    def domain=(value)
      @attributes[:domain] = value
    end

    # string - Where this custom domain routes. Can be `site_alias`, `public_hosting`, `s3_endpoint`, or `unassigned` (not routing traffic). Set to `unassigned` automatically when a bound `public_hosting` folder behavior is deleted, and can be set manually via the API for any reason.
    def destination
      @attributes[:destination]
    end

    def destination=(value)
      @attributes[:destination] = value
    end

    # string - Current DNS verification status.
    def dns_status
      @attributes[:dns_status]
    end

    def dns_status=(value)
      @attributes[:dns_status] = value
    end

    # int64 - Current SSL certificate ID.
    def ssl_certificate_id
      @attributes[:ssl_certificate_id]
    end

    def ssl_certificate_id=(value)
      @attributes[:ssl_certificate_id] = value
    end

    # boolean - Is this domain's SSL certificate automatically managed and renewed by Files.com?
    def brick_managed
      @attributes[:brick_managed]
    end

    def brick_managed=(value)
      @attributes[:brick_managed] = value
    end

    # int64 - Public Hosting behavior ID when this domain routes to a specific Public Hosting behavior.  Preserved as historical context when `destination` becomes `unassigned`.
    def folder_behavior_id
      @attributes[:folder_behavior_id]
    end

    def folder_behavior_id=(value)
      @attributes[:folder_behavior_id] = value
    end

    # array(string) - Dedicated public IP addresses allocated to this Custom Domain.
    def ip_addresses
      @attributes[:ip_addresses]
    end

    def ip_addresses=(value)
      @attributes[:ip_addresses] = value
    end

    # date-time - When this Custom Domain was created.
    def created_at
      @attributes[:created_at]
    end

    # date-time - When this Custom Domain was last updated.
    def updated_at
      @attributes[:updated_at]
    end

    # Parameters:
    #   available_to_all_workspaces - boolean - Allow all workspaces to use this default-workspace Custom Domain.
    #   workspace_id - int64 - Workspace ID (0 for the default workspace).
    #   destination - string - Where this custom domain routes. Can be `site_alias`, `public_hosting`, `s3_endpoint`, or `unassigned` (not routing traffic). Set to `unassigned` automatically when a bound `public_hosting` folder behavior is deleted, and can be set manually via the API for any reason.
    #   folder_behavior_id - int64 - Public Hosting behavior ID when this domain routes to a specific Public Hosting behavior.  Preserved as historical context when `destination` becomes `unassigned`.
    #   ssl_certificate_id - int64 - Current SSL certificate ID.
    #   domain - string - Customer-owned domain name.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params[:destination] and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: folder_behavior_id must be an Integer") if params[:folder_behavior_id] and !params[:folder_behavior_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate_id must be an Integer") if params[:ssl_certificate_id] and !params[:ssl_certificate_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: domain must be an String") if params[:domain] and !params[:domain].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/custom_domains/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("CustomDomain") }
      @attributes = response.data
      [ response, options ]
    end

    # Returns the [response, options] pair from Files::Api.send_request.
    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/custom_domains/#{@attributes[:id]}", :delete, params, @options)
    end

    # Alias for #delete. Returns nil.
    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = CustomDomain.create(@attributes, @options)
        @attributes = new_obj.attributes
      end

      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `id` or `available_to_all_workspaces`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id`.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::CustomDomain objects.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(CustomDomain, params) do |page_params, &check_page|
        Api.send_request("/custom_domains", :get, page_params, options, &check_page)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Custom Domain ID.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::CustomDomain.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/custom_domains/#{params[:id]}", :get, params, options) { |reply| reply.require_object("CustomDomain") }
      CustomDomain.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   id (required) - int64 - Custom Domain ID.
    #   count (required) - int64 - Number of dedicated IP addresses to allocate.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::CustomDomain.
    def self.create_allocate_ip(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: count must be an Integer") if params[:count] and !params[:count].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: count") unless params[:count]

      response, options = Api.send_request("/custom_domains/#{params[:id]}/allocate_ips", :post, params, options) { |reply| reply.require_object("CustomDomain") }
      CustomDomain.new(response.data, options)
    end

    # Parameters:
    #   available_to_all_workspaces - boolean - Allow all workspaces to use this default-workspace Custom Domain.
    #   workspace_id - int64 - Workspace ID (0 for the default workspace).
    #   destination - string - Where this custom domain routes. Can be `site_alias`, `public_hosting`, `s3_endpoint`, or `unassigned` (not routing traffic). Set to `unassigned` automatically when a bound `public_hosting` folder behavior is deleted, and can be set manually via the API for any reason.
    #   folder_behavior_id - int64 - Public Hosting behavior ID when this domain routes to a specific Public Hosting behavior.  Preserved as historical context when `destination` becomes `unassigned`.
    #   ssl_certificate_id - int64 - Current SSL certificate ID.
    #   domain (required) - string - Customer-owned domain name.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::CustomDomain.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params[:destination] and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: folder_behavior_id must be an Integer") if params[:folder_behavior_id] and !params[:folder_behavior_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate_id must be an Integer") if params[:ssl_certificate_id] and !params[:ssl_certificate_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: domain must be an String") if params[:domain] and !params[:domain].is_a?(String)
      raise MissingParameterError.new("Parameter missing: domain") unless params[:domain]

      response, options = Api.send_request("/custom_domains", :post, params, options) { |reply| reply.require_object("CustomDomain") }
      CustomDomain.new(response.data, options)
    end

    # Parameters:
    #   available_to_all_workspaces - boolean - Allow all workspaces to use this default-workspace Custom Domain.
    #   workspace_id - int64 - Workspace ID (0 for the default workspace).
    #   destination - string - Where this custom domain routes. Can be `site_alias`, `public_hosting`, `s3_endpoint`, or `unassigned` (not routing traffic). Set to `unassigned` automatically when a bound `public_hosting` folder behavior is deleted, and can be set manually via the API for any reason.
    #   folder_behavior_id - int64 - Public Hosting behavior ID when this domain routes to a specific Public Hosting behavior.  Preserved as historical context when `destination` becomes `unassigned`.
    #   ssl_certificate_id - int64 - Current SSL certificate ID.
    #   domain - string - Customer-owned domain name.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::CustomDomain.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params[:destination] and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: folder_behavior_id must be an Integer") if params[:folder_behavior_id] and !params[:folder_behavior_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate_id must be an Integer") if params[:ssl_certificate_id] and !params[:ssl_certificate_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: domain must be an String") if params[:domain] and !params[:domain].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/custom_domains/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("CustomDomain") }
      CustomDomain.new(response.data, options)
    end

    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns nil.
    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/custom_domains/#{params[:id]}", :delete, params, options)
      nil
    end

    # Alias for ::delete. Returns nil.
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
