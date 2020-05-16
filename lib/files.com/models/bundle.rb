# frozen_string_literal: true

module Files
  class Bundle
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Bundle ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Bundle code.  This code forms the end part of the Public URL.
    def code
      @attributes[:code]
    end

    def code=(value)
      @attributes[:code] = value
    end

    # date-time - Bundle created at date/time
    def created_at
      @attributes[:created_at]
    end

    # string - Public description
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # date-time - Bundle expiration date/time
    def expires_at
      @attributes[:expires_at]
    end

    def expires_at=(value)
      @attributes[:expires_at] = value
    end

    # array - A list of paths in this bundle
    def paths
      @attributes[:paths]
    end

    def paths=(value)
      @attributes[:paths] = value
    end

    # string - Bundle internal note
    def note
      @attributes[:note]
    end

    def note=(value)
      @attributes[:note] = value
    end

    # boolean - Is this bundle password protected?
    def password_protected
      @attributes[:password_protected]
    end

    def password_protected=(value)
      @attributes[:password_protected] = value
    end

    # string - Public URL of Share Link
    def url
      @attributes[:url]
    end

    def url=(value)
      @attributes[:url] = value
    end

    # int64 - Bundle creator user ID
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # string - Bundle creator username
    def username
      @attributes[:username]
    end

    def username=(value)
      @attributes[:username] = value
    end

    # string - Password for this bundle.
    def password
      @attributes[:password]
    end

    def password=(value)
      @attributes[:password] = value
    end

    # Send email(s) with a link to bundle
    #
    # Parameters:
    #   to (required) - array - A list of email addresses to share this bundle with.
    #   note - string - Note to include in email.
    def share(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: to must be an Array") if params.dig(:to) and !params.dig(:to).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params.dig(:note) and !params.dig(:note).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: to") unless params.dig(:to)

      Api.send_request("/bundles/#{@attributes[:id]}/share", :post, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/bundles/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The Bundle object doesn't support updates.")
      else
        new_obj = Bundle.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/bundles", :get, params, options)
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - integer - Bundle ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/bundles/#{params[:id]}", :get, params, options)
      Bundle.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
    #   paths (required) - array - A list of paths to include in this bundle.
    #   password - string - Password for this bundle.
    #   expires_at - string - Bundle expiration date/time.
    #   description - string - Bundle public description
    #   note - string - Bundle internal note
    #   code - string - Bundle name
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if params.dig(:paths) and !params.dig(:paths).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params.dig(:password) and !params.dig(:password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params.dig(:expires_at) and !params.dig(:expires_at).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params.dig(:description) and !params.dig(:description).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params.dig(:note) and !params.dig(:note).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: code must be an String") if params.dig(:code) and !params.dig(:code).is_a?(String)
      raise MissingParameterError.new("Parameter missing: paths") unless params.dig(:paths)

      response, options = Api.send_request("/bundles", :post, params, options)
      Bundle.new(response.data, options)
    end

    # Send email(s) with a link to bundle
    #
    # Parameters:
    #   to (required) - array - A list of email addresses to share this bundle with.
    #   note - string - Note to include in email.
    def self.share(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: to must be an Array") if params.dig(:to) and !params.dig(:to).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params.dig(:note) and !params.dig(:note).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)
      raise MissingParameterError.new("Parameter missing: to") unless params.dig(:to)

      response, _options = Api.send_request("/bundles/#{params[:id]}/share", :post, params, options)
      response.data
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/bundles/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
