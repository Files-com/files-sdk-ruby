# frozen_string_literal: true

module Files
  class Inbox
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Inbox title
    def title
      @attributes[:title]
    end

    # string - User description
    def description
      @attributes[:description]
    end

    # string - Text that will be shown to the users on the Inbox.  Use this field to provide custom instructions.
    def help_text
      @attributes[:help_text]
    end

    # string - Unique key for inbox
    def key
      @attributes[:key]
    end

    # boolean - Show this inbox on site login page?
    def show_on_login_page
      @attributes[:show_on_login_page]
    end

    # boolean - Is this inbox password protected?
    def has_password
      @attributes[:has_password]
    end

    # boolean - Does this inbox require registration?
    def require_registration
      @attributes[:require_registration]
    end

    # boolean - Should folder uploads be prevented?
    def dont_allow_folders_in_uploads
      @attributes[:dont_allow_folders_in_uploads]
    end

    # string - Legal text that must be agreed to prior to accessing Inbox.
    def clickwrap_body
      @attributes[:clickwrap_body]
    end

    # FormFieldSet - Custom Form to use
    def form_field_set
      @attributes[:form_field_set]
    end

    # boolean - Notify senders on successful uploads via email
    def notify_senders_on_successful_uploads_via_email
      @attributes[:notify_senders_on_successful_uploads_via_email]
    end

    # boolean - Notify senders on successful uploads via web
    def notify_senders_on_successful_uploads_via_web
      @attributes[:notify_senders_on_successful_uploads_via_web]
    end

    # boolean - allow/disallow whitelist
    def allow_whitelisting
      @attributes[:allow_whitelisting]
    end

    # array(string) - A list of emails and domain names for whitelisting
    def whitelist
      @attributes[:whitelist]
    end

    # boolean - This will disable the upload URL and can only be done if uploads via email are enabled
    def disable_web_upload
      @attributes[:disable_web_upload]
    end

    # string - inbound email address to the inbox
    def inbound_email_address
      @attributes[:inbound_email_address]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `allow_whitelisting`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      List.new(Inbox, params) do
        Api.send_request("/inboxes", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `allow_whitelisting`.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)

      response, options = Api.send_request("/inboxes/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
