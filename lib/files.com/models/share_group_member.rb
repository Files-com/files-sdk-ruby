# frozen_string_literal: true

module Files
  class ShareGroupMember
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Name of the share group member
    def name
      @attributes[:name]
    end

    # string - Company of the share group member
    def company
      @attributes[:company]
    end

    # string - Email of the share group member
    def email
      @attributes[:email]
    end
  end
end
