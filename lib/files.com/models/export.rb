# frozen_string_literal: true

module Files
  class Export
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - ID for this Export
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Status of the Export
    def export_status
      @attributes[:export_status]
    end

    def export_status=(value)
      @attributes[:export_status] = value
    end

    # string - Type of data being exported
    def export_type
      @attributes[:export_type]
    end

    def export_type=(value)
      @attributes[:export_type] = value
    end

    # int64 - Number of rows exported
    def export_rows
      @attributes[:export_rows]
    end

    def export_rows=(value)
      @attributes[:export_rows] = value
    end

    # string - Link to download Export file.
    def download_uri
      @attributes[:download_uri]
    end

    def download_uri=(value)
      @attributes[:download_uri] = value
    end

    # string - Export message
    def message
      @attributes[:message]
    end

    def message=(value)
      @attributes[:message] = value
    end

    # int64 - User ID.  Provide a value of `0` to operate the current session's user.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `export_status` and `export_type`.
    def sort_by
      @attributes[:sort_by]
    end

    def sort_by=(value)
      @attributes[:sort_by] = value
    end

    # object - If set, return records where the specified field is equal to the supplied value. Valid fields are `export_status` and `export_type`.
    def filter
      @attributes[:filter]
    end

    def filter=(value)
      @attributes[:filter] = value
    end

    # object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `export_type`.
    def filter_prefix
      @attributes[:filter_prefix]
    end

    def filter_prefix=(value)
      @attributes[:filter_prefix] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The Export object doesn't support updates.")
      else
        new_obj = Export.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `export_status` and `export_type`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `export_status` and `export_type`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `export_type`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

      List.new(Export, params) do
        Api.send_request("/exports", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Export ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/exports/#{params[:id]}", :get, params, options)
      Export.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `export_status` and `export_type`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `export_status` and `export_type`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `export_type`.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

      response, options = Api.send_request("/exports/create_export", :post, params, options)
      response.data.map do |entity_data|
        Export.new(entity_data, options)
      end
    end
  end
end
