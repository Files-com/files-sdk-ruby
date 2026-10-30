# frozen_string_literal: true

module Files
  # Files::BundlePath is the Ruby SDK's representation of Files.com API BundlePath objects.
  # Each instance keeps its API field values in +attributes+.
  class BundlePath
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

    # Allow access to subfolders content?
    # @return [Boolean, nil] the field value, or nil when absent.
    def recursive
      @attributes[:recursive]
    end

    # The path to the resource relative to filesystem. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end
  end
end
