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

    # string
    def bundle_registration_code
      @attributes[:bundle_registration_code]
    end

    def bundle_registration_code=(value)
      @attributes[:bundle_registration_code] = value
    end

    # array(string)
    def encoded_paths
      @attributes[:encoded_paths]
    end

    def encoded_paths=(value)
      @attributes[:encoded_paths] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The ZipDownload object doesn't support updates.")
      else
        new_obj = ZipDownload.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   paths (required) - array(string)
    #   bundle_registration_code - string
    #   encoded_paths - array(string)
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if params[:paths] and !params[:paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: bundle_registration_code must be an String") if params[:bundle_registration_code] and !params[:bundle_registration_code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: encoded_paths must be an Array") if params[:encoded_paths] and !params[:encoded_paths].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: paths") unless params[:paths]

      response, options = Api.send_request("/zip_downloads", :post, params, options)
      ZipDownload.new(response.data, options)
    end
  end
end
