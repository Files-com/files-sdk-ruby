# frozen_string_literal: true

module Files
  # Files::As2Partner is the Ruby SDK's representation of Files.com API As2Partner objects.
  # Each instance keeps its API field values in +attributes+.
  class As2Partner
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

    # ID of the AS2 Partner.
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def id=(value)
      @attributes[:id] = value
    end

    # ID of the Workspace associated with this AS2 Partner.
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # ID of the AS2 Station associated with this partner.
    # @return [Integer, nil] the field value, or nil when absent.
    def as2_station_id
      @attributes[:as2_station_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def as2_station_id=(value)
      @attributes[:as2_station_id] = value
    end

    # The partner's formal AS2 name.
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def name=(value)
      @attributes[:name] = value
    end

    # Public URI where we will send the AS2 messages (via HTTP/HTTPS).
    # @return [String, nil] the field value, or nil when absent.
    def uri
      @attributes[:uri]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def uri=(value)
      @attributes[:uri] = value
    end

    # Should we require that the remote HTTP server have a valid SSL Certificate for HTTPS? (This only applies to Outgoing AS2 message from Files.com to a Partner.)
    # @return [String, nil] the field value, or nil when absent.
    def server_certificate
      @attributes[:server_certificate]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def server_certificate=(value)
      @attributes[:server_certificate] = value
    end

    # Username to send to server for HTTP Authentication.
    # @return [String, nil] the field value, or nil when absent.
    def http_auth_username
      @attributes[:http_auth_username]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def http_auth_username=(value)
      @attributes[:http_auth_username] = value
    end

    # Additional HTTP Headers for outgoing message sent to this partner.
    # @return [Hash, nil] the field value, or nil when absent.
    def additional_http_headers
      @attributes[:additional_http_headers]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def additional_http_headers=(value)
      @attributes[:additional_http_headers] = value
    end

    # Default mime type of the file attached to the encrypted message
    # @return [String, nil] the field value, or nil when absent.
    def default_mime_type
      @attributes[:default_mime_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def default_mime_type=(value)
      @attributes[:default_mime_type] = value
    end

    # How should Files.com evaluate message transfer success based on a partner's MDN response?  This setting does not affect MDN storage; all MDNs received from a partner are always stored. `none`: MDN is stored for informational purposes only, a successful HTTPS transfer is a successful AS2 transfer. `weak`: Inspect the MDN for MIC and Disposition only. `normal`: `weak` plus validate MDN signature matches body, `strict`: `normal` but do not allow signatures from self-signed or incorrectly purposed certificates. `auto`: Automatically set the correct value for this setting based on next mdn received.
    # @return [String, nil] the field value, or nil when absent.
    def mdn_validation_level
      @attributes[:mdn_validation_level]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def mdn_validation_level=(value)
      @attributes[:mdn_validation_level] = value
    end

    # Should Files.com require signatures on incoming AS2 messages?  `normal`: require that incoming messages are signed with a valid matching signature. `none`: Unsigned incoming messages are allowed. `auto`: A one-time starting state. The next message received is always accepted and switches this to `normal` if it carries a valid signature, or `none` if it does not.
    # @return [String, nil] the field value, or nil when absent.
    def signature_validation_level
      @attributes[:signature_validation_level]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def signature_validation_level=(value)
      @attributes[:signature_validation_level] = value
    end

    # If `true`, we will use your site's dedicated IPs for all outbound connections to this AS2 Partner.
    # @return [Boolean, nil] the field value, or nil when absent.
    def enable_dedicated_ips
      @attributes[:enable_dedicated_ips]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def enable_dedicated_ips=(value)
      @attributes[:enable_dedicated_ips] = value
    end

    # Serial of public certificate used for message security in hex format.
    # @return [String, nil] the field value, or nil when absent.
    def hex_public_certificate_serial
      @attributes[:hex_public_certificate_serial]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def hex_public_certificate_serial=(value)
      @attributes[:hex_public_certificate_serial] = value
    end

    # Public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate
      @attributes[:public_certificate]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate=(value)
      @attributes[:public_certificate] = value
    end

    # MD5 hash of public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate_md5
      @attributes[:public_certificate_md5]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate_md5=(value)
      @attributes[:public_certificate_md5] = value
    end

    # Subject of public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate_subject
      @attributes[:public_certificate_subject]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate_subject=(value)
      @attributes[:public_certificate_subject] = value
    end

    # Issuer of public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate_issuer
      @attributes[:public_certificate_issuer]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate_issuer=(value)
      @attributes[:public_certificate_issuer] = value
    end

    # Serial of public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate_serial
      @attributes[:public_certificate_serial]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate_serial=(value)
      @attributes[:public_certificate_serial] = value
    end

    # Not before value of public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate_not_before
      @attributes[:public_certificate_not_before]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate_not_before=(value)
      @attributes[:public_certificate_not_before] = value
    end

    # Not after value of public certificate used for message security.
    # @return [String, nil] the field value, or nil when absent.
    def public_certificate_not_after
      @attributes[:public_certificate_not_after]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def public_certificate_not_after=(value)
      @attributes[:public_certificate_not_after] = value
    end

    # Password to send to server for HTTP Authentication.
    # @return [String, nil] the field value, or nil when absent.
    def http_auth_password
      @attributes[:http_auth_password]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def http_auth_password=(value)
      @attributes[:http_auth_password] = value
    end

    # Base64-encoded PKCS#12 (.pfx or .p12) file containing the partner's public certificate. Provide this instead of public_certificate. Any private key in the file is discarded. A public-only file must contain exactly one certificate.
    # @return [String, nil] the field value, or nil when absent.
    def pkcs12
      @attributes[:pkcs12]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def pkcs12=(value)
      @attributes[:pkcs12] = value
    end

    # Password for pkcs12. The file and password are used only for import; the extracted public certificate is stored as PEM.
    # @return [String, nil] the field value, or nil when absent.
    def pkcs12_password
      @attributes[:pkcs12_password]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def pkcs12_password=(value)
      @attributes[:pkcs12_password] = value
    end

    # Update AS2 Partner
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] enable_dedicated_ips If `true`, we will use your site's dedicated IPs for all outbound connections to this AS2 Partner.
    # @option params [String] http_auth_username Username to send to server for HTTP Authentication.
    # @option params [String] http_auth_password Password to send to server for HTTP Authentication.
    # @option params [String] mdn_validation_level How should Files.com evaluate message transfer success based on a partner's MDN response?  This setting does not affect MDN storage; all MDNs received from a partner are always stored. `none`: MDN is stored for informational purposes only, a successful HTTPS transfer is a successful AS2 transfer. `weak`: Inspect the MDN for MIC and Disposition only. `normal`: `weak` plus validate MDN signature matches body, `strict`: `normal` but do not allow signatures from self-signed or incorrectly purposed certificates. `auto`: Automatically set the correct value for this setting based on next mdn received.
    # @option params [String] signature_validation_level Should Files.com require signatures on incoming AS2 messages?  `normal`: require that incoming messages are signed with a valid matching signature. `none`: Unsigned incoming messages are allowed. `auto`: A one-time starting state. The next message received is always accepted and switches this to `normal` if it carries a valid signature, or `none` if it does not.
    # @option params [String] server_certificate Should we require that the remote HTTP server have a valid SSL Certificate for HTTPS? (This only applies to Outgoing AS2 message from Files.com to a Partner.)
    # @option params [String] default_mime_type Default mime type of the file attached to the encrypted message
    # @option params [Hash] additional_http_headers Additional HTTP Headers for outgoing message sent to this partner.
    # @option params [String] name The partner's formal AS2 name.
    # @option params [String] uri Public URI where we will send the AS2 messages (via HTTP/HTTPS).
    # @option params [String] public_certificate Public certificate for AS2 Partner.  Note: This is the certificate for AS2 message security, not a certificate used for HTTPS authentication.
    # @option params [String] pkcs12 Base64-encoded PKCS#12 (.pfx or .p12) file containing the partner's public certificate. Provide this instead of public_certificate. Any private key in the file is discarded. A public-only file must contain exactly one certificate.
    # @option params [String] pkcs12_password Password for pkcs12. The file and password are used only for import; the extracted public certificate is stored as PEM.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: enable_dedicated_ips must be a single value, not #{params[:enable_dedicated_ips].class}") if [ Array, Hash ].any? { |klass| params[:enable_dedicated_ips].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: http_auth_username must be an String") if !params[:http_auth_username].nil? and !params[:http_auth_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: http_auth_password must be an String") if !params[:http_auth_password].nil? and !params[:http_auth_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: mdn_validation_level must be an String") if !params[:mdn_validation_level].nil? and !params[:mdn_validation_level].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: signature_validation_level must be an String") if !params[:signature_validation_level].nil? and !params[:signature_validation_level].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if !params[:server_certificate].nil? and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: default_mime_type must be an String") if !params[:default_mime_type].nil? and !params[:default_mime_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: additional_http_headers must be an Hash") if !params[:additional_http_headers].nil? and !params[:additional_http_headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uri must be an String") if !params[:uri].nil? and !params[:uri].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if !params[:public_certificate].nil? and !params[:public_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pkcs12 must be an String") if !params[:pkcs12].nil? and !params[:pkcs12].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pkcs12_password must be an String") if !params[:pkcs12_password].nil? and !params[:pkcs12_password].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/as2_partners/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("As2Partner") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete AS2 Partner
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/as2_partners/#{@attributes[:id]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Calls {#delete} and discards its response.
    # @param (see #delete)
    # @option (see #delete)
    # @raise (see #delete)
    # @return [nil]
    def destroy(params = {})
      delete(params)
      nil
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = As2Partner.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List AS2 Partners
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `as2_station_id` or `name`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `as2_station_id` and `workspace_id`. Valid field combinations are `[ workspace_id, as2_station_id ]`.
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

      list_options = options.dup
      List.new(As2Partner, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/as2_partners", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show AS2 Partner
    #
    # @param id [Integer] As2 Partner ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::As2Partner] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/as2_partners/#{params[:id]}", :get, params, options) { |reply| reply.require_object("As2Partner") }
      As2Partner.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create AS2 Partner
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] enable_dedicated_ips If `true`, we will use your site's dedicated IPs for all outbound connections to this AS2 Partner.
    # @option params [String] http_auth_username Username to send to server for HTTP Authentication.
    # @option params [String] http_auth_password Password to send to server for HTTP Authentication.
    # @option params [String] mdn_validation_level How should Files.com evaluate message transfer success based on a partner's MDN response?  This setting does not affect MDN storage; all MDNs received from a partner are always stored. `none`: MDN is stored for informational purposes only, a successful HTTPS transfer is a successful AS2 transfer. `weak`: Inspect the MDN for MIC and Disposition only. `normal`: `weak` plus validate MDN signature matches body, `strict`: `normal` but do not allow signatures from self-signed or incorrectly purposed certificates. `auto`: Automatically set the correct value for this setting based on next mdn received.
    # @option params [String] signature_validation_level Should Files.com require signatures on incoming AS2 messages?  `normal`: require that incoming messages are signed with a valid matching signature. `none`: Unsigned incoming messages are allowed. `auto`: A one-time starting state. The next message received is always accepted and switches this to `normal` if it carries a valid signature, or `none` if it does not.
    # @option params [String] server_certificate Should we require that the remote HTTP server have a valid SSL Certificate for HTTPS? (This only applies to Outgoing AS2 message from Files.com to a Partner.)
    # @option params [String] default_mime_type Default mime type of the file attached to the encrypted message
    # @option params [Hash] additional_http_headers Additional HTTP Headers for outgoing message sent to this partner.
    # @option params [Integer] as2_station_id Required. ID of the AS2 Station associated with this partner.
    # @option params [String] name Required. The partner's formal AS2 name.
    # @option params [String] uri Required. Public URI where we will send the AS2 messages (via HTTP/HTTPS).
    # @option params [String] public_certificate Public certificate for AS2 Partner.  Note: This is the certificate for AS2 message security, not a certificate used for HTTPS authentication.
    # @option params [String] pkcs12 Base64-encoded PKCS#12 (.pfx or .p12) file containing the partner's public certificate. Provide this instead of public_certificate. Any private key in the file is discarded. A public-only file must contain exactly one certificate.
    # @option params [String] pkcs12_password Password for pkcs12. The file and password are used only for import; the extracted public certificate is stored as PEM.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::As2Partner] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: enable_dedicated_ips must be a single value, not #{params[:enable_dedicated_ips].class}") if [ Array, Hash ].any? { |klass| params[:enable_dedicated_ips].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: http_auth_username must be an String") if !params[:http_auth_username].nil? and !params[:http_auth_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: http_auth_password must be an String") if !params[:http_auth_password].nil? and !params[:http_auth_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: mdn_validation_level must be an String") if !params[:mdn_validation_level].nil? and !params[:mdn_validation_level].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: signature_validation_level must be an String") if !params[:signature_validation_level].nil? and !params[:signature_validation_level].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if !params[:server_certificate].nil? and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: default_mime_type must be an String") if !params[:default_mime_type].nil? and !params[:default_mime_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: additional_http_headers must be an Hash") if !params[:additional_http_headers].nil? and !params[:additional_http_headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: as2_station_id must be an Integer") if !params[:as2_station_id].nil? and !params[:as2_station_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uri must be an String") if !params[:uri].nil? and !params[:uri].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if !params[:public_certificate].nil? and !params[:public_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pkcs12 must be an String") if !params[:pkcs12].nil? and !params[:pkcs12].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pkcs12_password must be an String") if !params[:pkcs12_password].nil? and !params[:pkcs12_password].is_a?(String)
      raise MissingParameterError.new("Parameter missing: as2_station_id") if params[:as2_station_id].nil?
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?
      raise MissingParameterError.new("Parameter missing: uri") if params[:uri].nil?

      response, options = Api.send_request("/as2_partners", :post, params, options) { |reply| reply.require_object("As2Partner") }
      As2Partner.new(response.data, options)
    end

    # Update AS2 Partner
    #
    # @param id [Integer] As2 Partner ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] enable_dedicated_ips If `true`, we will use your site's dedicated IPs for all outbound connections to this AS2 Partner.
    # @option params [String] http_auth_username Username to send to server for HTTP Authentication.
    # @option params [String] http_auth_password Password to send to server for HTTP Authentication.
    # @option params [String] mdn_validation_level How should Files.com evaluate message transfer success based on a partner's MDN response?  This setting does not affect MDN storage; all MDNs received from a partner are always stored. `none`: MDN is stored for informational purposes only, a successful HTTPS transfer is a successful AS2 transfer. `weak`: Inspect the MDN for MIC and Disposition only. `normal`: `weak` plus validate MDN signature matches body, `strict`: `normal` but do not allow signatures from self-signed or incorrectly purposed certificates. `auto`: Automatically set the correct value for this setting based on next mdn received.
    # @option params [String] signature_validation_level Should Files.com require signatures on incoming AS2 messages?  `normal`: require that incoming messages are signed with a valid matching signature. `none`: Unsigned incoming messages are allowed. `auto`: A one-time starting state. The next message received is always accepted and switches this to `normal` if it carries a valid signature, or `none` if it does not.
    # @option params [String] server_certificate Should we require that the remote HTTP server have a valid SSL Certificate for HTTPS? (This only applies to Outgoing AS2 message from Files.com to a Partner.)
    # @option params [String] default_mime_type Default mime type of the file attached to the encrypted message
    # @option params [Hash] additional_http_headers Additional HTTP Headers for outgoing message sent to this partner.
    # @option params [String] name The partner's formal AS2 name.
    # @option params [String] uri Public URI where we will send the AS2 messages (via HTTP/HTTPS).
    # @option params [String] public_certificate Public certificate for AS2 Partner.  Note: This is the certificate for AS2 message security, not a certificate used for HTTPS authentication.
    # @option params [String] pkcs12 Base64-encoded PKCS#12 (.pfx or .p12) file containing the partner's public certificate. Provide this instead of public_certificate. Any private key in the file is discarded. A public-only file must contain exactly one certificate.
    # @option params [String] pkcs12_password Password for pkcs12. The file and password are used only for import; the extracted public certificate is stored as PEM.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::As2Partner] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: enable_dedicated_ips must be a single value, not #{params[:enable_dedicated_ips].class}") if [ Array, Hash ].any? { |klass| params[:enable_dedicated_ips].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: http_auth_username must be an String") if !params[:http_auth_username].nil? and !params[:http_auth_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: http_auth_password must be an String") if !params[:http_auth_password].nil? and !params[:http_auth_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: mdn_validation_level must be an String") if !params[:mdn_validation_level].nil? and !params[:mdn_validation_level].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: signature_validation_level must be an String") if !params[:signature_validation_level].nil? and !params[:signature_validation_level].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if !params[:server_certificate].nil? and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: default_mime_type must be an String") if !params[:default_mime_type].nil? and !params[:default_mime_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: additional_http_headers must be an Hash") if !params[:additional_http_headers].nil? and !params[:additional_http_headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uri must be an String") if !params[:uri].nil? and !params[:uri].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if !params[:public_certificate].nil? and !params[:public_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pkcs12 must be an String") if !params[:pkcs12].nil? and !params[:pkcs12].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pkcs12_password must be an String") if !params[:pkcs12_password].nil? and !params[:pkcs12_password].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/as2_partners/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("As2Partner") }
      As2Partner.new(response.data, options)
    end

    # Delete AS2 Partner
    #
    # @param id [Integer] As2 Partner ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/as2_partners/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
