# frozen_string_literal: true

module Files
  class Project
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Project ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Global access settings
    def global_access
      @attributes[:global_access]
    end

    def global_access=(value)
      @attributes[:global_access] = value
    end

    # Parameters:
    #   global_access (required) - string - Global permissions.  Can be: `none`, `anyone_with_read`, `anyone_with_full`.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: global_access must be an String") if params[:global_access] and !params[:global_access].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: global_access") unless params[:global_access]

      Api.send_request("/projects/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/projects/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = Project.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(Project, params) do
        Api.send_request("/projects", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Project ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/projects/#{params[:id]}", :get, params, options)
      Project.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   global_access (required) - string - Global permissions.  Can be: `none`, `anyone_with_read`, `anyone_with_full`.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: global_access must be an String") if params[:global_access] and !params[:global_access].is_a?(String)
      raise MissingParameterError.new("Parameter missing: global_access") unless params[:global_access]

      response, options = Api.send_request("/projects", :post, params, options)
      Project.new(response.data, options)
    end

    def self.create_export(params = {}, options = {})
      response, options = Api.send_request("/projects/create_export", :post, params, options)
      response.data.map do |entity_data|
        Export.new(entity_data, options)
      end
    end

    # Parameters:
    #   global_access (required) - string - Global permissions.  Can be: `none`, `anyone_with_read`, `anyone_with_full`.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: global_access must be an String") if params[:global_access] and !params[:global_access].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: global_access") unless params[:global_access]

      response, options = Api.send_request("/projects/#{params[:id]}", :patch, params, options)
      Project.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/projects/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
