# frozen_string_literal: true

module Files
  class Inbox
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
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

    # string - Inbox title
    def title
      @attributes[:title]
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/inboxes", :get, params, options)
      response.data.map { |object| Inbox.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
