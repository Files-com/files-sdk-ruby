# frozen_string_literal: true

module Files
  class RemoteMountBackend
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Path to the canary file used for health checks.
    def canary_file_path
      @attributes[:canary_file_path]
    end

    def canary_file_path=(value)
      @attributes[:canary_file_path] = value
    end

    # boolean - True if this backend is enabled.
    def enabled
      @attributes[:enabled]
    end

    def enabled=(value)
      @attributes[:enabled] = value
    end

    # int64 - Number of consecutive failures before considering the backend unhealthy.
    def fall
      @attributes[:fall]
    end

    def fall=(value)
      @attributes[:fall] = value
    end

    # boolean - True if health checks are enabled for this backend.
    def health_check_enabled
      @attributes[:health_check_enabled]
    end

    def health_check_enabled=(value)
      @attributes[:health_check_enabled] = value
    end

    # array(object) - Array of recent health check results.
    def health_check_results
      @attributes[:health_check_results]
    end

    def health_check_results=(value)
      @attributes[:health_check_results] = value
    end

    # string - Type of health check to perform.
    def health_check_type
      @attributes[:health_check_type]
    end

    def health_check_type=(value)
      @attributes[:health_check_type] = value
    end

    # int64 - Unique identifier for this backend.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Interval in seconds between health checks.
    def interval
      @attributes[:interval]
    end

    def interval=(value)
      @attributes[:interval] = value
    end

    # double - Minimum free CPU percentage required for this backend to be considered healthy.
    def min_free_cpu
      @attributes[:min_free_cpu]
    end

    def min_free_cpu=(value)
      @attributes[:min_free_cpu] = value
    end

    # double - Minimum free memory percentage required for this backend to be considered healthy.
    def min_free_mem
      @attributes[:min_free_mem]
    end

    def min_free_mem=(value)
      @attributes[:min_free_mem] = value
    end

    # int64 - Priority of this backend.
    def priority
      @attributes[:priority]
    end

    def priority=(value)
      @attributes[:priority] = value
    end

    # string - Path on the remote server to treat as the root of this mount.
    def remote_path
      @attributes[:remote_path]
    end

    def remote_path=(value)
      @attributes[:remote_path] = value
    end

    # int64 - The remote server that this backend is associated with.
    def remote_server_id
      @attributes[:remote_server_id]
    end

    def remote_server_id=(value)
      @attributes[:remote_server_id] = value
    end

    # int64 - The mount ID of the Remote Server Mount that this backend is associated with.
    def remote_server_mount_id
      @attributes[:remote_server_mount_id]
    end

    def remote_server_mount_id=(value)
      @attributes[:remote_server_mount_id] = value
    end

    # int64 - Number of consecutive successes before considering the backend healthy.
    def rise
      @attributes[:rise]
    end

    def rise=(value)
      @attributes[:rise] = value
    end

    # string - Status of this backend.
    def status
      @attributes[:status]
    end

    def status=(value)
      @attributes[:status] = value
    end

    # boolean - True if this backend is undergoing maintenance.
    def undergoing_maintenance
      @attributes[:undergoing_maintenance]
    end

    def undergoing_maintenance=(value)
      @attributes[:undergoing_maintenance] = value
    end

    # Reset backend status to healthy
    def reset_status(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/remote_mount_backends/#{@attributes[:id]}/reset_status", :post, params, @options)
    end

    # Parameters:
    #   enabled - boolean - True if this backend is enabled.
    #   fall - int64 - Number of consecutive failures before considering the backend unhealthy.
    #   health_check_enabled - boolean - True if health checks are enabled for this backend.
    #   health_check_type - string - Type of health check to perform.
    #   interval - int64 - Interval in seconds between health checks.
    #   min_free_cpu - double - Minimum free CPU percentage required for this backend to be considered healthy.
    #   min_free_mem - double - Minimum free memory percentage required for this backend to be considered healthy.
    #   priority - int64 - Priority of this backend.
    #   remote_path - string - Path on the remote server to treat as the root of this mount.
    #   rise - int64 - Number of consecutive successes before considering the backend healthy.
    #   canary_file_path - string - Path to the canary file used for health checks.
    #   remote_server_id - int64 - The remote server that this backend is associated with.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: fall must be an Integer") if params[:fall] and !params[:fall].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: health_check_type must be an String") if params[:health_check_type] and !params[:health_check_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an Integer") if params[:interval] and !params[:interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: priority must be an Integer") if params[:priority] and !params[:priority].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: remote_path must be an String") if params[:remote_path] and !params[:remote_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rise must be an Integer") if params[:rise] and !params[:rise].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: canary_file_path must be an String") if params[:canary_file_path] and !params[:canary_file_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: remote_server_id must be an Integer") if params[:remote_server_id] and !params[:remote_server_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/remote_mount_backends/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/remote_mount_backends/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = RemoteMountBackend.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `remote_server_mount_id`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(RemoteMountBackend, params) do
        Api.send_request("/remote_mount_backends", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Remote Mount Backend ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/remote_mount_backends/#{params[:id]}", :get, params, options)
      RemoteMountBackend.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   enabled - boolean - True if this backend is enabled.
    #   fall - int64 - Number of consecutive failures before considering the backend unhealthy.
    #   health_check_enabled - boolean - True if health checks are enabled for this backend.
    #   health_check_type - string - Type of health check to perform.
    #   interval - int64 - Interval in seconds between health checks.
    #   min_free_cpu - double - Minimum free CPU percentage required for this backend to be considered healthy.
    #   min_free_mem - double - Minimum free memory percentage required for this backend to be considered healthy.
    #   priority - int64 - Priority of this backend.
    #   remote_path - string - Path on the remote server to treat as the root of this mount.
    #   rise - int64 - Number of consecutive successes before considering the backend healthy.
    #   canary_file_path (required) - string - Path to the canary file used for health checks.
    #   remote_server_mount_id (required) - int64 - The mount ID of the Remote Server Mount that this backend is associated with.
    #   remote_server_id (required) - int64 - The remote server that this backend is associated with.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: fall must be an Integer") if params[:fall] and !params[:fall].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: health_check_type must be an String") if params[:health_check_type] and !params[:health_check_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an Integer") if params[:interval] and !params[:interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: min_free_cpu must be an Float") if params[:min_free_cpu] and !params[:min_free_cpu].is_a?(Float)
      raise InvalidParameterError.new("Bad parameter: min_free_mem must be an Float") if params[:min_free_mem] and !params[:min_free_mem].is_a?(Float)
      raise InvalidParameterError.new("Bad parameter: priority must be an Integer") if params[:priority] and !params[:priority].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: remote_path must be an String") if params[:remote_path] and !params[:remote_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rise must be an Integer") if params[:rise] and !params[:rise].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: canary_file_path must be an String") if params[:canary_file_path] and !params[:canary_file_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: remote_server_mount_id must be an Integer") if params[:remote_server_mount_id] and !params[:remote_server_mount_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: remote_server_id must be an Integer") if params[:remote_server_id] and !params[:remote_server_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: canary_file_path") unless params[:canary_file_path]
      raise MissingParameterError.new("Parameter missing: remote_server_mount_id") unless params[:remote_server_mount_id]
      raise MissingParameterError.new("Parameter missing: remote_server_id") unless params[:remote_server_id]

      response, options = Api.send_request("/remote_mount_backends", :post, params, options)
      RemoteMountBackend.new(response.data, options)
    end

    # Reset backend status to healthy
    def self.reset_status(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/remote_mount_backends/#{params[:id]}/reset_status", :post, params, options)
      nil
    end

    # Parameters:
    #   enabled - boolean - True if this backend is enabled.
    #   fall - int64 - Number of consecutive failures before considering the backend unhealthy.
    #   health_check_enabled - boolean - True if health checks are enabled for this backend.
    #   health_check_type - string - Type of health check to perform.
    #   interval - int64 - Interval in seconds between health checks.
    #   min_free_cpu - double - Minimum free CPU percentage required for this backend to be considered healthy.
    #   min_free_mem - double - Minimum free memory percentage required for this backend to be considered healthy.
    #   priority - int64 - Priority of this backend.
    #   remote_path - string - Path on the remote server to treat as the root of this mount.
    #   rise - int64 - Number of consecutive successes before considering the backend healthy.
    #   canary_file_path - string - Path to the canary file used for health checks.
    #   remote_server_id - int64 - The remote server that this backend is associated with.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: fall must be an Integer") if params[:fall] and !params[:fall].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: health_check_type must be an String") if params[:health_check_type] and !params[:health_check_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an Integer") if params[:interval] and !params[:interval].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: min_free_cpu must be an Float") if params[:min_free_cpu] and !params[:min_free_cpu].is_a?(Float)
      raise InvalidParameterError.new("Bad parameter: min_free_mem must be an Float") if params[:min_free_mem] and !params[:min_free_mem].is_a?(Float)
      raise InvalidParameterError.new("Bad parameter: priority must be an Integer") if params[:priority] and !params[:priority].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: remote_path must be an String") if params[:remote_path] and !params[:remote_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rise must be an Integer") if params[:rise] and !params[:rise].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: canary_file_path must be an String") if params[:canary_file_path] and !params[:canary_file_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: remote_server_id must be an Integer") if params[:remote_server_id] and !params[:remote_server_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/remote_mount_backends/#{params[:id]}", :patch, params, options)
      RemoteMountBackend.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/remote_mount_backends/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
