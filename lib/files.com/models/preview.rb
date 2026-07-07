# frozen_string_literal: true

module Files
  class Preview
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Preview ID
    def id
      @attributes[:id]
    end

    # string - Preview status.  Can be invalid, not_generated, generating, complete, or file_too_large
    def status
      @attributes[:status]
    end

    # string - Link to download preview
    def download_uri
      @attributes[:download_uri]
    end

    # string - Preview type. Can be image, pdf, pdf_native, video, audio, or text
    def type
      @attributes[:type]
    end

    # string - Preview size
    def size
      @attributes[:size]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   ids (required) - string - Preview IDs.  Comma delimited.
    #   bundle_registration_code - string - Bundle registration cookie code
    #   size - string - Preview Size
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ids must be an String") if params[:ids] and !params[:ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bundle_registration_code must be an String") if params[:bundle_registration_code] and !params[:bundle_registration_code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: size must be an String") if params[:size] and !params[:size].is_a?(String)
      raise MissingParameterError.new("Parameter missing: ids") unless params[:ids]

      List.new(Preview, params) do
        Api.send_request("/previews", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Preview ID
    #   bundle_registration_code - string - Bundle registration cookie code
    #   size - string - Preview Size
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: bundle_registration_code must be an String") if params[:bundle_registration_code] and !params[:bundle_registration_code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: size must be an String") if params[:size] and !params[:size].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/previews/#{params[:id]}", :get, params, options)
      Preview.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   ids (required) - string - Preview IDs.  Comma delimited.
    #   bundle_registration_code - string - Bundle registration cookie code
    #   size - string - Preview Size
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: ids must be an String") if params[:ids] and !params[:ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bundle_registration_code must be an String") if params[:bundle_registration_code] and !params[:bundle_registration_code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: size must be an String") if params[:size] and !params[:size].is_a?(String)
      raise MissingParameterError.new("Parameter missing: ids") unless params[:ids]

      response, options = Api.send_request("/previews/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
