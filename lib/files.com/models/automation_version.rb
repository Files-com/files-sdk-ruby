# frozen_string_literal: true

module Files
  # Files::AutomationVersion is the Ruby SDK's representation of Files.com API AutomationVersion objects.
  # Each instance keeps its API field values in +attributes+.
  class AutomationVersion
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

    # Automation revision ID.
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # ID of the Automation that owns this revision.
    # @return [Integer, nil] the field value, or nil when absent.
    def automation_id
      @attributes[:automation_id]
    end

    # Workspace that owns the Automation. Zero is the Default Workspace.
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Revision number within the Automation.
    # @return [Integer, nil] the field value, or nil when absent.
    def version
      @attributes[:version]
    end

    # Time the revision was saved.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # ID of the user who saved the revision, when available.
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # Username recorded when the revision was saved, when available.
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # ID of the API key used to save the revision, when available.
    # @return [Integer, nil] the field value, or nil when absent.
    def api_key_id
      @attributes[:api_key_id]
    end

    # Saved Automation v2 graph definition. Included when retrieving a single revision.
    # @return [Hash, nil] the field value, or nil when absent.
    def definition
      @attributes[:definition]
    end

    # Restore an Automation v2 definition as a new current version
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def restore(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/automation_versions/#{@attributes[:id]}/restore", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # List Automation Versions
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    # @option params [Integer] automation_id Required. ID of the Automation that owns this revision.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: automation_id must be an Integer") if !params[:automation_id].nil? and !params[:automation_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: automation_id") if params[:automation_id].nil?

      list_options = options.dup
      List.new(AutomationVersion, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/automation_versions", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Automation Version
    #
    # @param id [Integer] Automation Version ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AutomationVersion] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/automation_versions/#{params[:id]}", :get, params, options) { |reply| reply.require_object("AutomationVersion") }
      AutomationVersion.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Restore an Automation v2 definition as a new current version
    #
    # @param id [Integer] Automation Version ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Automation] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.restore(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/automation_versions/#{params[:id]}/restore", :post, params, options) { |reply| reply.require_object("Automation") }
      Automation.new(response.data, options)
    end
  end
end
