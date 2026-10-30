# frozen_string_literal: true

require "bigdecimal"

module Files
  # Files::RemoteMountBackend is the Ruby SDK's representation of Files.com API RemoteMountBackend objects.
  # Each instance keeps its API field values in +attributes+.
  class RemoteMountBackend
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

    # Path to the canary file used for health checks.
    # @return [String, nil] the field value, or nil when absent.
    def canary_file_path
      @attributes[:canary_file_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def canary_file_path=(value)
      @attributes[:canary_file_path] = value
    end

    # True if this backend is enabled.
    # @return [Boolean, nil] the field value, or nil when absent.
    def enabled
      @attributes[:enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def enabled=(value)
      @attributes[:enabled] = value
    end

    # Number of consecutive failures before considering the backend unhealthy.
    # @return [Integer, nil] the field value, or nil when absent.
    def fall
      @attributes[:fall]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def fall=(value)
      @attributes[:fall] = value
    end

    # True if health checks are enabled for this backend.
    # @return [Boolean, nil] the field value, or nil when absent.
    def health_check_enabled
      @attributes[:health_check_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def health_check_enabled=(value)
      @attributes[:health_check_enabled] = value
    end

    # Array of recent health check results.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def health_check_results
      @attributes[:health_check_results]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Hash>, nil] the new field value.
    # @return [Array<Hash>, nil] the assigned value.
    def health_check_results=(value)
      @attributes[:health_check_results] = value
    end

    # Type of health check to perform.
    # @return [String, nil] the field value, or nil when absent.
    def health_check_type
      @attributes[:health_check_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def health_check_type=(value)
      @attributes[:health_check_type] = value
    end

    # Unique identifier for this backend.
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

    # Interval in seconds between health checks.
    # @return [Integer, nil] the field value, or nil when absent.
    def interval
      @attributes[:interval]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def interval=(value)
      @attributes[:interval] = value
    end

    # Minimum free CPU percentage required for this backend to be considered healthy.
    # @return [BigDecimal, nil] the field value, or nil when absent.
    def min_free_cpu
      value = @attributes[:min_free_cpu]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [BigDecimal, nil] the new field value.
    # @return [BigDecimal, nil] the assigned value.
    def min_free_cpu=(value)
      @attributes[:min_free_cpu] = value
    end

    # Minimum free memory percentage required for this backend to be considered healthy.
    # @return [BigDecimal, nil] the field value, or nil when absent.
    def min_free_mem
      value = @attributes[:min_free_mem]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [BigDecimal, nil] the new field value.
    # @return [BigDecimal, nil] the assigned value.
    def min_free_mem=(value)
      @attributes[:min_free_mem] = value
    end

    # Priority of this backend.
    # @return [Integer, nil] the field value, or nil when absent.
    def priority
      @attributes[:priority]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def priority=(value)
      @attributes[:priority] = value
    end

    # Path on the remote server to treat as the root of this mount.
    # @return [String, nil] the field value, or nil when absent.
    def remote_path
      @attributes[:remote_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def remote_path=(value)
      @attributes[:remote_path] = value
    end

    # The remote server that this backend is associated with.
    # @return [Integer, nil] the field value, or nil when absent.
    def remote_server_id
      @attributes[:remote_server_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def remote_server_id=(value)
      @attributes[:remote_server_id] = value
    end

    # The mount ID of the Remote Server Mount that this backend is associated with.
    # @return [Integer, nil] the field value, or nil when absent.
    def remote_server_mount_id
      @attributes[:remote_server_mount_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def remote_server_mount_id=(value)
      @attributes[:remote_server_mount_id] = value
    end

    # Number of consecutive successes before considering the backend healthy.
    # @return [Integer, nil] the field value, or nil when absent.
    def rise
      @attributes[:rise]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def rise=(value)
      @attributes[:rise] = value
    end

    # Status of this backend.
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def status=(value)
      @attributes[:status] = value
    end

    # True if this backend is undergoing maintenance.
    # @return [Boolean, nil] the field value, or nil when absent.
    def undergoing_maintenance
      @attributes[:undergoing_maintenance]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def undergoing_maintenance=(value)
      @attributes[:undergoing_maintenance] = value
    end

    # Reset backend status to healthy
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def reset_status(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_mount_backends/#{@attributes[:id]}/reset_status", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Update Remote Mount Backend
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] enabled True if this backend is enabled.
    # @option params [Integer] fall Number of consecutive failures before considering the backend unhealthy.
    # @option params [Boolean] health_check_enabled True if health checks are enabled for this backend.
    # @option params [String] health_check_type Type of health check to perform.
    # @option params [Integer] interval Interval in seconds between health checks.
    # @option params [Float] min_free_cpu Minimum free CPU percentage required for this backend to be considered healthy.
    # @option params [Float] min_free_mem Minimum free memory percentage required for this backend to be considered healthy.
    # @option params [Integer] priority Priority of this backend.
    # @option params [String] remote_path Path on the remote server to treat as the root of this mount.
    # @option params [Integer] rise Number of consecutive successes before considering the backend healthy.
    # @option params [String] canary_file_path Path to the canary file used for health checks.
    # @option params [Integer] remote_server_id The remote server that this backend is associated with.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: enabled must be a single value, not #{params[:enabled].class}") if [ Array, Hash ].any? { |klass| params[:enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: fall must be an Integer") if !params[:fall].nil? and !params[:fall].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: health_check_enabled must be a single value, not #{params[:health_check_enabled].class}") if [ Array, Hash ].any? { |klass| params[:health_check_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: health_check_type must be an String") if !params[:health_check_type].nil? and !params[:health_check_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an Integer") if !params[:interval].nil? and !params[:interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: priority must be an Integer") if !params[:priority].nil? and !params[:priority].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: remote_path must be an String") if !params[:remote_path].nil? and !params[:remote_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rise must be an Integer") if !params[:rise].nil? and !params[:rise].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: canary_file_path must be an String") if !params[:canary_file_path].nil? and !params[:canary_file_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: remote_server_id must be an Integer") if !params[:remote_server_id].nil? and !params[:remote_server_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_mount_backends/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("RemoteMountBackend") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Remote Mount Backend
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

      response, options = Api.send_request("/remote_mount_backends/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = RemoteMountBackend.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Remote Mount Backends
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `remote_server_mount_id`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)

      list_options = options.dup
      List.new(RemoteMountBackend, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/remote_mount_backends", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Remote Mount Backend
    #
    # @param id [Integer] Remote Mount Backend ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::RemoteMountBackend] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_mount_backends/#{params[:id]}", :get, params, options) { |reply| reply.require_object("RemoteMountBackend") }
      RemoteMountBackend.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Remote Mount Backend
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] enabled True if this backend is enabled.
    # @option params [Integer] fall Number of consecutive failures before considering the backend unhealthy.
    # @option params [Boolean] health_check_enabled True if health checks are enabled for this backend.
    # @option params [String] health_check_type Type of health check to perform.
    # @option params [Integer] interval Interval in seconds between health checks.
    # @option params [Float] min_free_cpu Minimum free CPU percentage required for this backend to be considered healthy.
    # @option params [Float] min_free_mem Minimum free memory percentage required for this backend to be considered healthy.
    # @option params [Integer] priority Priority of this backend.
    # @option params [String] remote_path Path on the remote server to treat as the root of this mount.
    # @option params [Integer] rise Number of consecutive successes before considering the backend healthy.
    # @option params [String] canary_file_path Required. Path to the canary file used for health checks.
    # @option params [Integer] remote_server_mount_id Required. The mount ID of the Remote Server Mount that this backend is associated with.
    # @option params [Integer] remote_server_id Required. The remote server that this backend is associated with.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::RemoteMountBackend] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: enabled must be a single value, not #{params[:enabled].class}") if [ Array, Hash ].any? { |klass| params[:enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: fall must be an Integer") if !params[:fall].nil? and !params[:fall].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: health_check_enabled must be a single value, not #{params[:health_check_enabled].class}") if [ Array, Hash ].any? { |klass| params[:health_check_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: health_check_type must be an String") if !params[:health_check_type].nil? and !params[:health_check_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an Integer") if !params[:interval].nil? and !params[:interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: min_free_cpu must be an Float") if !params[:min_free_cpu].nil? and !params[:min_free_cpu].is_a?(Float)
      raise InvalidParameterError.new("Bad parameter: min_free_mem must be an Float") if !params[:min_free_mem].nil? and !params[:min_free_mem].is_a?(Float)
      raise InvalidParameterError.new("Bad parameter: priority must be an Integer") if !params[:priority].nil? and !params[:priority].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: remote_path must be an String") if !params[:remote_path].nil? and !params[:remote_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rise must be an Integer") if !params[:rise].nil? and !params[:rise].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: canary_file_path must be an String") if !params[:canary_file_path].nil? and !params[:canary_file_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: remote_server_mount_id must be an Integer") if !params[:remote_server_mount_id].nil? and !params[:remote_server_mount_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: remote_server_id must be an Integer") if !params[:remote_server_id].nil? and !params[:remote_server_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: canary_file_path") if params[:canary_file_path].nil?
      raise MissingParameterError.new("Parameter missing: remote_server_mount_id") if params[:remote_server_mount_id].nil?
      raise MissingParameterError.new("Parameter missing: remote_server_id") if params[:remote_server_id].nil?

      response, options = Api.send_request("/remote_mount_backends", :post, params, options) { |reply| reply.require_object("RemoteMountBackend") }
      RemoteMountBackend.new(response.data, options)
    end

    # Reset backend status to healthy
    #
    # @param id [Integer] Remote Mount Backend ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.reset_status(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/remote_mount_backends/#{params[:id]}/reset_status", :post, params, options)
      nil
    end

    # Update Remote Mount Backend
    #
    # @param id [Integer] Remote Mount Backend ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] enabled True if this backend is enabled.
    # @option params [Integer] fall Number of consecutive failures before considering the backend unhealthy.
    # @option params [Boolean] health_check_enabled True if health checks are enabled for this backend.
    # @option params [String] health_check_type Type of health check to perform.
    # @option params [Integer] interval Interval in seconds between health checks.
    # @option params [Float] min_free_cpu Minimum free CPU percentage required for this backend to be considered healthy.
    # @option params [Float] min_free_mem Minimum free memory percentage required for this backend to be considered healthy.
    # @option params [Integer] priority Priority of this backend.
    # @option params [String] remote_path Path on the remote server to treat as the root of this mount.
    # @option params [Integer] rise Number of consecutive successes before considering the backend healthy.
    # @option params [String] canary_file_path Path to the canary file used for health checks.
    # @option params [Integer] remote_server_id The remote server that this backend is associated with.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::RemoteMountBackend] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: enabled must be a single value, not #{params[:enabled].class}") if [ Array, Hash ].any? { |klass| params[:enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: fall must be an Integer") if !params[:fall].nil? and !params[:fall].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: health_check_enabled must be a single value, not #{params[:health_check_enabled].class}") if [ Array, Hash ].any? { |klass| params[:health_check_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: health_check_type must be an String") if !params[:health_check_type].nil? and !params[:health_check_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an Integer") if !params[:interval].nil? and !params[:interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: min_free_cpu must be an Float") if !params[:min_free_cpu].nil? and !params[:min_free_cpu].is_a?(Float)
      raise InvalidParameterError.new("Bad parameter: min_free_mem must be an Float") if !params[:min_free_mem].nil? and !params[:min_free_mem].is_a?(Float)
      raise InvalidParameterError.new("Bad parameter: priority must be an Integer") if !params[:priority].nil? and !params[:priority].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: remote_path must be an String") if !params[:remote_path].nil? and !params[:remote_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rise must be an Integer") if !params[:rise].nil? and !params[:rise].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: canary_file_path must be an String") if !params[:canary_file_path].nil? and !params[:canary_file_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: remote_server_id must be an Integer") if !params[:remote_server_id].nil? and !params[:remote_server_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_mount_backends/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("RemoteMountBackend") }
      RemoteMountBackend.new(response.data, options)
    end

    # Delete Remote Mount Backend
    #
    # @param id [Integer] Remote Mount Backend ID.
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

      Api.send_request("/remote_mount_backends/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
