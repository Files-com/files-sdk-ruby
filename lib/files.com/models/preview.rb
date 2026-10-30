# frozen_string_literal: true

module Files
  # Files::Preview is the Ruby SDK's representation of Files.com API Preview objects.
  # Each instance keeps its API field values in +attributes+.
  class Preview
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

    # Preview ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Preview status.  Can be invalid, not_generated, generating, complete, or file_too_large
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Link to download preview
    # @return [String, nil] the field value, or nil when absent.
    def download_uri
      @attributes[:download_uri]
    end

    # Preview type. Can be image, pdf, pdf_native, video, audio, or text
    # @return [String, nil] the field value, or nil when absent.
    def type
      @attributes[:type]
    end

    # Preview size
    # @return [String, nil] the field value, or nil when absent.
    def size
      @attributes[:size]
    end
  end
end
