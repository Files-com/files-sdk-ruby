# frozen_string_literal: true

module Files
  # Files::Status is the Ruby SDK's representation of Files.com API Status objects.
  # Each instance keeps its API field values in +attributes+.
  class Status
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Status HTTP code
    # @return [Integer, nil] the field value, or nil when absent.
    def code
      @attributes[:code]
    end

    # Error message
    # @return [String, nil] the field value, or nil when absent.
    def message
      @attributes[:message]
    end

    # Status message
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Additional data
    # @return [Hash, nil] the field value, or nil when absent.
    def data
      @attributes[:data]
    end

    # A list of api errors
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def errors
      @attributes[:errors]
    end

    # Required Clickwrap id
    # @return [Integer, nil] the field value, or nil when absent.
    def clickwrap_id
      @attributes[:clickwrap_id]
    end

    # Required Clickwrap body
    # @return [String, nil] the field value, or nil when absent.
    def clickwrap_body
      @attributes[:clickwrap_body]
    end
  end
end
