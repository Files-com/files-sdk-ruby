# frozen_string_literal: true

module Files
  class As2IncomingMessage
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

    # int64 - Id of the AS2 Station associated with this message.
    def as2_station_id
      @attributes[:as2_station_id]
    end

    # string - UUID assigned to this message.
    def uuid
      @attributes[:uuid]
    end

    # string - Content Type header of the incoming message.
    def content_type
      @attributes[:content_type]
    end

    # object - HTTP Headers sent with this message.
    def http_headers
      @attributes[:http_headers]
    end

    # string - JSON Structure of the activity log.
    def activity_log
      @attributes[:activity_log]
    end

    # string - Result of processing.
    def processing_result
      @attributes[:processing_result]
    end

    # string - Result of processing description.
    def processing_result_description
      @attributes[:processing_result_description]
    end

    # string - AS2 Message Integrity Check
    def mic
      @attributes[:mic]
    end

    # string - AS2 Message Integrity Check Algorithm Used
    def mic_algo
      @attributes[:mic_algo]
    end

    # string - AS2 TO header of message
    def as2_to
      @attributes[:as2_to]
    end

    # string - AS2 FROM header of message
    def as2_from
      @attributes[:as2_from]
    end

    # string - AS2 Message Id
    def message_id
      @attributes[:message_id]
    end

    # string - AS2 Subject Header
    def subject
      @attributes[:subject]
    end

    # string - Date Header
    def date
      @attributes[:date]
    end

    # string - Encrypted Payload Body Size
    def body_size
      @attributes[:body_size]
    end

    # string - Filename of the file being received.
    def attachment_filename
      @attributes[:attachment_filename]
    end

    # string - IP Address of the Sender
    def ip
      @attributes[:ip]
    end

    # date-time - Message creation date/time
    def created_at
      @attributes[:created_at]
    end

    # string - HTTP Response Code sent for this message
    def http_response_code
      @attributes[:http_response_code]
    end

    # object - HTTP Headers sent for this message.
    def http_response_headers
      @attributes[:http_response_headers]
    end

    # string - Incoming Message Recipient(the Client Cert used to encrypt this message)'s serial
    def recipient_serial
      @attributes[:recipient_serial]
    end

    # string - Incoming Message Recipient(the Client Cert used to encrypt this message)'s serial in hex format.
    def hex_recipient_serial
      @attributes[:hex_recipient_serial]
    end

    # string - Incoming Message Recipient(the Client Cert used to encrypt this message)'s issuer
    def recipient_issuer
      @attributes[:recipient_issuer]
    end

    # boolean - Message body received?
    def message_received
      @attributes[:message_received]
    end

    # boolean - Message decrypted successfully?
    def message_decrypted
      @attributes[:message_decrypted]
    end

    # boolean - Message signature verified?
    def message_signature_verified
      @attributes[:message_signature_verified]
    end

    # boolean - Message processed successfully?
    def message_processing_success
      @attributes[:message_processing_success]
    end

    # boolean - MDN returned?
    def message_mdn_returned
      @attributes[:message_mdn_returned]
    end

    # string - URL to download the encrypted signed smime that is to sent as AS2 body
    def encrypted_uri
      @attributes[:encrypted_uri]
    end

    # string - URL to download the file contents as smime with signature
    def smime_signed_uri
      @attributes[:smime_signed_uri]
    end

    # string - URL to download the file contents encoded as smime
    def smime_uri
      @attributes[:smime_uri]
    end

    # string - URL to download the original file contents
    def raw_uri
      @attributes[:raw_uri]
    end

    # string - URL to download the http response body
    def mdn_response_uri
      @attributes[:mdn_response_uri]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction (e.g. `sort_by[created_at]=desc`). Valid fields are `created_at` and `as2_partner_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `created_at`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `created_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `created_at`.
    #   as2_partner_id - int64 - As2 Partner ID.  If provided, will return message specific to that partner.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: as2_partner_id must be an Integer") if params[:as2_partner_id] and !params[:as2_partner_id].is_a?(Integer)

      List.new(As2IncomingMessage, params) do
        Api.send_request("/as2_incoming_messages", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
