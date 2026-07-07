# frozen_string_literal: true

module Files
  class Announcement
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Announcement Id
    def id
      @attributes[:id]
    end

    # string - Announcement headline
    def headline
      @attributes[:headline]
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
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)

      List.new(Announcement, params) do
        Api.send_request("/announcements", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)

      response, options = Api.send_request("/announcements/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
