# frozen_string_literal: true

module Files
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

    # object - Policy configuration data. Attributes differ by policy type. For more information, refer to the Value Hash section of the developer documentation.
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

    # array(int64) - IDs of child sites that this policy has been exempted from. If `skip_child_site_ids` is empty, the policy will be applied to all child sites. To apply a policy to a child site that has been exempted, remove it from `skip_child_site_ids` or set it to an empty array (`[]`).
    def skip_child_site_ids
      @attributes[:skip_child_site_ids]
    end

    def skip_child_site_ids=(value)
      @attributes[:skip_child_site_ids] = value
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
    #   value - string
    #   skip_child_site_ids - array(int64) - IDs of child sites that this policy has been exempted from. If `skip_child_site_ids` is empty, the policy will be applied to all child sites. To apply a policy to a child site that has been exempted, remove it from `skip_child_site_ids` or set it to an empty array (`[]`).
    #   policy_type - string - Type of policy.  Valid values: `settings`.
    #   name - string - Name for this policy.
    #   description - string - Description for this policy.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: value must be an String") if params[:value] and !params[:value].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: skip_child_site_ids must be an Array") if params[:skip_child_site_ids] and !params[:skip_child_site_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: policy_type must be an String") if params[:policy_type] and !params[:policy_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/child_site_management_policies/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/child_site_management_policies/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = ChildSiteManagementPolicy.create(@attributes, @options)
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

      List.new(ChildSiteManagementPolicy, params) do
        Api.send_request("/child_site_management_policies", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Child Site Management Policy ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/child_site_management_policies/#{params[:id]}", :get, params, options)
      ChildSiteManagementPolicy.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   value - string
    #   skip_child_site_ids - array(int64) - IDs of child sites that this policy has been exempted from. If `skip_child_site_ids` is empty, the policy will be applied to all child sites. To apply a policy to a child site that has been exempted, remove it from `skip_child_site_ids` or set it to an empty array (`[]`).
    #   policy_type (required) - string - Type of policy.  Valid values: `settings`.
    #   name - string - Name for this policy.
    #   description - string - Description for this policy.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: value must be an String") if params[:value] and !params[:value].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: skip_child_site_ids must be an Array") if params[:skip_child_site_ids] and !params[:skip_child_site_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: policy_type must be an String") if params[:policy_type] and !params[:policy_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise MissingParameterError.new("Parameter missing: policy_type") unless params[:policy_type]

      response, options = Api.send_request("/child_site_management_policies", :post, params, options)
      ChildSiteManagementPolicy.new(response.data, options)
    end

    # Parameters:
    #   value - string
    #   skip_child_site_ids - array(int64) - IDs of child sites that this policy has been exempted from. If `skip_child_site_ids` is empty, the policy will be applied to all child sites. To apply a policy to a child site that has been exempted, remove it from `skip_child_site_ids` or set it to an empty array (`[]`).
    #   policy_type - string - Type of policy.  Valid values: `settings`.
    #   name - string - Name for this policy.
    #   description - string - Description for this policy.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be one of String, Integer, Hash") if params[:id] and [ String, Integer, Hash ].none? { |klass| params[:id].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: value must be an String") if params[:value] and !params[:value].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: skip_child_site_ids must be an Array") if params[:skip_child_site_ids] and !params[:skip_child_site_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: policy_type must be an String") if params[:policy_type] and !params[:policy_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be one of String, Integer, Hash") if params[:description] and [ String, Integer, Hash ].none? { |klass| params[:description].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/child_site_management_policies/#{params[:id]}", :patch, params, options)
      ChildSiteManagementPolicy.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/child_site_management_policies/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
