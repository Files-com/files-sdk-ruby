# frozen_string_literal: true

module Files
  class BundlePath
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # boolean - Allow access to subfolders content?
    def recursive
      @attributes[:recursive]
    end

    # string - The path to the resource relative to filesystem. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end
  end
end
