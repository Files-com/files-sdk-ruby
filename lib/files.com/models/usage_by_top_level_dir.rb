# frozen_string_literal: true

module Files
  # Files::UsageByTopLevelDir is the Ruby SDK's representation of Files.com API UsageByTopLevelDir objects.
  # Each instance keeps its API field values in +attributes+.
  class UsageByTopLevelDir
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Directory name
    def dir
      @attributes[:dir]
    end

    # int64 - Usage
    def size
      @attributes[:size]
    end

    # int64 - File count
    def count
      @attributes[:count]
    end
  end
end
