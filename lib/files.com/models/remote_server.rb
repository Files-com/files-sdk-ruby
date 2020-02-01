# frozen_string_literal: true

module Files
  class RemoteServer
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Remote server ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Type of authentication method
    def authentication_method
      @attributes[:authentication_method]
    end

    def authentication_method=(value)
      @attributes[:authentication_method] = value
    end

    # string - Hostname or IP address
    def hostname
      @attributes[:hostname]
    end

    def hostname=(value)
      @attributes[:hostname] = value
    end

    # string - Internal name for your reference
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # int64 - Port for remote server.  Not needed for S3.
    def port
      @attributes[:port]
    end

    def port=(value)
      @attributes[:port] = value
    end

    # string - S3 bucket name
    def s3_bucket
      @attributes[:s3_bucket]
    end

    def s3_bucket=(value)
      @attributes[:s3_bucket] = value
    end

    # string - S3 region
    def s3_region
      @attributes[:s3_region]
    end

    def s3_region=(value)
      @attributes[:s3_region] = value
    end

    # string - Remote server certificate
    def server_certificate
      @attributes[:server_certificate]
    end

    def server_certificate=(value)
      @attributes[:server_certificate] = value
    end

    # string - Remote server type.
    def server_type
      @attributes[:server_type]
    end

    def server_type=(value)
      @attributes[:server_type] = value
    end

    # string - Should we require SSL?
    def ssl
      @attributes[:ssl]
    end

    def ssl=(value)
      @attributes[:ssl] = value
    end

    # string - Remote server username.  Not needed for S3 buckets.
    def username
      @attributes[:username]
    end

    def username=(value)
      @attributes[:username] = value
    end

    # string - AWS Access Key.
    def aws_access_key
      @attributes[:aws_access_key]
    end

    def aws_access_key=(value)
      @attributes[:aws_access_key] = value
    end

    # string - AWS secret key.
    def aws_secret_key
      @attributes[:aws_secret_key]
    end

    def aws_secret_key=(value)
      @attributes[:aws_secret_key] = value
    end

    # string - Password if needed.
    def password
      @attributes[:password]
    end

    def password=(value)
      @attributes[:password] = value
    end

    # string - Private key if needed.
    def private_key
      @attributes[:private_key]
    end

    def private_key=(value)
      @attributes[:private_key] = value
    end

    # Parameters:
    #   aws_access_key - string - AWS Access Key.
    #   aws_secret_key - string - AWS secret key.
    #   hostname - string - Hostname.
    #   name - string - Internal reference name for server.
    #   password - string - Password if needed.
    #   port - string - Port.
    #   private_key - string - Private key if needed.
    #   s3_bucket - string - S3 bucket name.
    #   s3_region - string - S3 region.
    #   server_certificate - string - Certificate for this server.
    #   server_type - string - Type of server.  Can be ftp, sftp, or s3.
    #   ssl - string - SSL requirements.  Can be if_available, require, require_implicit, never.
    #   username - string - Server username if needed.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if params.dig(:aws_access_key) and !params.dig(:aws_access_key).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_secret_key must be an String") if params.dig(:aws_secret_key) and !params.dig(:aws_secret_key).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params.dig(:hostname) and !params.dig(:hostname).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params.dig(:password) and !params.dig(:password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: port must be an String") if params.dig(:port) and !params.dig(:port).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params.dig(:private_key) and !params.dig(:private_key).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_bucket must be an String") if params.dig(:s3_bucket) and !params.dig(:s3_bucket).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_region must be an String") if params.dig(:s3_region) and !params.dig(:s3_region).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params.dig(:server_certificate) and !params.dig(:server_certificate).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if params.dig(:server_type) and !params.dig(:server_type).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl must be an String") if params.dig(:ssl) and !params.dig(:ssl).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params.dig(:username) and !params.dig(:username).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/remote_servers/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/remote_servers/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = RemoteServer.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/remote_servers", :get, params, options)
      response.data.map { |object| RemoteServer.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - integer - Remote Server ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/remote_servers/#{params[:id]}", :get, params, options)
      RemoteServer.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   aws_access_key - string - AWS Access Key.
    #   aws_secret_key - string - AWS secret key.
    #   hostname - string - Hostname.
    #   name - string - Internal reference name for server.
    #   password - string - Password if needed.
    #   port - string - Port.
    #   private_key - string - Private key if needed.
    #   s3_bucket - string - S3 bucket name.
    #   s3_region - string - S3 region.
    #   server_certificate - string - Certificate for this server.
    #   server_type - string - Type of server.  Can be ftp, sftp, or s3.
    #   ssl - string - SSL requirements.  Can be if_available, require, require_implicit, never.
    #   username - string - Server username if needed.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if params.dig(:aws_access_key) and !params.dig(:aws_access_key).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_secret_key must be an String") if params.dig(:aws_secret_key) and !params.dig(:aws_secret_key).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params.dig(:hostname) and !params.dig(:hostname).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params.dig(:password) and !params.dig(:password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: port must be an String") if params.dig(:port) and !params.dig(:port).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params.dig(:private_key) and !params.dig(:private_key).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_bucket must be an String") if params.dig(:s3_bucket) and !params.dig(:s3_bucket).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_region must be an String") if params.dig(:s3_region) and !params.dig(:s3_region).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params.dig(:server_certificate) and !params.dig(:server_certificate).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if params.dig(:server_type) and !params.dig(:server_type).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl must be an String") if params.dig(:ssl) and !params.dig(:ssl).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params.dig(:username) and !params.dig(:username).is_a?(String)

      response, options = Api.send_request("/remote_servers", :post, params, options)
      RemoteServer.new(response.data, options)
    end

    # Parameters:
    #   aws_access_key - string - AWS Access Key.
    #   aws_secret_key - string - AWS secret key.
    #   hostname - string - Hostname.
    #   name - string - Internal reference name for server.
    #   password - string - Password if needed.
    #   port - string - Port.
    #   private_key - string - Private key if needed.
    #   s3_bucket - string - S3 bucket name.
    #   s3_region - string - S3 region.
    #   server_certificate - string - Certificate for this server.
    #   server_type - string - Type of server.  Can be ftp, sftp, or s3.
    #   ssl - string - SSL requirements.  Can be if_available, require, require_implicit, never.
    #   username - string - Server username if needed.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if params.dig(:aws_access_key) and !params.dig(:aws_access_key).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_secret_key must be an String") if params.dig(:aws_secret_key) and !params.dig(:aws_secret_key).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params.dig(:hostname) and !params.dig(:hostname).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params.dig(:password) and !params.dig(:password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: port must be an String") if params.dig(:port) and !params.dig(:port).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params.dig(:private_key) and !params.dig(:private_key).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_bucket must be an String") if params.dig(:s3_bucket) and !params.dig(:s3_bucket).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_region must be an String") if params.dig(:s3_region) and !params.dig(:s3_region).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params.dig(:server_certificate) and !params.dig(:server_certificate).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if params.dig(:server_type) and !params.dig(:server_type).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl must be an String") if params.dig(:ssl) and !params.dig(:ssl).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params.dig(:username) and !params.dig(:username).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/remote_servers/#{params[:id]}", :patch, params, options)
      RemoteServer.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/remote_servers/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
