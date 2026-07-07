# frozen_string_literal: true

module Files
  class InboxRegistration
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

    # int64 - Id of associated inbox
    def inbox_id
      @attributes[:inbox_id]
    end

    def inbox_id=(value)
      @attributes[:inbox_id] = value
    end

    # int64 - Id of associated inbox recipient
    def inbox_recipient_id
      @attributes[:inbox_recipient_id]
    end

    def inbox_recipient_id=(value)
      @attributes[:inbox_recipient_id] = value
    end

    # string - Title of associated inbox
    def inbox_title
      @attributes[:inbox_title]
    end

    def inbox_title=(value)
      @attributes[:inbox_title] = value
    end

    # date-time - Registration creation date/time
    def created_at
      @attributes[:created_at]
    end

    # string - Inbox URL code
    def inbox_code
      @attributes[:inbox_code]
    end

    def inbox_code=(value)
      @attributes[:inbox_code] = value
    end

    # string - Inbox recipient registration code
    def inbox_recipient_registration_code
      @attributes[:inbox_recipient_registration_code]
    end

    def inbox_recipient_registration_code=(value)
      @attributes[:inbox_recipient_registration_code] = value
    end

    # string - Inbox password
    def password
      @attributes[:password]
    end

    def password=(value)
      @attributes[:password] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The InboxRegistration object doesn't support updates.")
      else
        new_obj = InboxRegistration.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   folder_behavior_id - int64 - ID of the associated Inbox. This is required if the user is not a site admin.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: folder_behavior_id must be an Integer") if params[:folder_behavior_id] and !params[:folder_behavior_id].is_a?(Integer)

      List.new(InboxRegistration, params) do
        Api.send_request("/inbox_registrations", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   inbox_code (required) - string - Inbox URL code
    #   inbox_recipient_registration_code - string - Inbox recipient registration code
    #   password - string - Inbox password
    #   name - string - Registrant name
    #   company - string - Registrant company name
    #   email - string - Registrant email address
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: inbox_code must be an String") if params[:inbox_code] and !params[:inbox_code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: inbox_recipient_registration_code must be an String") if params[:inbox_recipient_registration_code] and !params[:inbox_recipient_registration_code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company must be an String") if params[:company] and !params[:company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise MissingParameterError.new("Parameter missing: inbox_code") unless params[:inbox_code]

      response, options = Api.send_request("/inbox_registrations", :post, params, options)
      InboxRegistration.new(response.data, options)
    end

    # Parameters:
    #   inbox_registration_code (required) - string - Inbox registration cookie code
    def self.last_activity(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: inbox_registration_code must be an String") if params[:inbox_registration_code] and !params[:inbox_registration_code].is_a?(String)
      raise MissingParameterError.new("Parameter missing: inbox_registration_code") unless params[:inbox_registration_code]

      Api.send_request("/inbox_registrations/last_activity", :post, params, options)
      nil
    end

    # Parameters:
    #   folder_behavior_id - int64 - ID of the associated Inbox. This is required if the user is not a site admin.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: folder_behavior_id must be an Integer") if params[:folder_behavior_id] and !params[:folder_behavior_id].is_a?(Integer)

      response, options = Api.send_request("/inbox_registrations/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
