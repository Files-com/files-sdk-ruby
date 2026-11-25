# frozen_string_literal: true

module Files
  # Files::AutomationApplication is the Ruby SDK's representation of Files.com API AutomationApplication objects.
  # Each instance keeps its API field values in +attributes+.
  class AutomationApplication
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

    # Stable application key.
    # @return [String, nil] the field value, or nil when absent.
    def key
      @attributes[:key]
    end

    # Application display name.
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Application branding key.
    # @return [String, nil] the field value, or nil when absent.
    def brand
      @attributes[:brand]
    end
  end
end
