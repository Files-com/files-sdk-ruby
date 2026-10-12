# frozen_string_literal: true

module Files
  # Files::ShareGroupMember is the Ruby SDK's representation of Files.com API ShareGroupMember objects.
  # Each instance keeps its API field values in +attributes+.
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
