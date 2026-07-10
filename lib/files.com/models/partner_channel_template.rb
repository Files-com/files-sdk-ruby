# frozen_string_literal: true

module Files
  class PartnerChannelTemplate
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - The unique ID of the Partner Channel Template.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - ID of the Workspace associated with this Partner Channel Template.
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # string - The name of the Partner Channel Template.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Channel path relative to the Partner root folder. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # string - Optional Channel-level to-Partner folder name override.
    def to_partner_folder_name
      @attributes[:to_partner_folder_name]
    end

    def to_partner_folder_name=(value)
      @attributes[:to_partner_folder_name] = value
    end

    # string - Optional Channel-level from-Partner folder name override.
    def from_partner_folder_name
      @attributes[:from_partner_folder_name]
    end

    def from_partner_folder_name=(value)
      @attributes[:from_partner_folder_name] = value
    end

    # string - Optional route path pattern for files uploaded by the Partner. Supports {{partner_name}}.
    def from_partner_route_path_pattern
      @attributes[:from_partner_route_path_pattern]
    end

    def from_partner_route_path_pattern=(value)
      @attributes[:from_partner_route_path_pattern] = value
    end

    # string - Optional route path pattern for files delivered to the Partner. Supports {{partner_name}}.
    def to_partner_route_path_pattern
      @attributes[:to_partner_route_path_pattern]
    end

    def to_partner_route_path_pattern=(value)
      @attributes[:to_partner_route_path_pattern] = value
    end

    # array(string) - Managed folder paths inside the to-Partner folder.
    def to_partner_managed_folder_paths
      @attributes[:to_partner_managed_folder_paths]
    end

    def to_partner_managed_folder_paths=(value)
      @attributes[:to_partner_managed_folder_paths] = value
    end

    # array(string) - Managed folder paths inside the from-Partner folder.
    def from_partner_managed_folder_paths
      @attributes[:from_partner_managed_folder_paths]
    end

    def from_partner_managed_folder_paths=(value)
      @attributes[:from_partner_managed_folder_paths] = value
    end

    # string - Resolved to-Partner folder name after Template override and default.
    def effective_to_partner_folder_name
      @attributes[:effective_to_partner_folder_name]
    end

    def effective_to_partner_folder_name=(value)
      @attributes[:effective_to_partner_folder_name] = value
    end

    # string - Resolved from-Partner folder name after Template override and default.
    def effective_from_partner_folder_name
      @attributes[:effective_from_partner_folder_name]
    end

    def effective_from_partner_folder_name=(value)
      @attributes[:effective_from_partner_folder_name] = value
    end

    # Parameters:
    #   from_partner_folder_name - string - Optional Channel-level from-Partner folder name override.
    #   from_partner_managed_folder_paths - array(string) - Managed folder paths inside the from-Partner folder.
    #   from_partner_route_path_pattern - string - Optional route path pattern for files uploaded by the Partner. Supports {{partner_name}}.
    #   to_partner_folder_name - string - Optional Channel-level to-Partner folder name override.
    #   to_partner_managed_folder_paths - array(string) - Managed folder paths inside the to-Partner folder.
    #   to_partner_route_path_pattern - string - Optional route path pattern for files delivered to the Partner. Supports {{partner_name}}.
    #   name - string - The name of the Partner Channel Template.
    #   path - string - Channel path relative to the Partner root folder.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: from_partner_folder_name must be an String") if params[:from_partner_folder_name] and !params[:from_partner_folder_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: from_partner_managed_folder_paths must be an Array") if params[:from_partner_managed_folder_paths] and !params[:from_partner_managed_folder_paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: from_partner_route_path_pattern must be an String") if params[:from_partner_route_path_pattern] and !params[:from_partner_route_path_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: to_partner_folder_name must be an String") if params[:to_partner_folder_name] and !params[:to_partner_folder_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: to_partner_managed_folder_paths must be an Array") if params[:to_partner_managed_folder_paths] and !params[:to_partner_managed_folder_paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: to_partner_route_path_pattern must be an String") if params[:to_partner_route_path_pattern] and !params[:to_partner_route_path_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partner_channel_templates/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partner_channel_templates/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = PartnerChannelTemplate.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `name`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(PartnerChannelTemplate, params) do
        Api.send_request("/partner_channel_templates", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Partner Channel Template ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/partner_channel_templates/#{params[:id]}", :get, params, options)
      PartnerChannelTemplate.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   from_partner_folder_name - string - Optional Channel-level from-Partner folder name override.
    #   from_partner_managed_folder_paths - array(string) - Managed folder paths inside the from-Partner folder.
    #   from_partner_route_path_pattern - string - Optional route path pattern for files uploaded by the Partner. Supports {{partner_name}}.
    #   to_partner_folder_name - string - Optional Channel-level to-Partner folder name override.
    #   to_partner_managed_folder_paths - array(string) - Managed folder paths inside the to-Partner folder.
    #   to_partner_route_path_pattern - string - Optional route path pattern for files delivered to the Partner. Supports {{partner_name}}.
    #   name (required) - string - The name of the Partner Channel Template.
    #   path (required) - string - Channel path relative to the Partner root folder.
    #   workspace_id - int64 - ID of the Workspace associated with this Partner Channel Template.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: from_partner_folder_name must be an String") if params[:from_partner_folder_name] and !params[:from_partner_folder_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: from_partner_managed_folder_paths must be an Array") if params[:from_partner_managed_folder_paths] and !params[:from_partner_managed_folder_paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: from_partner_route_path_pattern must be an String") if params[:from_partner_route_path_pattern] and !params[:from_partner_route_path_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: to_partner_folder_name must be an String") if params[:to_partner_folder_name] and !params[:to_partner_folder_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: to_partner_managed_folder_paths must be an Array") if params[:to_partner_managed_folder_paths] and !params[:to_partner_managed_folder_paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: to_partner_route_path_pattern must be an String") if params[:to_partner_route_path_pattern] and !params[:to_partner_route_path_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      response, options = Api.send_request("/partner_channel_templates", :post, params, options)
      PartnerChannelTemplate.new(response.data, options)
    end

    # Parameters:
    #   from_partner_folder_name - string - Optional Channel-level from-Partner folder name override.
    #   from_partner_managed_folder_paths - array(string) - Managed folder paths inside the from-Partner folder.
    #   from_partner_route_path_pattern - string - Optional route path pattern for files uploaded by the Partner. Supports {{partner_name}}.
    #   to_partner_folder_name - string - Optional Channel-level to-Partner folder name override.
    #   to_partner_managed_folder_paths - array(string) - Managed folder paths inside the to-Partner folder.
    #   to_partner_route_path_pattern - string - Optional route path pattern for files delivered to the Partner. Supports {{partner_name}}.
    #   name - string - The name of the Partner Channel Template.
    #   path - string - Channel path relative to the Partner root folder.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: from_partner_folder_name must be an String") if params[:from_partner_folder_name] and !params[:from_partner_folder_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: from_partner_managed_folder_paths must be an Array") if params[:from_partner_managed_folder_paths] and !params[:from_partner_managed_folder_paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: from_partner_route_path_pattern must be an String") if params[:from_partner_route_path_pattern] and !params[:from_partner_route_path_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: to_partner_folder_name must be an String") if params[:to_partner_folder_name] and !params[:to_partner_folder_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: to_partner_managed_folder_paths must be an Array") if params[:to_partner_managed_folder_paths] and !params[:to_partner_managed_folder_paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: to_partner_route_path_pattern must be an String") if params[:to_partner_route_path_pattern] and !params[:to_partner_route_path_pattern].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/partner_channel_templates/#{params[:id]}", :patch, params, options)
      PartnerChannelTemplate.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/partner_channel_templates/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
