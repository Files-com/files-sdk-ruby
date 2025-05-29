# frozen_string_literal: true

module Files
  class FormFieldSet
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Form field set id
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Title to be displayed
    def title
      @attributes[:title]
    end

    def title=(value)
      @attributes[:title] = value
    end

    # array(int64) - Layout of the form
    def form_layout
      @attributes[:form_layout]
    end

    def form_layout=(value)
      @attributes[:form_layout] = value
    end

    # array(object) - Associated form fields
    def form_fields
      @attributes[:form_fields]
    end

    def form_fields=(value)
      @attributes[:form_fields] = value
    end

    # boolean - Any associated InboxRegistrations or BundleRegistrations can be saved without providing name
    def skip_name
      @attributes[:skip_name]
    end

    def skip_name=(value)
      @attributes[:skip_name] = value
    end

    # boolean - Any associated InboxRegistrations or BundleRegistrations can be saved without providing email
    def skip_email
      @attributes[:skip_email]
    end

    def skip_email=(value)
      @attributes[:skip_email] = value
    end

    # boolean - Any associated InboxRegistrations or BundleRegistrations can be saved without providing company
    def skip_company
      @attributes[:skip_company]
    end

    def skip_company=(value)
      @attributes[:skip_company] = value
    end

    # boolean - Form Field Set is in use by an active Inbox / Bundle / Inbox Registration / Bundle Registration
    def in_use
      @attributes[:in_use]
    end

    def in_use=(value)
      @attributes[:in_use] = value
    end

    # int64 - User ID.  Provide a value of `0` to operate the current session's user.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # Parameters:
    #   title - string - Title to be displayed
    #   skip_email - boolean - Skip validating form email
    #   skip_name - boolean - Skip validating form name
    #   skip_company - boolean - Skip validating company
    #   form_fields - array(object)
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: title must be an String") if params[:title] and !params[:title].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: form_fields must be an Array") if params[:form_fields] and !params[:form_fields].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/form_field_sets/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/form_field_sets/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = FormFieldSet.create(@attributes, @options)
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

      List.new(FormFieldSet, params) do
        Api.send_request("/form_field_sets", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Form Field Set ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/form_field_sets/#{params[:id]}", :get, params, options)
      FormFieldSet.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   title - string - Title to be displayed
    #   skip_email - boolean - Skip validating form email
    #   skip_name - boolean - Skip validating form name
    #   skip_company - boolean - Skip validating company
    #   form_fields - array(object)
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: title must be an String") if params[:title] and !params[:title].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: form_fields must be an Array") if params[:form_fields] and !params[:form_fields].is_a?(Array)

      response, options = Api.send_request("/form_field_sets", :post, params, options)
      FormFieldSet.new(response.data, options)
    end

    # Parameters:
    #   title - string - Title to be displayed
    #   skip_email - boolean - Skip validating form email
    #   skip_name - boolean - Skip validating form name
    #   skip_company - boolean - Skip validating company
    #   form_fields - array(object)
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: title must be an String") if params[:title] and !params[:title].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: form_fields must be an Array") if params[:form_fields] and !params[:form_fields].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/form_field_sets/#{params[:id]}", :patch, params, options)
      FormFieldSet.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/form_field_sets/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
