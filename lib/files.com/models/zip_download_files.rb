# frozen_string_literal: true

module Files
  class ZipDownloadFiles
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Site Id
    def site_id
      @attributes[:site_id]
    end

    # int64 - User Id
    def user_id
      @attributes[:user_id]
    end

    # int64 - Bundle Id
    def bundle_id
      @attributes[:bundle_id]
    end

    # int64 - Bundle Registration Id
    def bundle_registration_id
      @attributes[:bundle_registration_id]
    end

    # array(object) - A list of file names, sizes, and signed download URLs.
    def files
      @attributes[:files]
    end

    # string - Cursor for fetching more files in subsequent requests.
    def cursor
      @attributes[:cursor]
    end
  end
end
