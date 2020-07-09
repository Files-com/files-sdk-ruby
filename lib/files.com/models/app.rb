# frozen_string_literal: true

module Files
  class App
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Name of the App
    def name
      @attributes[:name]
    end

    # string - Long form description of the App
    def extended_description
      @attributes[:extended_description]
    end

    # string - Collection of named links to documentation
    def documentation_links
      @attributes[:documentation_links]
    end

    # string - Associated SSO Strategy type, if any
    def sso_strategy_type
      @attributes[:sso_strategy_type]
    end

    # string - Associated Remote Server type, if any
    def remote_server_type
      @attributes[:remote_server_type]
    end

    # string - Associated Folder Behavior type, if any
    def folder_behavior_type
      @attributes[:folder_behavior_type]
    end

    # string - Link to external homepage
    def external_homepage_url
      @attributes[:external_homepage_url]
    end

    # string - The type of the App
    def app_type
      @attributes[:app_type]
    end

    # boolean - Is featured on the App listing?
    def featured
      @attributes[:featured]
    end

    # Parameters:
    #   page - int64 - Current page number.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/apps", :get, params, options)
      response.data.map do |entity_data|
        App.new(entity_data, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
