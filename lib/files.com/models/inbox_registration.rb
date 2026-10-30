# frozen_string_literal: true

module Files
  # Files::InboxRegistration is the Ruby SDK's representation of Files.com API InboxRegistration objects.
  # Each instance keeps its API field values in +attributes+.
  class InboxRegistration
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

    # Registration cookie code
    # @return [String, nil] the field value, or nil when absent.
    def code
      @attributes[:code]
    end

    # Registrant name
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Registrant company name
    # @return [String, nil] the field value, or nil when absent.
    def company
      @attributes[:company]
    end

    # Registrant email address
    # @return [String, nil] the field value, or nil when absent.
    def email
      @attributes[:email]
    end

    # Registrant IP Address
    # @return [String, nil] the field value, or nil when absent.
    def ip
      @attributes[:ip]
    end

    # Clickwrap text that was shown to the registrant
    # @return [String, nil] the field value, or nil when absent.
    def clickwrap_body
      @attributes[:clickwrap_body]
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

    # Id of associated inbox
    # @return [Integer, nil] the field value, or nil when absent.
    def inbox_id
      @attributes[:inbox_id]
    end

    # Id of associated inbox recipient
    # @return [Integer, nil] the field value, or nil when absent.
    def inbox_recipient_id
      @attributes[:inbox_recipient_id]
    end

    # Title of associated inbox
    # @return [String, nil] the field value, or nil when absent.
    def inbox_title
      @attributes[:inbox_title]
    end

    # Registration creation date/time
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # List Inbox Registrations
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Integer] folder_behavior_id ID of the associated Inbox. This is required if the user is not a site admin.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: folder_behavior_id must be an Integer") if !params[:folder_behavior_id].nil? and !params[:folder_behavior_id].is_a?(Integer)

      list_options = options.dup
      List.new(InboxRegistration, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/inbox_registrations", :get, page_params, list_options, &check_page)
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
