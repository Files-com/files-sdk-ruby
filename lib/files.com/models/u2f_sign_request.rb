# frozen_string_literal: true

module Files
  class U2fSignRequest
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - App ID for U2F
    def app_id
      @attributes[:app_id]
    end

    # string - Challenge String for U2F
    def challenge
      @attributes[:challenge]
    end

    # string - Signature request for U2F
    def sign_request
      @attributes[:sign_request]
    end
  end
end
