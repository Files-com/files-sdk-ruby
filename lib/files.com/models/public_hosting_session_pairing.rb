# frozen_string_literal: true

module Files
  class PublicHostingSessionPairing
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - One-time pairing key for the Public Hosting session
    def pairing_key
      @attributes[:pairing_key]
    end

    # string - Public Hosting URL that exchanges the pairing key for a Public Hosting session cookie
    def redirect_uri
      @attributes[:redirect_uri]
    end

    # date-time - When the pairing key expires
    def expires_at
      @attributes[:expires_at]
    end
  end
end
