# frozen_string_literal: true

module Files
  class RegionalMigration
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end
  end
end
