# frozen_string_literal: true

module Files
  class BundleDownload
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Download method (file or full_zip)
    def download_method
      @attributes[:download_method]
    end

    # string - Download path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # date-time - Download date/time
    def created_at
      @attributes[:created_at]
    end

    # Parameters:
    #   page - int64 - Current page number.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   bundle_registration_id (required) - int64 - BundleRegistration ID
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bundle_registration_id must be an Integer") if params.dig(:bundle_registration_id) and !params.dig(:bundle_registration_id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: bundle_registration_id") unless params.dig(:bundle_registration_id)

      response, options = Api.send_request("/bundle_downloads", :get, params, options)
      response.data.map do |entity_data|
        BundleDownload.new(entity_data, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
