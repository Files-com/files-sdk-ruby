# frozen_string_literal: true

module Files
  # Files::BundleNotification is the Ruby SDK's representation of Files.com API BundleNotification objects.
  # Each instance keeps its API field values in +attributes+.
  class BundleNotification
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

    # Bundle ID to notify on
    # @return [Integer, nil] the field value, or nil when absent.
    def bundle_id
      @attributes[:bundle_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def bundle_id=(value)
      @attributes[:bundle_id] = value
    end

    # Bundle Notification ID
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

    # Triggers bundle notification when a registration action occurs for it.
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_registration
      @attributes[:notify_on_registration]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_registration=(value)
      @attributes[:notify_on_registration] = value
    end

    # Triggers bundle notification when a upload action occurs for it.
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_upload
      @attributes[:notify_on_upload]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_upload=(value)
      @attributes[:notify_on_upload] = value
    end

    # Is the current user the user to notify?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_current_user
      @attributes[:notify_current_user]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_current_user=(value)
      @attributes[:notify_current_user] = value
    end

    # The id of the user to notify.
    # @return [Integer, nil] the field value, or nil when absent.
    def notify_user_id
      @attributes[:notify_user_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def notify_user_id=(value)
      @attributes[:notify_user_id] = value
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

    # User ID.  Provide a value of `0` to operate the current session's user.
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def user_id=(value)
      @attributes[:user_id] = value
    end

    # Update Share Link Notification
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] notify_on_registration Triggers bundle notification when a registration action occurs for it.
    # @option params [Boolean] notify_on_upload Triggers bundle notification when a upload action occurs for it.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notify_on_registration must be a single value, not #{params[:notify_on_registration].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_registration].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_upload must be a single value, not #{params[:notify_on_upload].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_upload].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/bundle_notifications/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("BundleNotification") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Share Link Notification
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

      response, options = Api.send_request("/bundle_notifications/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = BundleNotification.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Share Link Notifications
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `bundle_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `bundle_id`.
    # @option params [Integer] bundle_id Bundle ID
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: bundle_id must be an Integer") if !params[:bundle_id].nil? and !params[:bundle_id].is_a?(Integer)

      list_options = options.dup
      List.new(BundleNotification, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/bundle_notifications", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Share Link Notification
    #
    # @param id [Integer] Bundle Notification ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::BundleNotification] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/bundle_notifications/#{params[:id]}", :get, params, options) { |reply| reply.require_object("BundleNotification") }
      BundleNotification.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Share Link Notification
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [Integer] bundle_id Required. Bundle ID to notify on
    # @option params [Integer] notify_user_id The id of the user to notify.
    # @option params [Boolean] notify_on_registration Triggers bundle notification when a registration action occurs for it.
    # @option params [Boolean] notify_on_upload Triggers bundle notification when a upload action occurs for it.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::BundleNotification] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: bundle_id must be an Integer") if !params[:bundle_id].nil? and !params[:bundle_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notify_user_id must be an Integer") if !params[:notify_user_id].nil? and !params[:notify_user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notify_on_registration must be a single value, not #{params[:notify_on_registration].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_registration].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_upload must be a single value, not #{params[:notify_on_upload].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_upload].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: bundle_id") if params[:bundle_id].nil?

      response, options = Api.send_request("/bundle_notifications", :post, params, options) { |reply| reply.require_object("BundleNotification") }
      BundleNotification.new(response.data, options)
    end

    # Update Share Link Notification
    #
    # @param id [Integer] Bundle Notification ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] notify_on_registration Triggers bundle notification when a registration action occurs for it.
    # @option params [Boolean] notify_on_upload Triggers bundle notification when a upload action occurs for it.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::BundleNotification] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notify_on_registration must be a single value, not #{params[:notify_on_registration].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_registration].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_upload must be a single value, not #{params[:notify_on_upload].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_upload].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/bundle_notifications/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("BundleNotification") }
      BundleNotification.new(response.data, options)
    end

    # Delete Share Link Notification
    #
    # @param id [Integer] Bundle Notification ID.
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

      Api.send_request("/bundle_notifications/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
