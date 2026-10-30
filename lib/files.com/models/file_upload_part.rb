# frozen_string_literal: true

module Files
  # Files::FileUploadPart is the Ruby SDK's representation of Files.com API FileUploadPart objects.
  # Each instance keeps its API field values in +attributes+.
  class FileUploadPart
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

    # Content-Type and File to send
    # @return [Hash, nil] the field value, or nil when absent.
    def send
      @attributes[:send]
    end

    # Type of upload
    # @return [String, nil] the field value, or nil when absent.
    def action
      @attributes[:action]
    end

    # If `true`, this file exists and you may wish to ask the user for overwrite confirmation
    # @return [Boolean, nil] the field value, or nil when absent.
    def ask_about_overwrites
      @attributes[:ask_about_overwrites]
    end

    # Number of parts in the upload
    # @return [Integer, nil] the field value, or nil when absent.
    def available_parts
      @attributes[:available_parts]
    end

    # Date/time of when this Upload part expires and the URL cannot be used any more
    # @return [String, nil] the field value, or nil when absent.
    def expires
      @attributes[:expires]
    end

    # Additional upload headers to provide as part of the upload
    # @return [Hash, nil] the field value, or nil when absent.
    def headers
      @attributes[:headers]
    end

    # HTTP Method to use for uploading the part, usually `PUT`
    # @return [String, nil] the field value, or nil when absent.
    def http_method
      @attributes[:http_method]
    end

    # Size in bytes for this part
    # @return [Integer, nil] the field value, or nil when absent.
    def next_partsize
      @attributes[:next_partsize]
    end

    # If `true`, multiple parts may be uploaded in parallel.  If `false`, be sure to only upload one part at a time, in order.
    # @return [Boolean, nil] the field value, or nil when absent.
    def parallel_parts
      @attributes[:parallel_parts]
    end

    # If `true`, parts may be retried. If `false`, a part cannot be retried and the upload should be restarted.
    # @return [Boolean, nil] the field value, or nil when absent.
    def retry_parts
      @attributes[:retry_parts]
    end

    # Additional HTTP parameters to send with the upload
    # @return [Hash, nil] the field value, or nil when absent.
    def parameters
      @attributes[:parameters]
    end

    # Number of this upload part
    # @return [Integer, nil] the field value, or nil when absent.
    def part_number
      @attributes[:part_number]
    end

    # Size in bytes for the next upload part
    # @return [Integer, nil] the field value, or nil when absent.
    def partsize
      @attributes[:partsize]
    end

    # New file path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Reference name for this upload part
    # @return [String, nil] the field value, or nil when absent.
    def ref
      @attributes[:ref]
    end

    # URI to upload this part to
    # @return [String, nil] the field value, or nil when absent.
    def upload_uri
      @attributes[:upload_uri]
    end

    # Optional direct connection information for direct Agent transfer attempts
    # @return [Hash, nil] the field value, or nil when absent.
    def direct_connection_info
      @attributes[:direct_connection_info]
    end
  end
end
