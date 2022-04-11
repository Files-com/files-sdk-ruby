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
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   as2_partner_id - int64 - As2 Partner ID.  If provided, will return message specific to that partner.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: as2_partner_id must be an Integer") if params.dig(:as2_partner_id) and !params.dig(:as2_partner_id).is_a?(Integer)

      List.new(As2IncomingMessage, params) do
        Api.send_request("/as2_incoming_messages", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
