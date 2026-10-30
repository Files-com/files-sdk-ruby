# frozen_string_literal: true

module Files
  # Files::As2OutgoingMessage is the Ruby SDK's representation of Files.com API As2OutgoingMessage objects.
  # Each instance keeps its API field values in +attributes+.
  class As2OutgoingMessage
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Id of the AS2 Partner.
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # ID of the Workspace associated with this AS2 Outgoing Message.
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Id of the AS2 Partner associated with this message.
    # @return [Integer, nil] the field value, or nil when absent.
    def as2_partner_id
      @attributes[:as2_partner_id]
    end

    # Id of the AS2 Station associated with this message.
    # @return [Integer, nil] the field value, or nil when absent.
    def as2_station_id
      @attributes[:as2_station_id]
    end

    # UUID assigned to this message.
    # @return [String, nil] the field value, or nil when absent.
    def uuid
      @attributes[:uuid]
    end

    # HTTP Headers sent with this message.
    # @return [Hash, nil] the field value, or nil when absent.
    def http_headers
      @attributes[:http_headers]
    end

    # Result of processing.
    # @return [String, nil] the field value, or nil when absent.
    def processing_result
      @attributes[:processing_result]
    end

    # Result of processing description.
    # @return [String, nil] the field value, or nil when absent.
    def processing_result_description
      @attributes[:processing_result_description]
    end

    # AS2 Message Integrity Check SHA1
    # @return [String, nil] the field value, or nil when absent.
    def mic
      @attributes[:mic]
    end

    # AS2 Message Integrity Check SHA256
    # @return [String, nil] the field value, or nil when absent.
    def mic_sha_256
      @attributes[:mic_sha_256]
    end

    # AS2 TO
    # @return [String, nil] the field value, or nil when absent.
    def as2_to
      @attributes[:as2_to]
    end

    # AS2 FROM
    # @return [String, nil] the field value, or nil when absent.
    def as2_from
      @attributes[:as2_from]
    end

    # AS2 Subject
    # @return [String, nil] the field value, or nil when absent.
    def as2_subject
      @attributes[:as2_subject]
    end

    # Date Header
    # @return [String, nil] the field value, or nil when absent.
    def date
      @attributes[:date]
    end

    # AS2 Message Id
    # @return [String, nil] the field value, or nil when absent.
    def message_id
      @attributes[:message_id]
    end

    # Encrypted Payload Body Size
    # @return [String, nil] the field value, or nil when absent.
    def body_size
      @attributes[:body_size]
    end

    # Filename of the file being sent.
    # @return [String, nil] the field value, or nil when absent.
    def attachment_filename
      @attributes[:attachment_filename]
    end

    # Message creation date/time
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # HTTP Response Code received for this message
    # @return [String, nil] the field value, or nil when absent.
    def http_response_code
      @attributes[:http_response_code]
    end

    # HTTP Headers received for this message.
    # @return [Hash, nil] the field value, or nil when absent.
    def http_response_headers
      @attributes[:http_response_headers]
    end

    # HTTP transmission duration in seceonds
    # @return [Float, nil] the field value, or nil when absent.
    def http_transmission_duration
      @attributes[:http_transmission_duration]
    end

    # Did the partner give a response body?
    # @return [Boolean, nil] the field value, or nil when absent.
    def mdn_received
      @attributes[:mdn_received]
    end

    # Is the response in MDN format?
    # @return [Boolean, nil] the field value, or nil when absent.
    def mdn_valid
      @attributes[:mdn_valid]
    end

    # MDN signature verified?
    # @return [Boolean, nil] the field value, or nil when absent.
    def mdn_signature_verified
      @attributes[:mdn_signature_verified]
    end

    # MDN message id matched?
    # @return [Boolean, nil] the field value, or nil when absent.
    def mdn_message_id_matched
      @attributes[:mdn_message_id_matched]
    end

    # MDN MIC matched?
    # @return [Boolean, nil] the field value, or nil when absent.
    def mdn_mic_matched
      @attributes[:mdn_mic_matched]
    end

    # MDN disposition indicate a successful processing?
    # @return [Boolean, nil] the field value, or nil when absent.
    def mdn_processing_success
      @attributes[:mdn_processing_success]
    end

    # URL to download the original file contents
    # @return [String, nil] the field value, or nil when absent.
    def raw_uri
      @attributes[:raw_uri]
    end

    # URL to download the file contents encoded as smime
    # @return [String, nil] the field value, or nil when absent.
    def smime_uri
      @attributes[:smime_uri]
    end

    # URL to download the file contents as smime with signature
    # @return [String, nil] the field value, or nil when absent.
    def smime_signed_uri
      @attributes[:smime_signed_uri]
    end

    # URL to download the encrypted signed smime that is to sent as AS2 body
    # @return [String, nil] the field value, or nil when absent.
    def encrypted_uri
      @attributes[:encrypted_uri]
    end

    # URL to download the http response body
    # @return [String, nil] the field value, or nil when absent.
    def mdn_response_uri
      @attributes[:mdn_response_uri]
    end

    # List AS2 Outgoing Messages
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `created_at` or `as2_partner_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at`, `as2_station_id`, `workspace_id` or `as2_partner_id`. Valid field combinations are `[ as2_station_id, created_at ]`, `[ workspace_id, created_at ]`, `[ as2_partner_id, created_at ]`, `[ workspace_id, as2_station_id ]`, `[ workspace_id, as2_partner_id ]`, `[ workspace_id, as2_station_id, created_at ]` or `[ workspace_id, as2_partner_id, created_at ]`.
    # @option params [Hash] filter_gt If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_gteq If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_lt If set, return records where the specified field is less than the supplied value. Valid fields are `created_at`.
    # @option params [Hash] filter_lteq If set, return records where the specified field is less than or equal the supplied value. Valid fields are `created_at`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if !params[:filter_gt].nil? and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if !params[:filter_gteq].nil? and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if !params[:filter_lt].nil? and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if !params[:filter_lteq].nil? and !params[:filter_lteq].is_a?(Hash)

      list_options = options.dup
      List.new(As2OutgoingMessage, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/as2_outgoing_messages", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
