# frozen_string_literal: true

module Files
  # Files::Errors is the Ruby SDK's representation of Files.com API Errors objects.
  # Each instance keeps its API field values in +attributes+.
  class Errors
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # array(string) - A list of fields where errors occur
    def fields
      @attributes[:fields]
    end

    # array(string) - A list of error messages
    def messages
      @attributes[:messages]
    end
  end
end
