# frozen_string_literal: true

module Files
  class BundleRecipientRegistration
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - The bundle recipient registration code. Use this to register for the bundle.
    def code
      @attributes[:code]
    end

    def code=(value)
      @attributes[:code] = value
    end

    # string - If the recipient has already registered for this bundle, this is their registration code to get the bundle contents.
    def bundle_registration_code
      @attributes[:bundle_registration_code]
    end

    def bundle_registration_code=(value)
      @attributes[:bundle_registration_code] = value
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

    # boolean - Whether a one-time password was emailed to the recipient.
    def password_emailed
      @attributes[:password_emailed]
    end

    def password_emailed=(value)
      @attributes[:password_emailed] = value
    end

    # string - InboxRegistration cookie code, if there is an associated InboxRegistration
    def inbox_code
      @attributes[:inbox_code]
    end

    def inbox_code=(value)
      @attributes[:inbox_code] = value
    end

    # string - Bundle recipient code
    def bundle_recipient_code
      @attributes[:bundle_recipient_code]
    end

    def bundle_recipient_code=(value)
      @attributes[:bundle_recipient_code] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The BundleRecipientRegistration object doesn't support updates.")
      else
        new_obj = BundleRecipientRegistration.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   bundle_recipient_code (required) - string - Bundle recipient code
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: bundle_recipient_code must be an String") if params[:bundle_recipient_code] and !params[:bundle_recipient_code].is_a?(String)
      raise MissingParameterError.new("Parameter missing: bundle_recipient_code") unless params[:bundle_recipient_code]

      response, options = Api.send_request("/bundle_recipient_registrations", :post, params, options)
      BundleRecipientRegistration.new(response.data, options)
    end
  end
end
