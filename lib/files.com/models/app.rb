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

    # string - Short description of the App
    def short_description
      @attributes[:short_description]
    end

    # object - Collection of named links to documentation
    def documentation_links
      @attributes[:documentation_links]
    end

    # string - App icon
    def icon_url
      @attributes[:icon_url]
    end

    # string - Full size logo for the App
    def logo_url
      @attributes[:logo_url]
    end

    # array - Screenshots of the App
    def screenshot_list_urls
      @attributes[:screenshot_list_urls]
    end

    # string - Logo thumbnail for the App
    def logo_thumbnail_url
      @attributes[:logo_thumbnail_url]
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

    # string - Marketing video page
    def marketing_youtube_url
      @attributes[:marketing_youtube_url]
    end

    # string - Tutorial video page
    def tutorial_youtube_url
      @attributes[:tutorial_youtube_url]
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
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction (e.g. `sort_by[name]=desc`). Valid fields are `name` and `app_type`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `name` and `app_type`. Valid field combinations are `[ name, app_type ]` and `[ app_type, name ]`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `name`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

      List.new(App, params) do
        Api.send_request("/apps", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
