# frozen_string_literal: true

module Files
  # Files::BundleAction is the Ruby SDK's representation of Files.com API BundleAction objects.
  # Each instance keeps its API field values in +attributes+.
  class BundleAction
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

    # Type of action
    # @return [String, nil] the field value, or nil when absent.
    def action
      @attributes[:action]
    end

    # Object that contains bundle registration information
    # @return [Hash, nil] the field value, or nil when absent.
    def bundle_registration
      @attributes[:bundle_registration]
    end

    # Action occurrence date/time
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # The destination path for this bundle action, if applicable
    # @return [String, nil] the field value, or nil when absent.
    def destination
      @attributes[:destination]
    end

    # Path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # The source path for this bundle action, if applicable
    # @return [String, nil] the field value, or nil when absent.
    def source
      @attributes[:source]
    end

    # Identifier of the associated bundle registration
    # @return [Integer, nil] the field value, or nil when absent.
    def bundle_registration_id
      @attributes[:bundle_registration_id]
    end

    # Workspace ID. `0` means the default workspace.
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Name of the registrant who performed the action
    # @return [String, nil] the field value, or nil when absent.
    def bundle_registration_name
      @attributes[:bundle_registration_name]
    end

    # Email of the registrant
    # @return [String, nil] the field value, or nil when absent.
    def bundle_registration_email
      @attributes[:bundle_registration_email]
    end

    # IP address of the registrant
    # @return [String, nil] the field value, or nil when absent.
    def bundle_registration_ip
      @attributes[:bundle_registration_ip]
    end

    # Id of associated form field set
    # @return [Integer, nil] the field value, or nil when absent.
    def form_field_set_id
      @attributes[:form_field_set_id]
    end

    # Data for form field set with form field ids as keys and user data as values
    # @return [Hash, nil] the field value, or nil when absent.
    def form_field_data
      @attributes[:form_field_data]
    end

    # List Bundle Actions
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `created_at` or `bundle_registration_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at`, `bundle_id` or `bundle_registration_id`. Valid field combinations are `[ bundle_id, created_at ]`, `[ bundle_registration_id, created_at ]`, `[ bundle_id, bundle_registration_id ]` or `[ bundle_id, bundle_registration_id, created_at ]`.
    # @option params [Hash] filter_gt If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_gteq If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_lt If set, return records where the specified field is less than the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_lteq If set, return records where the specified field is less than or equal the supplied value. Valid fields are `created_at`.
    # @option params [Integer] bundle_id Bundle ID
    # @option params [Integer] bundle_registration_id Bundle Registration ID
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
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if !params[:filter_gt].nil? and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if !params[:filter_gteq].nil? and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if !params[:filter_lt].nil? and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if !params[:filter_lteq].nil? and !params[:filter_lteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: bundle_id must be an Integer") if !params[:bundle_id].nil? and !params[:bundle_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: bundle_registration_id must be an Integer") if !params[:bundle_registration_id].nil? and !params[:bundle_registration_id].is_a?(Integer)

      list_options = options.dup
      List.new(BundleAction, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/bundle_actions", :get, page_params, list_options, &check_page)
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
