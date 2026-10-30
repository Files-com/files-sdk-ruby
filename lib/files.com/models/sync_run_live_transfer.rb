# frozen_string_literal: true

module Files
  # Files::SyncRunLiveTransfer is the Ruby SDK's representation of Files.com API SyncRunLiveTransfer objects.
  # Each instance keeps its API field values in +attributes+.
  class SyncRunLiveTransfer
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

    # The file path being transferred. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Status of this individual transfer
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Bytes transferred so far
    # @return [Integer, nil] the field value, or nil when absent.
    def bytes_copied
      @attributes[:bytes_copied]
    end

    # Total bytes of the file being transferred
    # @return [Integer, nil] the field value, or nil when absent.
    def bytes_total
      @attributes[:bytes_total]
    end

    # Transfer progress from 0.0 to 1.0
    # @return [Float, nil] the field value, or nil when absent.
    def percentage
      @attributes[:percentage]
    end

    # Estimated time remaining (human-readable)
    # @return [String, nil] the field value, or nil when absent.
    def eta
      @attributes[:eta]
    end

    # When this individual transfer started
    # @return [String, nil] the field value, or nil when absent.
    def started_at
      @attributes[:started_at]
    end
  end
end
