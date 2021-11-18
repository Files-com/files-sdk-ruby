# frozen_string_literal: true

module Files
  class InboxRecipient
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - The recipient's company.
    def company
      @attributes[:company]
    end

    def company=(value)
      @attributes[:company] = value
    end

    # string - The recipient's name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - A note sent to the recipient with the inbox.
    def note
      @attributes[:note]
    end

    def note=(value)
      @attributes[:note] = value
    end

    # string - The recipient's email address.
    def recipient
      @attributes[:recipient]
    end

    def recipient=(value)
      @attributes[:recipient] = value
    end

    # date-time - When the Inbox was shared with this recipient.
    def sent_at
      @attributes[:sent_at]
    end

    def sent_at=(value)
      @attributes[:sent_at] = value
    end

    # int64 - User ID.  Provide a value of `0` to operate the current session's user.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # int64 - Inbox to share.
    def inbox_id
      @attributes[:inbox_id]
    end

    def inbox_id=(value)
      @attributes[:inbox_id] = value
    end

    # boolean - Set to true to share the link with the recipient upon creation.
    def share_after_create
      @attributes[:share_after_create]
    end

    def share_after_create=(value)
      @attributes[:share_after_create] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The InboxRecipient object doesn't support updates.")
      else
        new_obj = InboxRecipient.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `has_registrations`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `has_registrations`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `has_registrations`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal to the supplied value. Valid fields are `has_registrations`.
    #   filter_like - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `has_registrations`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `has_registrations`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal to the supplied value. Valid fields are `has_registrations`.
    #   inbox_id (required) - int64 - List recipients for the inbox with this ID.
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
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if params.dig(:inbox_id) and !params.dig(:inbox_id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: inbox_id") unless params.dig(:inbox_id)

      List.new(InboxRecipient, params) do
        Api.send_request("/inbox_recipients", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   inbox_id (required) - int64 - Inbox to share.
    #   recipient (required) - string - Email address to share this inbox with.
    #   name - string - Name of recipient.
    #   company - string - Company of recipient.
    #   note - string - Note to include in email.
    #   share_after_create - boolean - Set to true to share the link with the recipient upon creation.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if params.dig(:inbox_id) and !params.dig(:inbox_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recipient must be an String") if params.dig(:recipient) and !params.dig(:recipient).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company must be an String") if params.dig(:company) and !params.dig(:company).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params.dig(:note) and !params.dig(:note).is_a?(String)
      raise MissingParameterError.new("Parameter missing: inbox_id") unless params.dig(:inbox_id)
      raise MissingParameterError.new("Parameter missing: recipient") unless params.dig(:recipient)

      response, options = Api.send_request("/inbox_recipients", :post, params, options)
      InboxRecipient.new(response.data, options)
    end
  end
end
