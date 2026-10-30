# frozen_string_literal: true

module Files
  # Files::IntegrationCentricProfile is the Ruby SDK's representation of Files.com API IntegrationCentricProfile objects.
  # Each instance keeps its API field values in +attributes+.
  class IntegrationCentricProfile
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

    # Integration Centric Profile ID
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

    # Profile name
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

    # Workspace ID
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

    # Whether this profile applies to all users in the Workspace by default
    # @return [Boolean, nil] the field value, or nil when absent.
    def use_for_all_users
      @attributes[:use_for_all_users]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def use_for_all_users=(value)
      @attributes[:use_for_all_users] = value
    end

    # Remote Server integrations the user is expected to add and connect. Each entry requires `server_type` and may include a display `name`.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def expected_remote_servers
      @attributes[:expected_remote_servers]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Hash>, nil] the new field value.
    # @return [Array<Hash>, nil] the assigned value.
    def expected_remote_servers=(value)
      @attributes[:expected_remote_servers] = value
    end

    # Update Integration Centric Profile
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Profile name
    # @option params [Integer] workspace_id Workspace ID
    # @option params [Array<Hash>] expected_remote_servers Remote Server integrations the user is expected to add and connect. Each entry requires `server_type` and may include a display `name`.
    # @option params [Boolean] use_for_all_users Whether this profile applies to all users in the Workspace by default
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: expected_remote_servers must be an Array") if !params[:expected_remote_servers].nil? and !params[:expected_remote_servers].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: use_for_all_users must be a single value, not #{params[:use_for_all_users].class}") if [ Array, Hash ].any? { |klass| params[:use_for_all_users].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/integration_centric_profiles/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("IntegrationCentricProfile") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Integration Centric Profile
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

      response, options = Api.send_request("/integration_centric_profiles/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = IntegrationCentricProfile.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Integration Centric Profiles
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `name`.
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
      List.new(IntegrationCentricProfile, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/integration_centric_profiles", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Integration Centric Profile
    #
    # @param id [Integer] Integration Centric Profile ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::IntegrationCentricProfile] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/integration_centric_profiles/#{params[:id]}", :get, params, options) { |reply| reply.require_object("IntegrationCentricProfile") }
      IntegrationCentricProfile.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Integration Centric Profile
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Required. Profile name
    # @option params [Array<Hash>] expected_remote_servers Required. Remote Server integrations the user is expected to add and connect. Each entry requires `server_type` and may include a display `name`.
    # @option params [Integer] workspace_id Workspace ID
    # @option params [Boolean] use_for_all_users Whether this profile applies to all users in the Workspace by default
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::IntegrationCentricProfile] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expected_remote_servers must be an Array") if !params[:expected_remote_servers].nil? and !params[:expected_remote_servers].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: use_for_all_users must be a single value, not #{params[:use_for_all_users].class}") if [ Array, Hash ].any? { |klass| params[:use_for_all_users].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?
      raise MissingParameterError.new("Parameter missing: expected_remote_servers") if params[:expected_remote_servers].nil?

      response, options = Api.send_request("/integration_centric_profiles", :post, params, options) { |reply| reply.require_object("IntegrationCentricProfile") }
      IntegrationCentricProfile.new(response.data, options)
    end

    # Update Integration Centric Profile
    #
    # @param id [Integer] Integration Centric Profile ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Profile name
    # @option params [Integer] workspace_id Workspace ID
    # @option params [Array<Hash>] expected_remote_servers Remote Server integrations the user is expected to add and connect. Each entry requires `server_type` and may include a display `name`.
    # @option params [Boolean] use_for_all_users Whether this profile applies to all users in the Workspace by default
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::IntegrationCentricProfile] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: expected_remote_servers must be an Array") if !params[:expected_remote_servers].nil? and !params[:expected_remote_servers].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: use_for_all_users must be a single value, not #{params[:use_for_all_users].class}") if [ Array, Hash ].any? { |klass| params[:use_for_all_users].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/integration_centric_profiles/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("IntegrationCentricProfile") }
      IntegrationCentricProfile.new(response.data, options)
    end

    # Delete Integration Centric Profile
    #
    # @param id [Integer] Integration Centric Profile ID.
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

      Api.send_request("/integration_centric_profiles/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
