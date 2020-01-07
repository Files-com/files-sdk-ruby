# frozen_string_literal: true

module Files
  class BundlePublic
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Bundle code
    def code
      @attributes[:code]
    end

    # string - Bundle url
    def url
      @attributes[:url]
    end

    # string - Bundle description
    def description
      @attributes[:description]
    end
  end
end
