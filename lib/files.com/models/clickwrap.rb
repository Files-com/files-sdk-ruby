# frozen_string_literal: true

module Files
  # Files::Clickwrap is the Ruby SDK's representation of Files.com API Clickwrap objects.
  # Each instance keeps its API field values in +attributes+.
  class Clickwrap
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

    # Clickwrap ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def id=(value)
      @attributes[:id] = value
    end

    # Name of the Clickwrap agreement (used when selecting from multiple Clickwrap agreements.)
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def name=(value)
      @attributes[:name] = value
    end

    # Body text of Clickwrap (supports Markdown formatting).
    # @return [String, nil] the field value, or nil when absent.
    def body
      @attributes[:body]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def body=(value)
      @attributes[:body] = value
    end

    # Use this Clickwrap for Users?  Values: `none`, `require` (new user signup via email invitation only), `require_all_users_once` (show to all users at their next web login; once accepted, not shown again), `require_all_users_always` (show to all users on every web login).
    # @return [String, nil] the field value, or nil when absent.
    def use_with_users
      @attributes[:use_with_users]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def use_with_users=(value)
      @attributes[:use_with_users] = value
    end

    # Use this Clickwrap for Bundles?
    # @return [String, nil] the field value, or nil when absent.
    def use_with_bundles
      @attributes[:use_with_bundles]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def use_with_bundles=(value)
      @attributes[:use_with_bundles] = value
    end

    # Use this Clickwrap for Inboxes?
    # @return [String, nil] the field value, or nil when absent.
    def use_with_inboxes
      @attributes[:use_with_inboxes]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def use_with_inboxes=(value)
      @attributes[:use_with_inboxes] = value
    end

    # Update Clickwrap
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Name of the Clickwrap agreement (used when selecting from multiple Clickwrap agreements.)
    # @option params [String] body Body text of Clickwrap (supports Markdown formatting).
    # @option params [String] use_with_bundles Use this Clickwrap for Bundles?
    # @option params [String] use_with_inboxes Use this Clickwrap for Inboxes?
    # @option params [String] use_with_users Use this Clickwrap for Users?  Values: `none`, `require` (new user signup via email invitation only), `require_all_users_once` (show to all users at their next web login; once accepted, not shown again), `require_all_users_always` (show to all users on every web login).
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if !params[:body].nil? and !params[:body].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_bundles must be an String") if !params[:use_with_bundles].nil? and !params[:use_with_bundles].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_inboxes must be an String") if !params[:use_with_inboxes].nil? and !params[:use_with_inboxes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_users must be an String") if !params[:use_with_users].nil? and !params[:use_with_users].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/clickwraps/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("Clickwrap") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Clickwrap
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/clickwraps/#{@attributes[:id]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Calls {#delete} and discards its response.
    # @param (see #delete)
    # @option (see #delete)
    # @raise (see #delete)
    # @return [nil]
    def destroy(params = {})
      delete(params)
      nil
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = Clickwrap.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Clickwraps
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)

      list_options = options.dup
      List.new(Clickwrap, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/clickwraps", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Clickwrap
    #
    # @param id [Integer] Clickwrap ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Clickwrap] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/clickwraps/#{params[:id]}", :get, params, options) { |reply| reply.require_object("Clickwrap") }
      Clickwrap.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Clickwrap
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Name of the Clickwrap agreement (used when selecting from multiple Clickwrap agreements.)
    # @option params [String] body Body text of Clickwrap (supports Markdown formatting).
    # @option params [String] use_with_bundles Use this Clickwrap for Bundles?
    # @option params [String] use_with_inboxes Use this Clickwrap for Inboxes?
    # @option params [String] use_with_users Use this Clickwrap for Users?  Values: `none`, `require` (new user signup via email invitation only), `require_all_users_once` (show to all users at their next web login; once accepted, not shown again), `require_all_users_always` (show to all users on every web login).
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Clickwrap] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if !params[:body].nil? and !params[:body].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_bundles must be an String") if !params[:use_with_bundles].nil? and !params[:use_with_bundles].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_inboxes must be an String") if !params[:use_with_inboxes].nil? and !params[:use_with_inboxes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_users must be an String") if !params[:use_with_users].nil? and !params[:use_with_users].is_a?(String)

      response, options = Api.send_request("/clickwraps", :post, params, options) { |reply| reply.require_object("Clickwrap") }
      Clickwrap.new(response.data, options)
    end

    # Update Clickwrap
    #
    # @param id [Integer] Clickwrap ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Name of the Clickwrap agreement (used when selecting from multiple Clickwrap agreements.)
    # @option params [String] body Body text of Clickwrap (supports Markdown formatting).
    # @option params [String] use_with_bundles Use this Clickwrap for Bundles?
    # @option params [String] use_with_inboxes Use this Clickwrap for Inboxes?
    # @option params [String] use_with_users Use this Clickwrap for Users?  Values: `none`, `require` (new user signup via email invitation only), `require_all_users_once` (show to all users at their next web login; once accepted, not shown again), `require_all_users_always` (show to all users on every web login).
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Clickwrap] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: body must be an String") if !params[:body].nil? and !params[:body].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_bundles must be an String") if !params[:use_with_bundles].nil? and !params[:use_with_bundles].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_inboxes must be an String") if !params[:use_with_inboxes].nil? and !params[:use_with_inboxes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_with_users must be an String") if !params[:use_with_users].nil? and !params[:use_with_users].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/clickwraps/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("Clickwrap") }
      Clickwrap.new(response.data, options)
    end

    # Delete Clickwrap
    #
    # @param id [Integer] Clickwrap ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/clickwraps/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
