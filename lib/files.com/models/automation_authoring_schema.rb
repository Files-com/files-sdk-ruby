# frozen_string_literal: true

module Files
  class AutomationAuthoringSchema
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # object - JSON Schema for active Automation v2 graph definitions.
    def definition_schema
      @attributes[:definition_schema]
    end

    # array(object) - Typed error families accepted by Automation v2 on_error rules.
    def error_families
      @attributes[:error_families]
    end

    # array(object) - Active Automation v2 node authoring metadata.
    def nodes
      @attributes[:nodes]
    end
  end
end
