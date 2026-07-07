# frozen_string_literal: true

module Files
  class InboxRecipientRegistration
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - The inbox recipient registration code. Use this to register for the inbox.
    def code
      @attributes[:code]
    end

    def code=(value)
      @attributes[:code] = value
    end

    # string - If the recipient has already registered for this inbox, this is their registration code to get the inbox contents.
    def inbox_registration_code
      @attributes[:inbox_registration_code]
    end

    def inbox_registration_code=(value)
      @attributes[:inbox_registration_code] = value
    end

    # string - The recipient's email address.
    def recipient
      @attributes[:recipient]
    end

    def recipient=(value)
      @attributes[:recipient] = value
    end

    # string - The recipient's name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - The recipient's company.
    def company
      @attributes[:company]
    end

    def company=(value)
      @attributes[:company] = value
    end

    # string - Inbox recipient code
    def inbox_recipient_code
      @attributes[:inbox_recipient_code]
    end

    def inbox_recipient_code=(value)
      @attributes[:inbox_recipient_code] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The InboxRecipientRegistration object doesn't support updates.")
      else
        new_obj = InboxRecipientRegistration.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   inbox_recipient_code (required) - string - Inbox recipient code
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: inbox_recipient_code must be an String") if params[:inbox_recipient_code] and !params[:inbox_recipient_code].is_a?(String)
      raise MissingParameterError.new("Parameter missing: inbox_recipient_code") unless params[:inbox_recipient_code]

      response, options = Api.send_request("/inbox_recipient_registrations", :post, params, options)
      InboxRecipientRegistration.new(response.data, options)
    end
  end
end
