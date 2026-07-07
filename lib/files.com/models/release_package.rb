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

    # string - Release architecture
    def architecture
      @attributes[:architecture]
    end

    # string - Package file extension
    def extension
      @attributes[:extension]
    end

    # string - SHA256 hash of the package
    def sha256
      @attributes[:sha256]
    end
  end
end
