# frozen_string_literal: true

module Files
  class BundleRegistration
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Registration cookie code
    def code
      @attributes[:code]
    end

    # string - Registrant name
    def name
      @attributes[:name]
    end

    # string - Registrant company name
    def company
      @attributes[:company]
    end

    # string - Registrant email address
    def email
      @attributes[:email]
    end

    # string - Registrant IP Address
    def ip
      @attributes[:ip]
    end

    # string - InboxRegistration cookie code, if there is an associated InboxRegistration
    def inbox_code
      @attributes[:inbox_code]
    end

    # string - Clickwrap text that was shown to the registrant
    def clickwrap_body
      @attributes[:clickwrap_body]
    end

    # int64 - Id of associated form field set
    def form_field_set_id
      @attributes[:form_field_set_id]
    end

    # object - Data for form field set with form field ids as keys and user data as values
    def form_field_data
      @attributes[:form_field_data]
    end

    # string - Bundle URL code
    def bundle_code
      @attributes[:bundle_code]
    end

    # int64 - Id of associated bundle
    def bundle_id
      @attributes[:bundle_id]
    end

    # int64 - Id of associated bundle recipient
    def bundle_recipient_id
      @attributes[:bundle_recipient_id]
    end

    # date-time - Registration creation date/time
    def created_at
      @attributes[:created_at]
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `bundle_id`.
    #   bundle_id - int64 - ID of the associated Bundle
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: bundle_id must be an Integer") if params[:bundle_id] and !params[:bundle_id].is_a?(Integer)

      List.new(BundleRegistration, params) do
        Api.send_request("/bundle_registrations", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
