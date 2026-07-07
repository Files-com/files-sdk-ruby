# frozen_string_literal: true

module Files
  class MonitoringStats
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # array(string)
    def alerts
      @attributes[:alerts]
    end

    # object
    def info
      @attributes[:info]
    end
  end
end
