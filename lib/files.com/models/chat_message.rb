# frozen_string_literal: true

module Files
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
