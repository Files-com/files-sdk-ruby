# frozen_string_literal: true

module Files
  class Errors
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # array - A list of fields where errors occur
    def fields
      @attributes[:fields]
    end

    # array - A list of error messages
    def messages
      @attributes[:messages]
    end
  end
end
