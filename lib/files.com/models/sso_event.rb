# frozen_string_literal: true

module Files
  # Files::SsoEvent is the Ruby SDK's representation of Files.com API SsoEvent objects.
  # Each instance keeps its API field values in +attributes+.
  class SsoEvent
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

    # Event ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Type of SSO event being recorded.
    # @return [String, nil] the field value, or nil when absent.
    def event_type
      @attributes[:event_type]
    end

    # Status of event.
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Event body.
    # @return [String, nil] the field value, or nil when absent.
    def body
      @attributes[:body]
    end

    # Event errors.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def event_errors
      @attributes[:event_errors]
    end

    # Event create date/time.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Link to log file.
    # @return [String, nil] the field value, or nil when absent.
    def body_url
      @attributes[:body_url]
    end

    # User ID.
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # Username on Files.com for the SSO login attempt.
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # Identity Provider UID for the SSO login attempt.
    # @return [String, nil] the field value, or nil when absent.
    def idp_uid
      @attributes[:idp_uid]
    end

    # SSO provider for the SSO login attempt.
    # @return [String, nil] the field value, or nil when absent.
    def provider
      @attributes[:provider]
    end

    # SSO provider label for the SSO login attempt.
    # @return [String, nil] the field value, or nil when absent.
    def provider_label
      @attributes[:provider_label]
    end

    # IP address for the SSO login attempt.
    # @return [String, nil] the field value, or nil when absent.
    def ip
      @attributes[:ip]
    end

    # Region for the SSO login attempt.
    # @return [String, nil] the field value, or nil when absent.
    def region
      @attributes[:region]
    end

    # List SSO Events
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`, `event_type`, `status` or `user_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at`, `event_type`, `idp_uid`, `ip`, `provider`, `status`, `user_id` or `username`. Valid field combinations are `[ event_type, created_at ]`, `[ idp_uid, created_at ]`, `[ ip, created_at ]`, `[ provider, created_at ]`, `[ status, created_at ]`, `[ user_id, created_at ]`, `[ username, created_at ]`, `[ event_type, status ]`, `[ idp_uid, status ]`, `[ ip, status ]`, `[ provider, status ]`, `[ user_id, status ]`, `[ username, status ]`, `[ event_type, status, created_at ]`, `[ idp_uid, status, created_at ]`, `[ ip, status, created_at ]`, `[ provider, status, created_at ]`, `[ user_id, status, created_at ]` or `[ username, status, created_at ]`.
    # @option params [Hash] filter_gt If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_gteq If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_prefix If set, return records where the specified field is prefixed by the supplied value. Valid fields are `idp_uid`, `ip`, `provider` or `username`.
    # @option params [Hash] filter_lt If set, return records where the specified field is less than the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_lteq If set, return records where the specified field is less than or equal the supplied value. Valid fields are `created_at`.
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
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if !params[:filter_gt].nil? and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if !params[:filter_gteq].nil? and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if !params[:filter_prefix].nil? and !params[:filter_prefix].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if !params[:filter_lt].nil? and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if !params[:filter_lteq].nil? and !params[:filter_lteq].is_a?(Hash)

      list_options = options.dup
      List.new(SsoEvent, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/sso_events", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show SSO Event
    #
    # @param id [Integer] Sso Event ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::SsoEvent] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/sso_events/#{params[:id]}", :get, params, options) { |reply| reply.require_object("SsoEvent") }
      SsoEvent.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end
  end
end
