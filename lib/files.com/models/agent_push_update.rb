# frozen_string_literal: true

module Files
  # Files::AgentPushUpdate is the Ruby SDK's representation of Files.com API AgentPushUpdate objects.
  # Each instance keeps its API field values in +attributes+.
  class AgentPushUpdate
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

    # Pushed agent version
    # @return [String, nil] the field value, or nil when absent.
    def version
      @attributes[:version]
    end

    # Update accepted or reason
    # @return [String, nil] the field value, or nil when absent.
    def message
      @attributes[:message]
    end

    # Installed agent version
    # @return [String, nil] the field value, or nil when absent.
    def current_version
      @attributes[:current_version]
    end

    # Pending agent version or null
    # @return [String, nil] the field value, or nil when absent.
    def pending_version
      @attributes[:pending_version]
    end

    # Last error message or null
    # @return [String, nil] the field value, or nil when absent.
    def last_error
      @attributes[:last_error]
    end

    # Error code
    # @return [String, nil] the field value, or nil when absent.
    def error
      @attributes[:error]
    end
  end
end
