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

    # int64 - Id of the AS2 Station associated with this message.
    def as2_station_id
      @attributes[:as2_station_id]
    end

    # string - UUID assigned to this message.
    def uuid
      @attributes[:uuid]
    end

    # object - HTTP Headers sent with this message.
    def http_headers
      @attributes[:http_headers]
    end

    # string - Result of processing.
    def processing_result
      @attributes[:processing_result]
    end

    # string - Result of processing description.
    def processing_result_description
      @attributes[:processing_result_description]
    end

    # string - AS2 Message Integrity Check SHA1
    def mic
      @attributes[:mic]
    end

    # string - AS2 Message Integrity Check SHA256
    def mic_sha_256
      @attributes[:mic_sha_256]
    end

    # string - AS2 TO
    def as2_to
      @attributes[:as2_to]
    end

    # string - AS2 FROM
    def as2_from
      @attributes[:as2_from]
    end

    # string - Date Header
    def date
      @attributes[:date]
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

    # string - HTTP Response Code received for this message
    def http_response_code
      @attributes[:http_response_code]
    end

    # object - HTTP Headers received for this message.
    def http_response_headers
      @attributes[:http_response_headers]
    end

    # double - HTTP transmission duration in seceonds
    def http_transmission_duration
      @attributes[:http_transmission_duration]
    end

    # boolean - Did the partner give a response body?
    def mdn_received
      @attributes[:mdn_received]
    end

    # boolean - Is the response in MDN format?
    def mdn_valid
      @attributes[:mdn_valid]
    end

    # boolean - MDN signature verified?
    def mdn_signature_verified
      @attributes[:mdn_signature_verified]
    end

    # boolean - MDN message id matched?
    def mdn_message_id_matched
      @attributes[:mdn_message_id_matched]
    end

    # boolean - MDN MIC matched?
    def mdn_mic_matched
      @attributes[:mdn_mic_matched]
    end

    # boolean - MDN disposition indicate a successful processing?
    def mdn_processing_success
      @attributes[:mdn_processing_success]
    end

    # string - URL to download the original file contents
    def raw_uri
      @attributes[:raw_uri]
    end

    # string - URL to download the file contents encoded as smime
    def smime_uri
      @attributes[:smime_uri]
    end

    # string - URL to download the file contents as smime with signature
    def smime_signed_uri
      @attributes[:smime_signed_uri]
    end

    # string - URL to download the encrypted signed smime that is to sent as AS2 body
    def encrypted_uri
      @attributes[:encrypted_uri]
    end

    # string - URL to download the http response body
    def mdn_response_uri
      @attributes[:mdn_response_uri]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at` and `as2_partner_id`.
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

      List.new(As2OutgoingMessage, params) do
        Api.send_request("/as2_outgoing_messages", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
