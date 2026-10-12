# frozen_string_literal: true

module Files
  # Files::Auto is the Ruby SDK's representation of Files.com API Auto objects.
  # Each instance keeps its API field values in +attributes+.
  class Auto
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # object
    def dynamic
      @attributes[:dynamic]
    end
  end
end
