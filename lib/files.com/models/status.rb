# frozen_string_literal: true

module Files
  class Status
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Status http code
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

    def data
      @attributes[:data]
    end

    # array - A list of api errors
    def errors
      @attributes[:errors]
    end
  end
end
