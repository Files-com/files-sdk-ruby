# frozen_string_literal: true

module Files
  # Files::SettingsChange is the Ruby SDK's representation of Files.com API SettingsChange objects.
  # Each instance keeps its API field values in +attributes+.
  class SettingsChange
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

    # The API key id responsible for this change.
    # @return [Integer, nil] the field value, or nil when absent.
    def api_key_id
      @attributes[:api_key_id]
    end

    # Markdown-formatted change messages.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def changes
      @attributes[:changes]
    end

    # The time this change was made.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # The user id responsible for this change.
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # true if this change was performed by Files.com support.
    # @return [Boolean, nil] the field value, or nil when absent.
    def user_is_files_support
      @attributes[:user_is_files_support]
    end

    # true if this change was performed by a user on a parent site.
    # @return [Boolean, nil] the field value, or nil when absent.
    def user_is_from_parent_site
      @attributes[:user_is_from_parent_site]
    end

    # The username of the user responsible for this change.
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # List Settings Changes
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`, `api_key_id` or `user_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `api_key_id` and `user_id`.
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

      list_options = options.dup
      List.new(SettingsChange, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/settings_changes", :get, page_params, list_options, &check_page)
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
