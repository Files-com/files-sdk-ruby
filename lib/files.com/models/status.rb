# frozen_string_literal: true

module Files
  class Status
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Status HTTP code
    def code
      @attributes[:code]
    end

    # string - Error message
    def message
      @attributes[:message]
    end

    # string - Status message
    def status
      @attributes[:status]
    end

    # Auto - Additional data
    def data
      @attributes[:data]
    end

    # array(object) - A list of api errors
    def errors
      @attributes[:errors]
    end

    # int64 - Required Clickwrap id
    def clickwrap_id
      @attributes[:clickwrap_id]
    end

    # string - Required Clickwrap body
    def clickwrap_body
      @attributes[:clickwrap_body]
    end
  end
end
