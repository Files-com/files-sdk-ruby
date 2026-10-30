# frozen_string_literal: true

module Files
  # Files::FormFieldSet is the Ruby SDK's representation of Files.com API FormFieldSet objects.
  # Each instance keeps its API field values in +attributes+.
  class FormFieldSet
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

    # Form field set id
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

    # Title to be displayed
    # @return [String, nil] the field value, or nil when absent.
    def title
      @attributes[:title]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def title=(value)
      @attributes[:title] = value
    end

    # Reject answers over 1024 characters or more than 32 answered custom fields to ensure complete file metadata capture
    # @return [Boolean, nil] the field value, or nil when absent.
    def require_complete_metadata_capture
      @attributes[:require_complete_metadata_capture]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def require_complete_metadata_capture=(value)
      @attributes[:require_complete_metadata_capture] = value
    end

    # Layout of the form
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def form_layout
      @attributes[:form_layout]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def form_layout=(value)
      @attributes[:form_layout] = value
    end

    # Associated form field definitions; authenticated form field set responses include historical definitions, while form_layout identifies current fields
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def form_fields
      @attributes[:form_fields]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Hash>, nil] the new field value.
    # @return [Array<Hash>, nil] the assigned value.
    def form_fields=(value)
      @attributes[:form_fields] = value
    end

    # Any associated InboxRegistrations or BundleRegistrations can be saved without providing name
    # @return [Boolean, nil] the field value, or nil when absent.
    def skip_name
      @attributes[:skip_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def skip_name=(value)
      @attributes[:skip_name] = value
    end

    # Any associated InboxRegistrations or BundleRegistrations can be saved without providing email
    # @return [Boolean, nil] the field value, or nil when absent.
    def skip_email
      @attributes[:skip_email]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def skip_email=(value)
      @attributes[:skip_email] = value
    end

    # Any associated InboxRegistrations or BundleRegistrations can be saved without providing company
    # @return [Boolean, nil] the field value, or nil when absent.
    def skip_company
      @attributes[:skip_company]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def skip_company=(value)
      @attributes[:skip_company] = value
    end

    # Form Field Set is in use by an active Inbox / Bundle / Inbox Registration / Bundle Registration
    # @return [Boolean, nil] the field value, or nil when absent.
    def in_use
      @attributes[:in_use]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def in_use=(value)
      @attributes[:in_use] = value
    end

    # User ID.  Provide a value of `0` to operate the current session's user.
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def user_id=(value)
      @attributes[:user_id] = value
    end

    # Workspace ID
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # Update Form Field Set
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] title Title to be displayed
    # @option params [Boolean] require_complete_metadata_capture Reject answers over 1024 characters or more than 32 answered custom fields to ensure complete file metadata capture
    # @option params [Integer] workspace_id Workspace ID
    # @option params [Boolean] skip_email Skip validating form email
    # @option params [Boolean] skip_name Skip validating form name
    # @option params [Boolean] skip_company Skip validating company
    # @option params [Array<Hash>] form_fields
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: title must be an String") if !params[:title].nil? and !params[:title].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: require_complete_metadata_capture must be a single value, not #{params[:require_complete_metadata_capture].class}") if [ Array, Hash ].any? { |klass| params[:require_complete_metadata_capture].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: skip_email must be a single value, not #{params[:skip_email].class}") if [ Array, Hash ].any? { |klass| params[:skip_email].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_name must be a single value, not #{params[:skip_name].class}") if [ Array, Hash ].any? { |klass| params[:skip_name].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_company must be a single value, not #{params[:skip_company].class}") if [ Array, Hash ].any? { |klass| params[:skip_company].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: form_fields must be an Array") if !params[:form_fields].nil? and !params[:form_fields].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/form_field_sets/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("FormFieldSet") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Form Field Set
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

      response, options = Api.send_request("/form_field_sets/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = FormFieldSet.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Form Field Sets
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)

      list_options = options.dup
      List.new(FormFieldSet, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/form_field_sets", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Form Field Set
    #
    # @param id [Integer] Form Field Set ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::FormFieldSet] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/form_field_sets/#{params[:id]}", :get, params, options) { |reply| reply.require_object("FormFieldSet") }
      FormFieldSet.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Form Field Set
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] title Title to be displayed
    # @option params [Boolean] require_complete_metadata_capture Reject answers over 1024 characters or more than 32 answered custom fields to ensure complete file metadata capture
    # @option params [Integer] workspace_id Workspace ID
    # @option params [Boolean] skip_email Skip validating form email
    # @option params [Boolean] skip_name Skip validating form name
    # @option params [Boolean] skip_company Skip validating company
    # @option params [Array<Hash>] form_fields
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::FormFieldSet] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: title must be an String") if !params[:title].nil? and !params[:title].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: require_complete_metadata_capture must be a single value, not #{params[:require_complete_metadata_capture].class}") if [ Array, Hash ].any? { |klass| params[:require_complete_metadata_capture].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: skip_email must be a single value, not #{params[:skip_email].class}") if [ Array, Hash ].any? { |klass| params[:skip_email].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_name must be a single value, not #{params[:skip_name].class}") if [ Array, Hash ].any? { |klass| params[:skip_name].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_company must be a single value, not #{params[:skip_company].class}") if [ Array, Hash ].any? { |klass| params[:skip_company].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: form_fields must be an Array") if !params[:form_fields].nil? and !params[:form_fields].is_a?(Array)

      response, options = Api.send_request("/form_field_sets", :post, params, options) { |reply| reply.require_object("FormFieldSet") }
      FormFieldSet.new(response.data, options)
    end

    # Update Form Field Set
    #
    # @param id [Integer] Form Field Set ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] title Title to be displayed
    # @option params [Boolean] require_complete_metadata_capture Reject answers over 1024 characters or more than 32 answered custom fields to ensure complete file metadata capture
    # @option params [Integer] workspace_id Workspace ID
    # @option params [Boolean] skip_email Skip validating form email
    # @option params [Boolean] skip_name Skip validating form name
    # @option params [Boolean] skip_company Skip validating company
    # @option params [Array<Hash>] form_fields
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::FormFieldSet] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: title must be an String") if !params[:title].nil? and !params[:title].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: require_complete_metadata_capture must be a single value, not #{params[:require_complete_metadata_capture].class}") if [ Array, Hash ].any? { |klass| params[:require_complete_metadata_capture].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: skip_email must be a single value, not #{params[:skip_email].class}") if [ Array, Hash ].any? { |klass| params[:skip_email].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_name must be a single value, not #{params[:skip_name].class}") if [ Array, Hash ].any? { |klass| params[:skip_name].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_company must be a single value, not #{params[:skip_company].class}") if [ Array, Hash ].any? { |klass| params[:skip_company].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: form_fields must be an Array") if !params[:form_fields].nil? and !params[:form_fields].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/form_field_sets/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("FormFieldSet") }
      FormFieldSet.new(response.data, options)
    end

    # Delete Form Field Set
    #
    # @param id [Integer] Form Field Set ID.
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

      Api.send_request("/form_field_sets/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
