# frozen_string_literal: true

module Files
  class RemoteServerCredential
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Remote Server Credential ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Workspace ID (0 for default workspace)
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # string - Internal name for your reference
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Internal description for your reference
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # string - Remote server type.  Remote Server Credentials are only valid for a single type of Remote Server.
    def server_type
      @attributes[:server_type]
    end

    def server_type=(value)
      @attributes[:server_type] = value
    end

    # string - AWS Access Key.
    def aws_access_key
      @attributes[:aws_access_key]
    end

    def aws_access_key=(value)
      @attributes[:aws_access_key] = value
    end

    # string - Google Cloud Storage: S3-compatible Access Key.
    def google_cloud_storage_s3_compatible_access_key
      @attributes[:google_cloud_storage_s3_compatible_access_key]
    end

    def google_cloud_storage_s3_compatible_access_key=(value)
      @attributes[:google_cloud_storage_s3_compatible_access_key] = value
    end

    # string - Wasabi: Access Key.
    def wasabi_access_key
      @attributes[:wasabi_access_key]
    end

    def wasabi_access_key=(value)
      @attributes[:wasabi_access_key] = value
    end

    # string - S3-compatible: Access Key
    def s3_compatible_access_key
      @attributes[:s3_compatible_access_key]
    end

    def s3_compatible_access_key=(value)
      @attributes[:s3_compatible_access_key] = value
    end

    # string - Filebase: Access Key.
    def filebase_access_key
      @attributes[:filebase_access_key]
    end

    def filebase_access_key=(value)
      @attributes[:filebase_access_key] = value
    end

    # string - Cloudflare: Access Key.
    def cloudflare_access_key
      @attributes[:cloudflare_access_key]
    end

    def cloudflare_access_key=(value)
      @attributes[:cloudflare_access_key] = value
    end

    # string - Linode: Access Key
    def linode_access_key
      @attributes[:linode_access_key]
    end

    def linode_access_key=(value)
      @attributes[:linode_access_key] = value
    end

    # string - Remote server username.
    def username
      @attributes[:username]
    end

    def username=(value)
      @attributes[:username] = value
    end

    # string - Password, if needed.
    def password
      @attributes[:password]
    end

    def password=(value)
      @attributes[:password] = value
    end

    # string - Private key, if needed.
    def private_key
      @attributes[:private_key]
    end

    def private_key=(value)
      @attributes[:private_key] = value
    end

    # string - Passphrase for private key if needed.
    def private_key_passphrase
      @attributes[:private_key_passphrase]
    end

    def private_key_passphrase=(value)
      @attributes[:private_key_passphrase] = value
    end

    # string - AWS: secret key.
    def aws_secret_key
      @attributes[:aws_secret_key]
    end

    def aws_secret_key=(value)
      @attributes[:aws_secret_key] = value
    end

    # string - Azure Blob Storage: Access Key
    def azure_blob_storage_access_key
      @attributes[:azure_blob_storage_access_key]
    end

    def azure_blob_storage_access_key=(value)
      @attributes[:azure_blob_storage_access_key] = value
    end

    # string - Azure Blob Storage: Shared Access Signature (SAS) token
    def azure_blob_storage_sas_token
      @attributes[:azure_blob_storage_sas_token]
    end

    def azure_blob_storage_sas_token=(value)
      @attributes[:azure_blob_storage_sas_token] = value
    end

    # string - Azure File Storage: Access Key
    def azure_files_storage_access_key
      @attributes[:azure_files_storage_access_key]
    end

    def azure_files_storage_access_key=(value)
      @attributes[:azure_files_storage_access_key] = value
    end

    # string - Azure File Storage: Shared Access Signature (SAS) token
    def azure_files_storage_sas_token
      @attributes[:azure_files_storage_sas_token]
    end

    def azure_files_storage_sas_token=(value)
      @attributes[:azure_files_storage_sas_token] = value
    end

    # string - Backblaze B2 Cloud Storage: applicationKey
    def backblaze_b2_application_key
      @attributes[:backblaze_b2_application_key]
    end

    def backblaze_b2_application_key=(value)
      @attributes[:backblaze_b2_application_key] = value
    end

    # string - Backblaze B2 Cloud Storage: keyID
    def backblaze_b2_key_id
      @attributes[:backblaze_b2_key_id]
    end

    def backblaze_b2_key_id=(value)
      @attributes[:backblaze_b2_key_id] = value
    end

    # string - Cloudflare: Secret Key
    def cloudflare_secret_key
      @attributes[:cloudflare_secret_key]
    end

    def cloudflare_secret_key=(value)
      @attributes[:cloudflare_secret_key] = value
    end

    # string - Filebase: Secret Key
    def filebase_secret_key
      @attributes[:filebase_secret_key]
    end

    def filebase_secret_key=(value)
      @attributes[:filebase_secret_key] = value
    end

    # string - Google Cloud Storage: JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
    def google_cloud_storage_credentials_json
      @attributes[:google_cloud_storage_credentials_json]
    end

    def google_cloud_storage_credentials_json=(value)
      @attributes[:google_cloud_storage_credentials_json] = value
    end

    # string - Google Cloud Storage: S3-compatible secret key
    def google_cloud_storage_s3_compatible_secret_key
      @attributes[:google_cloud_storage_s3_compatible_secret_key]
    end

    def google_cloud_storage_s3_compatible_secret_key=(value)
      @attributes[:google_cloud_storage_s3_compatible_secret_key] = value
    end

    # string - Linode: Secret Key
    def linode_secret_key
      @attributes[:linode_secret_key]
    end

    def linode_secret_key=(value)
      @attributes[:linode_secret_key] = value
    end

    # string - S3-compatible: Secret Key
    def s3_compatible_secret_key
      @attributes[:s3_compatible_secret_key]
    end

    def s3_compatible_secret_key=(value)
      @attributes[:s3_compatible_secret_key] = value
    end

    # string - Wasabi: Secret Key
    def wasabi_secret_key
      @attributes[:wasabi_secret_key]
    end

    def wasabi_secret_key=(value)
      @attributes[:wasabi_secret_key] = value
    end

    # Parameters:
    #   name - string - Internal name for your reference
    #   description - string - Internal description for your reference
    #   server_type - string - Remote server type.  Remote Server Credentials are only valid for a single type of Remote Server.
    #   aws_access_key - string - AWS Access Key.
    #   cloudflare_access_key - string - Cloudflare: Access Key.
    #   filebase_access_key - string - Filebase: Access Key.
    #   google_cloud_storage_s3_compatible_access_key - string - Google Cloud Storage: S3-compatible Access Key.
    #   linode_access_key - string - Linode: Access Key
    #   s3_compatible_access_key - string - S3-compatible: Access Key
    #   username - string - Remote server username.
    #   wasabi_access_key - string - Wasabi: Access Key.
    #   password - string - Password, if needed.
    #   private_key - string - Private key, if needed.
    #   private_key_passphrase - string - Passphrase for private key if needed.
    #   aws_secret_key - string - AWS: secret key.
    #   azure_blob_storage_access_key - string - Azure Blob Storage: Access Key
    #   azure_blob_storage_sas_token - string - Azure Blob Storage: Shared Access Signature (SAS) token
    #   azure_files_storage_access_key - string - Azure File Storage: Access Key
    #   azure_files_storage_sas_token - string - Azure File Storage: Shared Access Signature (SAS) token
    #   backblaze_b2_application_key - string - Backblaze B2 Cloud Storage: applicationKey
    #   backblaze_b2_key_id - string - Backblaze B2 Cloud Storage: keyID
    #   cloudflare_secret_key - string - Cloudflare: Secret Key
    #   filebase_secret_key - string - Filebase: Secret Key
    #   google_cloud_storage_credentials_json - string - Google Cloud Storage: JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
    #   google_cloud_storage_s3_compatible_secret_key - string - Google Cloud Storage: S3-compatible secret key
    #   linode_secret_key - string - Linode: Secret Key
    #   s3_compatible_secret_key - string - S3-compatible: Secret Key
    #   wasabi_secret_key - string - Wasabi: Secret Key
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if params[:server_type] and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if params[:aws_access_key] and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_access_key must be an String") if params[:cloudflare_access_key] and !params[:cloudflare_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_access_key must be an String") if params[:filebase_access_key] and !params[:filebase_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_access_key must be an String") if params[:google_cloud_storage_s3_compatible_access_key] and !params[:google_cloud_storage_s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_access_key must be an String") if params[:linode_access_key] and !params[:linode_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if params[:s3_compatible_access_key] and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if params[:wasabi_access_key] and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if params[:private_key_passphrase] and !params[:private_key_passphrase].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_secret_key must be an String") if params[:aws_secret_key] and !params[:aws_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_access_key must be an String") if params[:azure_blob_storage_access_key] and !params[:azure_blob_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_sas_token must be an String") if params[:azure_blob_storage_sas_token] and !params[:azure_blob_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_access_key must be an String") if params[:azure_files_storage_access_key] and !params[:azure_files_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_sas_token must be an String") if params[:azure_files_storage_sas_token] and !params[:azure_files_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_application_key must be an String") if params[:backblaze_b2_application_key] and !params[:backblaze_b2_application_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_key_id must be an String") if params[:backblaze_b2_key_id] and !params[:backblaze_b2_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_secret_key must be an String") if params[:cloudflare_secret_key] and !params[:cloudflare_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_secret_key must be an String") if params[:filebase_secret_key] and !params[:filebase_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_credentials_json must be an String") if params[:google_cloud_storage_credentials_json] and !params[:google_cloud_storage_credentials_json].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_secret_key must be an String") if params[:google_cloud_storage_s3_compatible_secret_key] and !params[:google_cloud_storage_s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_secret_key must be an String") if params[:linode_secret_key] and !params[:linode_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_secret_key must be an String") if params[:s3_compatible_secret_key] and !params[:s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_secret_key must be an String") if params[:wasabi_secret_key] and !params[:wasabi_secret_key].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/remote_server_credentials/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/remote_server_credentials/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = RemoteServerCredential.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id` and `name`. Valid field combinations are `[ workspace_id, name ]`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `name`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

      List.new(RemoteServerCredential, params) do
        Api.send_request("/remote_server_credentials", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Remote Server Credential ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/remote_server_credentials/#{params[:id]}", :get, params, options)
      RemoteServerCredential.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name - string - Internal name for your reference
    #   description - string - Internal description for your reference
    #   server_type - string - Remote server type.  Remote Server Credentials are only valid for a single type of Remote Server.
    #   aws_access_key - string - AWS Access Key.
    #   cloudflare_access_key - string - Cloudflare: Access Key.
    #   filebase_access_key - string - Filebase: Access Key.
    #   google_cloud_storage_s3_compatible_access_key - string - Google Cloud Storage: S3-compatible Access Key.
    #   linode_access_key - string - Linode: Access Key
    #   s3_compatible_access_key - string - S3-compatible: Access Key
    #   username - string - Remote server username.
    #   wasabi_access_key - string - Wasabi: Access Key.
    #   password - string - Password, if needed.
    #   private_key - string - Private key, if needed.
    #   private_key_passphrase - string - Passphrase for private key if needed.
    #   aws_secret_key - string - AWS: secret key.
    #   azure_blob_storage_access_key - string - Azure Blob Storage: Access Key
    #   azure_blob_storage_sas_token - string - Azure Blob Storage: Shared Access Signature (SAS) token
    #   azure_files_storage_access_key - string - Azure File Storage: Access Key
    #   azure_files_storage_sas_token - string - Azure File Storage: Shared Access Signature (SAS) token
    #   backblaze_b2_application_key - string - Backblaze B2 Cloud Storage: applicationKey
    #   backblaze_b2_key_id - string - Backblaze B2 Cloud Storage: keyID
    #   cloudflare_secret_key - string - Cloudflare: Secret Key
    #   filebase_secret_key - string - Filebase: Secret Key
    #   google_cloud_storage_credentials_json - string - Google Cloud Storage: JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
    #   google_cloud_storage_s3_compatible_secret_key - string - Google Cloud Storage: S3-compatible secret key
    #   linode_secret_key - string - Linode: Secret Key
    #   s3_compatible_secret_key - string - S3-compatible: Secret Key
    #   wasabi_secret_key - string - Wasabi: Secret Key
    #   workspace_id - int64 - Workspace ID (0 for default workspace)
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if params[:server_type] and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if params[:aws_access_key] and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_access_key must be an String") if params[:cloudflare_access_key] and !params[:cloudflare_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_access_key must be an String") if params[:filebase_access_key] and !params[:filebase_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_access_key must be an String") if params[:google_cloud_storage_s3_compatible_access_key] and !params[:google_cloud_storage_s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_access_key must be an String") if params[:linode_access_key] and !params[:linode_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if params[:s3_compatible_access_key] and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if params[:wasabi_access_key] and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if params[:private_key_passphrase] and !params[:private_key_passphrase].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_secret_key must be an String") if params[:aws_secret_key] and !params[:aws_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_access_key must be an String") if params[:azure_blob_storage_access_key] and !params[:azure_blob_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_sas_token must be an String") if params[:azure_blob_storage_sas_token] and !params[:azure_blob_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_access_key must be an String") if params[:azure_files_storage_access_key] and !params[:azure_files_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_sas_token must be an String") if params[:azure_files_storage_sas_token] and !params[:azure_files_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_application_key must be an String") if params[:backblaze_b2_application_key] and !params[:backblaze_b2_application_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_key_id must be an String") if params[:backblaze_b2_key_id] and !params[:backblaze_b2_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_secret_key must be an String") if params[:cloudflare_secret_key] and !params[:cloudflare_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_secret_key must be an String") if params[:filebase_secret_key] and !params[:filebase_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_credentials_json must be an String") if params[:google_cloud_storage_credentials_json] and !params[:google_cloud_storage_credentials_json].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_secret_key must be an String") if params[:google_cloud_storage_s3_compatible_secret_key] and !params[:google_cloud_storage_s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_secret_key must be an String") if params[:linode_secret_key] and !params[:linode_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_secret_key must be an String") if params[:s3_compatible_secret_key] and !params[:s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_secret_key must be an String") if params[:wasabi_secret_key] and !params[:wasabi_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)

      response, options = Api.send_request("/remote_server_credentials", :post, params, options)
      RemoteServerCredential.new(response.data, options)
    end

    # Parameters:
    #   name - string - Internal name for your reference
    #   description - string - Internal description for your reference
    #   server_type - string - Remote server type.  Remote Server Credentials are only valid for a single type of Remote Server.
    #   aws_access_key - string - AWS Access Key.
    #   cloudflare_access_key - string - Cloudflare: Access Key.
    #   filebase_access_key - string - Filebase: Access Key.
    #   google_cloud_storage_s3_compatible_access_key - string - Google Cloud Storage: S3-compatible Access Key.
    #   linode_access_key - string - Linode: Access Key
    #   s3_compatible_access_key - string - S3-compatible: Access Key
    #   username - string - Remote server username.
    #   wasabi_access_key - string - Wasabi: Access Key.
    #   password - string - Password, if needed.
    #   private_key - string - Private key, if needed.
    #   private_key_passphrase - string - Passphrase for private key if needed.
    #   aws_secret_key - string - AWS: secret key.
    #   azure_blob_storage_access_key - string - Azure Blob Storage: Access Key
    #   azure_blob_storage_sas_token - string - Azure Blob Storage: Shared Access Signature (SAS) token
    #   azure_files_storage_access_key - string - Azure File Storage: Access Key
    #   azure_files_storage_sas_token - string - Azure File Storage: Shared Access Signature (SAS) token
    #   backblaze_b2_application_key - string - Backblaze B2 Cloud Storage: applicationKey
    #   backblaze_b2_key_id - string - Backblaze B2 Cloud Storage: keyID
    #   cloudflare_secret_key - string - Cloudflare: Secret Key
    #   filebase_secret_key - string - Filebase: Secret Key
    #   google_cloud_storage_credentials_json - string - Google Cloud Storage: JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
    #   google_cloud_storage_s3_compatible_secret_key - string - Google Cloud Storage: S3-compatible secret key
    #   linode_secret_key - string - Linode: Secret Key
    #   s3_compatible_secret_key - string - S3-compatible: Secret Key
    #   wasabi_secret_key - string - Wasabi: Secret Key
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if params[:server_type] and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if params[:aws_access_key] and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_access_key must be an String") if params[:cloudflare_access_key] and !params[:cloudflare_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_access_key must be an String") if params[:filebase_access_key] and !params[:filebase_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_access_key must be an String") if params[:google_cloud_storage_s3_compatible_access_key] and !params[:google_cloud_storage_s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_access_key must be an String") if params[:linode_access_key] and !params[:linode_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if params[:s3_compatible_access_key] and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if params[:wasabi_access_key] and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if params[:private_key_passphrase] and !params[:private_key_passphrase].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_secret_key must be an String") if params[:aws_secret_key] and !params[:aws_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_access_key must be an String") if params[:azure_blob_storage_access_key] and !params[:azure_blob_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_sas_token must be an String") if params[:azure_blob_storage_sas_token] and !params[:azure_blob_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_access_key must be an String") if params[:azure_files_storage_access_key] and !params[:azure_files_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_sas_token must be an String") if params[:azure_files_storage_sas_token] and !params[:azure_files_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_application_key must be an String") if params[:backblaze_b2_application_key] and !params[:backblaze_b2_application_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_key_id must be an String") if params[:backblaze_b2_key_id] and !params[:backblaze_b2_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_secret_key must be an String") if params[:cloudflare_secret_key] and !params[:cloudflare_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_secret_key must be an String") if params[:filebase_secret_key] and !params[:filebase_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_credentials_json must be an String") if params[:google_cloud_storage_credentials_json] and !params[:google_cloud_storage_credentials_json].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_secret_key must be an String") if params[:google_cloud_storage_s3_compatible_secret_key] and !params[:google_cloud_storage_s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_secret_key must be an String") if params[:linode_secret_key] and !params[:linode_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_secret_key must be an String") if params[:s3_compatible_secret_key] and !params[:s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_secret_key must be an String") if params[:wasabi_secret_key] and !params[:wasabi_secret_key].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/remote_server_credentials/#{params[:id]}", :patch, params, options)
      RemoteServerCredential.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/remote_server_credentials/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
