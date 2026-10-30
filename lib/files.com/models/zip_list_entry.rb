# frozen_string_literal: true

module Files
  # Files::ZipListEntry is the Ruby SDK's representation of Files.com API ZipListEntry objects.
  # Each instance keeps its API field values in +attributes+.
  class ZipListEntry
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Entry path inside the ZIP. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Uncompressed size in bytes.
    # @return [Integer, nil] the field value, or nil when absent.
    def size
      @attributes[:size]
    end
  end
end
