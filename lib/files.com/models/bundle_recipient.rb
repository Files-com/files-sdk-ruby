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
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `has_registrations`.
    #   filter - object - If set, return records where the specifiied field is equal to the supplied value. Valid fields are `has_registrations`.
    #   filter_gt - object - If set, return records where the specifiied field is greater than the supplied value. Valid fields are `has_registrations`.
    #   filter_gteq - object - If set, return records where the specifiied field is greater than or equal to the supplied value. Valid fields are `has_registrations`.
    #   filter_like - object - If set, return records where the specifiied field is equal to the supplied value. Valid fields are `has_registrations`.
    #   filter_lt - object - If set, return records where the specifiied field is less than the supplied value. Valid fields are `has_registrations`.
    #   filter_lteq - object - If set, return records where the specifiied field is less than or equal to the supplied value. Valid fields are `has_registrations`.
    #   bundle_id (required) - int64 - List recipients for the bundle with this ID.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params.dig(:sort_by) and !params.dig(:sort_by).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params.dig(:filter) and !params.dig(:filter).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params.dig(:filter_gt) and !params.dig(:filter_gt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params.dig(:filter_gteq) and !params.dig(:filter_gteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params.dig(:filter_like) and !params.dig(:filter_like).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params.dig(:filter_lt) and !params.dig(:filter_lt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params.dig(:filter_lteq) and !params.dig(:filter_lteq).is_a?(Hash)
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
