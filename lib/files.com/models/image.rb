# frozen_string_literal: true

module Files
  # Files::Image is the Ruby SDK's representation of Files.com API Image objects.
  # Each instance keeps its API field values in +attributes+.
  class Image
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Image name
    def name
      @attributes[:name]
    end

    # string - Image URI
    def uri
      @attributes[:uri]
    end
  end
end
