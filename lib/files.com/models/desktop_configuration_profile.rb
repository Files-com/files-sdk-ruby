# frozen_string_literal: true

module Files
  class DesktopConfigurationProfile
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Desktop Configuration Profile ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Profile name
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # int64 - Workspace ID
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # boolean - Whether this profile applies to all users in the Workspace by default
    def use_for_all_users
      @attributes[:use_for_all_users]
    end

    def use_for_all_users=(value)
      @attributes[:use_for_all_users] = value
    end

    # object - Mount point mappings for the desktop app. Keys are mount points (e.g. drive letters) and values are paths in Files.com that the mount points map to.
    def mount_mappings
      @attributes[:mount_mappings]
    end

    def mount_mappings=(value)
      @attributes[:mount_mappings] = value
    end

    # Parameters:
    #   name - string - Profile name
    #   workspace_id - int64 - Workspace ID
    #   mount_mappings - object - Mount point mappings for the desktop app. Keys are mount points (e.g. drive letters) and values are paths in Files.com that the mount points map to.
    #   use_for_all_users - boolean - Whether this profile applies to all users in the Workspace by default
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/desktop_configuration_profiles/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/desktop_configuration_profiles/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = DesktopConfigurationProfile.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `name`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(DesktopConfigurationProfile, params) do
        Api.send_request("/desktop_configuration_profiles", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Desktop Configuration Profile ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/desktop_configuration_profiles/#{params[:id]}", :get, params, options)
      DesktopConfigurationProfile.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name (required) - string - Profile name
    #   mount_mappings (required) - object - Mount point mappings for the desktop app. Keys are mount points (e.g. drive letters) and values are paths in Files.com that the mount points map to.
    #   workspace_id - int64 - Workspace ID
    #   use_for_all_users - boolean - Whether this profile applies to all users in the Workspace by default
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: mount_mappings must be an Hash") if params[:mount_mappings] and !params[:mount_mappings].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]
      raise MissingParameterError.new("Parameter missing: mount_mappings") unless params[:mount_mappings]

      response, options = Api.send_request("/desktop_configuration_profiles", :post, params, options)
      DesktopConfigurationProfile.new(response.data, options)
    end

    # Parameters:
    #   name - string - Profile name
    #   workspace_id - int64 - Workspace ID
    #   mount_mappings - object - Mount point mappings for the desktop app. Keys are mount points (e.g. drive letters) and values are paths in Files.com that the mount points map to.
    #   use_for_all_users - boolean - Whether this profile applies to all users in the Workspace by default
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: mount_mappings must be an Hash") if params[:mount_mappings] and !params[:mount_mappings].is_a?(Hash)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/desktop_configuration_profiles/#{params[:id]}", :patch, params, options)
      DesktopConfigurationProfile.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/desktop_configuration_profiles/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
