# frozen_string_literal: true

module Files
  class ReleasePackage
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Link to the package
    def package_link
      @attributes[:package_link]
    end

    # string - Release platform
    def platform
      @attributes[:platform]
    end
  end
end
