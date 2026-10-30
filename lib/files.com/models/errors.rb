# frozen_string_literal: true

module Files
  # Files::Errors is the Ruby SDK's representation of Files.com API Errors objects.
  # Each instance keeps its API field values in +attributes+.
  class Errors
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

    # A list of fields where errors occur
    # @return [Array<String>, nil] the field value, or nil when absent.
    def fields
      @attributes[:fields]
    end

    # A list of error messages
    # @return [Array<String>, nil] the field value, or nil when absent.
    def messages
      @attributes[:messages]
    end
  end
end
