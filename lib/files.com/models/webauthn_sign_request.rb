# frozen_string_literal: true

module Files
  class WebauthnSignRequest
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # array(object) - WebAuthn / FIDO 2 authentication options
    def webauthn_authentication_options
      @attributes[:webauthn_authentication_options]
    end
  end
end
