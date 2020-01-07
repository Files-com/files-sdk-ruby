# frozen_string_literal: true

module Files
  class Account
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Account name
    def name
      @attributes[:name]
    end

    # string - Account address
    def address
      @attributes[:address]
    end

    # string - Account address 2
    def address_2
      @attributes[:address_2]
    end

    # string - Account payment card number
    def card_number
      @attributes[:card_number]
    end

    # string - Account payment card type
    def card_type
      @attributes[:card_type]
    end

    # string - Account city
    def city
      @attributes[:city]
    end

    # string - Account company name
    def company_name
      @attributes[:company_name]
    end

    # string - Account country
    def country
      @attributes[:country]
    end

    # date-time - Account creation date/time
    def created_at
      @attributes[:created_at]
    end

    # string - Account preferred currency
    def currency
      @attributes[:currency]
    end

    # email - Account email address
    def email
      @attributes[:email]
    end

    # string - Account phone number
    def phone_number
      @attributes[:phone_number]
    end

    # string - Type of billing processor.  Can be PayPal, Credit Card, or Manual
    def processor_type
      @attributes[:processor_type]
    end

    # string - Account state
    def state
      @attributes[:state]
    end

    # date-time - Account last updated at
    def updated_at
      @attributes[:updated_at]
    end

    # string - Account zipcode
    def zip
      @attributes[:zip]
    end

    # int64 - Account billing frequency.  Either 12(yearly) or 1(monthly)
    def billing_frequency
      @attributes[:billing_frequency]
    end

    # Parameters:
    #   name - string - Internal name.
    #   company_name - string - Company name.
    #   address - string - Address line 1.
    #   address_2 - string - Address line 2.
    #   city - string - City.
    #   state - string - State.
    #   zip - string - Zipcode.
    #   country - string - Country.
    #   email - string - Email.
    #   phone_number - string - Primary phone number.
    #   card_number - string - Credit card number.
    #   card_type - string - Credit card type.  Can be visa, master, maestro, solo, switch, american_express, or discover.
    #   expiration_year - string - Expiration year(4 digits).
    #   expiration_month - string - Expiration month(2 digits).
    #   start_year - string - Required for some cards(Switch / Solo).
    #   start_month - string - Required for some cards(Switch / Solo).
    #   cvv - string - 3 digit code on the back of the card.
    #   paypal_token - string - Token for paying with paypal.
    #   paypal_payer_id - string - Paypal payer ID for paying with paypal.
    def self.update(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company_name must be an String") if params.dig(:company_name) and !params.dig(:company_name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: address must be an String") if params.dig(:address) and !params.dig(:address).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: address_2 must be an String") if params.dig(:address_2) and !params.dig(:address_2).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: city must be an String") if params.dig(:city) and !params.dig(:city).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: state must be an String") if params.dig(:state) and !params.dig(:state).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: zip must be an String") if params.dig(:zip) and !params.dig(:zip).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: country must be an String") if params.dig(:country) and !params.dig(:country).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params.dig(:email) and !params.dig(:email).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: phone_number must be an String") if params.dig(:phone_number) and !params.dig(:phone_number).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: card_number must be an String") if params.dig(:card_number) and !params.dig(:card_number).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: card_type must be an String") if params.dig(:card_type) and !params.dig(:card_type).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expiration_year must be an String") if params.dig(:expiration_year) and !params.dig(:expiration_year).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expiration_month must be an String") if params.dig(:expiration_month) and !params.dig(:expiration_month).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: start_year must be an String") if params.dig(:start_year) and !params.dig(:start_year).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: start_month must be an String") if params.dig(:start_month) and !params.dig(:start_month).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cvv must be an String") if params.dig(:cvv) and !params.dig(:cvv).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: paypal_token must be an String") if params.dig(:paypal_token) and !params.dig(:paypal_token).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: paypal_payer_id must be an String") if params.dig(:paypal_payer_id) and !params.dig(:paypal_payer_id).is_a?(String)

      response, options = Api.send_request("/account", :patch, params, options)
      Account.new(response.data, options)
    end
  end
end
