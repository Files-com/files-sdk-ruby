# frozen_string_literal: true

module Files
  class FilePartUpload
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

    # boolean - If false, rename conflicting files instead of asking for overwrite confirmation
    def ask_about_overwrites
      @attributes[:ask_about_overwrites]
    end

    # string - Currently unused
    def available_parts
      @attributes[:available_parts]
    end

    # string - Currently unused
    def expires
      @attributes[:expires]
    end

    # object - Additional upload headers
    def headers
      @attributes[:headers]
    end

    # string - Upload method, usually POST
    def http_method
      @attributes[:http_method]
    end

    # string - Currently unused
    def next_partsize
      @attributes[:next_partsize]
    end

    # boolean - If true, parts may be uploaded in parallel
    def parallel_parts
      @attributes[:parallel_parts]
    end

    # string - Additional upload parameters
    def parameters
      @attributes[:parameters]
    end

    # string - Currently unused
    def part_number
      @attributes[:part_number]
    end

    # string - Currently unused
    def partsize
      @attributes[:partsize]
    end

    # string - Upload path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
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
