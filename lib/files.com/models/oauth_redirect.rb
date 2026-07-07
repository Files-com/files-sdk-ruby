# frozen_string_literal: true

module Files
  class OauthRedirect
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Redirect URL
    def redirect_uri
      @attributes[:redirect_uri]
    end
  end
end
