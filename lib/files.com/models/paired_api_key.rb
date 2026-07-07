# frozen_string_literal: true

module Files
  class PairedApiKey
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Site URL
    def server
      @attributes[:server]
    end

    # string - Paired API key username
    def username
      @attributes[:username]
    end

    # string - Paired API key password
    def password
      @attributes[:password]
    end

    # string - Unique nickname for this API key
    def user_username
      @attributes[:user_username]
    end

    # string - Unique nickname for this API key
    def nickname
      @attributes[:nickname]
    end
  end
end
