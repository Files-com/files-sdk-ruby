# frozen_string_literal: true

module Files
  class Notification
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Notification ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Folder path to notify on. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # int64 - ID of Group to receive notifications
    def group_id
      @attributes[:group_id]
    end

    def group_id=(value)
      @attributes[:group_id] = value
    end

    # string - Group name, if a Group ID is set
    def group_name
      @attributes[:group_name]
    end

    def group_name=(value)
      @attributes[:group_name] = value
    end

    # array(int64) - If set, will only notify on actions made by a member of one of the specified groups
    def triggering_group_ids
      @attributes[:triggering_group_ids]
    end

    def triggering_group_ids=(value)
      @attributes[:triggering_group_ids] = value
    end

    # array(int64) - If set, will onlynotify on actions made one of the specified users
    def triggering_user_ids
      @attributes[:triggering_user_ids]
    end

    def triggering_user_ids=(value)
      @attributes[:triggering_user_ids] = value
    end

    # boolean - Notify when actions are performed by a share recipient?
    def trigger_by_share_recipients
      @attributes[:trigger_by_share_recipients]
    end

    def trigger_by_share_recipients=(value)
      @attributes[:trigger_by_share_recipients] = value
    end

    # boolean - If true, will send notifications about a user's own activity to that user.  If false, only activity performed by other users (or anonymous users) will be sent in notifications.
    def notify_user_actions
      @attributes[:notify_user_actions]
    end

    def notify_user_actions=(value)
      @attributes[:notify_user_actions] = value
    end

    # boolean - Trigger on files copied to this path?
    def notify_on_copy
      @attributes[:notify_on_copy]
    end

    def notify_on_copy=(value)
      @attributes[:notify_on_copy] = value
    end

    # boolean - Trigger on files deleted in this path?
    def notify_on_delete
      @attributes[:notify_on_delete]
    end

    def notify_on_delete=(value)
      @attributes[:notify_on_delete] = value
    end

    # boolean - Trigger on files downloaded in this path?
    def notify_on_download
      @attributes[:notify_on_download]
    end

    def notify_on_download=(value)
      @attributes[:notify_on_download] = value
    end

    # boolean - Trigger on files moved to this path?
    def notify_on_move
      @attributes[:notify_on_move]
    end

    def notify_on_move=(value)
      @attributes[:notify_on_move] = value
    end

    # boolean - Trigger on files created/uploaded/updated/changed in this path?
    def notify_on_upload
      @attributes[:notify_on_upload]
    end

    def notify_on_upload=(value)
      @attributes[:notify_on_upload] = value
    end

    # boolean - Apply notification recursively?  This will enable notifications for each subfolder.
    def recursive
      @attributes[:recursive]
    end

    def recursive=(value)
      @attributes[:recursive] = value
    end

    # string - The time interval that notifications are aggregated to
    def send_interval
      @attributes[:send_interval]
    end

    def send_interval=(value)
      @attributes[:send_interval] = value
    end

    # string - Custom message to include in notification emails
    def message
      @attributes[:message]
    end

    def message=(value)
      @attributes[:message] = value
    end

    # array(string) - Array of filenames (possibly with wildcards) to scope trigger
    def triggering_filenames
      @attributes[:triggering_filenames]
    end

    def triggering_filenames=(value)
      @attributes[:triggering_filenames] = value
    end

    # boolean - Is the user unsubscribed from this notification?
    def unsubscribed
      @attributes[:unsubscribed]
    end

    def unsubscribed=(value)
      @attributes[:unsubscribed] = value
    end

    # string - The reason that the user unsubscribed
    def unsubscribed_reason
      @attributes[:unsubscribed_reason]
    end

    def unsubscribed_reason=(value)
      @attributes[:unsubscribed_reason] = value
    end

    # int64 - Notification user ID
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # string - Notification username
    def username
      @attributes[:username]
    end

    def username=(value)
      @attributes[:username] = value
    end

    # boolean - If true, it means that the recipient at this user's email address has manually unsubscribed from all emails, or had their email "hard bounce", which means that we are unable to send mail to this user's current email address. Notifications will resume if the user changes their email address.
    def suppressed_email
      @attributes[:suppressed_email]
    end

    def suppressed_email=(value)
      @attributes[:suppressed_email] = value
    end

    # Parameters:
    #   notify_on_copy - boolean - If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
    #   notify_on_delete - boolean - Trigger on files deleted in this path?
    #   notify_on_download - boolean - Trigger on files downloaded in this path?
    #   notify_on_move - boolean - Trigger on files moved to this path?
    #   notify_on_upload - boolean - Trigger on files created/uploaded/updated/changed in this path?
    #   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
    #   recursive - boolean - If `true`, enable notifications for each subfolder in this path
    #   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
    #   message - string - Custom message to include in notification emails
    #   triggering_filenames - array(string) - Array of filenames (possibly with wildcards) to scope trigger
    #   triggering_group_ids - array(int64) - If set, will only notify on actions made by a member of one of the specified groups
    #   triggering_user_ids - array(int64) - If set, will onlynotify on actions made one of the specified users
    #   trigger_by_share_recipients - boolean - Notify when actions are performed by a share recipient?
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: send_interval must be an String") if params[:send_interval] and !params[:send_interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: message must be an String") if params[:message] and !params[:message].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: triggering_filenames must be an Array") if params[:triggering_filenames] and !params[:triggering_filenames].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: triggering_group_ids must be an Array") if params[:triggering_group_ids] and !params[:triggering_group_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: triggering_user_ids must be an Array") if params[:triggering_user_ids] and !params[:triggering_user_ids].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/notifications/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/notifications/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = Notification.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string
    #   page - int64
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction (e.g. `sort_by[path]=desc`). Valid fields are `path`, `user_id` or `group_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `path`, `user_id` or `group_id`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `path`.
    #   path - string - Show notifications for this Path.
    #   include_ancestors - boolean - If `include_ancestors` is `true` and `path` is specified, include notifications for any parent paths. Ignored if `path` is not specified.
    #   group_id - string
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params[:action] and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params[:page] and !params[:page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_id must be an String") if params[:group_id] and !params[:group_id].is_a?(String)

      List.new(Notification, params) do
        Api.send_request("/notifications", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Notification ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/notifications/#{params[:id]}", :get, params, options)
      Notification.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - The id of the user to notify. Provide `user_id`, `username` or `group_id`.
    #   notify_on_copy - boolean - If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
    #   notify_on_delete - boolean - Trigger on files deleted in this path?
    #   notify_on_download - boolean - Trigger on files downloaded in this path?
    #   notify_on_move - boolean - Trigger on files moved to this path?
    #   notify_on_upload - boolean - Trigger on files created/uploaded/updated/changed in this path?
    #   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
    #   recursive - boolean - If `true`, enable notifications for each subfolder in this path
    #   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
    #   message - string - Custom message to include in notification emails
    #   triggering_filenames - array(string) - Array of filenames (possibly with wildcards) to scope trigger
    #   triggering_group_ids - array(int64) - If set, will only notify on actions made by a member of one of the specified groups
    #   triggering_user_ids - array(int64) - If set, will onlynotify on actions made one of the specified users
    #   trigger_by_share_recipients - boolean - Notify when actions are performed by a share recipient?
    #   group_id - int64 - The ID of the group to notify.  Provide `user_id`, `username` or `group_id`.
    #   path - string - Path
    #   username - string - The username of the user to notify.  Provide `user_id`, `username` or `group_id`.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: send_interval must be an String") if params[:send_interval] and !params[:send_interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: message must be an String") if params[:message] and !params[:message].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: triggering_filenames must be an Array") if params[:triggering_filenames] and !params[:triggering_filenames].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: triggering_group_ids must be an Array") if params[:triggering_group_ids] and !params[:triggering_group_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: triggering_user_ids must be an Array") if params[:triggering_user_ids] and !params[:triggering_user_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params[:group_id] and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)

      response, options = Api.send_request("/notifications", :post, params, options)
      Notification.new(response.data, options)
    end

    # Parameters:
    #   notify_on_copy - boolean - If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
    #   notify_on_delete - boolean - Trigger on files deleted in this path?
    #   notify_on_download - boolean - Trigger on files downloaded in this path?
    #   notify_on_move - boolean - Trigger on files moved to this path?
    #   notify_on_upload - boolean - Trigger on files created/uploaded/updated/changed in this path?
    #   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
    #   recursive - boolean - If `true`, enable notifications for each subfolder in this path
    #   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
    #   message - string - Custom message to include in notification emails
    #   triggering_filenames - array(string) - Array of filenames (possibly with wildcards) to scope trigger
    #   triggering_group_ids - array(int64) - If set, will only notify on actions made by a member of one of the specified groups
    #   triggering_user_ids - array(int64) - If set, will onlynotify on actions made one of the specified users
    #   trigger_by_share_recipients - boolean - Notify when actions are performed by a share recipient?
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: send_interval must be an String") if params[:send_interval] and !params[:send_interval].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: message must be an String") if params[:message] and !params[:message].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: triggering_filenames must be an Array") if params[:triggering_filenames] and !params[:triggering_filenames].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: triggering_group_ids must be an Array") if params[:triggering_group_ids] and !params[:triggering_group_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: triggering_user_ids must be an Array") if params[:triggering_user_ids] and !params[:triggering_user_ids].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/notifications/#{params[:id]}", :patch, params, options)
      Notification.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/notifications/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
