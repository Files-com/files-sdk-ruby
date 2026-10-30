# frozen_string_literal: true

module Files
  # Files::Notification is the Ruby SDK's representation of Files.com API Notification objects.
  # Each instance keeps its API field values in +attributes+.
  class Notification
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

    # Notification ID
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

    # Folder path to notify on. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def path=(value)
      @attributes[:path] = value
    end

    # ID of Group to receive notifications
    # @return [Integer, nil] the field value, or nil when absent.
    def group_id
      @attributes[:group_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def group_id=(value)
      @attributes[:group_id] = value
    end

    # Group name, if a Group ID is set
    # @return [String, nil] the field value, or nil when absent.
    def group_name
      @attributes[:group_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def group_name=(value)
      @attributes[:group_name] = value
    end

    # Group IDs when the notification requires multiple groups
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def group_ids
      @attributes[:group_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def group_ids=(value)
      @attributes[:group_ids] = value
    end

    # Group names when the notification requires multiple groups
    # @return [Array<String>, nil] the field value, or nil when absent.
    def group_names
      @attributes[:group_names]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def group_names=(value)
      @attributes[:group_names] = value
    end

    # If set, will only notify on actions made by a member of one of the specified groups
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def triggering_group_ids
      @attributes[:triggering_group_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def triggering_group_ids=(value)
      @attributes[:triggering_group_ids] = value
    end

    # If set, will only notify on actions made one of the specified users
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def triggering_user_ids
      @attributes[:triggering_user_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def triggering_user_ids=(value)
      @attributes[:triggering_user_ids] = value
    end

    # Notify when actions are performed by a share recipient?
    # @return [Boolean, nil] the field value, or nil when absent.
    def trigger_by_share_recipients
      @attributes[:trigger_by_share_recipients]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def trigger_by_share_recipients=(value)
      @attributes[:trigger_by_share_recipients] = value
    end

    # If true, will send notifications about a user's own activity to that user.  If false, only activity performed by other users (or anonymous users) will be sent in notifications.
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_user_actions
      @attributes[:notify_user_actions]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_user_actions=(value)
      @attributes[:notify_user_actions] = value
    end

    # Trigger on files copied to this path?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_copy
      @attributes[:notify_on_copy]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_copy=(value)
      @attributes[:notify_on_copy] = value
    end

    # Trigger on files deleted in this path?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_delete
      @attributes[:notify_on_delete]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_delete=(value)
      @attributes[:notify_on_delete] = value
    end

    # Trigger on files downloaded in this path?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_download
      @attributes[:notify_on_download]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_download=(value)
      @attributes[:notify_on_download] = value
    end

    # Trigger on files moved to this path?
    # @return [Boolean, nil] the field value, or nil when absent.
    def notify_on_move
      @attributes[:notify_on_move]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def notify_on_move=(value)
      @attributes[:notify_on_move] = value
    end

    # Trigger on files created/uploaded/updated/changed in this path?
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

    # Apply notification recursively?  This will enable notifications for each subfolder.
    # @return [Boolean, nil] the field value, or nil when absent.
    def recursive
      @attributes[:recursive]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def recursive=(value)
      @attributes[:recursive] = value
    end

    # The time interval that notifications are aggregated to
    # @return [String, nil] the field value, or nil when absent.
    def send_interval
      @attributes[:send_interval]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def send_interval=(value)
      @attributes[:send_interval] = value
    end

    # Custom subject line to use for notification emails
    # @return [String, nil] the field value, or nil when absent.
    def subject
      @attributes[:subject]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def subject=(value)
      @attributes[:subject] = value
    end

    # Custom message to include in notification emails
    # @return [String, nil] the field value, or nil when absent.
    def message
      @attributes[:message]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def message=(value)
      @attributes[:message] = value
    end

    # Array of filenames (possibly with wildcards) to scope trigger
    # @return [Array<String>, nil] the field value, or nil when absent.
    def triggering_filenames
      @attributes[:triggering_filenames]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def triggering_filenames=(value)
      @attributes[:triggering_filenames] = value
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

    # Is the user unsubscribed from this notification?
    # @return [Boolean, nil] the field value, or nil when absent.
    def unsubscribed
      @attributes[:unsubscribed]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def unsubscribed=(value)
      @attributes[:unsubscribed] = value
    end

    # The reason that the user unsubscribed
    # @return [String, nil] the field value, or nil when absent.
    def unsubscribed_reason
      @attributes[:unsubscribed_reason]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def unsubscribed_reason=(value)
      @attributes[:unsubscribed_reason] = value
    end

    # Notification user ID
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

    # Notification username
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def username=(value)
      @attributes[:username] = value
    end

    # If true, it means that the recipient at this user's email address has manually unsubscribed from all emails, or had their email "hard bounce", which means that we are unable to send mail to this user's current email address. Notifications will resume if the user changes their email address.
    # @return [Boolean, nil] the field value, or nil when absent.
    def suppressed_email
      @attributes[:suppressed_email]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def suppressed_email=(value)
      @attributes[:suppressed_email] = value
    end

    # Update Notification
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] notify_on_copy If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
    # @option params [Boolean] notify_on_delete Trigger on files deleted in this path?
    # @option params [Boolean] notify_on_download Trigger on files downloaded in this path?
    # @option params [Boolean] notify_on_move Trigger on files moved to this path?
    # @option params [Boolean] notify_on_upload Trigger on files created/uploaded/updated/changed in this path?
    # @option params [Boolean] notify_user_actions If `true` actions initiated by the user will still result in a notification
    # @option params [Boolean] recursive If `true`, enable notifications for each subfolder in this path
    # @option params [String] send_interval The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
    # @option params [String] subject Custom subject line to use for notification emails
    # @option params [String] message Custom message to include in notification emails
    # @option params [Array<String>] triggering_filenames Array of filenames (possibly with wildcards) to scope trigger
    # @option params [Array<Integer>] triggering_group_ids If set, will only notify on actions made by a member of one of the specified groups
    # @option params [Array<Integer>] triggering_user_ids If set, will only notify on actions made one of the specified users
    # @option params [Boolean] trigger_by_share_recipients Notify when actions are performed by a share recipient?
    # @option params [Integer] workspace_id Workspace ID. `0` means the default workspace.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notify_on_copy must be a single value, not #{params[:notify_on_copy].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_copy].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_delete must be a single value, not #{params[:notify_on_delete].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_download must be a single value, not #{params[:notify_on_download].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_download].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_move must be a single value, not #{params[:notify_on_move].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_move].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_upload must be a single value, not #{params[:notify_on_upload].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_upload].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_user_actions must be a single value, not #{params[:notify_user_actions].class}") if [ Array, Hash ].any? { |klass| params[:notify_user_actions].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: send_interval must be an String") if !params[:send_interval].nil? and !params[:send_interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subject must be an String") if !params[:subject].nil? and !params[:subject].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: message must be an String") if !params[:message].nil? and !params[:message].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: triggering_filenames must be an Array") if !params[:triggering_filenames].nil? and !params[:triggering_filenames].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: triggering_group_ids must be an Array") if !params[:triggering_group_ids].nil? and !params[:triggering_group_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: triggering_user_ids must be an Array") if !params[:triggering_user_ids].nil? and !params[:triggering_user_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: trigger_by_share_recipients must be a single value, not #{params[:trigger_by_share_recipients].class}") if [ Array, Hash ].any? { |klass| params[:trigger_by_share_recipients].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/notifications/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("Notification") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Notification
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

      response, options = Api.send_request("/notifications/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = Notification.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Notifications
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `path`, `user_id` or `group_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `path`, `user_id`, `workspace_id` or `group_id`. Valid field combinations are `[ workspace_id, path ]`, `[ workspace_id, user_id ]`, `[ workspace_id, group_id ]` or `[ workspace_id, user_id, path ]`.
    # @option params [Hash] filter_prefix If set, return records where the specified field is prefixed by the supplied value. Valid fields are `path`.
    # @option params [String] path Show notifications for this Path.
    # @option params [Boolean] include_ancestors If `include_ancestors` is `true` and `path` is specified, include notifications for any parent paths. Ignored if `path` is not specified.
    # @option params [String] group_id
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
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: include_ancestors must be a single value, not #{params[:include_ancestors].class}") if [ Array, Hash ].any? { |klass| params[:include_ancestors].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: group_id must be an String") if !params[:group_id].nil? and !params[:group_id].is_a?(String)

      list_options = options.dup
      List.new(Notification, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/notifications", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Notification
    #
    # @param id [Integer] Notification ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Notification] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/notifications/#{params[:id]}", :get, params, options) { |reply| reply.require_object("Notification") }
      Notification.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Notification
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id The id of the user to notify. Provide `user_id`, `username` or `group_id`.
    # @option params [Boolean] notify_on_copy If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
    # @option params [Boolean] notify_on_delete Trigger on files deleted in this path?
    # @option params [Boolean] notify_on_download Trigger on files downloaded in this path?
    # @option params [Boolean] notify_on_move Trigger on files moved to this path?
    # @option params [Boolean] notify_on_upload Trigger on files created/uploaded/updated/changed in this path?
    # @option params [Boolean] notify_user_actions If `true` actions initiated by the user will still result in a notification
    # @option params [Boolean] recursive If `true`, enable notifications for each subfolder in this path
    # @option params [String] send_interval The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
    # @option params [String] subject Custom subject line to use for notification emails
    # @option params [String] message Custom message to include in notification emails
    # @option params [Array<String>] triggering_filenames Array of filenames (possibly with wildcards) to scope trigger
    # @option params [Array<Integer>] triggering_group_ids If set, will only notify on actions made by a member of one of the specified groups
    # @option params [Array<Integer>] triggering_user_ids If set, will only notify on actions made one of the specified users
    # @option params [Boolean] trigger_by_share_recipients Notify when actions are performed by a share recipient?
    # @option params [Integer] workspace_id Workspace ID. `0` means the default workspace.
    # @option params [Integer] group_id The ID of the group to notify.  Provide `user_id`, `username` or `group_id`.
    # @option params [String] group_ids Group IDs when the notification requires multiple groups. If sent as a string, it should be comma-delimited.
    # @option params [String] path Path
    # @option params [String] username The username of the user to notify.  Provide `user_id`, `username` or `group_id`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Notification] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notify_on_copy must be a single value, not #{params[:notify_on_copy].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_copy].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_delete must be a single value, not #{params[:notify_on_delete].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_download must be a single value, not #{params[:notify_on_download].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_download].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_move must be a single value, not #{params[:notify_on_move].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_move].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_upload must be a single value, not #{params[:notify_on_upload].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_upload].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_user_actions must be a single value, not #{params[:notify_user_actions].class}") if [ Array, Hash ].any? { |klass| params[:notify_user_actions].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: send_interval must be an String") if !params[:send_interval].nil? and !params[:send_interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subject must be an String") if !params[:subject].nil? and !params[:subject].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: message must be an String") if !params[:message].nil? and !params[:message].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: triggering_filenames must be an Array") if !params[:triggering_filenames].nil? and !params[:triggering_filenames].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: triggering_group_ids must be an Array") if !params[:triggering_group_ids].nil? and !params[:triggering_group_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: triggering_user_ids must be an Array") if !params[:triggering_user_ids].nil? and !params[:triggering_user_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: trigger_by_share_recipients must be a single value, not #{params[:trigger_by_share_recipients].class}") if [ Array, Hash ].any? { |klass| params[:trigger_by_share_recipients].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if !params[:group_ids].nil? and !params[:group_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if !params[:username].nil? and !params[:username].is_a?(String)

      response, options = Api.send_request("/notifications", :post, params, options) { |reply| reply.require_object("Notification") }
      Notification.new(response.data, options)
    end

    # Update Notification
    #
    # @param id [Integer] Notification ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] notify_on_copy If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
    # @option params [Boolean] notify_on_delete Trigger on files deleted in this path?
    # @option params [Boolean] notify_on_download Trigger on files downloaded in this path?
    # @option params [Boolean] notify_on_move Trigger on files moved to this path?
    # @option params [Boolean] notify_on_upload Trigger on files created/uploaded/updated/changed in this path?
    # @option params [Boolean] notify_user_actions If `true` actions initiated by the user will still result in a notification
    # @option params [Boolean] recursive If `true`, enable notifications for each subfolder in this path
    # @option params [String] send_interval The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
    # @option params [String] subject Custom subject line to use for notification emails
    # @option params [String] message Custom message to include in notification emails
    # @option params [Array<String>] triggering_filenames Array of filenames (possibly with wildcards) to scope trigger
    # @option params [Array<Integer>] triggering_group_ids If set, will only notify on actions made by a member of one of the specified groups
    # @option params [Array<Integer>] triggering_user_ids If set, will only notify on actions made one of the specified users
    # @option params [Boolean] trigger_by_share_recipients Notify when actions are performed by a share recipient?
    # @option params [Integer] workspace_id Workspace ID. `0` means the default workspace.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Notification] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notify_on_copy must be a single value, not #{params[:notify_on_copy].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_copy].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_delete must be a single value, not #{params[:notify_on_delete].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_download must be a single value, not #{params[:notify_on_download].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_download].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_move must be a single value, not #{params[:notify_on_move].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_move].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_on_upload must be a single value, not #{params[:notify_on_upload].class}") if [ Array, Hash ].any? { |klass| params[:notify_on_upload].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: notify_user_actions must be a single value, not #{params[:notify_user_actions].class}") if [ Array, Hash ].any? { |klass| params[:notify_user_actions].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: send_interval must be an String") if !params[:send_interval].nil? and !params[:send_interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subject must be an String") if !params[:subject].nil? and !params[:subject].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: message must be an String") if !params[:message].nil? and !params[:message].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: triggering_filenames must be an Array") if !params[:triggering_filenames].nil? and !params[:triggering_filenames].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: triggering_group_ids must be an Array") if !params[:triggering_group_ids].nil? and !params[:triggering_group_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: triggering_user_ids must be an Array") if !params[:triggering_user_ids].nil? and !params[:triggering_user_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: trigger_by_share_recipients must be a single value, not #{params[:trigger_by_share_recipients].class}") if [ Array, Hash ].any? { |klass| params[:trigger_by_share_recipients].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/notifications/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("Notification") }
      Notification.new(response.data, options)
    end

    # Delete Notification
    #
    # @param id [Integer] Notification ID.
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

      Api.send_request("/notifications/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
