# frozen_string_literal: true

module Files
  # Files::CustomDomain is the Ruby SDK's representation of Files.com API CustomDomain objects.
  # Each instance keeps its API field values in +attributes+.
  class CustomDomain
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

    # Custom Domain ID.
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

    # Workspace ID (0 for the default workspace).
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # Allow all workspaces to use this default-workspace Custom Domain.
    # @return [Boolean, nil] the field value, or nil when absent.
    def available_to_all_workspaces
      @attributes[:available_to_all_workspaces]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def available_to_all_workspaces=(value)
      @attributes[:available_to_all_workspaces] = value
    end

    # Eligible public IP addresses for Remote Server outbound connections. Empty when this Custom Domain is not eligible for outbound selection.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def outbound_ip_addresses
      @attributes[:outbound_ip_addresses]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def outbound_ip_addresses=(value)
      @attributes[:outbound_ip_addresses] = value
    end

    # Customer-owned domain name.
    # @return [String, nil] the field value, or nil when absent.
    def domain
      @attributes[:domain]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def domain=(value)
      @attributes[:domain] = value
    end

    # Where this custom domain routes. Can be `site_alias`, `public_hosting`, `s3_endpoint`, or `unassigned` (not routing traffic). Set to `unassigned` automatically when a bound `public_hosting` folder behavior is deleted, and can be set manually via the API for any reason.
    # @return [String, nil] the field value, or nil when absent.
    def destination
      @attributes[:destination]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def destination=(value)
      @attributes[:destination] = value
    end

    # Current DNS verification status.
    # @return [String, nil] the field value, or nil when absent.
    def dns_status
      @attributes[:dns_status]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def dns_status=(value)
      @attributes[:dns_status] = value
    end

    # Current SSL certificate ID.
    # @return [Integer, nil] the field value, or nil when absent.
    def ssl_certificate_id
      @attributes[:ssl_certificate_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def ssl_certificate_id=(value)
      @attributes[:ssl_certificate_id] = value
    end

    # Is this domain's SSL certificate automatically managed and renewed by Files.com?
    # @return [Boolean, nil] the field value, or nil when absent.
    def brick_managed
      @attributes[:brick_managed]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def brick_managed=(value)
      @attributes[:brick_managed] = value
    end

    # Public Hosting behavior ID when this domain routes to a specific Public Hosting behavior.  Preserved as historical context when `destination` becomes `unassigned`.
    # @return [Integer, nil] the field value, or nil when absent.
    def folder_behavior_id
      @attributes[:folder_behavior_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def folder_behavior_id=(value)
      @attributes[:folder_behavior_id] = value
    end

    # Dedicated public IP addresses allocated to this Custom Domain.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def ip_addresses
      @attributes[:ip_addresses]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def ip_addresses=(value)
      @attributes[:ip_addresses] = value
    end

    # When this Custom Domain was created.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # When this Custom Domain was last updated.
    # @return [String, nil] the field value, or nil when absent.
    def updated_at
      @attributes[:updated_at]
    end

    # Update Custom Domain
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] available_to_all_workspaces Allow all workspaces to use this default-workspace Custom Domain.
    # @option params [Integer] workspace_id Workspace ID (0 for the default workspace).
    # @option params [String] destination Where this custom domain routes. Can be `site_alias`, `public_hosting`, `s3_endpoint`, or `unassigned` (not routing traffic). Set to `unassigned` automatically when a bound `public_hosting` folder behavior is deleted, and can be set manually via the API for any reason.
    # @option params [Integer] folder_behavior_id Public Hosting behavior ID when this domain routes to a specific Public Hosting behavior.  Preserved as historical context when `destination` becomes `unassigned`.
    # @option params [Integer] ssl_certificate_id Current SSL certificate ID.
    # @option params [String] domain Customer-owned domain name.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: available_to_all_workspaces must be a single value, not #{params[:available_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:available_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: folder_behavior_id must be an Integer") if !params[:folder_behavior_id].nil? and !params[:folder_behavior_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate_id must be an Integer") if !params[:ssl_certificate_id].nil? and !params[:ssl_certificate_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: domain must be an String") if !params[:domain].nil? and !params[:domain].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/custom_domains/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("CustomDomain") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Custom Domain
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

      response, options = Api.send_request("/custom_domains/#{@attributes[:id]}", :delete, params, @options)
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
    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = CustomDomain.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Custom Domains
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `id` or `available_to_all_workspaces`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id`.
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
      List.new(CustomDomain, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/custom_domains", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Custom Domain
    #
    # @param id [Integer] Custom Domain ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::CustomDomain] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/custom_domains/#{params[:id]}", :get, params, options) { |reply| reply.require_object("CustomDomain") }
      CustomDomain.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Allocate dedicated IP addresses to this Custom Domain
    #
    # @param id [Integer] Custom Domain ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] count Required. Number of dedicated IP addresses to allocate.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::CustomDomain] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create_allocate_ip(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: count must be an Integer") if !params[:count].nil? and !params[:count].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?
      raise MissingParameterError.new("Parameter missing: count") if params[:count].nil?

      response, options = Api.send_request("/custom_domains/#{params[:id]}/allocate_ips", :post, params, options) { |reply| reply.require_object("CustomDomain") }
      CustomDomain.new(response.data, options)
    end

    # Create Custom Domain
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] available_to_all_workspaces Allow all workspaces to use this default-workspace Custom Domain.
    # @option params [Integer] workspace_id Workspace ID (0 for the default workspace).
    # @option params [String] destination Where this custom domain routes. Can be `site_alias`, `public_hosting`, `s3_endpoint`, or `unassigned` (not routing traffic). Set to `unassigned` automatically when a bound `public_hosting` folder behavior is deleted, and can be set manually via the API for any reason.
    # @option params [Integer] folder_behavior_id Public Hosting behavior ID when this domain routes to a specific Public Hosting behavior.  Preserved as historical context when `destination` becomes `unassigned`.
    # @option params [Integer] ssl_certificate_id Current SSL certificate ID.
    # @option params [String] domain Required. Customer-owned domain name.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::CustomDomain] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: available_to_all_workspaces must be a single value, not #{params[:available_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:available_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: folder_behavior_id must be an Integer") if !params[:folder_behavior_id].nil? and !params[:folder_behavior_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate_id must be an Integer") if !params[:ssl_certificate_id].nil? and !params[:ssl_certificate_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: domain must be an String") if !params[:domain].nil? and !params[:domain].is_a?(String)
      raise MissingParameterError.new("Parameter missing: domain") if params[:domain].nil?

      response, options = Api.send_request("/custom_domains", :post, params, options) { |reply| reply.require_object("CustomDomain") }
      CustomDomain.new(response.data, options)
    end

    # Update Custom Domain
    #
    # @param id [Integer] Custom Domain ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] available_to_all_workspaces Allow all workspaces to use this default-workspace Custom Domain.
    # @option params [Integer] workspace_id Workspace ID (0 for the default workspace).
    # @option params [String] destination Where this custom domain routes. Can be `site_alias`, `public_hosting`, `s3_endpoint`, or `unassigned` (not routing traffic). Set to `unassigned` automatically when a bound `public_hosting` folder behavior is deleted, and can be set manually via the API for any reason.
    # @option params [Integer] folder_behavior_id Public Hosting behavior ID when this domain routes to a specific Public Hosting behavior.  Preserved as historical context when `destination` becomes `unassigned`.
    # @option params [Integer] ssl_certificate_id Current SSL certificate ID.
    # @option params [String] domain Customer-owned domain name.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::CustomDomain] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: available_to_all_workspaces must be a single value, not #{params[:available_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:available_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: folder_behavior_id must be an Integer") if !params[:folder_behavior_id].nil? and !params[:folder_behavior_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate_id must be an Integer") if !params[:ssl_certificate_id].nil? and !params[:ssl_certificate_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: domain must be an String") if !params[:domain].nil? and !params[:domain].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/custom_domains/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("CustomDomain") }
      CustomDomain.new(response.data, options)
    end

    # Delete Custom Domain
    #
    # @param id [Integer] Custom Domain ID.
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

      Api.send_request("/custom_domains/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
