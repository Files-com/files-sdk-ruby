# frozen_string_literal: true

module Files
  # Files::ZipListEntry is the Ruby SDK's representation of Files.com API ZipListEntry objects.
  # Each instance keeps its API field values in +attributes+.
  class ZipListEntry
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Entry path inside the ZIP. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # int64 - Uncompressed size in bytes.
    def size
      @attributes[:size]
    end
  end
end
