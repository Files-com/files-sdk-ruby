# frozen_string_literal: true

module Files
  # Files::Image is the Ruby SDK's representation of Files.com API Image objects.
  # Each instance keeps its API field values in +attributes+.
  class Image
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

    # Image name
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Image URI
    # @return [String, nil] the field value, or nil when absent.
    def uri
      @attributes[:uri]
    end
  end
end
