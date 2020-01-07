# frozen_string_literal: true

module Files
  class RegionalMigration
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Regional migration ID
    def id
      @attributes[:id]
    end

    # int64 - Number of files moved
    def files_moved
      @attributes[:files_moved]
    end

    # int64 - Total number of files
    def files_total
      @attributes[:files_total]
    end

    # string - Source path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # string - Region
    def region
      @attributes[:region]
    end

    # string - Status
    def status
      @attributes[:status]
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/regional_migrations", :get, params, options)
      response.data.map { |object| RegionalMigration.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
