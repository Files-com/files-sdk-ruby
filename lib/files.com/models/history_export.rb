# frozen_string_literal: true

module Files
  class HistoryExport
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - History Export ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # date-time - Start date/time of export range.
    def start_at
      @attributes[:start_at]
    end

    def start_at=(value)
      @attributes[:start_at] = value
    end

    # date-time - End date/time of export range.
    def end_at
      @attributes[:end_at]
    end

    def end_at=(value)
      @attributes[:end_at] = value
    end

    # string - Status of export.  Will be: `building`, `ready`, or `failed`
    def status
      @attributes[:status]
    end

    def status=(value)
      @attributes[:status] = value
    end

    # string - Filter results by this this action type. Valid values: `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, `api_key_destroy`
    def query_action
      @attributes[:query_action]
    end

    def query_action=(value)
      @attributes[:query_action] = value
    end

    # string - Filter results by this this interface type. Valid values: `web`, `ftp`, `robot`, `jsapi`, `webdesktopapi`, `sftp`, `dav`, `desktop`, `restapi`, `scim`
    def query_interface
      @attributes[:query_interface]
    end

    def query_interface=(value)
      @attributes[:query_interface] = value
    end

    # string - Return results that are actions performed by the user indiciated by this User ID
    def query_user_id
      @attributes[:query_user_id]
    end

    def query_user_id=(value)
      @attributes[:query_user_id] = value
    end

    # string - Return results that are file actions related to the file indicated by this File ID
    def query_file_id
      @attributes[:query_file_id]
    end

    def query_file_id=(value)
      @attributes[:query_file_id] = value
    end

    # string - Return results that are file actions inside the parent folder specified by this folder ID
    def query_parent_id
      @attributes[:query_parent_id]
    end

    def query_parent_id=(value)
      @attributes[:query_parent_id] = value
    end

    # string - Return results that are file actions related to this path.
    def query_path
      @attributes[:query_path]
    end

    def query_path=(value)
      @attributes[:query_path] = value
    end

    # string - Return results that are file actions related to files or folders inside this folder path.
    def query_folder
      @attributes[:query_folder]
    end

    def query_folder=(value)
      @attributes[:query_folder] = value
    end

    # string - Return results that are file moves originating from this path.
    def query_src
      @attributes[:query_src]
    end

    def query_src=(value)
      @attributes[:query_src] = value
    end

    # string - Return results that are file moves with this path as destination.
    def query_destination
      @attributes[:query_destination]
    end

    def query_destination=(value)
      @attributes[:query_destination] = value
    end

    # string - Filter results by this IP address.
    def query_ip
      @attributes[:query_ip]
    end

    def query_ip=(value)
      @attributes[:query_ip] = value
    end

    # string - Filter results by this username.
    def query_username
      @attributes[:query_username]
    end

    def query_username=(value)
      @attributes[:query_username] = value
    end

    # string - If searching for Histories about login failures, this parameter restricts results to failures of this specific type.  Valid values: `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, `expired_access`, `desktop_ip_mismatch`, `desktop_api_key_not_used_quickly_enough`, `disabled`
    def query_failure_type
      @attributes[:query_failure_type]
    end

    def query_failure_type=(value)
      @attributes[:query_failure_type] = value
    end

    # string - If searching for Histories about specific objects (such as Users, or API Keys), this paremeter restricts results to objects that match this ID.
    def query_target_id
      @attributes[:query_target_id]
    end

    def query_target_id=(value)
      @attributes[:query_target_id] = value
    end

    # string - If searching for Histories about Users, Groups or other objects with names, this parameter restricts results to objects with this name/username.
    def query_target_name
      @attributes[:query_target_name]
    end

    def query_target_name=(value)
      @attributes[:query_target_name] = value
    end

    # string - If searching for Histories about Permisisons, this parameter restricts results to permissions of this level.
    def query_target_permission
      @attributes[:query_target_permission]
    end

    def query_target_permission=(value)
      @attributes[:query_target_permission] = value
    end

    # string - If searching for Histories about API keys, this parameter restricts results to API keys created by/for this user ID.
    def query_target_user_id
      @attributes[:query_target_user_id]
    end

    def query_target_user_id=(value)
      @attributes[:query_target_user_id] = value
    end

    # string - If searching for Histories about API keys, this parameter restricts results to API keys created by/for this username.
    def query_target_username
      @attributes[:query_target_username]
    end

    def query_target_username=(value)
      @attributes[:query_target_username] = value
    end

    # string - If searching for Histories about API keys, this parameter restricts results to API keys associated with this platform.
    def query_target_platform
      @attributes[:query_target_platform]
    end

    def query_target_platform=(value)
      @attributes[:query_target_platform] = value
    end

    # string - If searching for Histories about API keys, this parameter restricts results to API keys with this permission set.
    def query_target_permission_set
      @attributes[:query_target_permission_set]
    end

    def query_target_permission_set=(value)
      @attributes[:query_target_permission_set] = value
    end

    # string - If `status` is `ready` and the query succeeded, this will be a URL where all the results can be downloaded at once as a CSV.
    def results_url
      @attributes[:results_url]
    end

    def results_url=(value)
      @attributes[:results_url] = value
    end

    # int64 - User ID.  Provide a value of `0` to operate the current session's user.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The HistoryExport object doesn't support updates.")
      else
        new_obj = HistoryExport.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   id (required) - int64 - History Export ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/history_exports/#{params[:id]}", :get, params, options)
      HistoryExport.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   start_at - string - Start date/time of export range.
    #   end_at - string - End date/time of export range.
    #   query_action - string - Filter results by this this action type. Valid values: `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, `api_key_destroy`
    #   query_interface - string - Filter results by this this interface type. Valid values: `web`, `ftp`, `robot`, `jsapi`, `webdesktopapi`, `sftp`, `dav`, `desktop`, `restapi`, `scim`
    #   query_user_id - string - Return results that are actions performed by the user indiciated by this User ID
    #   query_file_id - string - Return results that are file actions related to the file indicated by this File ID
    #   query_parent_id - string - Return results that are file actions inside the parent folder specified by this folder ID
    #   query_path - string - Return results that are file actions related to this path.
    #   query_folder - string - Return results that are file actions related to files or folders inside this folder path.
    #   query_src - string - Return results that are file moves originating from this path.
    #   query_destination - string - Return results that are file moves with this path as destination.
    #   query_ip - string - Filter results by this IP address.
    #   query_username - string - Filter results by this username.
    #   query_failure_type - string - If searching for Histories about login failures, this parameter restricts results to failures of this specific type.  Valid values: `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, `expired_access`, `desktop_ip_mismatch`, `desktop_api_key_not_used_quickly_enough`, `disabled`
    #   query_target_id - string - If searching for Histories about specific objects (such as Users, or API Keys), this paremeter restricts results to objects that match this ID.
    #   query_target_name - string - If searching for Histories about Users, Groups or other objects with names, this parameter restricts results to objects with this name/username.
    #   query_target_permission - string - If searching for Histories about Permisisons, this parameter restricts results to permissions of this level.
    #   query_target_user_id - string - If searching for Histories about API keys, this parameter restricts results to API keys created by/for this user ID.
    #   query_target_username - string - If searching for Histories about API keys, this parameter restricts results to API keys created by/for this username.
    #   query_target_platform - string - If searching for Histories about API keys, this parameter restricts results to API keys associated with this platform.
    #   query_target_permission_set - string - If searching for Histories about API keys, this parameter restricts results to API keys with this permission set.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if params.dig(:start_at) and !params.dig(:start_at).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if params.dig(:end_at) and !params.dig(:end_at).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_action must be an String") if params.dig(:query_action) and !params.dig(:query_action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_interface must be an String") if params.dig(:query_interface) and !params.dig(:query_interface).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_user_id must be an String") if params.dig(:query_user_id) and !params.dig(:query_user_id).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_file_id must be an String") if params.dig(:query_file_id) and !params.dig(:query_file_id).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_parent_id must be an String") if params.dig(:query_parent_id) and !params.dig(:query_parent_id).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_path must be an String") if params.dig(:query_path) and !params.dig(:query_path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_folder must be an String") if params.dig(:query_folder) and !params.dig(:query_folder).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_src must be an String") if params.dig(:query_src) and !params.dig(:query_src).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_destination must be an String") if params.dig(:query_destination) and !params.dig(:query_destination).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_ip must be an String") if params.dig(:query_ip) and !params.dig(:query_ip).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_username must be an String") if params.dig(:query_username) and !params.dig(:query_username).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_failure_type must be an String") if params.dig(:query_failure_type) and !params.dig(:query_failure_type).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_id must be an String") if params.dig(:query_target_id) and !params.dig(:query_target_id).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_name must be an String") if params.dig(:query_target_name) and !params.dig(:query_target_name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_permission must be an String") if params.dig(:query_target_permission) and !params.dig(:query_target_permission).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_user_id must be an String") if params.dig(:query_target_user_id) and !params.dig(:query_target_user_id).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_username must be an String") if params.dig(:query_target_username) and !params.dig(:query_target_username).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_platform must be an String") if params.dig(:query_target_platform) and !params.dig(:query_target_platform).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_target_permission_set must be an String") if params.dig(:query_target_permission_set) and !params.dig(:query_target_permission_set).is_a?(String)

      response, options = Api.send_request("/history_exports", :post, params, options)
      HistoryExport.new(response.data, options)
    end
  end
end
