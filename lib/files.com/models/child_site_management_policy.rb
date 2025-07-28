# frozen_string_literal: true

module Files
  class ChildSiteManagementPolicy
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - ChildSiteManagementPolicy ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - ID of the Site managing the policy
    def site_id
      @attributes[:site_id]
    end

    def site_id=(value)
      @attributes[:site_id] = value
    end

    # string - The name of the setting that is managed by the policy
    def site_setting_name
      @attributes[:site_setting_name]
    end

    def site_setting_name=(value)
      @attributes[:site_setting_name] = value
    end

    # string - The value for the setting that will be enforced for all child sites that are not exempt
    def managed_value
      @attributes[:managed_value]
    end

    def managed_value=(value)
      @attributes[:managed_value] = value
    end

    # array(int64) - The list of child site IDs that are exempt from this policy
    def skip_child_site_ids
      @attributes[:skip_child_site_ids]
    end

    def skip_child_site_ids=(value)
      @attributes[:skip_child_site_ids] = value
    end

    # Parameters:
    #   site_setting_name (required) - string - The name of the setting that is managed by the policy
    #   managed_value (required) - string - The value for the setting that will be enforced for all child sites that are not exempt
    #   skip_child_site_ids - array(int64) - The list of child site IDs that are exempt from this policy
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: site_setting_name must be an String") if params[:site_setting_name] and !params[:site_setting_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: managed_value must be an String") if params[:managed_value] and !params[:managed_value].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: skip_child_site_ids must be an Array") if params[:skip_child_site_ids] and !params[:skip_child_site_ids].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: site_setting_name") unless params[:site_setting_name]
      raise MissingParameterError.new("Parameter missing: managed_value") unless params[:managed_value]

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
    #   site_setting_name (required) - string - The name of the setting that is managed by the policy
    #   managed_value (required) - string - The value for the setting that will be enforced for all child sites that are not exempt
    #   skip_child_site_ids - array(int64) - The list of child site IDs that are exempt from this policy
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: site_setting_name must be an String") if params[:site_setting_name] and !params[:site_setting_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: managed_value must be an String") if params[:managed_value] and !params[:managed_value].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: skip_child_site_ids must be an Array") if params[:skip_child_site_ids] and !params[:skip_child_site_ids].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: site_setting_name") unless params[:site_setting_name]
      raise MissingParameterError.new("Parameter missing: managed_value") unless params[:managed_value]

      response, options = Api.send_request("/child_site_management_policies", :post, params, options)
      ChildSiteManagementPolicy.new(response.data, options)
    end

    # Parameters:
    #   site_setting_name (required) - string - The name of the setting that is managed by the policy
    #   managed_value (required) - string - The value for the setting that will be enforced for all child sites that are not exempt
    #   skip_child_site_ids - array(int64) - The list of child site IDs that are exempt from this policy
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: site_setting_name must be an String") if params[:site_setting_name] and !params[:site_setting_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: managed_value must be an String") if params[:managed_value] and !params[:managed_value].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: skip_child_site_ids must be an Array") if params[:skip_child_site_ids] and !params[:skip_child_site_ids].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: site_setting_name") unless params[:site_setting_name]
      raise MissingParameterError.new("Parameter missing: managed_value") unless params[:managed_value]

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
