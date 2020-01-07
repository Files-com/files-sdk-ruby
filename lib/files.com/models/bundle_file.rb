# frozen_string_literal: true

module Files
  class BundleFile
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Bundle file download URI
    def download_uri
      @attributes[:download_uri]
    end

    # string - File path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # int64 - File size
    def size
      @attributes[:size]
    end

    # string - Type of 'directory' or 'file'
    def type
      @attributes[:type]
    end
  end
end
