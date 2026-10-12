# frozen_string_literal: true

module Files
  # Files::HolidayRegion is the Ruby SDK's representation of Files.com API HolidayRegion objects.
  # Each instance keeps its API field values in +attributes+.
  class HolidayRegion
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - The code representing a region
    def code
      @attributes[:code]
    end

    # string - The name of the region
    def name
      @attributes[:name]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::HolidayRegion objects.
    def self.get_supported(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)

      list_options = options.dup
      List.new(HolidayRegion, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/holiday_regions/supported", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end
  end
end
