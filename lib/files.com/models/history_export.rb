# frozen_string_literal: true

module Files
  # Files::HistoryExport is the Ruby SDK's representation of Files.com API HistoryExport objects.
  # Each instance keeps its API field values in +attributes+.
  class HistoryExport
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

    # Workspace of the export. 0 represents the default workspace. A null value means a site-wide export.
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

    # History Export ID
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

    # Version of the history for the export.
    # @return [String, nil] the field value, or nil when absent.
    def history_version
      @attributes[:history_version]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def history_version=(value)
      @attributes[:history_version] = value
    end

    # Start date/time of export range.
    # @return [String, nil] the field value, or nil when absent.
    def start_at
      @attributes[:start_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def start_at=(value)
      @attributes[:start_at] = value
    end

    # End date/time of export range.
    # @return [String, nil] the field value, or nil when absent.
    def end_at
      @attributes[:end_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def end_at=(value)
      @attributes[:end_at] = value
    end

    # Status of export.  Will be: `building`, `ready`, or `failed`
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

    # Filter results by this this action type. Valid values: `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, `api_key_destroy`, `archived_delete`
    # @return [String, nil] the field value, or nil when absent.
    def query_action
      @attributes[:query_action]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_action=(value)
      @attributes[:query_action] = value
    end

    # Filter results by this this interface type. Valid values: `web`, `ftp`, `robot`, `jsapi`, `webdesktopapi`, `sftp`, `dav`, `desktop`, `restapi`, `scim`, `office`, `mobile`, `as2`, `inbound_email`, `remote`, `inbound_s3`
    # @return [String, nil] the field value, or nil when absent.
    def query_interface
      @attributes[:query_interface]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_interface=(value)
      @attributes[:query_interface] = value
    end

    # Return results that are actions performed by the user indicated by this User ID
    # @return [String, nil] the field value, or nil when absent.
    def query_user_id
      @attributes[:query_user_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_user_id=(value)
      @attributes[:query_user_id] = value
    end

    # Return results that are file actions related to the file indicated by this File ID
    # @return [String, nil] the field value, or nil when absent.
    def query_file_id
      @attributes[:query_file_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_file_id=(value)
      @attributes[:query_file_id] = value
    end

    # Return results that are file actions inside the parent folder specified by this folder ID
    # @return [String, nil] the field value, or nil when absent.
    def query_parent_id
      @attributes[:query_parent_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_parent_id=(value)
      @attributes[:query_parent_id] = value
    end

    # Return results that are file actions related to paths matching this pattern.
    # @return [String, nil] the field value, or nil when absent.
    def query_path
      @attributes[:query_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_path=(value)
      @attributes[:query_path] = value
    end

    # Return results that are file actions related to files or folders inside folder paths matching this pattern.
    # @return [String, nil] the field value, or nil when absent.
    def query_folder
      @attributes[:query_folder]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_folder=(value)
      @attributes[:query_folder] = value
    end

    # Return results that are file moves originating from paths matching this pattern.
    # @return [String, nil] the field value, or nil when absent.
    def query_src
      @attributes[:query_src]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_src=(value)
      @attributes[:query_src] = value
    end

    # Return results that are file moves with paths matching this pattern as destination.
    # @return [String, nil] the field value, or nil when absent.
    def query_destination
      @attributes[:query_destination]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_destination=(value)
      @attributes[:query_destination] = value
    end

    # Filter results by this IP address.
    # @return [String, nil] the field value, or nil when absent.
    def query_ip
      @attributes[:query_ip]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_ip=(value)
      @attributes[:query_ip] = value
    end

    # Filter results by this username.
    # @return [String, nil] the field value, or nil when absent.
    def query_username
      @attributes[:query_username]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_username=(value)
      @attributes[:query_username] = value
    end

    # If searching for Histories about login failures, this parameter restricts results to failures of this specific type.  Valid values: `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, `expired_access`, `desktop_ip_mismatch`, `desktop_api_key_not_used_quickly_enough`, `disabled`, `country_mismatch`, `insecure_ftp`, `insecure_cipher`, `rate_limited`, `no_s3_compatible_endpoint_permission`, `mobile_ip_mismatch`, `mobile_api_key_not_used_quickly_enough`, `desktop_app_disabled`, `mobile_app_disabled`
    # @return [String, nil] the field value, or nil when absent.
    def query_failure_type
      @attributes[:query_failure_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_failure_type=(value)
      @attributes[:query_failure_type] = value
    end

    # If searching for Histories about specific objects (such as Users, or API Keys), this parameter restricts results to objects that match this ID.
    # @return [String, nil] the field value, or nil when absent.
    def query_target_id
      @attributes[:query_target_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_target_id=(value)
      @attributes[:query_target_id] = value
    end

    # If searching for Histories about Users, Groups or other objects with names, this parameter restricts results to objects with this name/username.
    # @return [String, nil] the field value, or nil when absent.
    def query_target_name
      @attributes[:query_target_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_target_name=(value)
      @attributes[:query_target_name] = value
    end

    # If searching for Histories about Permissions, this parameter restricts results to permissions of this level.
    # @return [String, nil] the field value, or nil when absent.
    def query_target_permission
      @attributes[:query_target_permission]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_target_permission=(value)
      @attributes[:query_target_permission] = value
    end

    # If searching for Histories about API keys, this parameter restricts results to API keys created by/for this user ID.
    # @return [String, nil] the field value, or nil when absent.
    def query_target_user_id
      @attributes[:query_target_user_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_target_user_id=(value)
      @attributes[:query_target_user_id] = value
    end

    # If searching for Histories about API keys, this parameter restricts results to API keys created by/for this username.
    # @return [String, nil] the field value, or nil when absent.
    def query_target_username
      @attributes[:query_target_username]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_target_username=(value)
      @attributes[:query_target_username] = value
    end

    # If searching for Histories about API keys, this parameter restricts results to API keys associated with this platform.
    # @return [String, nil] the field value, or nil when absent.
    def query_target_platform
      @attributes[:query_target_platform]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_target_platform=(value)
      @attributes[:query_target_platform] = value
    end

    # If searching for Histories about API keys, this parameter restricts results to API keys with this permission set.
    # @return [String, nil] the field value, or nil when absent.
    def query_target_permission_set
      @attributes[:query_target_permission_set]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_target_permission_set=(value)
      @attributes[:query_target_permission_set] = value
    end

    # If `status` is `ready`, this will be a URL where all the results can be downloaded at once as a CSV.
    # @return [String, nil] the field value, or nil when absent.
    def results_url
      @attributes[:results_url]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def results_url=(value)
      @attributes[:results_url] = value
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

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    # @raise [Files::NotImplementedError] if this record already has an id; updates are unsupported.
    def save
      if @attributes[:id]
        raise NotImplementedError.new("The HistoryExport object doesn't support updates.")
      else
        new_obj = HistoryExport.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # Show History Export
    #
    # @param id [Integer] History Export ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::HistoryExport] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/history_exports/#{params[:id]}", :get, params, options) { |reply| reply.require_object("HistoryExport") }
      HistoryExport.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create History Export
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] start_at Start date/time of export range.
    # @option params [String] end_at End date/time of export range.
    # @option params [String] query_action Filter results by this this action type. Valid values: `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, `api_key_destroy`, `archived_delete`
    # @option params [String] query_interface Filter results by this this interface type. Valid values: `web`, `ftp`, `robot`, `jsapi`, `webdesktopapi`, `sftp`, `dav`, `desktop`, `restapi`, `scim`, `office`, `mobile`, `as2`, `inbound_email`, `remote`, `inbound_s3`
    # @option params [String] query_user_id Return results that are actions performed by the user indicated by this User ID
    # @option params [String] query_file_id Return results that are file actions related to the file indicated by this File ID
    # @option params [String] query_parent_id Return results that are file actions inside the parent folder specified by this folder ID
    # @option params [String] query_path Return results that are file actions related to paths matching this pattern.
    # @option params [String] query_folder Return results that are file actions related to files or folders inside folder paths matching this pattern.
    # @option params [String] query_src Return results that are file moves originating from paths matching this pattern.
    # @option params [String] query_destination Return results that are file moves with paths matching this pattern as destination.
    # @option params [String] query_ip Filter results by this IP address.
    # @option params [String] query_username Filter results by this username.
    # @option params [String] query_failure_type If searching for Histories about login failures, this parameter restricts results to failures of this specific type.  Valid values: `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, `expired_access`, `desktop_ip_mismatch`, `desktop_api_key_not_used_quickly_enough`, `disabled`, `country_mismatch`, `insecure_ftp`, `insecure_cipher`, `rate_limited`, `no_s3_compatible_endpoint_permission`, `mobile_ip_mismatch`, `mobile_api_key_not_used_quickly_enough`, `desktop_app_disabled`, `mobile_app_disabled`
    # @option params [String] query_target_id If searching for Histories about specific objects (such as Users, or API Keys), this parameter restricts results to objects that match this ID.
    # @option params [String] query_target_name If searching for Histories about Users, Groups or other objects with names, this parameter restricts results to objects with this name/username.
    # @option params [String] query_target_permission If searching for Histories about Permissions, this parameter restricts results to permissions of this level.
    # @option params [String] query_target_user_id If searching for Histories about API keys, this parameter restricts results to API keys created by/for this user ID.
    # @option params [String] query_target_username If searching for Histories about API keys, this parameter restricts results to API keys created by/for this username.
    # @option params [String] query_target_platform If searching for Histories about API keys, this parameter restricts results to API keys associated with this platform.
    # @option params [String] query_target_permission_set If searching for Histories about API keys, this parameter restricts results to API keys with this permission set.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::HistoryExport] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if !params[:start_at].nil? and !params[:start_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if !params[:end_at].nil? and !params[:end_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_action must be an String") if !params[:query_action].nil? and !params[:query_action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_interface must be an String") if !params[:query_interface].nil? and !params[:query_interface].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_user_id must be an String") if !params[:query_user_id].nil? and !params[:query_user_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_file_id must be an String") if !params[:query_file_id].nil? and !params[:query_file_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_parent_id must be an String") if !params[:query_parent_id].nil? and !params[:query_parent_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_path must be an String") if !params[:query_path].nil? and !params[:query_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_folder must be an String") if !params[:query_folder].nil? and !params[:query_folder].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_src must be an String") if !params[:query_src].nil? and !params[:query_src].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_destination must be an String") if !params[:query_destination].nil? and !params[:query_destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_ip must be an String") if !params[:query_ip].nil? and !params[:query_ip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_username must be an String") if !params[:query_username].nil? and !params[:query_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_failure_type must be an String") if !params[:query_failure_type].nil? and !params[:query_failure_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_id must be an String") if !params[:query_target_id].nil? and !params[:query_target_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_name must be an String") if !params[:query_target_name].nil? and !params[:query_target_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_permission must be an String") if !params[:query_target_permission].nil? and !params[:query_target_permission].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_user_id must be an String") if !params[:query_target_user_id].nil? and !params[:query_target_user_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_username must be an String") if !params[:query_target_username].nil? and !params[:query_target_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_platform must be an String") if !params[:query_target_platform].nil? and !params[:query_target_platform].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_permission_set must be an String") if !params[:query_target_permission_set].nil? and !params[:query_target_permission_set].is_a?(String)

      response, options = Api.send_request("/history_exports", :post, params, options) { |reply| reply.require_object("HistoryExport") }
      HistoryExport.new(response.data, options)
    end
  end
end
