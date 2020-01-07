# frozen_string_literal: true

module Files
  class Release
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Native release description
    def description
      @attributes[:description]
    end

    # array - A list of native release packages
    def native_release_packages
      @attributes[:native_release_packages]
    end

    # string - Native release title
    def title
      @attributes[:title]
    end

    # string - Native release version
    def version
      @attributes[:version]
    end

    # Parameters:
    #   platform - string
    def self.get_latest(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: platform must be an String") if params.dig(:platform) and !params.dig(:platform).is_a?(String)

      response, options = Api.send_request("/releases/latest", :get, params, options)
      Release.new(response.data, options)
    end
  end
end
