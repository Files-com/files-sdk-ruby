# frozen_string_literal: true

module Files
  class As2OutgoingMessage
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Id of the AS2 Partner.
    def id
      @attributes[:id]
    end

    # int64 - Id of the AS2 Partner associated with this message.
    def as2_partner_id
      @attributes[:as2_partner_id]
    end

    # string - UUID assigned to this message.
    def uuid
      @attributes[:uuid]
    end

    # object - HTTP Headers sent with this message.
    def http_headers
      @attributes[:http_headers]
    end

    # string - JSON Structure of the activity log.
    def activity_log
      @attributes[:activity_log]
    end

    # string - Result of processing. Valid values: `send_failed`, `send_success`
    def processing_result
      @attributes[:processing_result]
    end

    # string - AS2 Message Integrity Check
    def mic
      @attributes[:mic]
    end

    # string - AS2 Message Id
    def message_id
      @attributes[:message_id]
    end

    # string - Encrypted Payload Body Size
    def body_size
      @attributes[:body_size]
    end

    # string - Filename of the file being sent.
    def attachment_filename
      @attributes[:attachment_filename]
    end

    # date-time - Message creation date/time
    def created_at
      @attributes[:created_at]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   as2_partner_id - int64 - As2 Partner ID.  If provided, will return message specific to that partner.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: as2_partner_id must be an Integer") if params.dig(:as2_partner_id) and !params.dig(:as2_partner_id).is_a?(Integer)

      List.new(As2OutgoingMessage, params) do
        Api.send_request("/as2_outgoing_messages", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
