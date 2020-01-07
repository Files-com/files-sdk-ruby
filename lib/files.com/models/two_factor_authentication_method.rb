# frozen_string_literal: true

module Files
  class TwoFactorAuthenticationMethod
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - 2fa ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Type of 2fa
    def method_type
      @attributes[:method_type]
    end

    def method_type=(value)
      @attributes[:method_type] = value
    end

    # string - 2fa method name
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - 2fa phone number (if SMS)
    def phone_number
      @attributes[:phone_number]
    end

    def phone_number=(value)
      @attributes[:phone_number] = value
    end

    # string - 2fa phone number country (if SMS)
    def phone_number_country
      @attributes[:phone_number_country]
    end

    def phone_number_country=(value)
      @attributes[:phone_number_country] = value
    end

    # string - 2fa phone number national format (if SMS)
    def phone_number_national_format
      @attributes[:phone_number_national_format]
    end

    def phone_number_national_format=(value)
      @attributes[:phone_number_national_format] = value
    end

    # boolean - 2fa setup expired?
    def setup_expired
      @attributes[:setup_expired]
    end

    def setup_expired=(value)
      @attributes[:setup_expired] = value
    end

    # boolean - 2fa setup complete?
    def setup_complete
      @attributes[:setup_complete]
    end

    def setup_complete=(value)
      @attributes[:setup_complete] = value
    end

    # date-time - 2fa setup expires at this date/time (typically 10 minutes after a new method is created)
    def setup_expires_at
      @attributes[:setup_expires_at]
    end

    def setup_expires_at=(value)
      @attributes[:setup_expires_at] = value
    end

    # string - TOTP provisioning URI (if TOTP)
    def totp_provisioning_uri
      @attributes[:totp_provisioning_uri]
    end

    def totp_provisioning_uri=(value)
      @attributes[:totp_provisioning_uri] = value
    end

    # string - U2F app ID (if U2F)
    def u2f_app_id
      @attributes[:u2f_app_id]
    end

    def u2f_app_id=(value)
      @attributes[:u2f_app_id] = value
    end

    # array - U2F registration requests (if U2F)
    def u2f_registration_requests
      @attributes[:u2f_registration_requests]
    end

    def u2f_registration_requests=(value)
      @attributes[:u2f_registration_requests] = value
    end

    # string - Current value of OTP, Yubikey string, or U2F response value.  U2F response value requires a json stringified object containing fields `clientData`, `keyHandle`, and `signatureData`.
    def otp
      @attributes[:otp]
    end

    def otp=(value)
      @attributes[:otp] = value
    end

    # Parameters:
    #   otp - string - Current value of OTP, Yubikey string, or U2F response value.  U2F response value requires a json stringified object containing fields `clientData`, `keyHandle`, and `signatureData`.
    #   name - string - 2fa method name
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: otp must be an String") if params.dig(:otp) and !params.dig(:otp).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/2fa/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/2fa/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = TwoFactorAuthenticationMethod.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.get(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/2fa", :get, params, options)
      response.data.map { |object| TwoFactorAuthenticationMethod.new(object, options) }
    end

    # Parameters:
    #   method_type (required) - string - Type of 2fa
    #   name - string - 2fa method name
    #   phone_number - string - 2fa phone number (if SMS)
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: method_type must be an String") if params.dig(:method_type) and !params.dig(:method_type).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: phone_number must be an String") if params.dig(:phone_number) and !params.dig(:phone_number).is_a?(String)
      raise MissingParameterError.new("Parameter missing: method_type") unless params.dig(:method_type)

      response, options = Api.send_request("/2fa", :post, params, options)
      TwoFactorAuthenticationMethod.new(response.data, options)
    end

    # Parameters:
    #   u2f_only - boolean - Set to `true` to only generate an OTP for U2F (FIDO) keys and skip things like SMS.
    def self.send_code(params = {}, options = {})
      response, options = Api.send_request("/2fa/send_code", :post, params, options)
      U2fSignRequest.new(response.data, options)
    end

    # Parameters:
    #   otp - string - Current value of OTP, Yubikey string, or U2F response value.  U2F response value requires a json stringified object containing fields `clientData`, `keyHandle`, and `signatureData`.
    #   name - string - 2fa method name
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: otp must be an String") if params.dig(:otp) and !params.dig(:otp).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/2fa/#{params[:id]}", :patch, params, options)
      TwoFactorAuthenticationMethod.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/2fa/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
