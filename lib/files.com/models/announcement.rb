# frozen_string_literal: true

module Files
  class Announcement
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Announcement body
    def body
      @attributes[:body]
    end

    # string - Text to go on the CTA button
    def button_text
      @attributes[:button_text]
    end

    # string - URL to link to when CTA button is clicked
    def button_url
      @attributes[:button_url]
    end

    # string - Announcement headline
    def headline
      @attributes[:headline]
    end

    # string - Body converted to HTML
    def html_body
      @attributes[:html_body]
    end

    # string - Text for a label that can be added to the announcement
    def label
      @attributes[:label]
    end

    # string - Color for label on announcement
    def label_color
      @attributes[:label_color]
    end

    # date-time - When was this announcement published?
    def publish_at
      @attributes[:publish_at]
    end

    # string - URL slug for announcement
    def slug
      @attributes[:slug]
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/announcements", :get, params, options)
      response.data.map { |object| Announcement.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
