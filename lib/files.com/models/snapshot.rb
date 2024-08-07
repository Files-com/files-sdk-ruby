# frozen_string_literal: true

module Files
  class Snapshot
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - The snapshot's unique ID.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # date-time - When the snapshot expires.
    def expires_at
      @attributes[:expires_at]
    end

    def expires_at=(value)
      @attributes[:expires_at] = value
    end

    # date-time - When the snapshot was finalized.
    def finalized_at
      @attributes[:finalized_at]
    end

    def finalized_at=(value)
      @attributes[:finalized_at] = value
    end

    # string - A name for the snapshot.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # int64 - The user that created this snapshot, if applicable.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # int64 - The bundle using this snapshot, if applicable.
    def bundle_id
      @attributes[:bundle_id]
    end

    def bundle_id=(value)
      @attributes[:bundle_id] = value
    end

    # array(string) - An array of paths to add to the snapshot.
    def paths
      @attributes[:paths]
    end

    def paths=(value)
      @attributes[:paths] = value
    end

    # Finalize Snapshot
    def finalize(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/snapshots/#{@attributes[:id]}/finalize", :post, params, @options)
    end

    # Parameters:
    #   expires_at - string - When the snapshot expires.
    #   name - string - A name for the snapshot.
    #   paths - array(string) - An array of paths to add to the snapshot.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params[:expires_at] and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if params[:paths] and !params[:paths].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/snapshots/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/snapshots/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = Snapshot.create(@attributes, @options)
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

      List.new(Snapshot, params) do
        Api.send_request("/snapshots", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Snapshot ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/snapshots/#{params[:id]}", :get, params, options)
      Snapshot.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   expires_at - string - When the snapshot expires.
    #   name - string - A name for the snapshot.
    #   paths - array(string) - An array of paths to add to the snapshot.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params[:expires_at] and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if params[:paths] and !params[:paths].is_a?(Array)

      response, options = Api.send_request("/snapshots", :post, params, options)
      Snapshot.new(response.data, options)
    end

    # Finalize Snapshot
    def self.finalize(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/snapshots/#{params[:id]}/finalize", :post, params, options)
      nil
    end

    # Parameters:
    #   expires_at - string - When the snapshot expires.
    #   name - string - A name for the snapshot.
    #   paths - array(string) - An array of paths to add to the snapshot.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params[:expires_at] and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if params[:paths] and !params[:paths].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/snapshots/#{params[:id]}", :patch, params, options)
      Snapshot.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/snapshots/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
