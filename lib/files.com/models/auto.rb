# frozen_string_literal: true

module Files
  class Auto
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # object
    def dynamic
      @attributes[:dynamic]
    end
  end
end
