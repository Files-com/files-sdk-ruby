# frozen_string_literal: true

module Files
  # Files::ChatMessage is the Ruby SDK's representation of Files.com API ChatMessage objects.
  # Each instance keeps its API field values in +attributes+.
  class ChatMessage
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Chat Message ID.
    def id
      @attributes[:id]
    end

    # string - Message role.
    def role
      @attributes[:role]
    end

    # string - Message content.
    def content
      @attributes[:content]
    end

    # date-time - Message creation date/time.
    def created_at
      @attributes[:created_at]
    end
  end
end
