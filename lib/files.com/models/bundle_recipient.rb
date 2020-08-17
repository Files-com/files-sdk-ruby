# frozen_string_literal: true

module Files
  class BundleRecipient
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - The recipient's company.
    def company
      @attributes[:company]
    end

    # string - The recipient's name.
    def name
      @attributes[:name]
    end

    # string - A note sent to the recipient with the bundle.
    def note
      @attributes[:note]
    end

    # string - The recipient's email address.
    def recipient
      @attributes[:recipient]
    end

    # date-time - When the Bundle was shared with this recipient.
    def sent_at
      @attributes[:sent_at]
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   page - int64 - Current page number.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    #   cursor - string - Send cursor to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   bundle_id (required) - int64 - List recipients for the bundle with this ID.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bundle_id must be an Integer") if params.dig(:bundle_id) and !params.dig(:bundle_id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: bundle_id") unless params.dig(:bundle_id)

      List.new(BundleRecipient, params) do
        Api.send_request("/bundle_recipients", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
