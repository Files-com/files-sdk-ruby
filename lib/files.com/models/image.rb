# frozen_string_literal: true

module Files
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
