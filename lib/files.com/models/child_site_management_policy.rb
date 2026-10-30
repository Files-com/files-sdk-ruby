# frozen_string_literal: true

module Files
  # Files::ChildSiteManagementPolicy is the Ruby SDK's representation of Files.com API ChildSiteManagementPolicy objects.
  # Each instance keeps its API field values in +attributes+.
  class ChildSiteManagementPolicy
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

    # Policy ID.
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

    # Type of policy.  Valid values: `settings`.
    # @return [String, nil] the field value, or nil when absent.
    def policy_type
      @attributes[:policy_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def policy_type=(value)
      @attributes[:policy_type] = value
    end

    # Name for this policy.
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def name=(value)
      @attributes[:name] = value
    end

    # Description for this policy.
    # @return [String, nil] the field value, or nil when absent.
    def description
      @attributes[:description]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def description=(value)
      @attributes[:description] = value
    end

    # Policy configuration data. On a Child Site, contains only managed setting names with null values. Settings policies accept site settings plus an optional `folder_behaviors` array for parent-managed root behaviors on child sites. For more information, refer to the Value Hash section of the developer documentation.
    # @return [Hash, nil] the field value, or nil when absent.
    def value
      @attributes[:value]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def value=(value)
      @attributes[:value] = value
    end

    # IDs of child sites that this policy has been applied to. This field is read-only.
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def applied_child_site_ids
      @attributes[:applied_child_site_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def applied_child_site_ids=(value)
      @attributes[:applied_child_site_ids] = value
    end

    # IDs of child sites excluded from this default policy.
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def skip_child_site_ids
      @attributes[:skip_child_site_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def skip_child_site_ids=(value)
      @attributes[:skip_child_site_ids] = value
    end

    # IDs of child sites explicitly assigned to this non-default policy.
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def child_site_ids
      @attributes[:child_site_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def child_site_ids=(value)
      @attributes[:child_site_ids] = value
    end

    # Whether this policy applies to child sites not explicitly assigned to another policy.
    # @return [Boolean, nil] the field value, or nil when absent.
    def default_policy
      @attributes[:default_policy]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def default_policy=(value)
      @attributes[:default_policy] = value
    end

    # When this policy was created.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # When this policy was last updated.
    # @return [String, nil] the field value, or nil when absent.
    def updated_at
      @attributes[:updated_at]
    end

    # Update Child Site Management Policy
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Hash] value Policy configuration data. Attributes differ by policy type. For more information, refer to the Value Hash section of the developer documentation.
    # @option params [Array<Integer>] skip_child_site_ids IDs of child sites excluded from this default policy.
    # @option params [Array<Integer>] child_site_ids IDs of child sites explicitly assigned to this non-default policy.
    # @option params [Boolean] default_policy Whether this policy applies to child sites not explicitly assigned to another policy.
    # @option params [String] policy_type Type of policy.  Valid values: `settings`.
    # @option params [String] name Name for this policy.
    # @option params [String] description Description for this policy.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if !params[:value].nil? and !params[:value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: skip_child_site_ids must be an Array") if !params[:skip_child_site_ids].nil? and !params[:skip_child_site_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: child_site_ids must be an Array") if !params[:child_site_ids].nil? and !params[:child_site_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: default_policy must be a single value, not #{params[:default_policy].class}") if [ Array, Hash ].any? { |klass| params[:default_policy].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: policy_type must be an String") if !params[:policy_type].nil? and !params[:policy_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/child_site_management_policies/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("ChildSiteManagementPolicy") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Child Site Management Policy
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

      response, options = Api.send_request("/child_site_management_policies/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = ChildSiteManagementPolicy.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Child Site Management Policies. On a Child Site, returns only the policy covering that site. Its value contains managed setting names with null values
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
      List.new(ChildSiteManagementPolicy, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/child_site_management_policies", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Child Site Management Policy
    #
    # @param id [Integer] Child Site Management Policy ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ChildSiteManagementPolicy] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/child_site_management_policies/#{params[:id]}", :get, params, options) { |reply| reply.require_object("ChildSiteManagementPolicy") }
      ChildSiteManagementPolicy.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Child Site Management Policy
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Hash] value Policy configuration data. Attributes differ by policy type. For more information, refer to the Value Hash section of the developer documentation.
    # @option params [Array<Integer>] skip_child_site_ids IDs of child sites excluded from this default policy.
    # @option params [Array<Integer>] child_site_ids IDs of child sites explicitly assigned to this non-default policy.
    # @option params [Boolean] default_policy Whether this policy applies to child sites not explicitly assigned to another policy.
    # @option params [String] policy_type Required. Type of policy.  Valid values: `settings`.
    # @option params [String] name Name for this policy.
    # @option params [String] description Description for this policy.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ChildSiteManagementPolicy] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if !params[:value].nil? and !params[:value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: skip_child_site_ids must be an Array") if !params[:skip_child_site_ids].nil? and !params[:skip_child_site_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: child_site_ids must be an Array") if !params[:child_site_ids].nil? and !params[:child_site_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: default_policy must be a single value, not #{params[:default_policy].class}") if [ Array, Hash ].any? { |klass| params[:default_policy].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: policy_type must be an String") if !params[:policy_type].nil? and !params[:policy_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise MissingParameterError.new("Parameter missing: policy_type") if params[:policy_type].nil?

      response, options = Api.send_request("/child_site_management_policies", :post, params, options) { |reply| reply.require_object("ChildSiteManagementPolicy") }
      ChildSiteManagementPolicy.new(response.data, options)
    end

    # Update Child Site Management Policy
    #
    # @param id [Integer] Child Site Management Policy ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Hash] value Policy configuration data. Attributes differ by policy type. For more information, refer to the Value Hash section of the developer documentation.
    # @option params [Array<Integer>] skip_child_site_ids IDs of child sites excluded from this default policy.
    # @option params [Array<Integer>] child_site_ids IDs of child sites explicitly assigned to this non-default policy.
    # @option params [Boolean] default_policy Whether this policy applies to child sites not explicitly assigned to another policy.
    # @option params [String] policy_type Type of policy.  Valid values: `settings`.
    # @option params [String] name Name for this policy.
    # @option params [String] description Description for this policy.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ChildSiteManagementPolicy] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if !params[:value].nil? and !params[:value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: skip_child_site_ids must be an Array") if !params[:skip_child_site_ids].nil? and !params[:skip_child_site_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: child_site_ids must be an Array") if !params[:child_site_ids].nil? and !params[:child_site_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: default_policy must be a single value, not #{params[:default_policy].class}") if [ Array, Hash ].any? { |klass| params[:default_policy].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: policy_type must be an String") if !params[:policy_type].nil? and !params[:policy_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/child_site_management_policies/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("ChildSiteManagementPolicy") }
      ChildSiteManagementPolicy.new(response.data, options)
    end

    # Delete Child Site Management Policy
    #
    # @param id [Integer] Child Site Management Policy ID.
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

      Api.send_request("/child_site_management_policies/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
