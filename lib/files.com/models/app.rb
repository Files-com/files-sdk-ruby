# frozen_string_literal: true

module Files
  # Files::App is the Ruby SDK's representation of Files.com API App objects.
  # Each instance keeps its API field values in +attributes+.
  class App
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # The type of the App
    # @return [String, nil] the field value, or nil when absent.
    def app_type
      @attributes[:app_type]
    end

    # Collection of named links to documentation
    # @return [Hash, nil] the field value, or nil when absent.
    def documentation_links
      @attributes[:documentation_links]
    end

    # Long description for the in-App landing page
    # @return [String, nil] the field value, or nil when absent.
    def extended_description
      @attributes[:extended_description]
    end

    # Long form description of the App
    # @return [String, nil] the field value, or nil when absent.
    def extended_description_for_marketing_site
      @attributes[:extended_description_for_marketing_site]
    end

    # Link to external homepage
    # @return [String, nil] the field value, or nil when absent.
    def external_homepage_url
      @attributes[:external_homepage_url]
    end

    # Is featured on the App listing?
    # @return [Boolean, nil] the field value, or nil when absent.
    def featured
      @attributes[:featured]
    end

    # Associated Folder Behavior type, if any
    # @return [String, nil] the field value, or nil when absent.
    def folder_behavior_type
      @attributes[:folder_behavior_type]
    end

    # App icon
    # @return [String, nil] the field value, or nil when absent.
    def icon_url
      @attributes[:icon_url]
    end

    # Logo thumbnail for the App
    # @return [String, nil] the field value, or nil when absent.
    def logo_thumbnail_url
      @attributes[:logo_thumbnail_url]
    end

    # Full size logo for the App
    # @return [String, nil] the field value, or nil when absent.
    def logo_url
      @attributes[:logo_url]
    end

    # Marketing introdution of the App
    # @return [String, nil] the field value, or nil when absent.
    def marketing_intro
      @attributes[:marketing_intro]
    end

    # Marketing video page
    # @return [String, nil] the field value, or nil when absent.
    def marketing_youtube_url
      @attributes[:marketing_youtube_url]
    end

    # Name of the App
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Package manager install command
    # @return [String, nil] the field value, or nil when absent.
    def package_manager_install_command
      @attributes[:package_manager_install_command]
    end

    # Associated Remote Server type, if any
    # @return [String, nil] the field value, or nil when absent.
    def remote_server_type
      @attributes[:remote_server_type]
    end

    # Screenshots of the App
    # @return [Array<String>, nil] the field value, or nil when absent.
    def screenshot_list_urls
      @attributes[:screenshot_list_urls]
    end

    # Link to SDK installation instructions
    # @return [String, nil] the field value, or nil when absent.
    def sdk_installation_instructions_link
      @attributes[:sdk_installation_instructions_link]
    end

    # Short description of the App
    # @return [String, nil] the field value, or nil when absent.
    def short_description
      @attributes[:short_description]
    end

    # Associated SSO Strategy type, if any
    # @return [String, nil] the field value, or nil when absent.
    def sso_strategy_type
      @attributes[:sso_strategy_type]
    end

    # Associated SIEM type, if any
    # @return [String, nil] the field value, or nil when absent.
    def siem_type
      @attributes[:siem_type]
    end

    # Tutorial video page
    # @return [String, nil] the field value, or nil when absent.
    def tutorial_youtube_url
      @attributes[:tutorial_youtube_url]
    end

    # List Apps
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `name` and `app_type`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `name` and `app_type`. Valid field combinations are `[ name, app_type ]`.
    # @option params [Hash] filter_prefix If set, return records where the specified field is prefixed by the supplied value. Valid fields are `name`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if !params[:filter_prefix].nil? and !params[:filter_prefix].is_a?(Hash)

      list_options = options.dup
      List.new(App, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/apps", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
