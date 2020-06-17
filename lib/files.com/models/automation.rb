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

    # string - Source Path
    def source
      @attributes[:source]
    end

    def source=(value)
      @attributes[:source] = value
    end

    # string - Destination Path
    def destination
      @attributes[:destination]
    end

    def destination=(value)
      @attributes[:destination] = value
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

    # string - How often to run this automation?  One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    def interval
      @attributes[:interval]
    end

    def interval=(value)
      @attributes[:interval] = value
    end

    # string - Date this automation will next run.
    def next_process_on
      @attributes[:next_process_on]
    end

    def next_process_on=(value)
      @attributes[:next_process_on] = value
    end

    # string - Path on which this Automation runs.  Supports globs. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # boolean - Does this automation run in real time?  This is a read-only property based on automation type.
    def realtime
      @attributes[:realtime]
    end

    def realtime=(value)
      @attributes[:realtime] = value
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

    # Parameters:
    #   automation (required) - string - Type of automation.  One of: `create_folder`, `request_file`, `request_move`
    #   source - string - Source Path
    #   destination - string - Destination Path
    #   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    #   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    #   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    #   path - string - Path on which this Automation runs.  Supports globs.
    #   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if params.dig(:automation) and !params.dig(:automation).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params.dig(:source) and !params.dig(:source).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params.dig(:destination) and !params.dig(:destination).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_from must be an String") if params.dig(:destination_replace_from) and !params.dig(:destination_replace_from).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_to must be an String") if params.dig(:destination_replace_to) and !params.dig(:destination_replace_to).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params.dig(:interval) and !params.dig(:interval).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params.dig(:user_ids) and !params.dig(:user_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params.dig(:group_ids) and !params.dig(:group_ids).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: automation") unless params.dig(:automation)

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
    #   page - int64 - Current page number.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   automation - string - Type of automation to filter by.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if params.dig(:automation) and !params.dig(:automation).is_a?(String)

      response, options = Api.send_request("/automations", :get, params, options)
      response.data.map do |entity_data|
        Automation.new(entity_data, options)
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
    #   automation (required) - string - Type of automation.  One of: `create_folder`, `request_file`, `request_move`
    #   source - string - Source Path
    #   destination - string - Destination Path
    #   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    #   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    #   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    #   path - string - Path on which this Automation runs.  Supports globs.
    #   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if params.dig(:automation) and !params.dig(:automation).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params.dig(:source) and !params.dig(:source).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params.dig(:destination) and !params.dig(:destination).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_from must be an String") if params.dig(:destination_replace_from) and !params.dig(:destination_replace_from).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_to must be an String") if params.dig(:destination_replace_to) and !params.dig(:destination_replace_to).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params.dig(:interval) and !params.dig(:interval).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params.dig(:user_ids) and !params.dig(:user_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params.dig(:group_ids) and !params.dig(:group_ids).is_a?(String)
      raise MissingParameterError.new("Parameter missing: automation") unless params.dig(:automation)

      response, options = Api.send_request("/automations", :post, params, options)
      Automation.new(response.data, options)
    end

    # Parameters:
    #   automation (required) - string - Type of automation.  One of: `create_folder`, `request_file`, `request_move`
    #   source - string - Source Path
    #   destination - string - Destination Path
    #   destination_replace_from - string - If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
    #   destination_replace_to - string - If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
    #   interval - string - How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
    #   path - string - Path on which this Automation runs.  Supports globs.
    #   user_ids - string - A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    #   group_ids - string - A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: automation must be an String") if params.dig(:automation) and !params.dig(:automation).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: source must be an String") if params.dig(:source) and !params.dig(:source).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params.dig(:destination) and !params.dig(:destination).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_from must be an String") if params.dig(:destination_replace_from) and !params.dig(:destination_replace_from).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_replace_to must be an String") if params.dig(:destination_replace_to) and !params.dig(:destination_replace_to).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interval must be an String") if params.dig(:interval) and !params.dig(:interval).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params.dig(:user_ids) and !params.dig(:user_ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: group_ids must be an String") if params.dig(:group_ids) and !params.dig(:group_ids).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: automation") unless params.dig(:automation)

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
