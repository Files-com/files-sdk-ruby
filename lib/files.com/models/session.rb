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

    # string - Session ID
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

    # string - AWS Secret Key for validating AWS-style signatures in the Inbound S3 endpoint.
    def aws_secret_key
      @attributes[:aws_secret_key]
    end

    def aws_secret_key=(value)
      @attributes[:aws_secret_key] = value
    end

    # int64 - AI Assistant Personality ID for the in-app AI Assistant.
    def ai_assistant_personality_id
      @attributes[:ai_assistant_personality_id]
    end

    def ai_assistant_personality_id=(value)
      @attributes[:ai_assistant_personality_id] = value
    end

    # string - System prompt for the in-app AI Assistant.
    def ai_assistant_personality_system_prompt
      @attributes[:ai_assistant_personality_system_prompt]
    end

    def ai_assistant_personality_system_prompt=(value)
      @attributes[:ai_assistant_personality_system_prompt] = value
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

    # int64 - Workspace ID the user should land in by default when more than one Workspace is available.
    def default_workspace_id
      @attributes[:default_workspace_id]
    end

    def default_workspace_id=(value)
      @attributes[:default_workspace_id] = value
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

    # string - Root path to restrict the user's session to.
    def root_path
      @attributes[:root_path]
    end

    def root_path=(value)
      @attributes[:root_path] = value
    end

    # string - Initial path to start the user's session in.
    def home_path
      @attributes[:home_path]
    end

    def home_path=(value)
      @attributes[:home_path] = value
    end

    # boolean - Are insecure SFTP ciphers allowed for this user? (If this is set to true, the site administrator has signaled that it is ok to use less secure SSH ciphers for this user.)
    def sftp_insecure_ciphers
      @attributes[:sftp_insecure_ciphers]
    end

    def sftp_insecure_ciphers=(value)
      @attributes[:sftp_insecure_ciphers] = value
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

    # date-time - Session timeout datetime
    def timeout_at
      @attributes[:timeout_at]
    end

    def timeout_at=(value)
      @attributes[:timeout_at] = value
    end

    # boolean - Can this session tolerate IP and User-Agent mismatches?
    def trusted
      @attributes[:trusted]
    end

    def trusted=(value)
      @attributes[:trusted] = value
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

    # boolean - Sent only if 2FA setup is needed. Is WebAuthn two factor authentication allowed?
    def allowed_2fa_method_webauthn
      @attributes[:allowed_2fa_method_webauthn]
    end

    def allowed_2fa_method_webauthn=(value)
      @attributes[:allowed_2fa_method_webauthn] = value
    end

    # boolean - Sent only if 2FA setup is needed. Is Yubikey two factor authentication allowed?
    def allowed_2fa_method_yubi
      @attributes[:allowed_2fa_method_yubi]
    end

    def allowed_2fa_method_yubi=(value)
      @attributes[:allowed_2fa_method_yubi] = value
    end

    # boolean - Calculate CRC32 checksum for incoming files?
    def calculate_file_checksums_crc32
      @attributes[:calculate_file_checksums_crc32]
    end

    def calculate_file_checksums_crc32=(value)
      @attributes[:calculate_file_checksums_crc32] = value
    end

    # boolean - Calculate MD5 checksum for incoming files?
    def calculate_file_checksums_md5
      @attributes[:calculate_file_checksums_md5]
    end

    def calculate_file_checksums_md5=(value)
      @attributes[:calculate_file_checksums_md5] = value
    end

    # boolean - Calculate SHA1 checksum for incoming files?
    def calculate_file_checksums_sha1
      @attributes[:calculate_file_checksums_sha1]
    end

    def calculate_file_checksums_sha1=(value)
      @attributes[:calculate_file_checksums_sha1] = value
    end

    # boolean - Calculate SHA256 checksum for incoming files?
    def calculate_file_checksums_sha256
      @attributes[:calculate_file_checksums_sha256]
    end

    def calculate_file_checksums_sha256=(value)
      @attributes[:calculate_file_checksums_sha256] = value
    end

    # boolean - Use legacy checksums mode?
    def legacy_checksums_mode
      @attributes[:legacy_checksums_mode]
    end

    def legacy_checksums_mode=(value)
      @attributes[:legacy_checksums_mode] = value
    end

    # boolean - Finalize partial SFTP uploads?
    def finalize_partial_uploads
      @attributes[:finalize_partial_uploads]
    end

    def finalize_partial_uploads=(value)
      @attributes[:finalize_partial_uploads] = value
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

    # boolean
    def user_belongs_to_parent_site
      @attributes[:user_belongs_to_parent_site]
    end

    def user_belongs_to_parent_site=(value)
      @attributes[:user_belongs_to_parent_site] = value
    end

    # int64 - User ID of the Site Admin who initiated a Read-Only session impersonating this session's user
    def impersonator_user_id
      @attributes[:impersonator_user_id]
    end

    def impersonator_user_id=(value)
      @attributes[:impersonator_user_id] = value
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

    # string - AWS Access Key ID for signing in with AWS credentials
    def aws_access_key_id
      @attributes[:aws_access_key_id]
    end

    def aws_access_key_id=(value)
      @attributes[:aws_access_key_id] = value
    end

    # string
    def change_password
      @attributes[:change_password]
    end

    def change_password=(value)
      @attributes[:change_password] = value
    end

    # string
    def change_password_confirmation
      @attributes[:change_password_confirmation]
    end

    def change_password_confirmation=(value)
      @attributes[:change_password_confirmation] = value
    end

    # string
    def interface
      @attributes[:interface]
    end

    def interface=(value)
      @attributes[:interface] = value
    end

    # string
    def ssh_client_identification
      @attributes[:ssh_client_identification]
    end

    def ssh_client_identification=(value)
      @attributes[:ssh_client_identification] = value
    end

    # string
    def locale
      @attributes[:locale]
    end

    def locale=(value)
      @attributes[:locale] = value
    end

    # boolean
    def no_cookie
      @attributes[:no_cookie]
    end

    def no_cookie=(value)
      @attributes[:no_cookie] = value
    end

    # string
    def oauth_provider
      @attributes[:oauth_provider]
    end

    def oauth_provider=(value)
      @attributes[:oauth_provider] = value
    end

    # string
    def oauth_label
      @attributes[:oauth_label]
    end

    def oauth_label=(value)
      @attributes[:oauth_label] = value
    end

    # string
    def oauth_code
      @attributes[:oauth_code]
    end

    def oauth_code=(value)
      @attributes[:oauth_code] = value
    end

    # string
    def oauth_state
      @attributes[:oauth_state]
    end

    def oauth_state=(value)
      @attributes[:oauth_state] = value
    end

    # string - If this user has a 2FA device, provide its OTP or code here.
    def otp
      @attributes[:otp]
    end

    def otp=(value)
      @attributes[:otp] = value
    end

    # string - Identifier for a partially-completed login
    def partial_session_id
      @attributes[:partial_session_id]
    end

    def partial_session_id=(value)
      @attributes[:partial_session_id] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The Session object doesn't support updates.")
      else
        new_obj = Session.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   username - string - Username to sign in as
    #   password - string - Password for sign in
    #   aws_access_key_id - string - AWS Access Key ID for signing in with AWS credentials
    #   change_password - string
    #   change_password_confirmation - string
    #   interface - string
    #   ssh_client_identification - string
    #   locale - string
    #   no_cookie - boolean
    #   oauth_provider - string
    #   oauth_label - string
    #   oauth_code - string
    #   oauth_state - string
    #   otp - string - If this user has a 2FA device, provide its OTP or code here.
    #   partial_session_id - string - Identifier for a partially-completed login
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_access_key_id must be an String") if params[:aws_access_key_id] and !params[:aws_access_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: change_password must be an String") if params[:change_password] and !params[:change_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: change_password_confirmation must be an String") if params[:change_password_confirmation] and !params[:change_password_confirmation].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interface must be an String") if params[:interface] and !params[:interface].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssh_client_identification must be an String") if params[:ssh_client_identification] and !params[:ssh_client_identification].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: locale must be an String") if params[:locale] and !params[:locale].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: oauth_provider must be an String") if params[:oauth_provider] and !params[:oauth_provider].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: oauth_label must be an String") if params[:oauth_label] and !params[:oauth_label].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: oauth_code must be an String") if params[:oauth_code] and !params[:oauth_code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: oauth_state must be an String") if params[:oauth_state] and !params[:oauth_state].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: otp must be an String") if params[:otp] and !params[:otp].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: partial_session_id must be an String") if params[:partial_session_id] and !params[:partial_session_id].is_a?(String)

      response, options = Api.send_request("/sessions", :post, params, options)
      Session.new(response.data, options)
    end

    # Parameters:
    #   subdomain (required) - string - Site subdomain to login to
    def self.subdomain(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: subdomain must be an String") if params[:subdomain] and !params[:subdomain].is_a?(String)
      raise MissingParameterError.new("Parameter missing: subdomain") unless params[:subdomain]

      response, options = Api.send_request("/sessions/subdomain", :post, params, options)
      Session.new(response.data, options)
    end

    # Parameters:
    #   user_id (required) - string - User id to login as
    def self.as_user(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an String") if params[:user_id] and !params[:user_id].is_a?(String)
      raise MissingParameterError.new("Parameter missing: user_id") unless params[:user_id]

      response, options = Api.send_request("/sessions/as_user", :post, params, options)
      Session.new(response.data, options)
    end

    # Parameters:
    #   session_id (required) - string - Session ID to convert to a trusted session
    def self.trusted(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: session_id must be an String") if params[:session_id] and !params[:session_id].is_a?(String)
      raise MissingParameterError.new("Parameter missing: session_id") unless params[:session_id]

      response, options = Api.send_request("/sessions/trusted", :post, params, options)
      Session.new(response.data, options)
    end

    # Parameters:
    #   code (required) - string
    #   password (required) - string
    #   confirm_password - string
    #   interface - string
    #   locale - string
    #   otp - string
    def self.forgot_reset(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: code must be an String") if params[:code] and !params[:code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: confirm_password must be an String") if params[:confirm_password] and !params[:confirm_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: interface must be an String") if params[:interface] and !params[:interface].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: locale must be an String") if params[:locale] and !params[:locale].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: otp must be an String") if params[:otp] and !params[:otp].is_a?(String)
      raise MissingParameterError.new("Parameter missing: code") unless params[:code]
      raise MissingParameterError.new("Parameter missing: password") unless params[:password]

      Api.send_request("/sessions/forgot/reset", :post, params, options)
      nil
    end

    # Parameters:
    #   code (required) - string
    def self.forgot_validate(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: code must be an String") if params[:code] and !params[:code].is_a?(String)
      raise MissingParameterError.new("Parameter missing: code") unless params[:code]

      Api.send_request("/sessions/forgot/validate", :post, params, options)
      nil
    end

    # Parameters:
    #   email - string
    #   username - string
    #   username_or_email - string
    def self.forgot(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username_or_email must be an String") if params[:username_or_email] and !params[:username_or_email].is_a?(String)

      Api.send_request("/sessions/forgot", :post, params, options)
      nil
    end

    # Parameters:
    #   return_to (required) - string - Public Hosting URL to return to after authentication
    def self.public_hosting(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: return_to must be an String") if params[:return_to] and !params[:return_to].is_a?(String)
      raise MissingParameterError.new("Parameter missing: return_to") unless params[:return_to]

      response, options = Api.send_request("/sessions/public_hosting", :post, params, options)
      PublicHostingSessionPairing.new(response.data, options)
    end

    # Parameters:
    #   key (required) - string - The pairing key to reserve for login.  Cannot be reused
    def self.pairing_key(key, params = {}, options = {})
      params ||= {}
      params[:key] = key
      raise InvalidParameterError.new("Bad parameter: key must be an String") if params[:key] and !params[:key].is_a?(String)
      raise MissingParameterError.new("Parameter missing: key") unless params[:key]

      response, options = Api.send_request("/sessions/pairing_key/#{params[:key]}", :post, params, options)
      PairedApiKey.new(response.data, options)
    end

    # Parameters:
    #   provider (required) - string
    #   label - string
    #   state - string
    #   host - string
    def self.oauth(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: provider must be an String") if params[:provider] and !params[:provider].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: label must be an String") if params[:label] and !params[:label].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: state must be an String") if params[:state] and !params[:state].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: host must be an String") if params[:host] and !params[:host].is_a?(String)
      raise MissingParameterError.new("Parameter missing: provider") unless params[:provider]

      response, options = Api.send_request("/sessions/oauth", :post, params, options)
      OauthRedirect.new(response.data, options)
    end

    def self.delete(params = {}, options = {})
      Api.send_request("/sessions", :delete, params, options)
      nil
    end

    def self.destroy(params = {}, options = {})
      delete(params, options)
      nil
    end
  end
end
