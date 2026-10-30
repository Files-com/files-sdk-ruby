# frozen_string_literal: true

module Files
  # Files::AutomationAuthoringSchema is the Ruby SDK's representation of Files.com API AutomationAuthoringSchema objects.
  # Each instance keeps its API field values in +attributes+.
  class AutomationAuthoringSchema
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

    # JSON Schema for active Automation v2 graph definitions.
    # @return [Hash, nil] the field value, or nil when absent.
    def definition_schema
      @attributes[:definition_schema]
    end

    # Typed error families accepted by Automation v2 on_error rules.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def error_families
      @attributes[:error_families]
    end

    # Active Automation v2 node authoring metadata.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def nodes
      @attributes[:nodes]
    end

    # Stable public URL for the Automation v2 graph definition JSON Schema.
    # @return [String, nil] the field value, or nil when absent.
    def schema_url
      @attributes[:schema_url]
    end
  end
end
