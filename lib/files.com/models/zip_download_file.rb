# frozen_string_literal: true

module Files
  class ZipDownloadFile
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Site Id
    def site_id
      @attributes[:site_id]
    end

    def site_id=(value)
      @attributes[:site_id] = value
    end

    # int64 - User Id
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # int64 - Bundle Id
    def bundle_id
      @attributes[:bundle_id]
    end

    def bundle_id=(value)
      @attributes[:bundle_id] = value
    end

    # int64 - Bundle Registration Id
    def bundle_registration_id
      @attributes[:bundle_registration_id]
    end

    def bundle_registration_id=(value)
      @attributes[:bundle_registration_id] = value
    end

    # array(object) - A list of file names, sizes, and signed download URLs.
    def files
      @attributes[:files]
    end

    def files=(value)
      @attributes[:files] = value
    end

    # string - Cursor for fetching more files in subsequent requests.
    def cursor
      @attributes[:cursor]
    end

    def cursor=(value)
      @attributes[:cursor] = value
    end

    # string - Secure code that was generated when creating the zip download.
    def code
      @attributes[:code]
    end

    def code=(value)
      @attributes[:code] = value
    end

    # int64 - Limit the number of files returned.
    def limit
      @attributes[:limit]
    end

    def limit=(value)
      @attributes[:limit] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The ZipDownloadFile object doesn't support updates.")
      else
        new_obj = ZipDownloadFile.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   code (required) - string - Secure code that was generated when creating the zip download.
    #   limit - int64 - Limit the number of files returned.
    #   cursor - string - Cursor used for paging through files.
    #   site_id - int64 - Only check the given site for the zip download.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: code must be an String") if params[:code] and !params[:code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: limit must be an Integer") if params[:limit] and !params[:limit].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: site_id must be an Integer") if params[:site_id] and !params[:site_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: code") unless params[:code]

      response, options = Api.send_request("/zip_download_files", :post, params, options)
      ZipDownloadFiles.new(response.data, options)
    end
  end
end
