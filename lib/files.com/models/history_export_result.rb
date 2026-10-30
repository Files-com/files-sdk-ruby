# frozen_string_literal: true

module Files
  # Files::HistoryExportResult is the Ruby SDK's representation of Files.com API HistoryExportResult objects.
  # Each instance keeps its API field values in +attributes+.
  class HistoryExportResult
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

    # Action ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # When the action happened
    # @return [Integer, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # When the action happened, in ISO8601 format.
    # @return [String, nil] the field value, or nil when absent.
    def created_at_iso8601
      @attributes[:created_at_iso8601]
    end

    # User ID
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # File ID related to the action
    # @return [Integer, nil] the field value, or nil when absent.
    def file_id
      @attributes[:file_id]
    end

    # ID of the parent folder
    # @return [Integer, nil] the field value, or nil when absent.
    def parent_id
      @attributes[:parent_id]
    end

    # Path of the related action. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Folder in which the action occurred
    # @return [String, nil] the field value, or nil when absent.
    def folder
      @attributes[:folder]
    end

    # File move originated from this path
    # @return [String, nil] the field value, or nil when absent.
    def src
      @attributes[:src]
    end

    # File moved to this destination folder
    # @return [String, nil] the field value, or nil when absent.
    def destination
      @attributes[:destination]
    end

    # Client IP that performed the action
    # @return [String, nil] the field value, or nil when absent.
    def ip
      @attributes[:ip]
    end

    # Username of the user that performed the action
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # true if this change was performed by a user on a parent site.
    # @return [Boolean, nil] the field value, or nil when absent.
    def user_is_from_parent_site
      @attributes[:user_is_from_parent_site]
    end

    # What action was taken. Valid values: `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, `api_key_destroy`, `archived_delete`
    # @return [String, nil] the field value, or nil when absent.
    def action
      @attributes[:action]
    end

    # The type of login failure, if applicable.  Valid values: `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, `expired_access`, `desktop_ip_mismatch`, `desktop_api_key_not_used_quickly_enough`, `disabled`, `country_mismatch`, `insecure_ftp`, `insecure_cipher`, `rate_limited`, `no_s3_compatible_endpoint_permission`, `mobile_ip_mismatch`, `mobile_api_key_not_used_quickly_enough`, `desktop_app_disabled`, `mobile_app_disabled`
    # @return [String, nil] the field value, or nil when absent.
    def failure_type
      @attributes[:failure_type]
    end

    # Interface through which the action was taken. Valid values: `web`, `ftp`, `robot`, `jsapi`, `webdesktopapi`, `sftp`, `dav`, `desktop`, `restapi`, `scim`, `office`, `mobile`, `as2`, `inbound_email`, `remote`, `inbound_s3`
    # @return [String, nil] the field value, or nil when absent.
    def interface
      @attributes[:interface]
    end

    # ID of the object (such as Users, or API Keys) on which the action was taken
    # @return [Integer, nil] the field value, or nil when absent.
    def target_id
      @attributes[:target_id]
    end

    # Name of the User, Group or other object with a name related to this action
    # @return [String, nil] the field value, or nil when absent.
    def target_name
      @attributes[:target_name]
    end

    # Permission level of the action
    # @return [String, nil] the field value, or nil when absent.
    def target_permission
      @attributes[:target_permission]
    end

    # Whether or not the action was recursive
    # @return [Boolean, nil] the field value, or nil when absent.
    def target_recursive
      @attributes[:target_recursive]
    end

    # If searching for Histories about API keys, this is when the API key will expire. Represented as a Unix timestamp.
    # @return [Integer, nil] the field value, or nil when absent.
    def target_expires_at
      @attributes[:target_expires_at]
    end

    # If searching for Histories about API keys, this is when the API key will expire. Represented in ISO8601 format.
    # @return [String, nil] the field value, or nil when absent.
    def target_expires_at_iso8601
      @attributes[:target_expires_at_iso8601]
    end

    # If searching for Histories about API keys, this represents the permission set of the associated  API key
    # @return [String, nil] the field value, or nil when absent.
    def target_permission_set
      @attributes[:target_permission_set]
    end

    # If searching for Histories about API keys, this is the platform on which the action was taken
    # @return [String, nil] the field value, or nil when absent.
    def target_platform
      @attributes[:target_platform]
    end

    # If searching for Histories about API keys, this is the username on which the action was taken
    # @return [String, nil] the field value, or nil when absent.
    def target_username
      @attributes[:target_username]
    end

    # If searching for Histories about API keys, this is the User ID on which the action was taken
    # @return [Integer, nil] the field value, or nil when absent.
    def target_user_id
      @attributes[:target_user_id]
    end

    # List History Export Results
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Integer] history_export_id Required. ID of the associated history export.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: history_export_id must be an Integer") if !params[:history_export_id].nil? and !params[:history_export_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: history_export_id") if params[:history_export_id].nil?

      list_options = options.dup
      List.new(HistoryExportResult, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/history_export_results", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
