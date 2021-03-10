# frozen_string_literal: true

module Files
  class InboxRegistration
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Registration cookie code
    def code
      @attributes[:code]
    end

    # string - Registrant name
    def name
      @attributes[:name]
    end

    # string - Registrant company name
    def company
      @attributes[:company]
    end

    # string - Registrant email address
    def email
      @attributes[:email]
    end

    # int64 - Id of associated form field set
    def form_field_set_id
      @attributes[:form_field_set_id]
    end

    # string - Data for form field set with form field ids as keys and user data as values
    def form_field_data
      @attributes[:form_field_data]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   folder_behavior_id (required) - int64 - ID of the associated Inbox.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: folder_behavior_id must be an Integer") if params.dig(:folder_behavior_id) and !params.dig(:folder_behavior_id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: folder_behavior_id") unless params.dig(:folder_behavior_id)

      List.new(InboxRegistration, params) do
        Api.send_request("/inbox_registrations", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
