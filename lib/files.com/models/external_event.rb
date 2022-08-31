# frozen_string_literal: true

module Files
  class ExternalEvent
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Event ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Type of event being recorded.
    def event_type
      @attributes[:event_type]
    end

    def event_type=(value)
      @attributes[:event_type] = value
    end

    # string - Status of event.
    def status
      @attributes[:status]
    end

    def status=(value)
      @attributes[:status] = value
    end

    # string - Event body
    def body
      @attributes[:body]
    end

    def body=(value)
      @attributes[:body] = value
    end

    # date-time - External event create date/time
    def created_at
      @attributes[:created_at]
    end

    # string - Link to log file.
    def body_url
      @attributes[:body_url]
    end

    def body_url=(value)
      @attributes[:body_url] = value
    end

    # int64 - Folder Behavior ID
    def folder_behavior_id
      @attributes[:folder_behavior_id]
    end

    def folder_behavior_id=(value)
      @attributes[:folder_behavior_id] = value
    end

    # int64 - For sync events, the number of files handled successfully.
    def successful_files
      @attributes[:successful_files]
    end

    def successful_files=(value)
      @attributes[:successful_files] = value
    end

    # int64 - For sync events, the number of files that encountered errors.
    def errored_files
      @attributes[:errored_files]
    end

    def errored_files=(value)
      @attributes[:errored_files] = value
    end

    # int64 - For sync events, the total number of bytes synced.
    def bytes_synced
      @attributes[:bytes_synced]
    end

    def bytes_synced=(value)
      @attributes[:bytes_synced] = value
    end

    # string - Associated Remote Server type, if any
    def remote_server_type
      @attributes[:remote_server_type]
    end

    def remote_server_type=(value)
      @attributes[:remote_server_type] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The ExternalEvent object doesn't support updates.")
      else
        new_obj = ExternalEvent.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `remote_server_type`, `site_id`, `folder_behavior_id`, `event_type`, `created_at` or `status`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at`, `event_type`, `remote_server_type`, `status` or `folder_behavior_id`. Valid field combinations are `[ event_type, status, created_at ]`, `[ event_type, created_at ]` or `[ status, created_at ]`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at`, `event_type`, `remote_server_type`, `status` or `folder_behavior_id`. Valid field combinations are `[ event_type, status, created_at ]`, `[ event_type, created_at ]` or `[ status, created_at ]`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal to the supplied value. Valid fields are `created_at`, `event_type`, `remote_server_type`, `status` or `folder_behavior_id`. Valid field combinations are `[ event_type, status, created_at ]`, `[ event_type, created_at ]` or `[ status, created_at ]`.
    #   filter_like - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at`, `event_type`, `remote_server_type`, `status` or `folder_behavior_id`. Valid field combinations are `[ event_type, status, created_at ]`, `[ event_type, created_at ]` or `[ status, created_at ]`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `created_at`, `event_type`, `remote_server_type`, `status` or `folder_behavior_id`. Valid field combinations are `[ event_type, status, created_at ]`, `[ event_type, created_at ]` or `[ status, created_at ]`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal to the supplied value. Valid fields are `created_at`, `event_type`, `remote_server_type`, `status` or `folder_behavior_id`. Valid field combinations are `[ event_type, status, created_at ]`, `[ event_type, created_at ]` or `[ status, created_at ]`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params[:filter_like] and !params[:filter_like].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)

      List.new(ExternalEvent, params) do
        Api.send_request("/external_events", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - External Event ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/external_events/#{params[:id]}", :get, params, options)
      ExternalEvent.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   status (required) - string - Status of event.
    #   body (required) - string - Event body
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: status must be an String") if params[:status] and !params[:status].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if params[:body] and !params[:body].is_a?(String)
      raise MissingParameterError.new("Parameter missing: status") unless params[:status]
      raise MissingParameterError.new("Parameter missing: body") unless params[:body]

      response, options = Api.send_request("/external_events", :post, params, options)
      ExternalEvent.new(response.data, options)
    end
  end
end
