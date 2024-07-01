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

    # string - A note sent to the recipient with the bundle.
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

    # date-time - When the Bundle was shared with this recipient.
    def sent_at
      @attributes[:sent_at]
    end

    def sent_at=(value)
      @attributes[:sent_at] = value
    end

    # int64 - Bundle to share.
    def bundle_id
      @attributes[:bundle_id]
    end

    def bundle_id=(value)
      @attributes[:bundle_id] = value
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
        raise NotImplementedError.new("The BundleRecipient object doesn't support updates.")
      else
        new_obj = BundleRecipient.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string
    #   page - int64
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction (e.g. `sort_by[has_registrations]=desc`). Valid fields are `has_registrations`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `has_registrations`.
    #   bundle_id (required) - int64 - List recipients for the bundle with this ID.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params[:action] and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params[:page] and !params[:page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: bundle_id must be an Integer") if params[:bundle_id] and !params[:bundle_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: bundle_id") unless params[:bundle_id]

      List.new(BundleRecipient, params) do
        Api.send_request("/bundle_recipients", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   bundle_id (required) - int64 - Bundle to share.
    #   recipient (required) - string - Email addresses to share this bundle with.
    #   name - string - Name of recipient.
    #   company - string - Company of recipient.
    #   note - string - Note to include in email.
    #   share_after_create - boolean - Set to true to share the link with the recipient upon creation.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: bundle_id must be an Integer") if params[:bundle_id] and !params[:bundle_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: recipient must be an String") if params[:recipient] and !params[:recipient].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: company must be an String") if params[:company] and !params[:company].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params[:note] and !params[:note].is_a?(String)
      raise MissingParameterError.new("Parameter missing: bundle_id") unless params[:bundle_id]
      raise MissingParameterError.new("Parameter missing: recipient") unless params[:recipient]

      response, options = Api.send_request("/bundle_recipients", :post, params, options)
      BundleRecipient.new(response.data, options)
    end
  end
end
