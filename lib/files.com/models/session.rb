# frozen_string_literal: true

module Files
  class Session
    attr_reader :options, :attributes
    def destroy(params = {}, options = {})
      Session.destroy(params, options.merge(session: self, session_id: nil))
    end

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Session ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Session language
    def language
      @attributes[:language]
    end

    def language=(value)
      @attributes[:language] = value
    end

    # string - Login token. If set, this token will allow your user to log in via browser at the domain in `login_token_domain`.
    def login_token
      @attributes[:login_token]
    end

    def login_token=(value)
      @attributes[:login_token] = value
    end

    # string - Domain to use with `login_token`.
    def login_token_domain
      @attributes[:login_token_domain]
    end

    def login_token_domain=(value)
      @attributes[:login_token_domain] = value
    end

    # int64 - Maximum number of files to retrieve per folder for a directory listing.  This is based on the user's plan.
    def max_dir_listing_size
      @attributes[:max_dir_listing_size]
    end

    def max_dir_listing_size=(value)
      @attributes[:max_dir_listing_size] = value
    end

    # boolean - Can access multiple regions?
    def multiple_regions
      @attributes[:multiple_regions]
    end

    def multiple_regions=(value)
      @attributes[:multiple_regions] = value
    end

    # boolean - Is this session read only?
    def read_only
      @attributes[:read_only]
    end

    def read_only=(value)
      @attributes[:read_only] = value
    end

    # string - Initial root path to start the user's session in.
    def root_path
      @attributes[:root_path]
    end

    def root_path=(value)
      @attributes[:root_path] = value
    end

    # int64 - Site ID
    def site_id
      @attributes[:site_id]
    end

    def site_id=(value)
      @attributes[:site_id] = value
    end

    # boolean - Is SSL required for this user?  (If so, ensure all your communications with this user use SSL.)
    def ssl_required
      @attributes[:ssl_required]
    end

    def ssl_required=(value)
      @attributes[:ssl_required] = value
    end

    # boolean - Is strong TLS disabled for this user? (If this is set to true, the site administrator has signaled that it is ok to use less secure TLS versions for this user.)
    def tls_disabled
      @attributes[:tls_disabled]
    end

    def tls_disabled=(value)
      @attributes[:tls_disabled] = value
    end

    # boolean - If true, this user needs to add a Two Factor Authentication method before performing any further actions.
    def two_factor_setup_needed
      @attributes[:two_factor_setup_needed]
    end

    def two_factor_setup_needed=(value)
      @attributes[:two_factor_setup_needed] = value
    end

    # boolean - Sent only if 2FA setup is needed. Is SMS two factor authentication allowed?
    def allowed_2fa_method_sms
      @attributes[:allowed_2fa_method_sms]
    end

    def allowed_2fa_method_sms=(value)
      @attributes[:allowed_2fa_method_sms] = value
    end

    # boolean - Sent only if 2FA setup is needed. Is TOTP two factor authentication allowed?
    def allowed_2fa_method_totp
      @attributes[:allowed_2fa_method_totp]
    end

    def allowed_2fa_method_totp=(value)
      @attributes[:allowed_2fa_method_totp] = value
    end

    # boolean - Sent only if 2FA setup is needed. Is U2F two factor authentication allowed?
    def allowed_2fa_method_u2f
      @attributes[:allowed_2fa_method_u2f]
    end

    def allowed_2fa_method_u2f=(value)
      @attributes[:allowed_2fa_method_u2f] = value
    end

    # boolean - Sent only if 2FA setup is needed. Is Yubikey two factor authentication allowed?
    def allowed_2fa_method_yubi
      @attributes[:allowed_2fa_method_yubi]
    end

    def allowed_2fa_method_yubi=(value)
      @attributes[:allowed_2fa_method_yubi] = value
    end

    # boolean - Allow the user to provide file/folder modified at dates?  If false, the server will always use the current date/time.
    def use_provided_modified_at
      @attributes[:use_provided_modified_at]
    end

    def use_provided_modified_at=(value)
      @attributes[:use_provided_modified_at] = value
    end

    # boolean - Does this user want to use Windows line-ending emulation?  (CR vs CRLF)
    def windows_mode_ftp
      @attributes[:windows_mode_ftp]
    end

    def windows_mode_ftp=(value)
      @attributes[:windows_mode_ftp] = value
    end

    # string - Username to sign in as
    def username
      @attributes[:username]
    end

    def username=(value)
      @attributes[:username] = value
    end

    # string - Password for sign in
    def password
      @attributes[:password]
    end

    def password=(value)
      @attributes[:password] = value
    end

    # string - If this user has a 2FA device, provide its OTP or code here.
    def otp
      @attributes[:otp]
    end

    def otp=(value)
      @attributes[:otp] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The Session object doesn't support updates.")
      else
        new_obj = Session.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   username - string - Username to sign in as
    #   password - string - Password for sign in
    #   otp - string - If this user has a 2FA device, provide its OTP or code here.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params.dig(:username) and !params.dig(:username).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params.dig(:password) and !params.dig(:password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: otp must be an String") if params.dig(:otp) and !params.dig(:otp).is_a?(String)

      response, options = Api.send_request("/sessions", :post, params, options)
      Session.new(response.data, options)
    end

    def self.delete(params = {}, options = {})
      response, _options = Api.send_request("/sessions", :delete, params, options)
      response.data
    end

    def self.destroy(params = {}, options = {})
      delete(params, options)
    end
  end
end
