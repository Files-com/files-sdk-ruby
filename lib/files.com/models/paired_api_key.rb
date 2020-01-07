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

    # string - Paired api key username
    def username
      @attributes[:username]
    end

    # string - Paired api key password
    def password
      @attributes[:password]
    end

    # string - Unique nickname for this api key
    def nickname
      @attributes[:nickname]
    end
  end
end
