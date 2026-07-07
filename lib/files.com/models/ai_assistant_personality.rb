# frozen_string_literal: true

module Files
  class AiAssistantPersonality
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - AI Assistant Personality ID.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Workspace ID. `0` means the default workspace.
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # string - AI Assistant Personality name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - System prompt injected into the in-app AI Assistant.
    def system_prompt
      @attributes[:system_prompt]
    end

    def system_prompt=(value)
      @attributes[:system_prompt] = value
    end

    # boolean - Whether this personality is the default personality for the Workspace.
    def use_by_default
      @attributes[:use_by_default]
    end

    def use_by_default=(value)
      @attributes[:use_by_default] = value
    end

    # boolean - If true, this default-workspace personality can apply to users in all workspaces.
    def apply_to_all_workspaces
      @attributes[:apply_to_all_workspaces]
    end

    def apply_to_all_workspaces=(value)
      @attributes[:apply_to_all_workspaces] = value
    end

    # date-time - Creation time.
    def created_at
      @attributes[:created_at]
    end

    # date-time - Last update time.
    def updated_at
      @attributes[:updated_at]
    end

    # Parameters:
    #   apply_to_all_workspaces - boolean - If true, this default-workspace personality can apply to users in all workspaces.
    #   name - string - AI Assistant Personality name.
    #   system_prompt - string - System prompt injected into the in-app AI Assistant.
    #   use_by_default - boolean - Whether this personality is the default personality for the Workspace.
    #   workspace_id - int64 - Workspace ID. `0` means the default workspace.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: system_prompt must be an String") if params[:system_prompt] and !params[:system_prompt].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/ai_assistant_personalities/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/ai_assistant_personalities/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = AiAssistantPersonality.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(AiAssistantPersonality, params) do
        Api.send_request("/ai_assistant_personalities", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Ai Assistant Personality ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/ai_assistant_personalities/#{params[:id]}", :get, params, options)
      AiAssistantPersonality.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   apply_to_all_workspaces - boolean - If true, this default-workspace personality can apply to users in all workspaces.
    #   name (required) - string - AI Assistant Personality name.
    #   system_prompt (required) - string - System prompt injected into the in-app AI Assistant.
    #   use_by_default - boolean - Whether this personality is the default personality for the Workspace.
    #   workspace_id - int64 - Workspace ID. `0` means the default workspace.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: system_prompt must be an String") if params[:system_prompt] and !params[:system_prompt].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]
      raise MissingParameterError.new("Parameter missing: system_prompt") unless params[:system_prompt]

      response, options = Api.send_request("/ai_assistant_personalities", :post, params, options)
      AiAssistantPersonality.new(response.data, options)
    end

    # Parameters:
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id`.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      response, options = Api.send_request("/ai_assistant_personalities/create_export", :post, params, options)
      Export.new(response.data, options)
    end

    # Parameters:
    #   apply_to_all_workspaces - boolean - If true, this default-workspace personality can apply to users in all workspaces.
    #   name - string - AI Assistant Personality name.
    #   system_prompt - string - System prompt injected into the in-app AI Assistant.
    #   use_by_default - boolean - Whether this personality is the default personality for the Workspace.
    #   workspace_id - int64 - Workspace ID. `0` means the default workspace.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: system_prompt must be an String") if params[:system_prompt] and !params[:system_prompt].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/ai_assistant_personalities/#{params[:id]}", :patch, params, options)
      AiAssistantPersonality.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/ai_assistant_personalities/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
