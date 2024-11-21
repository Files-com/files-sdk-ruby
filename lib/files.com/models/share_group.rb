# frozen_string_literal: true

module Files
  class ShareGroup
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Share Group ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Name of the share group
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Additional notes of the share group
    def notes
      @attributes[:notes]
    end

    def notes=(value)
      @attributes[:notes] = value
    end

    # int64 - Owner User ID
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # array(object) - A list of share group members
    def members
      @attributes[:members]
    end

    def members=(value)
      @attributes[:members] = value
    end

    # Parameters:
    #   notes - string - Additional notes of the share group
    #   name - string - Name of the share group
    #   members - array(object) - A list of share group members.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params[:notes] and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: members must be an Array") if params[:members] and !params[:members].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/share_groups/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/share_groups/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = ShareGroup.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(ShareGroup, params) do
        Api.send_request("/share_groups", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Share Group ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/share_groups/#{params[:id]}", :get, params, options)
      ShareGroup.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   notes - string - Additional notes of the share group
    #   name (required) - string - Name of the share group
    #   members (required) - array(object) - A list of share group members.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params[:notes] and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: members must be an Array") if params[:members] and !params[:members].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]
      raise MissingParameterError.new("Parameter missing: members") unless params[:members]

      response, options = Api.send_request("/share_groups", :post, params, options)
      ShareGroup.new(response.data, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)

      response, options = Api.send_request("/share_groups/create_export", :post, params, options)
      response.data.map do |entity_data|
        Export.new(entity_data, options)
      end
    end

    # Parameters:
    #   notes - string - Additional notes of the share group
    #   name - string - Name of the share group
    #   members - array(object) - A list of share group members.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params[:notes] and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: members must be an Array") if params[:members] and !params[:members].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/share_groups/#{params[:id]}", :patch, params, options)
      ShareGroup.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/share_groups/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
