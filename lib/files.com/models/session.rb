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

    # boolean - Is this session read only?
    def read_only
      @attributes[:read_only]
    end

    def read_only=(value)
      @attributes[:read_only] = value
    end

    # boolean - Are insecure SFTP ciphers allowed for this user? (If this is set to true, the site administrator has signaled that it is ok to use less secure SSH ciphers for this user.)
    def sftp_insecure_ciphers
      @attributes[:sftp_insecure_ciphers]
    end

    def sftp_insecure_ciphers=(value)
      @attributes[:sftp_insecure_ciphers] = value
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
    #   otp - string - If this user has a 2FA device, provide its OTP or code here.
    #   partial_session_id - string - Identifier for a partially-completed login
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: otp must be an String") if params[:otp] and !params[:otp].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: partial_session_id must be an String") if params[:partial_session_id] and !params[:partial_session_id].is_a?(String)

      response, options = Api.send_request("/sessions", :post, params, options)
      Session.new(response.data, options)
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
