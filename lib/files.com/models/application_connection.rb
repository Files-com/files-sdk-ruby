# frozen_string_literal: true

module Files
  # Files::ApplicationConnection is the Ruby SDK's representation of Files.com API ApplicationConnection objects.
  # Each instance keeps its API field values in +attributes+.
  class ApplicationConnection
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

    # Connection ID.
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

    # Workspace that owns this connection.
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

    # Connection display name.
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

    # Application key from the Automation applications list.
    # @return [String, nil] the field value, or nil when absent.
    def application_key
      @attributes[:application_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def application_key=(value)
      @attributes[:application_key] = value
    end

    # HTTPS origin for this connection.
    # @return [String, nil] the field value, or nil when absent.
    def origin
      @attributes[:origin]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def origin=(value)
      @attributes[:origin] = value
    end

    # ID of the credential in the Secret Store, if the connection uses a credential.
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

    # Current credential type and placement, without the secret value.
    # @return [Hash, nil] the field value, or nil when absent.
    def authentication
      @attributes[:authentication]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def authentication=(value)
      @attributes[:authentication] = value
    end

    # Time the connection was created.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Time the connection was updated.
    # @return [String, nil] the field value, or nil when absent.
    def updated_at
      @attributes[:updated_at]
    end

    # Update Application Connection
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Connection display name.
    # @option params [Integer] secret_id ID of the credential in the Secret Store, if the connection uses a credential.
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
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/application_connections/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("ApplicationConnection") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Application Connection
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

      response, options = Api.send_request("/application_connections/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = ApplicationConnection.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Application Connections
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `name` or `application_key`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id` and `application_key`. Valid field combinations are `[ workspace_id, application_key ]`.
    # @option params [Hash] filter_prefix If set, return records where the specified field is prefixed by the supplied value. Valid fields are `application_key`.
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
      List.new(ApplicationConnection, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/application_connections", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Application Connection
    #
    # @param id [Integer] Application Connection ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ApplicationConnection] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/application_connections/#{params[:id]}", :get, params, options) { |reply| reply.require_object("ApplicationConnection") }
      ApplicationConnection.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Application Connection
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Required. Connection display name.
    # @option params [Integer] secret_id ID of the credential in the Secret Store, if the connection uses a credential.
    # @option params [String] application_key Required. Application key from the Automation applications list.
    # @option params [String] origin Required. HTTPS origin for this connection.
    # @option params [Integer] workspace_id Workspace that owns this connection.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ApplicationConnection] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: secret_id must be an Integer") if !params[:secret_id].nil? and !params[:secret_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: application_key must be an String") if !params[:application_key].nil? and !params[:application_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: origin must be an String") if !params[:origin].nil? and !params[:origin].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?
      raise MissingParameterError.new("Parameter missing: application_key") if params[:application_key].nil?
      raise MissingParameterError.new("Parameter missing: origin") if params[:origin].nil?

      response, options = Api.send_request("/application_connections", :post, params, options) { |reply| reply.require_object("ApplicationConnection") }
      ApplicationConnection.new(response.data, options)
    end

    # Update Application Connection
    #
    # @param id [Integer] Application Connection ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Connection display name.
    # @option params [Integer] secret_id ID of the credential in the Secret Store, if the connection uses a credential.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ApplicationConnection] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: secret_id must be an Integer") if !params[:secret_id].nil? and !params[:secret_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/application_connections/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("ApplicationConnection") }
      ApplicationConnection.new(response.data, options)
    end

    # Delete Application Connection
    #
    # @param id [Integer] Application Connection ID.
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

      Api.send_request("/application_connections/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
