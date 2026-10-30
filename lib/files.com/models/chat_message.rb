# frozen_string_literal: true

module Files
  # Files::ChatMessage is the Ruby SDK's representation of Files.com API ChatMessage objects.
  # Each instance keeps its API field values in +attributes+.
  class ChatMessage
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

    # Chat Message ID.
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Message role.
    # @return [String, nil] the field value, or nil when absent.
    def role
      @attributes[:role]
    end

    # Message content.
    # @return [String, nil] the field value, or nil when absent.
    def content
      @attributes[:content]
    end

    # Message creation date/time.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end
  end
end
