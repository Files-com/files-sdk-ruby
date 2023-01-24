# frozen_string_literal: true

module Files
  class HistoryExportResult
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Action ID
    def id
      @attributes[:id]
    end

    # int64 - When the action happened
    def created_at
      @attributes[:created_at]
    end

    # int64 - When the action happened, in ISO8601 format.
    def created_at_iso8601
      @attributes[:created_at_iso8601]
    end

    # int64 - User ID
    def user_id
      @attributes[:user_id]
    end

    # int64 - File ID related to the action
    def file_id
      @attributes[:file_id]
    end

    # int64 - ID of the parent folder
    def parent_id
      @attributes[:parent_id]
    end

    # string - Path of the related action This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # string - Folder in which the action occurred
    def folder
      @attributes[:folder]
    end

    # string - File move originated from this path
    def src
      @attributes[:src]
    end

    # string - File moved to this destination folder
    def destination
      @attributes[:destination]
    end

    # string - Client IP that performed the action
    def ip
      @attributes[:ip]
    end

    # string - Username of the user that performed the action
    def username
      @attributes[:username]
    end

    # string - What action was taken. Valid values: `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, `api_key_destroy`
    def action
      @attributes[:action]
    end

    # string - The type of login failure, if applicable.  Valid values: `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, `expired_access`, `desktop_ip_mismatch`, `desktop_api_key_not_used_quickly_enough`, `disabled`, `country_mismatch`
    def failure_type
      @attributes[:failure_type]
    end

    # string - Inteface through which the action was taken. Valid values: `web`, `ftp`, `robot`, `jsapi`, `webdesktopapi`, `sftp`, `dav`, `desktop`, `restapi`, `scim`, `office`, `mobile`, `as2`, `inbound_email`, `remote`
    def interface
      @attributes[:interface]
    end

    # int64 - ID of the object (such as Users, or API Keys) on which the action was taken
    def target_id
      @attributes[:target_id]
    end

    # string - Name of the User, Group or other object with a name related to this action
    def target_name
      @attributes[:target_name]
    end

    # string - Permission level of the action
    def target_permission
      @attributes[:target_permission]
    end

    # boolean - Whether or not the action was recursive
    def target_recursive
      @attributes[:target_recursive]
    end

    # int64 - If searching for Histories about API keys, this is when the API key will expire
    def target_expires_at
      @attributes[:target_expires_at]
    end

    # string - If searching for Histories about API keys, this represents the permission set of the associated  API key
    def target_permission_set
      @attributes[:target_permission_set]
    end

    # string - If searching for Histories about API keys, this is the platform on which the action was taken
    def target_platform
      @attributes[:target_platform]
    end

    # string - If searching for Histories about API keys, this is the username on which the action was taken
    def target_username
      @attributes[:target_username]
    end

    # int64 - If searching for Histories about API keys, this is the User ID on which the action was taken
    def target_user_id
      @attributes[:target_user_id]
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   history_export_id (required) - int64 - ID of the associated history export.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: history_export_id must be an Integer") if params[:history_export_id] and !params[:history_export_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: history_export_id") unless params[:history_export_id]

      List.new(HistoryExportResult, params) do
        Api.send_request("/history_export_results", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
