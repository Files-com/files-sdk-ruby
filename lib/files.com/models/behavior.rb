# frozen_string_literal: true

module Files
  # Files::Behavior is the Ruby SDK's representation of Files.com API Behavior objects.
  # Each instance keeps its API field values in +attributes+.
  class Behavior
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

    # Folder behavior ID
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

    # Folder path.  Note that Behavior paths cannot be updated once initially set.  You will need to remove and re-create the behavior on the new path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def path=(value)
      @attributes[:path] = value
    end

    # URL for attached file
    # @return [String, nil] the field value, or nil when absent.
    def attachment_url
      @attributes[:attachment_url]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def attachment_url=(value)
      @attributes[:attachment_url] = value
    end

    # Behavior type.
    # @return [String, nil] the field value, or nil when absent.
    def behavior
      @attributes[:behavior]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def behavior=(value)
      @attributes[:behavior] = value
    end

    # Name for this behavior.
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

    # Description for this behavior.
    # @return [String, nil] the field value, or nil when absent.
    def description
      @attributes[:description]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def description=(value)
      @attributes[:description] = value
    end

    # Settings for this behavior.  See the section above for an example value to provide here.  Formatting is different for each Behavior type.  May be sent as nested JSON or a single JSON-encoded string.  If using XML encoding for the API call, this data must be sent as a JSON-encoded string.
    # @return [Hash, nil] the field value, or nil when absent.
    def value
      @attributes[:value]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def value=(value)
      @attributes[:value] = value
    end

    # Public URL for this publicly hosted folder when the `Serve Publicly` behavior has a key configured. When a Custom Domain with `public_hosting` destination is attached to this behavior, the URL uses that domain. Otherwise it uses the site's `subdomain.hosted-by-files.com` host, unless `custom_domain_only` is enabled, in which case no URL is returned.
    # @return [String, nil] the field value, or nil when absent.
    def public_hosting_url
      @attributes[:public_hosting_url]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_hosting_url=(value)
      @attributes[:public_hosting_url] = value
    end

    # If true, disables the inherited behavior for this folder and its children. Valid only for behavior types that child folders may override, and requires recursive to be true. Rejected for all other behavior types.
    # @return [Boolean, nil] the field value, or nil when absent.
    def disable_parent_folder_behavior
      @attributes[:disable_parent_folder_behavior]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def disable_parent_folder_behavior=(value)
      @attributes[:disable_parent_folder_behavior] = value
    end

    # Whether this behavior is recursive for this record. `always` behaviors are always `true`, `never` behaviors are always `false`, and `sometimes` behaviors may be either value.
    # @return [Boolean, nil] the field value, or nil when absent.
    def recursive
      @attributes[:recursive]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def recursive=(value)
      @attributes[:recursive] = value
    end

    # If true, this behavior is inherited from a higher scope rather than owned by the requested workspace.
    # @return [Boolean, nil] the field value, or nil when absent.
    define_method(:inherited) do
      @attributes[:inherited]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def inherited=(value)
      @attributes[:inherited] = value
    end

    # If true, this behavior is controlled by a parent-site policy and cannot be modified locally.
    # @return [Boolean, nil] the field value, or nil when absent.
    def managed
      @attributes[:managed]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def managed=(value)
      @attributes[:managed] = value
    end

    # If true, this behavior may only be modified by a site admin because it is at the site root or disables a root behavior.
    # @return [Boolean, nil] the field value, or nil when absent.
    def root_behavior_site_admin_only
      @attributes[:root_behavior_site_admin_only]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def root_behavior_site_admin_only=(value)
      @attributes[:root_behavior_site_admin_only] = value
    end

    # Certain behaviors may require a file, for instance, the `watermark` behavior requires a watermark image. Attach that file here.
    # @return [Hash, nil] the field value, or nil when absent.
    def attachment_file
      @attributes[:attachment_file]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def attachment_file=(value)
      @attributes[:attachment_file] = value
    end

    # If `true`, delete the file stored in `attachment`.
    # @return [Boolean, nil] the field value, or nil when absent.
    def attachment_delete
      @attributes[:attachment_delete]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def attachment_delete=(value)
      @attributes[:attachment_delete] = value
    end

    # Update Behavior
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Hash] value This field stores data specific to the type of behavior. See The Behavior Types section for the accepted value for each type of behavior.
    # @option params [Object] attachment_file Certain behaviors may require a file, for instance, the `watermark` behavior requires a watermark image. Attach that file here.
    # @option params [Boolean] disable_parent_folder_behavior If true, disables the inherited behavior for this folder and its children. Valid only for behavior types that child folders may override, and requires recursive to be true. Rejected for all other behavior types.
    # @option params [Boolean] recursive Whether the behavior should apply to child folders. This is only configurable for behavior types whose recursion mode is `sometimes`; `always` behaviors stay recursive and `never` behaviors stay non-recursive.
    # @option params [String] name Name for this behavior.
    # @option params [String] description Description for this behavior.
    # @option params [Hash, String, Integer] attachment_delete If `true`, delete the file stored in `attachment`.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if !params[:value].nil? and !params[:value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: disable_parent_folder_behavior must be a single value, not #{params[:disable_parent_folder_behavior].class}") if [ Array, Hash ].any? { |klass| params[:disable_parent_folder_behavior].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/behaviors/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("Behavior") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Behavior
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

      response, options = Api.send_request("/behaviors/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = Behavior.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Behaviors
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `behavior`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `clickwrap_id`, `form_field_set_id`, `impacts_ui`, `remote_server_id` or `behavior`. Valid field combinations are `[ impacts_ui, behavior ]` and `[ behavior, remote_server_id ]`.
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
      List.new(Behavior, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/behaviors", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Behavior
    #
    # @param id [Integer] Behavior ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Behavior] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/behaviors/#{params[:id]}", :get, params, options) { |reply| reply.require_object("Behavior") }
      Behavior.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # List Behaviors by Path
    #
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `behavior`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `impacts_ui` and `behavior`. Valid field combinations are `[ impacts_ui, behavior ]`.
    # @option params [Boolean] ancestor_behaviors If `true`, behaviors above this path are shown.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list_for(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ancestor_behaviors must be a single value, not #{params[:ancestor_behaviors].class}") if [ Array, Hash ].any? { |klass| params[:ancestor_behaviors].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      list_options = options.dup
      List.new(Behavior, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/behaviors/folders/#{page_params[:path]}", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # Create Behavior
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Hash] value This field stores data specific to the type of behavior. See The Behavior Types section for the accepted value for each type of behavior.
    # @option params [Object] attachment_file Certain behaviors may require a file, for instance, the `watermark` behavior requires a watermark image. Attach that file here.
    # @option params [Boolean] disable_parent_folder_behavior If true, disables the inherited behavior for this folder and its children. Valid only for behavior types that child folders may override, and requires recursive to be true. Rejected for all other behavior types.
    # @option params [Boolean] recursive Whether the behavior should apply to child folders. This is only configurable for behavior types whose recursion mode is `sometimes`; `always` behaviors stay recursive and `never` behaviors stay non-recursive.
    # @option params [String] name Name for this behavior.
    # @option params [String] description Description for this behavior.
    # @option params [String] path Required. Path where this behavior should apply.
    # @option params [String] behavior Required. Behavior type.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Behavior] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if !params[:value].nil? and !params[:value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: disable_parent_folder_behavior must be a single value, not #{params[:disable_parent_folder_behavior].class}") if [ Array, Hash ].any? { |klass| params[:disable_parent_folder_behavior].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: behavior must be an String") if !params[:behavior].nil? and !params[:behavior].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: behavior") if params[:behavior].nil?

      response, options = Api.send_request("/behaviors", :post, params, options) { |reply| reply.require_object("Behavior") }
      Behavior.new(response.data, options)
    end

    # Test Webhook
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] url Required. URL for testing the webhook.
    # @option params [String] method HTTP request method (GET or POST).
    # @option params [String] encoding Encoding type for the webhook payload. Can be JSON, XML, or RAW (form data).
    # @option params [Hash] headers Additional request headers to send via HTTP.
    # @option params [Hash] body Additional body parameters to include in the webhook payload.
    # @option params [String] action Action for test body.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.webhook_test(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: url must be an String") if !params[:url].nil? and !params[:url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: method must be an String") if !params[:method].nil? and !params[:method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: encoding must be an String") if !params[:encoding].nil? and !params[:encoding].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: headers must be an Hash") if !params[:headers].nil? and !params[:headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: body must be an Hash") if !params[:body].nil? and !params[:body].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if !params[:action].nil? and !params[:action].is_a?(String)
      raise MissingParameterError.new("Parameter missing: url") if params[:url].nil?

      Api.send_request("/behaviors/webhook/test", :post, params, options)
      nil
    end

    # Update Behavior
    #
    # @param id [Hash, String, Integer] Behavior ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Hash] value This field stores data specific to the type of behavior. See The Behavior Types section for the accepted value for each type of behavior.
    # @option params [Object] attachment_file Certain behaviors may require a file, for instance, the `watermark` behavior requires a watermark image. Attach that file here.
    # @option params [Boolean] disable_parent_folder_behavior If true, disables the inherited behavior for this folder and its children. Valid only for behavior types that child folders may override, and requires recursive to be true. Rejected for all other behavior types.
    # @option params [Boolean] recursive Whether the behavior should apply to child folders. This is only configurable for behavior types whose recursion mode is `sometimes`; `always` behaviors stay recursive and `never` behaviors stay non-recursive.
    # @option params [String] name Name for this behavior.
    # @option params [String] description Description for this behavior.
    # @option params [Hash, String, Integer] attachment_delete If `true`, delete the file stored in `attachment`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Behavior] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be one of Hash, String, Integer") if !params[:id].nil? and [ Hash, String, Integer ].none? { |klass| params[:id].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: value must be an Hash") if !params[:value].nil? and !params[:value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: disable_parent_folder_behavior must be a single value, not #{params[:disable_parent_folder_behavior].class}") if [ Array, Hash ].any? { |klass| params[:disable_parent_folder_behavior].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: attachment_delete must be one of Hash, String, Integer") if !params[:attachment_delete].nil? and [ Hash, String, Integer ].none? { |klass| params[:attachment_delete].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/behaviors/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("Behavior") }
      Behavior.new(response.data, options)
    end

    # Delete Behavior
    #
    # @param id [Integer] Behavior ID.
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

      Api.send_request("/behaviors/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
