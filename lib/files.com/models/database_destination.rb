# frozen_string_literal: true

module Files
  # Files::DatabaseDestination is the Ruby SDK's representation of Files.com API DatabaseDestination objects.
  # Each instance keeps its API field values in +attributes+.
  class DatabaseDestination
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

    # Database Destination ID.
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

    # Workspace ID. 0 means the default workspace.
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

    # Name of the destination.
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

    # Database provider.
    # @return [String, nil] the field value, or nil when absent.
    def provider
      @attributes[:provider]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def provider=(value)
      @attributes[:provider] = value
    end

    # Provider settings for the destination. Use the schema matching provider. The connection address and table are fixed after creation.
    # @return [Hash, nil] the field value, or nil when absent.
    def config
      @attributes[:config]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def config=(value)
      @attributes[:config] = value
    end

    # ID of a Secret in the same Workspace. Use a Token Secret for Snowflake, a service account Key/Value Secret for BigQuery, or a Username/Password Secret for a database login.
    # @return [Integer, nil] the field value, or nil when absent.
    def secret_id
      @attributes[:secret_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def secret_id=(value)
      @attributes[:secret_id] = value
    end

    # When the destination was created.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # When the destination was last updated.
    # @return [String, nil] the field value, or nil when absent.
    def updated_at
      @attributes[:updated_at]
    end

    # Update Database Destination
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Name of the destination.
    # @option params [Integer] secret_id ID of a Secret in the same Workspace. Use a Token Secret for Snowflake, a service account Key/Value Secret for BigQuery, or a Username/Password Secret for a database login.
    # @option params [Hash] config Provider settings for the destination. Use the schema matching provider. The connection address and table are fixed after creation.
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
      raise InvalidParameterError.new("Bad parameter: secret_id must be an Integer") if !params[:secret_id].nil? and !params[:secret_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: config must be an Hash") if !params[:config].nil? and !params[:config].is_a?(Hash)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/database_destinations/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("DatabaseDestination") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Database Destination
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

      response, options = Api.send_request("/database_destinations/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = DatabaseDestination.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Database Destinations
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `name`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id` and `name`. Valid field combinations are `[ workspace_id, name ]`.
    # @option params [Hash] filter_prefix If set, return records where the specified field is prefixed by the supplied value. Valid fields are `name`.
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
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if !params[:filter_prefix].nil? and !params[:filter_prefix].is_a?(Hash)

      list_options = options.dup
      List.new(DatabaseDestination, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/database_destinations", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Database Destination
    #
    # @param id [Integer] Database Destination ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::DatabaseDestination] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/database_destinations/#{params[:id]}", :get, params, options) { |reply| reply.require_object("DatabaseDestination") }
      DatabaseDestination.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Database Destination
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Required. Name of the destination.
    # @option params [String] provider Required. Database provider.
    # @option params [Hash] config Required. Provider settings for the destination. Use the schema matching provider. The connection address and table are fixed after creation.
    # @option params [Integer] secret_id Required. ID of a Secret in the same Workspace. Use a Token Secret for Snowflake, a service account Key/Value Secret for BigQuery, or a Username/Password Secret for a database login.
    # @option params [Integer] workspace_id Workspace ID. 0 means the default workspace.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::DatabaseDestination] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provider must be an String") if !params[:provider].nil? and !params[:provider].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: config must be an Hash") if !params[:config].nil? and !params[:config].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: secret_id must be an Integer") if !params[:secret_id].nil? and !params[:secret_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?
      raise MissingParameterError.new("Parameter missing: provider") if params[:provider].nil?
      raise MissingParameterError.new("Parameter missing: config") if params[:config].nil?
      raise MissingParameterError.new("Parameter missing: secret_id") if params[:secret_id].nil?

      response, options = Api.send_request("/database_destinations", :post, params, options) { |reply| reply.require_object("DatabaseDestination") }
      DatabaseDestination.new(response.data, options)
    end

    # Update Database Destination
    #
    # @param id [Integer] Database Destination ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Name of the destination.
    # @option params [Integer] secret_id ID of a Secret in the same Workspace. Use a Token Secret for Snowflake, a service account Key/Value Secret for BigQuery, or a Username/Password Secret for a database login.
    # @option params [Hash] config Provider settings for the destination. Use the schema matching provider. The connection address and table are fixed after creation.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::DatabaseDestination] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: secret_id must be an Integer") if !params[:secret_id].nil? and !params[:secret_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: config must be an Hash") if !params[:config].nil? and !params[:config].is_a?(Hash)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/database_destinations/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("DatabaseDestination") }
      DatabaseDestination.new(response.data, options)
    end

    # Delete Database Destination
    #
    # @param id [Integer] Database Destination ID.
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

      Api.send_request("/database_destinations/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
