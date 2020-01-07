# frozen_string_literal: true

module Files
  class PaypalExpressInfo
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # email - Paypal billing email
    def billing_email
      @attributes[:billing_email]
    end

    # string - Paypal billing company name
    def billing_company_name
      @attributes[:billing_company_name]
    end

    # string - Paypal billing address
    def billing_address
      @attributes[:billing_address]
    end

    # string - Paypal billing address 2
    def billing_address_2
      @attributes[:billing_address_2]
    end

    # string - Paypal billing city
    def billing_city
      @attributes[:billing_city]
    end

    # string - Paypal billing state
    def billing_state
      @attributes[:billing_state]
    end

    # string - Paypal billing country
    def billing_country
      @attributes[:billing_country]
    end

    # string - Paypal billing zipcode
    def billing_zip
      @attributes[:billing_zip]
    end

    # string - Paypal billing name
    def billing_name
      @attributes[:billing_name]
    end

    # string - Paypal billing phone
    def billing_phone
      @attributes[:billing_phone]
    end

    # int64 - Paypal payer ID
    def paypal_payer_id
      @attributes[:paypal_payer_id]
    end
  end
end
