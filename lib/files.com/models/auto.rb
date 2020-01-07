# frozen_string_literal: true

module Files
  class Auto
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # object - Additional data
    def dynamic
      @attributes[:dynamic]
    end
  end
end
