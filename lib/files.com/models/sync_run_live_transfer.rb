# frozen_string_literal: true

module Files
  class SyncRunLiveTransfer
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - The file path being transferred. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # string - Status of this individual transfer
    def status
      @attributes[:status]
    end

    # int64 - Bytes transferred so far
    def bytes_copied
      @attributes[:bytes_copied]
    end

    # int64 - Total bytes of the file being transferred
    def bytes_total
      @attributes[:bytes_total]
    end

    # double - Transfer progress from 0.0 to 1.0
    def percentage
      @attributes[:percentage]
    end

    # string - Estimated time remaining (human-readable)
    def eta
      @attributes[:eta]
    end

    # string - When this individual transfer started
    def started_at
      @attributes[:started_at]
    end
  end
end
