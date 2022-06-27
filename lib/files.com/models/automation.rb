# frozen_string_literal: true

module Files
  class Automation
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Automation ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Automation type
    def automation
      @attributes[:automation]
    end

    def automation=(value)
      @attributes[:automation] = value
    end

    # boolean - Indicates if the automation has been deleted.
    def deleted
      @attributes[:deleted]
    end

    def deleted=(value)
      @attributes[:deleted] = value
    end

    # boolean - If true, this automation will not run.
    def disabled
      @attributes[:disabled]
    end

    def disabled=(value)
      @attributes[:disabled] = value
    end

    # string - How this automation is triggered to run. One of: `realtime`, `daily`, `custom_schedule`, `webhook`, `email`, or `action`.
    def trigger
      @attributes[:trigger]
    end

    def trigger=(value)
      @attributes[:trigger] = value
    end

    # string - If trigger is `daily`, this specifies how often to run this automation.  One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    def interval
      @attributes[:interval]
    end

    def interval=(value)
      @attributes[:interval] = value
    end

    # date-time - Time when automation was last modified. Does not change for name or description updates.
    def last_modified_at
      @attributes[:last_modified_at]
    end

    def last_modified_at=(value)
      @attributes[:last_modified_at] = value
    end

    # string - Name for this automation.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # object - If trigger is `custom_schedule`, Custom schedule description for when the automation should be run.
    def schedule
      @attributes[:schedule]
    end

    def schedule=(value)
      @attributes[:schedule] = value
    end

    # string - Source Path
    def source
      @attributes[:source]
    end

    def source=(value)
      @attributes[:source] = value
    end

    # string - Destination Path
    def destinations
      @attributes[:destinations]
    end

    def destinations=(value)
      @attributes[:destinations] = value
    end

    # string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    def destination_replace_from
      @attributes[:destination_replace_from]
    end

    def destination_replace_from=(value)
      @attributes[:destination_replace_from] = value
    end

    # string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    def destination_replace_to
      @attributes[:destination_replace_to]
    end

    def destination_replace_to=(value)
      @attributes[:destination_replace_to] = value
    end

    # string - Description for the this Automation.
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # string - Path on which this Automation runs.  Supports globs. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # int64 - User ID of the Automation's creator.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # array - IDs of Users for the Automation (i.e. who to Request File from)
    def user_ids
      @attributes[:user_ids]
    end

    def user_ids=(value)
      @attributes[:user_ids] = value
    end

    # array - IDs of Groups for the Automation (i.e. who to Request File from)
    def group_ids
      @attributes[:group_ids]
    end

    def group_ids=(value)
      @attributes[:group_ids] = value
    end

    # string - If trigger is `webhook`, this is the URL of the webhook to trigger the Automation.
    def webhook_url
      @attributes[:webhook_url]
    end

    def webhook_url=(value)
      @attributes[:webhook_url] = value
    end

    # string - If trigger is `action`, this is the list of action types on which to trigger the automation. Valid actions are create, read, update, destroy, move, copy
    def trigger_actions
      @attributes[:trigger_actions]
    end

    def trigger_actions=(value)
      @attributes[:trigger_actions] = value
    end

    # object - A Hash of attributes specific to the automation type.
    def value
      @attributes[:value]
    end

    def value=(value)
      @attributes[:value] = value
    end

    # string - DEPRECATED: Destination Path. Use `destinations` instead.
    def destination
      @attributes[:destination]
    end

    def destination=(value)
      @attributes[:destination] = value
    end

    # Parameters:
    #   source - string - Source Path
    #   destination - string - DEPRECATED: Destination Path. Use `destinations` instead.
    #   destinations - array(string) - A list of String destination paths or Hash of folder_path and optional file_path.
    #   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    #   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    #   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    #   path - string - Path on which this Automation runs.  Supports globs.
    #   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   schedule - object - Custom schedule for running this automation.
    #   description - string - Description for the this Automation.
    #   disabled - boolean - If true, this automation will not run.
    #   name - string - Name for this automation.
    #   trigger - string - How this automation is triggered to run. One of: `realtime`, `daily`, `custom_schedule`, `webhook`, `email`, or `action`.
    #   trigger_actions - array(string) - If trigger is `action`, this is the list of action types on which to trigger the automation. Valid actions are create, read, update, destroy, move, copy
    #   value - object - A Hash of attributes specific to the automation type.
    #   automation - string - Automation type
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params.dig(:source) and !params.dig(:source).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params.dig(:destination) and !params.dig(:destination).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destinations must be an Array") if params.dig(:destinations) and !params.dig(:destinations).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: destination_replace_from must be an String") if params.dig(:destination_replace_from) and !params.dig(:destination_replace_from).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_to must be an String") if params.dig(:destination_replace_to) and !params.dig(:destination_replace_to).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params.dig(:interval) and !params.dig(:interval).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params.dig(:user_ids) and !params.dig(:user_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params.dig(:group_ids) and !params.dig(:group_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params.dig(:description) and !params.dig(:description).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params.dig(:trigger) and !params.dig(:trigger).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_actions must be an Array") if params.dig(:trigger_actions) and !params.dig(:trigger_actions).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if params.dig(:automation) and !params.dig(:automation).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/automations/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/automations/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = Automation.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `automation`, `disabled` or `last_modified_at`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `automation`, `last_modified_at` or `disabled`. Valid field combinations are `[ automation, disabled ]` and `[ disabled, automation ]`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `automation`, `last_modified_at` or `disabled`. Valid field combinations are `[ automation, disabled ]` and `[ disabled, automation ]`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal to the supplied value. Valid fields are `automation`, `last_modified_at` or `disabled`. Valid field combinations are `[ automation, disabled ]` and `[ disabled, automation ]`.
    #   filter_like - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `automation`, `last_modified_at` or `disabled`. Valid field combinations are `[ automation, disabled ]` and `[ disabled, automation ]`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `automation`, `last_modified_at` or `disabled`. Valid field combinations are `[ automation, disabled ]` and `[ disabled, automation ]`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal to the supplied value. Valid fields are `automation`, `last_modified_at` or `disabled`. Valid field combinations are `[ automation, disabled ]` and `[ disabled, automation ]`.
    #   with_deleted - boolean - Set to true to include deleted automations in the results.
    #   automation - string - DEPRECATED: Type of automation to filter by. Use `filter[automation]` instead.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params.dig(:sort_by) and !params.dig(:sort_by).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params.dig(:filter) and !params.dig(:filter).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params.dig(:filter_gt) and !params.dig(:filter_gt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params.dig(:filter_gteq) and !params.dig(:filter_gteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params.dig(:filter_like) and !params.dig(:filter_like).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params.dig(:filter_lt) and !params.dig(:filter_lt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params.dig(:filter_lteq) and !params.dig(:filter_lteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if params.dig(:automation) and !params.dig(:automation).is_a?(String)

      List.new(Automation, params) do
        Api.send_request("/automations", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Automation ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/automations/#{params[:id]}", :get, params, options)
      Automation.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   source - string - Source Path
    #   destination - string - DEPRECATED: Destination Path. Use `destinations` instead.
    #   destinations - array(string) - A list of String destination paths or Hash of folder_path and optional file_path.
    #   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    #   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    #   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    #   path - string - Path on which this Automation runs.  Supports globs.
    #   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   schedule - object - Custom schedule for running this automation.
    #   description - string - Description for the this Automation.
    #   disabled - boolean - If true, this automation will not run.
    #   name - string - Name for this automation.
    #   trigger - string - How this automation is triggered to run. One of: `realtime`, `daily`, `custom_schedule`, `webhook`, `email`, or `action`.
    #   trigger_actions - array(string) - If trigger is `action`, this is the list of action types on which to trigger the automation. Valid actions are create, read, update, destroy, move, copy
    #   value - object - A Hash of attributes specific to the automation type.
    #   automation (required) - string - Automation type
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params.dig(:source) and !params.dig(:source).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params.dig(:destination) and !params.dig(:destination).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destinations must be an Array") if params.dig(:destinations) and !params.dig(:destinations).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: destination_replace_from must be an String") if params.dig(:destination_replace_from) and !params.dig(:destination_replace_from).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_to must be an String") if params.dig(:destination_replace_to) and !params.dig(:destination_replace_to).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params.dig(:interval) and !params.dig(:interval).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params.dig(:user_ids) and !params.dig(:user_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params.dig(:group_ids) and !params.dig(:group_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule must be an Hash") if params.dig(:schedule) and !params.dig(:schedule).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params.dig(:description) and !params.dig(:description).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params.dig(:trigger) and !params.dig(:trigger).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_actions must be an Array") if params.dig(:trigger_actions) and !params.dig(:trigger_actions).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if params.dig(:value) and !params.dig(:value).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if params.dig(:automation) and !params.dig(:automation).is_a?(String)
      raise MissingParameterError.new("Parameter missing: automation") unless params.dig(:automation)

      response, options = Api.send_request("/automations", :post, params, options)
      Automation.new(response.data, options)
    end

    # Parameters:
    #   source - string - Source Path
    #   destination - string - DEPRECATED: Destination Path. Use `destinations` instead.
    #   destinations - array(string) - A list of String destination paths or Hash of folder_path and optional file_path.
    #   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    #   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    #   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    #   path - string - Path on which this Automation runs.  Supports globs.
    #   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   schedule - object - Custom schedule for running this automation.
    #   description - string - Description for the this Automation.
    #   disabled - boolean - If true, this automation will not run.
    #   name - string - Name for this automation.
    #   trigger - string - How this automation is triggered to run. One of: `realtime`, `daily`, `custom_schedule`, `webhook`, `email`, or `action`.
    #   trigger_actions - array(string) - If trigger is `action`, this is the list of action types on which to trigger the automation. Valid actions are create, read, update, destroy, move, copy
    #   value - object - A Hash of attributes specific to the automation type.
    #   automation - string - Automation type
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params.dig(:source) and !params.dig(:source).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params.dig(:destination) and !params.dig(:destination).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destinations must be an Array") if params.dig(:destinations) and !params.dig(:destinations).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: destination_replace_from must be an String") if params.dig(:destination_replace_from) and !params.dig(:destination_replace_from).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_to must be an String") if params.dig(:destination_replace_to) and !params.dig(:destination_replace_to).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params.dig(:interval) and !params.dig(:interval).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params.dig(:user_ids) and !params.dig(:user_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params.dig(:group_ids) and !params.dig(:group_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: schedule must be an Hash") if params.dig(:schedule) and !params.dig(:schedule).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params.dig(:description) and !params.dig(:description).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger must be an String") if params.dig(:trigger) and !params.dig(:trigger).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: trigger_actions must be an Array") if params.dig(:trigger_actions) and !params.dig(:trigger_actions).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if params.dig(:value) and !params.dig(:value).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if params.dig(:automation) and !params.dig(:automation).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/automations/#{params[:id]}", :patch, params, options)
      Automation.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/automations/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
