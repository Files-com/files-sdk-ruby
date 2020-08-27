# frozen_string_literal: true

module Files
  class FileUploadPart
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # object - Content-Type and File to send
    def send
      @attributes[:send]
    end

    # string - Type of upload
    def action
      @attributes[:action]
    end

    # boolean - If `true`, this file exists and you may wish to ask the user for overwrite confirmation
    def ask_about_overwrites
      @attributes[:ask_about_overwrites]
    end

    # int64 - Number of parts in the upload
    def available_parts
      @attributes[:available_parts]
    end

    # string - Date/time of when this Upload part expires and the URL cannot be used any more
    def expires
      @attributes[:expires]
    end

    # object - Additional upload headers to provide as part of the upload
    def headers
      @attributes[:headers]
    end

    # string - HTTP Method to use for uploading the part, usually `PUT`
    def http_method
      @attributes[:http_method]
    end

    # int64 - Size in bytes for this part
    def next_partsize
      @attributes[:next_partsize]
    end

    # boolean - If `true`, multiple parts may be uploaded in parallel.  If `false`, be sure to only upload one part at a time, in order.
    def parallel_parts
      @attributes[:parallel_parts]
    end

    # object - Additional HTTP parameters to send with the upload
    def parameters
      @attributes[:parameters]
    end

    # int64 - Number of this upload part
    def part_number
      @attributes[:part_number]
    end

    # int64 - Size in bytes for the next upload part
    def partsize
      @attributes[:partsize]
    end

    # string - New file path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # string - Reference name for this upload part
    def ref
      @attributes[:ref]
    end

    # string - URI to upload this part to
    def upload_uri
      @attributes[:upload_uri]
    end
  end
end
