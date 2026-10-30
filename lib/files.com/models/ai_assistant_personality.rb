# frozen_string_literal: true

module Files
  # Files::AiAssistantPersonality is the Ruby SDK's representation of Files.com API AiAssistantPersonality objects.
  # Each instance keeps its API field values in +attributes+.
  class AiAssistantPersonality
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

    # AI Assistant Personality ID.
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

    # Workspace ID. `0` means the default workspace.
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

    # AI Assistant Personality name.
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

    # System prompt injected into the in-app AI Assistant.
    # @return [String, nil] the field value, or nil when absent.
    def system_prompt
      @attributes[:system_prompt]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def system_prompt=(value)
      @attributes[:system_prompt] = value
    end

    # Whether this personality is the default personality for the Workspace.
    # @return [Boolean, nil] the field value, or nil when absent.
    def use_by_default
      @attributes[:use_by_default]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def use_by_default=(value)
      @attributes[:use_by_default] = value
    end

    # If true, this default-workspace personality can apply to users in all workspaces.
    # @return [Boolean, nil] the field value, or nil when absent.
    def apply_to_all_workspaces
      @attributes[:apply_to_all_workspaces]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def apply_to_all_workspaces=(value)
      @attributes[:apply_to_all_workspaces] = value
    end

    # Creation time.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Last update time.
    # @return [String, nil] the field value, or nil when absent.
    def updated_at
      @attributes[:updated_at]
    end

    # Update Ai Assistant Personality
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] apply_to_all_workspaces If true, this default-workspace personality can apply to users in all workspaces.
    # @option params [String] name AI Assistant Personality name.
    # @option params [String] system_prompt System prompt injected into the in-app AI Assistant.
    # @option params [Boolean] use_by_default Whether this personality is the default personality for the Workspace.
    # @option params [Integer] workspace_id Workspace ID. `0` means the default workspace.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: apply_to_all_workspaces must be a single value, not #{params[:apply_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:apply_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: system_prompt must be an String") if !params[:system_prompt].nil? and !params[:system_prompt].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_by_default must be a single value, not #{params[:use_by_default].class}") if [ Array, Hash ].any? { |klass| params[:use_by_default].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/ai_assistant_personalities/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("AiAssistantPersonality") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Ai Assistant Personality
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

      response, options = Api.send_request("/ai_assistant_personalities/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = AiAssistantPersonality.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Ai Assistant Personalities
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `id`.
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
      List.new(AiAssistantPersonality, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/ai_assistant_personalities", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Ai Assistant Personality
    #
    # @param id [Integer] Ai Assistant Personality ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AiAssistantPersonality] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/ai_assistant_personalities/#{params[:id]}", :get, params, options) { |reply| reply.require_object("AiAssistantPersonality") }
      AiAssistantPersonality.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Ai Assistant Personality
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] apply_to_all_workspaces If true, this default-workspace personality can apply to users in all workspaces.
    # @option params [String] name Required. AI Assistant Personality name.
    # @option params [String] system_prompt Required. System prompt injected into the in-app AI Assistant.
    # @option params [Boolean] use_by_default Whether this personality is the default personality for the Workspace.
    # @option params [Integer] workspace_id Workspace ID. `0` means the default workspace.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AiAssistantPersonality] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: apply_to_all_workspaces must be a single value, not #{params[:apply_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:apply_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: system_prompt must be an String") if !params[:system_prompt].nil? and !params[:system_prompt].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_by_default must be a single value, not #{params[:use_by_default].class}") if [ Array, Hash ].any? { |klass| params[:use_by_default].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?
      raise MissingParameterError.new("Parameter missing: system_prompt") if params[:system_prompt].nil?

      response, options = Api.send_request("/ai_assistant_personalities", :post, params, options) { |reply| reply.require_object("AiAssistantPersonality") }
      AiAssistantPersonality.new(response.data, options)
    end

    # Update Ai Assistant Personality
    #
    # @param id [Integer] Ai Assistant Personality ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] apply_to_all_workspaces If true, this default-workspace personality can apply to users in all workspaces.
    # @option params [String] name AI Assistant Personality name.
    # @option params [String] system_prompt System prompt injected into the in-app AI Assistant.
    # @option params [Boolean] use_by_default Whether this personality is the default personality for the Workspace.
    # @option params [Integer] workspace_id Workspace ID. `0` means the default workspace.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AiAssistantPersonality] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: apply_to_all_workspaces must be a single value, not #{params[:apply_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:apply_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: system_prompt must be an String") if !params[:system_prompt].nil? and !params[:system_prompt].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_by_default must be a single value, not #{params[:use_by_default].class}") if [ Array, Hash ].any? { |klass| params[:use_by_default].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/ai_assistant_personalities/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("AiAssistantPersonality") }
      AiAssistantPersonality.new(response.data, options)
    end

    # Delete Ai Assistant Personality
    #
    # @param id [Integer] Ai Assistant Personality ID.
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

      Api.send_request("/ai_assistant_personalities/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
