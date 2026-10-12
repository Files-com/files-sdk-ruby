# frozen_string_literal: true

module Files
  # Files::Preview is the Ruby SDK's representation of Files.com API Preview objects.
  # Each instance keeps its API field values in +attributes+.
  class Preview
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Preview ID
    def id
      @attributes[:id]
    end

    # string - Preview status.  Can be invalid, not_generated, generating, complete, or file_too_large
    def status
      @attributes[:status]
    end

    # string - Link to download preview
    def download_uri
      @attributes[:download_uri]
    end

    # string - Preview type. Can be image, pdf, pdf_native, video, audio, or text
    def type
      @attributes[:type]
    end

    # string - Preview size
    def size
      @attributes[:size]
    end
  end
end
