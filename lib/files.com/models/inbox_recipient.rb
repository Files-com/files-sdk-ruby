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
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `has_registrations`.
    #   inbox_id (required) - int64 - List recipients for the inbox with this ID.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if params[:inbox_id] and !params[:inbox_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: inbox_id") unless params[:inbox_id]

      List.new(InboxRecipient, params) do
        Api.send_request("/inbox_recipients", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   inbox_id (required) - int64 - Inbox to share.
    #   recipient (required) - string - Email address to share this inbox with.
    #   name - string - Name of recipient.
    #   company - string - Company of recipient.
    #   note - string - Note to include in email.
    #   share_after_create - boolean - Set to true to share the link with the recipient upon creation.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if params[:inbox_id] and !params[:inbox_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recipient must be an String") if params[:recipient] and !params[:recipient].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company must be an String") if params[:company] and !params[:company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params[:note] and !params[:note].is_a?(String)
      raise MissingParameterError.new("Parameter missing: inbox_id") unless params[:inbox_id]
      raise MissingParameterError.new("Parameter missing: recipient") unless params[:recipient]

      response, options = Api.send_request("/inbox_recipients", :post, params, options)
      InboxRecipient.new(response.data, options)
    end

    # Parameters:
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `has_registrations`.
    #   inbox_id (required) - int64 - List recipients for the inbox with this ID.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if params[:inbox_id] and !params[:inbox_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: inbox_id") unless params[:inbox_id]

      response, options = Api.send_request("/inbox_recipients/create_export", :post, params, options)
      response.data.map do |entity_data|
        Export.new(entity_data, options)
      end
    end
  end
end
