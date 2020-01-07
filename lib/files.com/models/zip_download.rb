# frozen_string_literal: true

module Files
  class ZipDownload
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - URL for downloading the ZIP
    def download_uri
      @attributes[:download_uri]
    end

    def download_uri=(value)
      @attributes[:download_uri] = value
    end

    # array(string)
    def paths
      @attributes[:paths]
    end

    def paths=(value)
      @attributes[:paths] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The ZipDownload object doesn't support updates.")
      else
        new_obj = ZipDownload.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   paths (required) - array
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if params.dig(:paths) and !params.dig(:paths).is_a?(Array)
      raise MissingParameterError.new("Parameter missing: paths") unless params.dig(:paths)

      response, options = Api.send_request("/zip_downloads", :post, params, options)
      ZipDownload.new(response.data, options)
    end
  end
end
