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

    # string - 2fa method name
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Type of 2fa
    def method_type
      @attributes[:method_type]
    end

    def method_type=(value)
      @attributes[:method_type] = value
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

    # array(string) - For the Static method type, this is the list of tokens which can be used
    def secret_tokens
      @attributes[:secret_tokens]
    end

    def secret_tokens=(value)
      @attributes[:secret_tokens] = value
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

    # object - WebAuthn / FIDO 2 registration options (if WebAuthn)
    def webauthn_registration_options
      @attributes[:webauthn_registration_options]
    end

    def webauthn_registration_options=(value)
      @attributes[:webauthn_registration_options] = value
    end

    # boolean - Set true to skip checking this 2FA method when using FTP, SFTP, and DAV
    def bypass_for_ftp_sftp_dav
      @attributes[:bypass_for_ftp_sftp_dav]
    end

    def bypass_for_ftp_sftp_dav=(value)
      @attributes[:bypass_for_ftp_sftp_dav] = value
    end

    # string - Current value of OTP, Yubikey string, or Webauthn response value.
    def otp
      @attributes[:otp]
    end

    def otp=(value)
      @attributes[:otp] = value
    end

    # Parameters:
    #   otp - string - Current value of OTP, Yubikey string, or Webauthn response value.
    #   name - string - 2fa method name
    #   bypass_for_ftp_sftp_dav - boolean - Set true to skip checking this 2FA method when using FTP, SFTP, and DAV
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: otp must be an String") if params[:otp] and !params[:otp].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/2fa/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/2fa/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = TwoFactorAuthenticationMethod.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    def self.get(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(TwoFactorAuthenticationMethod, params) do
        Api.send_request("/2fa", :get, params, options)
      end
    end

    # Parameters:
    #   method_type (required) - string - Type of 2fa
    #   name - string - 2fa method name
    #   phone_number - string - 2fa phone number (if SMS)
    #   bypass_for_ftp_sftp_dav - boolean - Set true to skip checking this 2FA method when using FTP, SFTP, and DAV
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: method_type must be an String") if params[:method_type] and !params[:method_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: phone_number must be an String") if params[:phone_number] and !params[:phone_number].is_a?(String)
      raise MissingParameterError.new("Parameter missing: method_type") unless params[:method_type]

      response, options = Api.send_request("/2fa", :post, params, options)
      TwoFactorAuthenticationMethod.new(response.data, options)
    end

    # Parameters:
    #   webauthn_only - boolean - Set to `true` to only generate an OTP for Webauthn keys and skip things like SMS.
    def self.send_code(params = {}, options = {})
      response, options = Api.send_request("/2fa/send_code", :post, params, options)
      WebauthnSignRequest.new(response.data, options)
    end

    def self.create_export(params = {}, options = {})
      response, options = Api.send_request("/2fa/create_export", :post, params, options)
      Export.new(response.data, options)
    end

    # Parameters:
    #   otp - string - Current value of OTP, Yubikey string, or Webauthn response value.
    #   name - string - 2fa method name
    #   bypass_for_ftp_sftp_dav - boolean - Set true to skip checking this 2FA method when using FTP, SFTP, and DAV
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: otp must be an String") if params[:otp] and !params[:otp].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/2fa/#{params[:id]}", :patch, params, options)
      TwoFactorAuthenticationMethod.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/2fa/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
