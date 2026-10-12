# frozen_string_literal: true

module Files
  # Files::ChildSiteManagementPolicy is the Ruby SDK's representation of Files.com API ChildSiteManagementPolicy objects.
  # Each instance keeps its API field values in +attributes+.
  class ChildSiteManagementPolicy
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Policy ID.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Type of policy.  Valid values: `settings`.
    def policy_type
      @attributes[:policy_type]
    end

    def policy_type=(value)
      @attributes[:policy_type] = value
    end

    # string - Name for this policy.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Description for this policy.
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # object - Policy configuration data. On a Child Site, contains only managed setting names with null values. Settings policies accept site settings plus an optional `folder_behaviors` array for parent-managed root behaviors on child sites. For more information, refer to the Value Hash section of the developer documentation.
    def value
      @attributes[:value]
    end

    def value=(value)
      @attributes[:value] = value
    end

    # array(int64) - IDs of child sites that this policy has been applied to. This field is read-only.
    def applied_child_site_ids
      @attributes[:applied_child_site_ids]
    end

    def applied_child_site_ids=(value)
      @attributes[:applied_child_site_ids] = value
    end

    # array(int64) - IDs of child sites excluded from this default policy.
    def skip_child_site_ids
      @attributes[:skip_child_site_ids]
    end

    def skip_child_site_ids=(value)
      @attributes[:skip_child_site_ids] = value
    end

    # array(int64) - IDs of child sites explicitly assigned to this non-default policy.
    def child_site_ids
      @attributes[:child_site_ids]
    end

    def child_site_ids=(value)
      @attributes[:child_site_ids] = value
    end

    # boolean - Whether this policy applies to child sites not explicitly assigned to another policy.
    def default_policy
      @attributes[:default_policy]
    end

    def default_policy=(value)
      @attributes[:default_policy] = value
    end

    # date-time - When this policy was created.
    def created_at
      @attributes[:created_at]
    end

    # date-time - When this policy was last updated.
    def updated_at
      @attributes[:updated_at]
    end

    # Parameters:
    #   value - object - Policy configuration data. Attributes differ by policy type. For more information, refer to the Value Hash section of the developer documentation.
    #   skip_child_site_ids - array(int64) - IDs of child sites excluded from this default policy.
    #   child_site_ids - array(int64) - IDs of child sites explicitly assigned to this non-default policy.
    #   default_policy - boolean - Whether this policy applies to child sites not explicitly assigned to another policy.
    #   policy_type - string - Type of policy.  Valid values: `settings`.
    #   name - string - Name for this policy.
    #   description - string - Description for this policy.
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

    # Returns the [response, options] pair from Files::Api.send_request.
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

    # Alias for #delete. Returns nil.
    def destroy(params = {})
      delete(params)
      nil
    end

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

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::ChildSiteManagementPolicy objects.
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

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Child Site Management Policy ID.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::ChildSiteManagementPolicy.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/child_site_management_policies/#{params[:id]}", :get, params, options) { |reply| reply.require_object("ChildSiteManagementPolicy") }
      ChildSiteManagementPolicy.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   value - object - Policy configuration data. Attributes differ by policy type. For more information, refer to the Value Hash section of the developer documentation.
    #   skip_child_site_ids - array(int64) - IDs of child sites excluded from this default policy.
    #   child_site_ids - array(int64) - IDs of child sites explicitly assigned to this non-default policy.
    #   default_policy - boolean - Whether this policy applies to child sites not explicitly assigned to another policy.
    #   policy_type (required) - string - Type of policy.  Valid values: `settings`.
    #   name - string - Name for this policy.
    #   description - string - Description for this policy.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::ChildSiteManagementPolicy.
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

    # Parameters:
    #   value - object - Policy configuration data. Attributes differ by policy type. For more information, refer to the Value Hash section of the developer documentation.
    #   skip_child_site_ids - array(int64) - IDs of child sites excluded from this default policy.
    #   child_site_ids - array(int64) - IDs of child sites explicitly assigned to this non-default policy.
    #   default_policy - boolean - Whether this policy applies to child sites not explicitly assigned to another policy.
    #   policy_type - string - Type of policy.  Valid values: `settings`.
    #   name - string - Name for this policy.
    #   description - string - Description for this policy.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::ChildSiteManagementPolicy.
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

    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns nil.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/child_site_management_policies/#{params[:id]}", :delete, params, options)
      nil
    end

    # Alias for ::delete. Returns nil.
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
