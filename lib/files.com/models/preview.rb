# frozen_string_literal: true

module Files
  class Preview
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Preview status.  Can be invalid, not_generated, generating, complete, or file_too_large
    def status
      @attributes[:status]
    end

    # string - Link to download preview
    def download_uri
      @attributes[:download_uri]
    end

    # int64 - Preview ID
    def id
      @attributes[:id]
    end

    # string - Preview status.  Can be invalid, not_generated, generating, complete, or file_too_large
    def type
      @attributes[:type]
    end

    # int64 - Preview size
    def size
      @attributes[:size]
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   ids (required) - string - Preview IDs.  Comma delimited.
    #   size - string - Preview Size
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ids must be an String") if params.dig(:ids) and !params.dig(:ids).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: size must be an String") if params.dig(:size) and !params.dig(:size).is_a?(String)
      raise MissingParameterError.new("Parameter missing: ids") unless params.dig(:ids)

      response, options = Api.send_request("/previews", :get, params, options)
      response.data.map { |object| Preview.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - integer - Preview ID.
    #   size - string - Preview Size
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: size must be an String") if params.dig(:size) and !params.dig(:size).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/previews/#{params[:id]}", :get, params, options)
      Preview.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
