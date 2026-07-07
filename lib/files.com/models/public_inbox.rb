# frozen_string_literal: true

module Files
  class PublicInbox
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Page link and button color
    def color_left
      @attributes[:color_left]
    end

    # string - Top bar link color
    def color_link
      @attributes[:color_link]
    end

    # string - Page link and button color
    def color_text
      @attributes[:color_text]
    end

    # string - Top bar background color
    def color_top
      @attributes[:color_top]
    end

    # string - Top bar text color
    def color_top_text
      @attributes[:color_top_text]
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

    # boolean - If true, we will hide the 'Remember Me' box on the Inbox registration page, requiring that the user logout and log back in every time they visit the page.
    def require_logout
      @attributes[:require_logout]
    end

    # Image - Custom logo for Inbox folder
    def logo
      @attributes[:logo]
    end

    # string - URL to open when a public visitor clicks the custom logo
    def logo_click_href
      @attributes[:logo_click_href]
    end

    # Image - Custom logo thumbnail for Inbox folder
    def thumbnail
      @attributes[:thumbnail]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(PublicInbox, params) do
        Api.send_request("/public_inboxes", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   key (required) - string - Unique key for inbox
    #   recipient_code - string - Inbox recipient code
    def self.get_key(key, params = {}, options = {})
      params ||= {}
      params[:key] = key
      raise InvalidParameterError.new("Bad parameter: key must be an String") if params[:key] and !params[:key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recipient_code must be an String") if params[:recipient_code] and !params[:recipient_code].is_a?(String)
      raise MissingParameterError.new("Parameter missing: key") unless params[:key]

      response, options = Api.send_request("/public_inboxes/key/#{params[:key]}", :get, params, options)
      PublicInbox.new(response.data, options)
    end

    def self.create_export(params = {}, options = {})
      response, options = Api.send_request("/public_inboxes/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
