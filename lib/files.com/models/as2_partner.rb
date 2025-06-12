# frozen_string_literal: true

module Files
  class As2Partner
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - ID of the AS2 Partner.
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - ID of the AS2 Station associated with this partner.
    def as2_station_id
      @attributes[:as2_station_id]
    end

    def as2_station_id=(value)
      @attributes[:as2_station_id] = value
    end

    # string - The partner's formal AS2 name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Public URI where we will send the AS2 messages (via HTTP/HTTPS).
    def uri
      @attributes[:uri]
    end

    def uri=(value)
      @attributes[:uri] = value
    end

    # string - Should we require that the remote HTTP server have a valid SSL Certificate for HTTPS? (This only applies to Outgoing AS2 message from Files.com to a Partner.)
    def server_certificate
      @attributes[:server_certificate]
    end

    def server_certificate=(value)
      @attributes[:server_certificate] = value
    end

    # string - Username to send to server for HTTP Authentication.
    def http_auth_username
      @attributes[:http_auth_username]
    end

    def http_auth_username=(value)
      @attributes[:http_auth_username] = value
    end

    # object - Additional HTTP Headers for outgoing message sent to this partner.
    def additional_http_headers
      @attributes[:additional_http_headers]
    end

    def additional_http_headers=(value)
      @attributes[:additional_http_headers] = value
    end

    # string - Default mime type of the file attached to the encrypted message
    def default_mime_type
      @attributes[:default_mime_type]
    end

    def default_mime_type=(value)
      @attributes[:default_mime_type] = value
    end

    # string - How should Files.com evaluate message transfer success based on a partner's MDN response?  This setting does not affect MDN storage; all MDNs received from a partner are always stored. `none`: MDN is stored for informational purposes only, a successful HTTPS transfer is a successful AS2 transfer. `weak`: Inspect the MDN for MIC and Disposition only. `normal`: `weak` plus validate MDN signature matches body, `strict`: `normal` but do not allow signatures from self-signed or incorrectly purposed certificates. `auto`: Automatically set the correct value for this setting based on next mdn received.
    def mdn_validation_level
      @attributes[:mdn_validation_level]
    end

    def mdn_validation_level=(value)
      @attributes[:mdn_validation_level] = value
    end

    # string - Should Files.com require signatures on incoming AS2 messages?  `normal`: require that incoming messages are signed with a valid matching signature. `none`: Unsigned incoming messages are allowed. `auto`: Automatically set the correct value for this setting based on next message received.
    def signature_validation_level
      @attributes[:signature_validation_level]
    end

    def signature_validation_level=(value)
      @attributes[:signature_validation_level] = value
    end

    # boolean - If `true`, we will use your site's dedicated IPs for all outbound connections to this AS2 Partner.
    def enable_dedicated_ips
      @attributes[:enable_dedicated_ips]
    end

    def enable_dedicated_ips=(value)
      @attributes[:enable_dedicated_ips] = value
    end

    # string - Serial of public certificate used for message security in hex format.
    def hex_public_certificate_serial
      @attributes[:hex_public_certificate_serial]
    end

    def hex_public_certificate_serial=(value)
      @attributes[:hex_public_certificate_serial] = value
    end

    # string - Public certificate used for message security.
    def public_certificate
      @attributes[:public_certificate]
    end

    def public_certificate=(value)
      @attributes[:public_certificate] = value
    end

    # string - MD5 hash of public certificate used for message security.
    def public_certificate_md5
      @attributes[:public_certificate_md5]
    end

    def public_certificate_md5=(value)
      @attributes[:public_certificate_md5] = value
    end

    # string - Subject of public certificate used for message security.
    def public_certificate_subject
      @attributes[:public_certificate_subject]
    end

    def public_certificate_subject=(value)
      @attributes[:public_certificate_subject] = value
    end

    # string - Issuer of public certificate used for message security.
    def public_certificate_issuer
      @attributes[:public_certificate_issuer]
    end

    def public_certificate_issuer=(value)
      @attributes[:public_certificate_issuer] = value
    end

    # string - Serial of public certificate used for message security.
    def public_certificate_serial
      @attributes[:public_certificate_serial]
    end

    def public_certificate_serial=(value)
      @attributes[:public_certificate_serial] = value
    end

    # string - Not before value of public certificate used for message security.
    def public_certificate_not_before
      @attributes[:public_certificate_not_before]
    end

    def public_certificate_not_before=(value)
      @attributes[:public_certificate_not_before] = value
    end

    # string - Not after value of public certificate used for message security.
    def public_certificate_not_after
      @attributes[:public_certificate_not_after]
    end

    def public_certificate_not_after=(value)
      @attributes[:public_certificate_not_after] = value
    end

    # string - Password to send to server for HTTP Authentication.
    def http_auth_password
      @attributes[:http_auth_password]
    end

    def http_auth_password=(value)
      @attributes[:http_auth_password] = value
    end

    # Parameters:
    #   enable_dedicated_ips - boolean - If `true`, we will use your site's dedicated IPs for all outbound connections to this AS2 Partner.
    #   http_auth_username - string - Username to send to server for HTTP Authentication.
    #   http_auth_password - string - Password to send to server for HTTP Authentication.
    #   mdn_validation_level - string - How should Files.com evaluate message transfer success based on a partner's MDN response?  This setting does not affect MDN storage; all MDNs received from a partner are always stored. `none`: MDN is stored for informational purposes only, a successful HTTPS transfer is a successful AS2 transfer. `weak`: Inspect the MDN for MIC and Disposition only. `normal`: `weak` plus validate MDN signature matches body, `strict`: `normal` but do not allow signatures from self-signed or incorrectly purposed certificates. `auto`: Automatically set the correct value for this setting based on next mdn received.
    #   signature_validation_level - string - Should Files.com require signatures on incoming AS2 messages?  `normal`: require that incoming messages are signed with a valid matching signature. `none`: Unsigned incoming messages are allowed. `auto`: Automatically set the correct value for this setting based on next message received.
    #   server_certificate - string - Should we require that the remote HTTP server have a valid SSL Certificate for HTTPS? (This only applies to Outgoing AS2 message from Files.com to a Partner.)
    #   default_mime_type - string - Default mime type of the file attached to the encrypted message
    #   additional_http_headers - object - Additional HTTP Headers for outgoing message sent to this partner.
    #   name - string - The partner's formal AS2 name.
    #   uri - string - Public URI where we will send the AS2 messages (via HTTP/HTTPS).
    #   public_certificate - string - Public certificate for AS2 Partner.  Note: This is the certificate for AS2 message security, not a certificate used for HTTPS authentication.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: http_auth_username must be an String") if params[:http_auth_username] and !params[:http_auth_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: http_auth_password must be an String") if params[:http_auth_password] and !params[:http_auth_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: mdn_validation_level must be an String") if params[:mdn_validation_level] and !params[:mdn_validation_level].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: signature_validation_level must be an String") if params[:signature_validation_level] and !params[:signature_validation_level].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params[:server_certificate] and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: default_mime_type must be an String") if params[:default_mime_type] and !params[:default_mime_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uri must be an String") if params[:uri] and !params[:uri].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if params[:public_certificate] and !params[:public_certificate].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/as2_partners/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/as2_partners/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = As2Partner.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(As2Partner, params) do
        Api.send_request("/as2_partners", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - As2 Partner ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/as2_partners/#{params[:id]}", :get, params, options)
      As2Partner.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   enable_dedicated_ips - boolean - If `true`, we will use your site's dedicated IPs for all outbound connections to this AS2 Partner.
    #   http_auth_username - string - Username to send to server for HTTP Authentication.
    #   http_auth_password - string - Password to send to server for HTTP Authentication.
    #   mdn_validation_level - string - How should Files.com evaluate message transfer success based on a partner's MDN response?  This setting does not affect MDN storage; all MDNs received from a partner are always stored. `none`: MDN is stored for informational purposes only, a successful HTTPS transfer is a successful AS2 transfer. `weak`: Inspect the MDN for MIC and Disposition only. `normal`: `weak` plus validate MDN signature matches body, `strict`: `normal` but do not allow signatures from self-signed or incorrectly purposed certificates. `auto`: Automatically set the correct value for this setting based on next mdn received.
    #   signature_validation_level - string - Should Files.com require signatures on incoming AS2 messages?  `normal`: require that incoming messages are signed with a valid matching signature. `none`: Unsigned incoming messages are allowed. `auto`: Automatically set the correct value for this setting based on next message received.
    #   server_certificate - string - Should we require that the remote HTTP server have a valid SSL Certificate for HTTPS? (This only applies to Outgoing AS2 message from Files.com to a Partner.)
    #   default_mime_type - string - Default mime type of the file attached to the encrypted message
    #   additional_http_headers - object - Additional HTTP Headers for outgoing message sent to this partner.
    #   as2_station_id (required) - int64 - ID of the AS2 Station associated with this partner.
    #   name (required) - string - The partner's formal AS2 name.
    #   uri (required) - string - Public URI where we will send the AS2 messages (via HTTP/HTTPS).
    #   public_certificate (required) - string - Public certificate for AS2 Partner.  Note: This is the certificate for AS2 message security, not a certificate used for HTTPS authentication.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: http_auth_username must be an String") if params[:http_auth_username] and !params[:http_auth_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: http_auth_password must be an String") if params[:http_auth_password] and !params[:http_auth_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: mdn_validation_level must be an String") if params[:mdn_validation_level] and !params[:mdn_validation_level].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: signature_validation_level must be an String") if params[:signature_validation_level] and !params[:signature_validation_level].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params[:server_certificate] and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: default_mime_type must be an String") if params[:default_mime_type] and !params[:default_mime_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: additional_http_headers must be an Hash") if params[:additional_http_headers] and !params[:additional_http_headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: as2_station_id must be an Integer") if params[:as2_station_id] and !params[:as2_station_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uri must be an String") if params[:uri] and !params[:uri].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if params[:public_certificate] and !params[:public_certificate].is_a?(String)
      raise MissingParameterError.new("Parameter missing: as2_station_id") unless params[:as2_station_id]
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]
      raise MissingParameterError.new("Parameter missing: uri") unless params[:uri]
      raise MissingParameterError.new("Parameter missing: public_certificate") unless params[:public_certificate]

      response, options = Api.send_request("/as2_partners", :post, params, options)
      As2Partner.new(response.data, options)
    end

    # Parameters:
    #   enable_dedicated_ips - boolean - If `true`, we will use your site's dedicated IPs for all outbound connections to this AS2 Partner.
    #   http_auth_username - string - Username to send to server for HTTP Authentication.
    #   http_auth_password - string - Password to send to server for HTTP Authentication.
    #   mdn_validation_level - string - How should Files.com evaluate message transfer success based on a partner's MDN response?  This setting does not affect MDN storage; all MDNs received from a partner are always stored. `none`: MDN is stored for informational purposes only, a successful HTTPS transfer is a successful AS2 transfer. `weak`: Inspect the MDN for MIC and Disposition only. `normal`: `weak` plus validate MDN signature matches body, `strict`: `normal` but do not allow signatures from self-signed or incorrectly purposed certificates. `auto`: Automatically set the correct value for this setting based on next mdn received.
    #   signature_validation_level - string - Should Files.com require signatures on incoming AS2 messages?  `normal`: require that incoming messages are signed with a valid matching signature. `none`: Unsigned incoming messages are allowed. `auto`: Automatically set the correct value for this setting based on next message received.
    #   server_certificate - string - Should we require that the remote HTTP server have a valid SSL Certificate for HTTPS? (This only applies to Outgoing AS2 message from Files.com to a Partner.)
    #   default_mime_type - string - Default mime type of the file attached to the encrypted message
    #   additional_http_headers - object - Additional HTTP Headers for outgoing message sent to this partner.
    #   name - string - The partner's formal AS2 name.
    #   uri - string - Public URI where we will send the AS2 messages (via HTTP/HTTPS).
    #   public_certificate - string - Public certificate for AS2 Partner.  Note: This is the certificate for AS2 message security, not a certificate used for HTTPS authentication.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: http_auth_username must be an String") if params[:http_auth_username] and !params[:http_auth_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: http_auth_password must be an String") if params[:http_auth_password] and !params[:http_auth_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: mdn_validation_level must be an String") if params[:mdn_validation_level] and !params[:mdn_validation_level].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: signature_validation_level must be an String") if params[:signature_validation_level] and !params[:signature_validation_level].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params[:server_certificate] and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: default_mime_type must be an String") if params[:default_mime_type] and !params[:default_mime_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: additional_http_headers must be an Hash") if params[:additional_http_headers] and !params[:additional_http_headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uri must be an String") if params[:uri] and !params[:uri].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_certificate must be an String") if params[:public_certificate] and !params[:public_certificate].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/as2_partners/#{params[:id]}", :patch, params, options)
      As2Partner.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/as2_partners/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
