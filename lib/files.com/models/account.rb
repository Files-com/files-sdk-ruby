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

    def name=(value)
      @attributes[:name] = value
    end

    # string - Account address
    def address
      @attributes[:address]
    end

    def address=(value)
      @attributes[:address] = value
    end

    # string - Account address 2
    def address_2
      @attributes[:address_2]
    end

    def address_2=(value)
      @attributes[:address_2] = value
    end

    # string - Account payment card number
    def card_number
      @attributes[:card_number]
    end

    def card_number=(value)
      @attributes[:card_number] = value
    end

    # string - Account payment card type
    def card_type
      @attributes[:card_type]
    end

    def card_type=(value)
      @attributes[:card_type] = value
    end

    # string - Account city
    def city
      @attributes[:city]
    end

    def city=(value)
      @attributes[:city] = value
    end

    # string - Account company name
    def company_name
      @attributes[:company_name]
    end

    def company_name=(value)
      @attributes[:company_name] = value
    end

    # string - Account country
    def country
      @attributes[:country]
    end

    def country=(value)
      @attributes[:country] = value
    end

    # date-time - Account creation date/time
    def created_at
      @attributes[:created_at]
    end

    # string - Account preferred currency
    def currency
      @attributes[:currency]
    end

    def currency=(value)
      @attributes[:currency] = value
    end

    # email - Account email address
    def email
      @attributes[:email]
    end

    def email=(value)
      @attributes[:email] = value
    end

    # string - Account phone number
    def phone_number
      @attributes[:phone_number]
    end

    def phone_number=(value)
      @attributes[:phone_number] = value
    end

    # string - Type of billing processor.  Can be PayPal, Credit Card, or Manual
    def processor_type
      @attributes[:processor_type]
    end

    def processor_type=(value)
      @attributes[:processor_type] = value
    end

    # string - Account state
    def state
      @attributes[:state]
    end

    def state=(value)
      @attributes[:state] = value
    end

    # string - Account zipcode
    def zip
      @attributes[:zip]
    end

    def zip=(value)
      @attributes[:zip] = value
    end

    # int64 - Number of usage periods billed at once.  This value will either be 12 representing an annual account of 12 usage periods or 1 representing a monthly account.
    def billing_frequency
      @attributes[:billing_frequency]
    end

    def billing_frequency=(value)
      @attributes[:billing_frequency] = value
    end

    # string - Expiration year(4 digits).
    def expiration_year
      @attributes[:expiration_year]
    end

    def expiration_year=(value)
      @attributes[:expiration_year] = value
    end

    # string - Expiration month(2 digits).
    def expiration_month
      @attributes[:expiration_month]
    end

    def expiration_month=(value)
      @attributes[:expiration_month] = value
    end

    # string - Required for some cards(Switch / Solo).
    def start_year
      @attributes[:start_year]
    end

    def start_year=(value)
      @attributes[:start_year] = value
    end

    # string - Required for some cards(Switch / Solo).
    def start_month
      @attributes[:start_month]
    end

    def start_month=(value)
      @attributes[:start_month] = value
    end

    # string - 3 digit code on the back of the card.
    def cvv
      @attributes[:cvv]
    end

    def cvv=(value)
      @attributes[:cvv] = value
    end

    # string - Token for paying with paypal.
    def paypal_token
      @attributes[:paypal_token]
    end

    def paypal_token=(value)
      @attributes[:paypal_token] = value
    end

    # string - Paypal payer ID for paying with paypal.
    def paypal_payer_id
      @attributes[:paypal_payer_id]
    end

    def paypal_payer_id=(value)
      @attributes[:paypal_payer_id] = value
    end

    # int64 - Plan ID to switch to immediately.
    def plan_id
      @attributes[:plan_id]
    end

    def plan_id=(value)
      @attributes[:plan_id] = value
    end

    # boolean - Create account without immediately charging the customer.  (i.e. let the trial complete first.)
    def create_account
      @attributes[:create_account]
    end

    def create_account=(value)
      @attributes[:create_account] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The Account object doesn't support updates.")
      else
        new_obj = Account.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    def self.get(params = {}, options = {})
      response, options = Api.send_request("/account", :get, params, options)
      Account.new(response.data, options)
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
    #   plan_id - int64 - Plan ID to switch to immediately.
    #   billing_frequency - int64 - The billing frequency, in months, for the site.  Must be 1 (monthly) or 12 (annual).
    #   currency - string - Preferred currency for this account.
    #   create_account - boolean - Create account without immediately charging the customer.  (i.e. let the trial complete first.)
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company_name must be an String") if params[:company_name] and !params[:company_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: address must be an String") if params[:address] and !params[:address].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: address_2 must be an String") if params[:address_2] and !params[:address_2].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: city must be an String") if params[:city] and !params[:city].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: state must be an String") if params[:state] and !params[:state].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: zip must be an String") if params[:zip] and !params[:zip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: country must be an String") if params[:country] and !params[:country].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: phone_number must be an String") if params[:phone_number] and !params[:phone_number].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: card_number must be an String") if params[:card_number] and !params[:card_number].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: card_type must be an String") if params[:card_type] and !params[:card_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expiration_year must be an String") if params[:expiration_year] and !params[:expiration_year].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expiration_month must be an String") if params[:expiration_month] and !params[:expiration_month].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: start_year must be an String") if params[:start_year] and !params[:start_year].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: start_month must be an String") if params[:start_month] and !params[:start_month].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cvv must be an String") if params[:cvv] and !params[:cvv].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: paypal_token must be an String") if params[:paypal_token] and !params[:paypal_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: paypal_payer_id must be an String") if params[:paypal_payer_id] and !params[:paypal_payer_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: plan_id must be an Integer") if params[:plan_id] and !params[:plan_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: billing_frequency must be an Integer") if params[:billing_frequency] and !params[:billing_frequency].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: currency must be an String") if params[:currency] and !params[:currency].is_a?(String)

      response, options = Api.send_request("/account", :post, params, options)
      Account.new(response.data, options)
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
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company_name must be an String") if params[:company_name] and !params[:company_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: address must be an String") if params[:address] and !params[:address].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: address_2 must be an String") if params[:address_2] and !params[:address_2].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: city must be an String") if params[:city] and !params[:city].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: state must be an String") if params[:state] and !params[:state].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: zip must be an String") if params[:zip] and !params[:zip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: country must be an String") if params[:country] and !params[:country].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: phone_number must be an String") if params[:phone_number] and !params[:phone_number].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: card_number must be an String") if params[:card_number] and !params[:card_number].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: card_type must be an String") if params[:card_type] and !params[:card_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expiration_year must be an String") if params[:expiration_year] and !params[:expiration_year].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expiration_month must be an String") if params[:expiration_month] and !params[:expiration_month].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: start_year must be an String") if params[:start_year] and !params[:start_year].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: start_month must be an String") if params[:start_month] and !params[:start_month].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cvv must be an String") if params[:cvv] and !params[:cvv].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: paypal_token must be an String") if params[:paypal_token] and !params[:paypal_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: paypal_payer_id must be an String") if params[:paypal_payer_id] and !params[:paypal_payer_id].is_a?(String)

      response, options = Api.send_request("/account", :patch, params, options)
      Account.new(response.data, options)
    end
  end
end
