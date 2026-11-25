# frozen_string_literal: true

module Files
  # Files::AutomationApplicationAction is the Ruby SDK's representation of Files.com API AutomationApplicationAction objects.
  # Each instance keeps its API field values in +attributes+.
  class AutomationApplicationAction
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

    # Application that provides the action.
    # @return [Hash, nil] the field value, or nil when absent.
    def application
      @attributes[:application]
    end

    # Stable action key within the application.
    # @return [String, nil] the field value, or nil when absent.
    def key
      @attributes[:key]
    end

    # Action display name.
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # What the action does.
    # @return [String, nil] the field value, or nil when absent.
    def description
      @attributes[:description]
    end

    # Fingerprint of the action contract shown to the author.
    # @return [String, nil] the field value, or nil when absent.
    def fingerprint
      @attributes[:fingerprint]
    end

    # Normalized input fields.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def fields
      @attributes[:fields]
    end

    # Normalized output schema.
    # @return [Hash, nil] the field value, or nil when absent.
    def output
      @attributes[:output]
    end

    # HTTPS origins supported by this action.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def origins
      @attributes[:origins]
    end

    # Authentication types accepted by this action.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def authentication
      @attributes[:authentication]
    end
  end
end
