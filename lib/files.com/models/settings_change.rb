# frozen_string_literal: true

module Files
  class SettingsChange
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # array(string) - Markdown-formatted change messages.
    def changes
      @attributes[:changes]
    end

    # date-time - The time this change was made
    def created_at
      @attributes[:created_at]
    end

    # int64 - The user id responsible for this change
    def user_id
      @attributes[:user_id]
    end

    # int64 - The API key id responsible for this change
    def api_key_id
      @attributes[:api_key_id]
    end

    # boolean - true if this change was performed by Files.com support.
    def user_is_files_support
      @attributes[:user_is_files_support]
    end

    # boolean - true if this change was performed by a user on a parent site.
    def user_is_from_parent_site
      @attributes[:user_is_from_parent_site]
    end

    # string - The username of the user responsible for this change
    def username
      @attributes[:username]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`, `api_key_id` or `user_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `api_key_id` and `user_id`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(SettingsChange, params) do
        Api.send_request("/settings_changes", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`, `api_key_id` or `user_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `api_key_id` and `user_id`.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      response, options = Api.send_request("/settings_changes/create_export", :post, params, options)
      response.data.map do |entity_data|
        Export.new(entity_data, options)
      end
    end
  end
end
