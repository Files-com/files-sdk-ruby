# frozen_string_literal: true

module Files
  # Files::Auto is the Ruby SDK's representation of Files.com API Auto objects.
  # Each instance keeps its API field values in +attributes+.
  class Auto
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

    #
    # @return [Hash, nil] the field value, or nil when absent.
    def dynamic
      @attributes[:dynamic]
    end
  end
end
