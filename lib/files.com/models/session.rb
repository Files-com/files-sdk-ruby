# frozen_string_literal: true

module Files
  # Files::Session is the Ruby SDK's representation of Files.com API Session objects.
  # Each instance keeps its API field values in +attributes+.
  class Session
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    def destroy(params = {}, options = {})
      Session.destroy(params, options.merge(session: self, session_id: nil))
    end

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Session ID
    # @return [String, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def id=(value)
      @attributes[:id] = value
    end

    # Session language
    # @return [String, nil] the field value, or nil when absent.
    def language
      @attributes[:language]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def language=(value)
      @attributes[:language] = value
    end

    # Is this session read only?
    # @return [Boolean, nil] the field value, or nil when absent.
    def read_only
      @attributes[:read_only]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def read_only=(value)
      @attributes[:read_only] = value
    end

    # Are insecure SFTP ciphers allowed for this user? (If this is set to true, the site administrator has signaled that it is ok to use less secure SSH ciphers for this user.)
    # @return [Boolean, nil] the field value, or nil when absent.
    def sftp_insecure_ciphers
      @attributes[:sftp_insecure_ciphers]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def sftp_insecure_ciphers=(value)
      @attributes[:sftp_insecure_ciphers] = value
    end

    # Username to sign in as
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def username=(value)
      @attributes[:username] = value
    end

    # Password for sign in
    # @return [String, nil] the field value, or nil when absent.
    def password
      @attributes[:password]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def password=(value)
      @attributes[:password] = value
    end

    # If this user has a 2FA device, provide its OTP or code here.
    # @return [String, nil] the field value, or nil when absent.
    def otp
      @attributes[:otp]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def otp=(value)
      @attributes[:otp] = value
    end

    # Identifier for a partially-completed login
    # @return [String, nil] the field value, or nil when absent.
    def partial_session_id
      @attributes[:partial_session_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def partial_session_id=(value)
      @attributes[:partial_session_id] = value
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    # @raise [Files::NotImplementedError] if this record already has an id; updates are unsupported.
    def save
      if @attributes[:id]
        raise NotImplementedError.new("The Session object doesn't support updates.")
      else
        new_obj = Session.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # Create user session (log in)
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] username Username to sign in as
    # @option params [String] password Password for sign in
    # @option params [String] otp If this user has a 2FA device, provide its OTP or code here.
    # @option params [String] partial_session_id Identifier for a partially-completed login
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Session] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: username must be an String") if !params[:username].nil? and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: otp must be an String") if !params[:otp].nil? and !params[:otp].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: partial_session_id must be an String") if !params[:partial_session_id].nil? and !params[:partial_session_id].is_a?(String)

      response, options = Api.send_request("/sessions", :post, params, options) { |reply| reply.require_object("Session") }
      Session.new(response.data, options)
    end

    # Delete user session (log out)
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(params = {}, options = {})
      Api.send_request("/sessions", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(params = {}, options = {})
      delete(params, options)
      nil
    end
  end
end
