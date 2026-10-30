# frozen_string_literal: true

module Files
  # Files::BundleRecipient is the Ruby SDK's representation of Files.com API BundleRecipient objects.
  # Each instance keeps its API field values in +attributes+.
  class BundleRecipient
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

    # The recipient's company.
    # @return [String, nil] the field value, or nil when absent.
    def company
      @attributes[:company]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def company=(value)
      @attributes[:company] = value
    end

    # The recipient's name.
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

    # A note sent to the recipient with the bundle.
    # @return [String, nil] the field value, or nil when absent.
    def note
      @attributes[:note]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def note=(value)
      @attributes[:note] = value
    end

    # The recipient's email address.
    # @return [String, nil] the field value, or nil when absent.
    def recipient
      @attributes[:recipient]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def recipient=(value)
      @attributes[:recipient] = value
    end

    # When the Bundle was shared with this recipient.
    # @return [String, nil] the field value, or nil when absent.
    def sent_at
      @attributes[:sent_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def sent_at=(value)
      @attributes[:sent_at] = value
    end

    # Workspace ID. `0` means the default workspace.
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

    # Bundle to share.
    # @return [Integer, nil] the field value, or nil when absent.
    def bundle_id
      @attributes[:bundle_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def bundle_id=(value)
      @attributes[:bundle_id] = value
    end

    # Set to true to share the link with the recipient upon creation.
    # @return [Boolean, nil] the field value, or nil when absent.
    def share_after_create
      @attributes[:share_after_create]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def share_after_create=(value)
      @attributes[:share_after_create] = value
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    # @raise [Files::NotImplementedError] if this record already has an id; updates are unsupported.
    def save
      if @attributes[:id]
        raise NotImplementedError.new("The BundleRecipient object doesn't support updates.")
      else
        new_obj = BundleRecipient.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Share Link Recipients
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `has_registrations`.
    # @option params [Integer] bundle_id Required. List recipients for the bundle with this ID.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: bundle_id must be an Integer") if !params[:bundle_id].nil? and !params[:bundle_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: bundle_id") if params[:bundle_id].nil?

      list_options = options.dup
      List.new(BundleRecipient, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/bundle_recipients", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Create Share Link Recipient
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [Integer] bundle_id Required. Bundle to share.
    # @option params [String] recipient Required. Email addresses to share this bundle with.
    # @option params [String] name Name of recipient.
    # @option params [String] company Company of recipient.
    # @option params [String] note Note to include in email.
    # @option params [Boolean] share_after_create Set to true to share the link with the recipient upon creation.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::BundleRecipient] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: bundle_id must be an Integer") if !params[:bundle_id].nil? and !params[:bundle_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recipient must be an String") if !params[:recipient].nil? and !params[:recipient].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company must be an String") if !params[:company].nil? and !params[:company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if !params[:note].nil? and !params[:note].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: share_after_create must be a single value, not #{params[:share_after_create].class}") if [ Array, Hash ].any? { |klass| params[:share_after_create].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: bundle_id") if params[:bundle_id].nil?
      raise MissingParameterError.new("Parameter missing: recipient") if params[:recipient].nil?

      response, options = Api.send_request("/bundle_recipients", :post, params, options) { |reply| reply.require_object("BundleRecipient") }
      BundleRecipient.new(response.data, options)
    end
  end
end
