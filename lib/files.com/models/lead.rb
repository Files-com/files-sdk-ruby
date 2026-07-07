# frozen_string_literal: true

module Files
  class Lead
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Lead ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Lead Cookie Code
    def code
      @attributes[:code]
    end

    def code=(value)
      @attributes[:code] = value
    end

    # string - Lead name
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Lead address
    def address
      @attributes[:address]
    end

    def address=(value)
      @attributes[:address] = value
    end

    # string - Lead address 2
    def address_2
      @attributes[:address_2]
    end

    def address_2=(value)
      @attributes[:address_2] = value
    end

    # string - Lead city
    def city
      @attributes[:city]
    end

    def city=(value)
      @attributes[:city] = value
    end

    # string - Lead company name
    def company_name
      @attributes[:company_name]
    end

    def company_name=(value)
      @attributes[:company_name] = value
    end

    # string - Contact name at the company
    def contact_name
      @attributes[:contact_name]
    end

    def contact_name=(value)
      @attributes[:contact_name] = value
    end

    # string - Lead country
    def country
      @attributes[:country]
    end

    def country=(value)
      @attributes[:country] = value
    end

    # string - Lead preferred currency
    def currency
      @attributes[:currency]
    end

    def currency=(value)
      @attributes[:currency] = value
    end

    # string - Lead email address
    def email
      @attributes[:email]
    end

    def email=(value)
      @attributes[:email] = value
    end

    # string - Lead preferred language
    def language
      @attributes[:language]
    end

    def language=(value)
      @attributes[:language] = value
    end

    # string - Lead phone number
    def phone_number
      @attributes[:phone_number]
    end

    def phone_number=(value)
      @attributes[:phone_number] = value
    end

    # string - Lead state
    def state
      @attributes[:state]
    end

    def state=(value)
      @attributes[:state] = value
    end

    # string - Lead zipcode
    def zip
      @attributes[:zip]
    end

    def zip=(value)
      @attributes[:zip] = value
    end

    # string - Quality score of the lead
    def lead_level
      @attributes[:lead_level]
    end

    def lead_level=(value)
      @attributes[:lead_level] = value
    end

    # string - Signup page split test group
    def signup_page_split_test_group
      @attributes[:signup_page_split_test_group]
    end

    def signup_page_split_test_group=(value)
      @attributes[:signup_page_split_test_group] = value
    end

    # string
    def recaptcha_token
      @attributes[:recaptcha_token]
    end

    def recaptcha_token=(value)
      @attributes[:recaptcha_token] = value
    end

    # string - Signup form name
    def form_name
      @attributes[:form_name]
    end

    def form_name=(value)
      @attributes[:form_name] = value
    end

    # string - Source of the lead
    def lead_source
      @attributes[:lead_source]
    end

    def lead_source=(value)
      @attributes[:lead_source] = value
    end

    # string - Opportunity comment
    def opportunity_comment
      @attributes[:opportunity_comment]
    end

    def opportunity_comment=(value)
      @attributes[:opportunity_comment] = value
    end

    # string - Type of opportunity to create
    def opportunity_type
      @attributes[:opportunity_type]
    end

    def opportunity_type=(value)
      @attributes[:opportunity_type] = value
    end

    # string - Google Adwords Click ID
    def gclid
      @attributes[:gclid]
    end

    def gclid=(value)
      @attributes[:gclid] = value
    end

    # string - Brand: `files`, `exavault` or `mover`
    def original_brand
      @attributes[:original_brand]
    end

    def original_brand=(value)
      @attributes[:original_brand] = value
    end

    # string - Marketing tracking - campaign
    def utm_campaign
      @attributes[:utm_campaign]
    end

    def utm_campaign=(value)
      @attributes[:utm_campaign] = value
    end

    # string - Marketing tracking - content
    def utm_content
      @attributes[:utm_content]
    end

    def utm_content=(value)
      @attributes[:utm_content] = value
    end

    # string - Marketing tracking - domain
    def utm_domain
      @attributes[:utm_domain]
    end

    def utm_domain=(value)
      @attributes[:utm_domain] = value
    end

    # string - Marketing tracking - medium
    def utm_medium
      @attributes[:utm_medium]
    end

    def utm_medium=(value)
      @attributes[:utm_medium] = value
    end

    # string - Marketing tracking - source
    def utm_source
      @attributes[:utm_source]
    end

    def utm_source=(value)
      @attributes[:utm_source] = value
    end

    # string - Marketing tracking - term
    def utm_term
      @attributes[:utm_term]
    end

    def utm_term=(value)
      @attributes[:utm_term] = value
    end

    # string - Time zone, as returned by Javascript
    def time_zone
      @attributes[:time_zone]
    end

    def time_zone=(value)
      @attributes[:time_zone] = value
    end

    # int64 - Time zone offset (integer from -12 to 12)
    def time_zone_offset
      @attributes[:time_zone_offset]
    end

    def time_zone_offset=(value)
      @attributes[:time_zone_offset] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The Lead object doesn't support updates.")
      else
        new_obj = Lead.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   recaptcha_token - string
    #   name - string - Lead name
    #   address - string - Lead address
    #   address_2 - string - Lead address 2
    #   city - string - Lead city
    #   contact_name - string - Contact name at the company
    #   currency - string - Lead preferred currency
    #   email - string - Lead email address
    #   language - string - Lead preferred language
    #   phone_number - string - Lead phone number
    #   state - string - Lead state
    #   zip - string - Lead zipcode
    #   form_name - string - Signup form name
    #   lead_source - string - Source of the lead
    #   opportunity_comment - string - Opportunity comment
    #   opportunity_type - string - Type of opportunity to create
    #   gclid - string - Google Adwords Click ID
    #   original_brand - string - Brand: `files`, `exavault` or `mover`
    #   utm_campaign - string - Marketing tracking - campaign
    #   utm_content - string - Marketing tracking - content
    #   utm_domain - string - Marketing tracking - domain
    #   utm_medium - string - Marketing tracking - medium
    #   utm_source - string - Marketing tracking - source
    #   utm_term - string - Marketing tracking - term
    #   time_zone - string - Time zone, as returned by Javascript
    #   time_zone_offset - int64 - Time zone offset (integer from -12 to 12)
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: recaptcha_token must be an String") if params[:recaptcha_token] and !params[:recaptcha_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: address must be an String") if params[:address] and !params[:address].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: address_2 must be an String") if params[:address_2] and !params[:address_2].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: city must be an String") if params[:city] and !params[:city].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: contact_name must be an String") if params[:contact_name] and !params[:contact_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: currency must be an String") if params[:currency] and !params[:currency].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if params[:language] and !params[:language].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: phone_number must be an String") if params[:phone_number] and !params[:phone_number].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: state must be an String") if params[:state] and !params[:state].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: zip must be an String") if params[:zip] and !params[:zip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: form_name must be an String") if params[:form_name] and !params[:form_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: lead_source must be an String") if params[:lead_source] and !params[:lead_source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: opportunity_comment must be an String") if params[:opportunity_comment] and !params[:opportunity_comment].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: opportunity_type must be an String") if params[:opportunity_type] and !params[:opportunity_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: gclid must be an String") if params[:gclid] and !params[:gclid].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: original_brand must be an String") if params[:original_brand] and !params[:original_brand].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: utm_campaign must be an String") if params[:utm_campaign] and !params[:utm_campaign].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: utm_content must be an String") if params[:utm_content] and !params[:utm_content].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: utm_domain must be an String") if params[:utm_domain] and !params[:utm_domain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: utm_medium must be an String") if params[:utm_medium] and !params[:utm_medium].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: utm_source must be an String") if params[:utm_source] and !params[:utm_source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: utm_term must be an String") if params[:utm_term] and !params[:utm_term].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: time_zone must be an String") if params[:time_zone] and !params[:time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: time_zone_offset must be an Integer") if params[:time_zone_offset] and !params[:time_zone_offset].is_a?(Integer)

      response, options = Api.send_request("/leads", :post, params, options)
      Lead.new(response.data, options)
    end

    # Parameters:
    #   code (required) - string - Lead lookup code.
    #   recaptcha_token - string
    #   name - string - Lead name
    #   address - string - Lead address
    #   address_2 - string - Lead address 2
    #   city - string - Lead city
    #   contact_name - string - Contact name at the company
    #   currency - string - Lead preferred currency
    #   email - string - Lead email address
    #   language - string - Lead preferred language
    #   phone_number - string - Lead phone number
    #   state - string - Lead state
    #   zip - string - Lead zipcode
    #   form_name - string - Signup form name
    #   lead_source - string - Source of the lead
    #   opportunity_comment - string - Opportunity comment
    #   opportunity_type - string - Type of opportunity to create
    #   gclid - string - Google Adwords Click ID
    #   original_brand - string - Brand: `files`, `exavault` or `mover`
    #   utm_campaign - string - Marketing tracking - campaign
    #   utm_content - string - Marketing tracking - content
    #   utm_domain - string - Marketing tracking - domain
    #   utm_medium - string - Marketing tracking - medium
    #   utm_source - string - Marketing tracking - source
    #   utm_term - string - Marketing tracking - term
    #   time_zone - string - Time zone, as returned by Javascript
    #   time_zone_offset - int64 - Time zone offset (integer from -12 to 12)
    def self.update(code, params = {}, options = {})
      params ||= {}
      params[:code] = code
      raise InvalidParameterError.new("Bad parameter: code must be an String") if params[:code] and !params[:code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recaptcha_token must be an String") if params[:recaptcha_token] and !params[:recaptcha_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: address must be an String") if params[:address] and !params[:address].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: address_2 must be an String") if params[:address_2] and !params[:address_2].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: city must be an String") if params[:city] and !params[:city].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: contact_name must be an String") if params[:contact_name] and !params[:contact_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: currency must be an String") if params[:currency] and !params[:currency].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: language must be an String") if params[:language] and !params[:language].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: phone_number must be an String") if params[:phone_number] and !params[:phone_number].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: state must be an String") if params[:state] and !params[:state].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: zip must be an String") if params[:zip] and !params[:zip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: form_name must be an String") if params[:form_name] and !params[:form_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: lead_source must be an String") if params[:lead_source] and !params[:lead_source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: opportunity_comment must be an String") if params[:opportunity_comment] and !params[:opportunity_comment].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: opportunity_type must be an String") if params[:opportunity_type] and !params[:opportunity_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: gclid must be an String") if params[:gclid] and !params[:gclid].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: original_brand must be an String") if params[:original_brand] and !params[:original_brand].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: utm_campaign must be an String") if params[:utm_campaign] and !params[:utm_campaign].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: utm_content must be an String") if params[:utm_content] and !params[:utm_content].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: utm_domain must be an String") if params[:utm_domain] and !params[:utm_domain].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: utm_medium must be an String") if params[:utm_medium] and !params[:utm_medium].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: utm_source must be an String") if params[:utm_source] and !params[:utm_source].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: utm_term must be an String") if params[:utm_term] and !params[:utm_term].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: time_zone must be an String") if params[:time_zone] and !params[:time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: time_zone_offset must be an Integer") if params[:time_zone_offset] and !params[:time_zone_offset].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: code") unless params[:code]

      response, options = Api.send_request("/leads/#{params[:code]}", :patch, params, options)
      Lead.new(response.data, options)
    end
  end
end
