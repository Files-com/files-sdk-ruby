# frozen_string_literal: true

module Files
  class BundleRegistration
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Registration cookie code
    def code
      @attributes[:code]
    end

    def code=(value)
      @attributes[:code] = value
    end

    # string - Registrant name
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Registrant company name
    def company
      @attributes[:company]
    end

    def company=(value)
      @attributes[:company] = value
    end

    # string - Registrant email address
    def email
      @attributes[:email]
    end

    def email=(value)
      @attributes[:email] = value
    end

    # string - Registrant IP Address
    def ip
      @attributes[:ip]
    end

    def ip=(value)
      @attributes[:ip] = value
    end

    # string - InboxRegistration cookie code, if there is an associated InboxRegistration
    def inbox_code
      @attributes[:inbox_code]
    end

    def inbox_code=(value)
      @attributes[:inbox_code] = value
    end

    # string - Clickwrap text that was shown to the registrant
    def clickwrap_body
      @attributes[:clickwrap_body]
    end

    def clickwrap_body=(value)
      @attributes[:clickwrap_body] = value
    end

    # int64 - Id of associated form field set
    def form_field_set_id
      @attributes[:form_field_set_id]
    end

    def form_field_set_id=(value)
      @attributes[:form_field_set_id] = value
    end

    # object - Data for form field set with form field ids as keys and user data as values
    def form_field_data
      @attributes[:form_field_data]
    end

    def form_field_data=(value)
      @attributes[:form_field_data] = value
    end

    # string - Bundle URL code
    def bundle_code
      @attributes[:bundle_code]
    end

    def bundle_code=(value)
      @attributes[:bundle_code] = value
    end

    # int64 - Id of associated bundle
    def bundle_id
      @attributes[:bundle_id]
    end

    def bundle_id=(value)
      @attributes[:bundle_id] = value
    end

    # int64 - Id of associated bundle recipient
    def bundle_recipient_id
      @attributes[:bundle_recipient_id]
    end

    def bundle_recipient_id=(value)
      @attributes[:bundle_recipient_id] = value
    end

    # int64 - Workspace ID. `0` means the default workspace.
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # date-time - Registration creation date/time
    def created_at
      @attributes[:created_at]
    end

    # string - Bundle recipient registration code
    def bundle_recipient_registration_code
      @attributes[:bundle_recipient_registration_code]
    end

    def bundle_recipient_registration_code=(value)
      @attributes[:bundle_recipient_registration_code] = value
    end

    # string - Public bundle password.
    def password
      @attributes[:password]
    end

    def password=(value)
      @attributes[:password] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The BundleRegistration object doesn't support updates.")
      else
        new_obj = BundleRegistration.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `bundle_id` or `created_at`.
    #   bundle_id - int64 - ID of the associated Bundle
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: bundle_id must be an Integer") if params[:bundle_id] and !params[:bundle_id].is_a?(Integer)

      List.new(BundleRegistration, params) do
        Api.send_request("/bundle_registrations", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   bundle_recipient_registration_code - string - Bundle recipient registration code
    #   password - string - Public bundle password.
    #   company - string - Registrant company name
    #   email - string - Registrant email address
    #   name - string - Registrant name
    #   bundle_code (required) - string - Bundle URL code
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: bundle_recipient_registration_code must be an String") if params[:bundle_recipient_registration_code] and !params[:bundle_recipient_registration_code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company must be an String") if params[:company] and !params[:company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bundle_code must be an String") if params[:bundle_code] and !params[:bundle_code].is_a?(String)
      raise MissingParameterError.new("Parameter missing: bundle_code") unless params[:bundle_code]

      response, options = Api.send_request("/bundle_registrations", :post, params, options)
      BundleRegistration.new(response.data, options)
    end

    # Parameters:
    #   bundle_registration_code (required) - string - Bundle registration cookie code
    #   upload_in_progress - boolean - Flag that indicates if current upload is going during this registration session
    def self.last_activity(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: bundle_registration_code must be an String") if params[:bundle_registration_code] and !params[:bundle_registration_code].is_a?(String)
      raise MissingParameterError.new("Parameter missing: bundle_registration_code") unless params[:bundle_registration_code]

      Api.send_request("/bundle_registrations/last_activity", :post, params, options)
      nil
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `bundle_id` or `created_at`.
    #   bundle_id - int64 - ID of the associated Bundle
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: bundle_id must be an Integer") if params[:bundle_id] and !params[:bundle_id].is_a?(Integer)

      response, options = Api.send_request("/bundle_registrations/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
