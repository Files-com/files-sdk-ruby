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

    # string - Folder path to notify on This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # int64 - Notification group id
    def group_id
      @attributes[:group_id]
    end

    def group_id=(value)
      @attributes[:group_id] = value
    end

    # string - Group name if applicable
    def group_name
      @attributes[:group_name]
    end

    def group_name=(value)
      @attributes[:group_name] = value
    end

    # array - Only notify on actions made by a member of one of the specified groups
    def triggering_group_ids
      @attributes[:triggering_group_ids]
    end

    def triggering_group_ids=(value)
      @attributes[:triggering_group_ids] = value
    end

    # array - Only notify on actions made one of the specified users
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

    # boolean - Trigger notification on notification user actions?
    def notify_user_actions
      @attributes[:notify_user_actions]
    end

    def notify_user_actions=(value)
      @attributes[:notify_user_actions] = value
    end

    # boolean - Triggers notification when copying files to this path
    def notify_on_copy
      @attributes[:notify_on_copy]
    end

    def notify_on_copy=(value)
      @attributes[:notify_on_copy] = value
    end

    # boolean - Triggers notification when deleting files from this path
    def notify_on_delete
      @attributes[:notify_on_delete]
    end

    def notify_on_delete=(value)
      @attributes[:notify_on_delete] = value
    end

    # boolean - Triggers notification when downloading files from this path
    def notify_on_download
      @attributes[:notify_on_download]
    end

    def notify_on_download=(value)
      @attributes[:notify_on_download] = value
    end

    # boolean - Triggers notification when moving files to this path
    def notify_on_move
      @attributes[:notify_on_move]
    end

    def notify_on_move=(value)
      @attributes[:notify_on_move] = value
    end

    # boolean - Triggers notification when uploading new files to this path
    def notify_on_upload
      @attributes[:notify_on_upload]
    end

    def notify_on_upload=(value)
      @attributes[:notify_on_upload] = value
    end

    # boolean - Enable notifications for each subfolder in this path
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

    # string - Custom message to include in notification emails.
    def message
      @attributes[:message]
    end

    def message=(value)
      @attributes[:message] = value
    end

    # array - Array of filenames (possibly with wildcards) to match for action path
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
    #   notify_on_delete - boolean - Triggers notification when deleting files from this path
    #   notify_on_download - boolean - Triggers notification when downloading files from this path
    #   notify_on_move - boolean - Triggers notification when moving files to this path
    #   notify_on_upload - boolean - Triggers notification when uploading new files to this path
    #   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
    #   recursive - boolean - If `true`, enable notifications for each subfolder in this path
    #   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
    #   message - string - Custom message to include in notification emails.
    #   triggering_filenames - array(string) - Array of filenames (possibly with wildcards) to match for action path
    #   triggering_group_ids - array(int64) - Only notify on actions made by a member of one of the specified groups
    #   triggering_user_ids - array(int64) - Only notify on actions made one of the specified users
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
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = Notification.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   user_id - int64 - DEPRECATED: Show notifications for this User ID. Use `filter[user_id]` instead.
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `path`, `user_id` or `group_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `user_id`, `group_id` or `path`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `user_id`, `group_id` or `path`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal to the supplied value. Valid fields are `user_id`, `group_id` or `path`.
    #   filter_like - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `user_id`, `group_id` or `path`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `user_id`, `group_id` or `path`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal to the supplied value. Valid fields are `user_id`, `group_id` or `path`.
    #   group_id - int64 - DEPRECATED: Show notifications for this Group ID. Use `filter[group_id]` instead.
    #   path - string - Show notifications for this Path.
    #   include_ancestors - boolean - If `include_ancestors` is `true` and `path` is specified, include notifications for any parent paths. Ignored if `path` is not specified.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params[:filter_like] and !params[:filter_like].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if params[:group_id] and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)

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
    #   notify_on_delete - boolean - Triggers notification when deleting files from this path
    #   notify_on_download - boolean - Triggers notification when downloading files from this path
    #   notify_on_move - boolean - Triggers notification when moving files to this path
    #   notify_on_upload - boolean - Triggers notification when uploading new files to this path
    #   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
    #   recursive - boolean - If `true`, enable notifications for each subfolder in this path
    #   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
    #   message - string - Custom message to include in notification emails.
    #   triggering_filenames - array(string) - Array of filenames (possibly with wildcards) to match for action path
    #   triggering_group_ids - array(int64) - Only notify on actions made by a member of one of the specified groups
    #   triggering_user_ids - array(int64) - Only notify on actions made one of the specified users
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
    #   notify_on_delete - boolean - Triggers notification when deleting files from this path
    #   notify_on_download - boolean - Triggers notification when downloading files from this path
    #   notify_on_move - boolean - Triggers notification when moving files to this path
    #   notify_on_upload - boolean - Triggers notification when uploading new files to this path
    #   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
    #   recursive - boolean - If `true`, enable notifications for each subfolder in this path
    #   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
    #   message - string - Custom message to include in notification emails.
    #   triggering_filenames - array(string) - Array of filenames (possibly with wildcards) to match for action path
    #   triggering_group_ids - array(int64) - Only notify on actions made by a member of one of the specified groups
    #   triggering_user_ids - array(int64) - Only notify on actions made one of the specified users
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

      response, _options = Api.send_request("/notifications/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
