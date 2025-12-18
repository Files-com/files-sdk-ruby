# frozen_string_literal: true

module Files
  class AgentPushUpdate
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Pushed agent version
    def version
      @attributes[:version]
    end

    # string - Update accepted or reason
    def message
      @attributes[:message]
    end

    # string - Installed agent version
    def current_version
      @attributes[:current_version]
    end

    # string - Pending agent version or null
    def pending_version
      @attributes[:pending_version]
    end

    # string - Last error message or null
    def last_error
      @attributes[:last_error]
    end

    # string - Error code
    def error
      @attributes[:error]
    end
  end
end
