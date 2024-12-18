# frozen_string_literal: true

module Files
  class Clickwrap
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Clickwrap ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Name of the Clickwrap agreement (used when selecting from multiple Clickwrap agreements.)
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Body text of Clickwrap (supports Markdown formatting).
    def body
      @attributes[:body]
    end

    def body=(value)
      @attributes[:body] = value
    end

    # string - Use this Clickwrap for User Registrations?  Note: This only applies to User Registrations where the User is invited to your Files.com site using an E-Mail invitation process where they then set their own password.
    def use_with_users
      @attributes[:use_with_users]
    end

    def use_with_users=(value)
      @attributes[:use_with_users] = value
    end

    # string - Use this Clickwrap for Bundles?
    def use_with_bundles
      @attributes[:use_with_bundles]
    end

    def use_with_bundles=(value)
      @attributes[:use_with_bundles] = value
    end

    # string - Use this Clickwrap for Inboxes?
    def use_with_inboxes
      @attributes[:use_with_inboxes]
    end

    def use_with_inboxes=(value)
      @attributes[:use_with_inboxes] = value
    end

    # Parameters:
    #   name - string - Name of the Clickwrap agreement (used when selecting from multiple Clickwrap agreements.)
    #   body - string - Body text of Clickwrap (supports Markdown formatting).
    #   use_with_bundles - string - Use this Clickwrap for Bundles?
    #   use_with_inboxes - string - Use this Clickwrap for Inboxes?
    #   use_with_users - string - Use this Clickwrap for User Registrations?  Note: This only applies to User Registrations where the User is invited to your Files.com site using an E-Mail invitation process where they then set their own password.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if params[:body] and !params[:body].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_bundles must be an String") if params[:use_with_bundles] and !params[:use_with_bundles].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_inboxes must be an String") if params[:use_with_inboxes] and !params[:use_with_inboxes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_users must be an String") if params[:use_with_users] and !params[:use_with_users].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/clickwraps/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/clickwraps/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = Clickwrap.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)

      List.new(Clickwrap, params) do
        Api.send_request("/clickwraps", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Clickwrap ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/clickwraps/#{params[:id]}", :get, params, options)
      Clickwrap.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name - string - Name of the Clickwrap agreement (used when selecting from multiple Clickwrap agreements.)
    #   body - string - Body text of Clickwrap (supports Markdown formatting).
    #   use_with_bundles - string - Use this Clickwrap for Bundles?
    #   use_with_inboxes - string - Use this Clickwrap for Inboxes?
    #   use_with_users - string - Use this Clickwrap for User Registrations?  Note: This only applies to User Registrations where the User is invited to your Files.com site using an E-Mail invitation process where they then set their own password.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if params[:body] and !params[:body].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_bundles must be an String") if params[:use_with_bundles] and !params[:use_with_bundles].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_inboxes must be an String") if params[:use_with_inboxes] and !params[:use_with_inboxes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_users must be an String") if params[:use_with_users] and !params[:use_with_users].is_a?(String)

      response, options = Api.send_request("/clickwraps", :post, params, options)
      Clickwrap.new(response.data, options)
    end

    # Parameters:
    #   name - string - Name of the Clickwrap agreement (used when selecting from multiple Clickwrap agreements.)
    #   body - string - Body text of Clickwrap (supports Markdown formatting).
    #   use_with_bundles - string - Use this Clickwrap for Bundles?
    #   use_with_inboxes - string - Use this Clickwrap for Inboxes?
    #   use_with_users - string - Use this Clickwrap for User Registrations?  Note: This only applies to User Registrations where the User is invited to your Files.com site using an E-Mail invitation process where they then set their own password.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if params[:body] and !params[:body].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_bundles must be an String") if params[:use_with_bundles] and !params[:use_with_bundles].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_inboxes must be an String") if params[:use_with_inboxes] and !params[:use_with_inboxes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_users must be an String") if params[:use_with_users] and !params[:use_with_users].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/clickwraps/#{params[:id]}", :patch, params, options)
      Clickwrap.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/clickwraps/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
