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

    # boolean - If true, this server has been disabled due to failures.  Make any change or set disabled to false to clear this flag.
    def disabled
      @attributes[:disabled]
    end

    def disabled=(value)
      @attributes[:disabled] = value
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

    # string - Initial home folder on remote server
    def remote_home_path
      @attributes[:remote_home_path]
    end

    def remote_home_path=(value)
      @attributes[:remote_home_path] = value
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

    # int64 - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
    def max_connections
      @attributes[:max_connections]
    end

    def max_connections=(value)
      @attributes[:max_connections] = value
    end

    # boolean - If true, we will ensure that all communications with this remote server are made through the primary region of the site.  This setting can also be overridden by a sitewide setting which will force it to true.
    def pin_to_site_region
      @attributes[:pin_to_site_region]
    end

    def pin_to_site_region=(value)
      @attributes[:pin_to_site_region] = value
    end

    # string - If set, all communciations with this remote server are made through the provided region.
    def pinned_region
      @attributes[:pinned_region]
    end

    def pinned_region=(value)
      @attributes[:pinned_region] = value
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

    # string - AWS Access Key.
    def aws_access_key
      @attributes[:aws_access_key]
    end

    def aws_access_key=(value)
      @attributes[:aws_access_key] = value
    end

    # string - Remote server certificate
    def server_certificate
      @attributes[:server_certificate]
    end

    def server_certificate=(value)
      @attributes[:server_certificate] = value
    end

    # string - Remote server SSH Host Key. If provided, we will require that the server host key matches the provided key. Uses OpenSSH format similar to what would go into ~/.ssh/known_hosts
    def server_host_key
      @attributes[:server_host_key]
    end

    def server_host_key=(value)
      @attributes[:server_host_key] = value
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

    # string - Google Cloud Storage bucket name
    def google_cloud_storage_bucket
      @attributes[:google_cloud_storage_bucket]
    end

    def google_cloud_storage_bucket=(value)
      @attributes[:google_cloud_storage_bucket] = value
    end

    # string - Google Cloud Project ID
    def google_cloud_storage_project_id
      @attributes[:google_cloud_storage_project_id]
    end

    def google_cloud_storage_project_id=(value)
      @attributes[:google_cloud_storage_project_id] = value
    end

    # string - Backblaze B2 Cloud Storage S3 Endpoint
    def backblaze_b2_s3_endpoint
      @attributes[:backblaze_b2_s3_endpoint]
    end

    def backblaze_b2_s3_endpoint=(value)
      @attributes[:backblaze_b2_s3_endpoint] = value
    end

    # string - Backblaze B2 Cloud Storage Bucket name
    def backblaze_b2_bucket
      @attributes[:backblaze_b2_bucket]
    end

    def backblaze_b2_bucket=(value)
      @attributes[:backblaze_b2_bucket] = value
    end

    # string - Wasabi Bucket name
    def wasabi_bucket
      @attributes[:wasabi_bucket]
    end

    def wasabi_bucket=(value)
      @attributes[:wasabi_bucket] = value
    end

    # string - Wasabi region
    def wasabi_region
      @attributes[:wasabi_region]
    end

    def wasabi_region=(value)
      @attributes[:wasabi_region] = value
    end

    # string - Wasabi access key.
    def wasabi_access_key
      @attributes[:wasabi_access_key]
    end

    def wasabi_access_key=(value)
      @attributes[:wasabi_access_key] = value
    end

    # string - Rackspace username used to login to the Rackspace Cloud Control Panel.
    def rackspace_username
      @attributes[:rackspace_username]
    end

    def rackspace_username=(value)
      @attributes[:rackspace_username] = value
    end

    # string - Three letter airport code for Rackspace region. See https://support.rackspace.com/how-to/about-regions/
    def rackspace_region
      @attributes[:rackspace_region]
    end

    def rackspace_region=(value)
      @attributes[:rackspace_region] = value
    end

    # string - The name of the container (top level directory) where files will sync.
    def rackspace_container
      @attributes[:rackspace_container]
    end

    def rackspace_container=(value)
      @attributes[:rackspace_container] = value
    end

    # string - Returns link to login with an Oauth provider
    def auth_setup_link
      @attributes[:auth_setup_link]
    end

    def auth_setup_link=(value)
      @attributes[:auth_setup_link] = value
    end

    # string - Either `in_setup` or `complete`
    def auth_status
      @attributes[:auth_status]
    end

    def auth_status=(value)
      @attributes[:auth_status] = value
    end

    # string - Describes the authorized account
    def auth_account_name
      @attributes[:auth_account_name]
    end

    def auth_account_name=(value)
      @attributes[:auth_account_name] = value
    end

    # string - Either personal or business_other account types
    def one_drive_account_type
      @attributes[:one_drive_account_type]
    end

    def one_drive_account_type=(value)
      @attributes[:one_drive_account_type] = value
    end

    # string - Azure Blob Storage Account name
    def azure_blob_storage_account
      @attributes[:azure_blob_storage_account]
    end

    def azure_blob_storage_account=(value)
      @attributes[:azure_blob_storage_account] = value
    end

    # string - Shared Access Signature (SAS) token
    def azure_blob_storage_sas_token
      @attributes[:azure_blob_storage_sas_token]
    end

    def azure_blob_storage_sas_token=(value)
      @attributes[:azure_blob_storage_sas_token] = value
    end

    # string - Azure Blob Storage Container name
    def azure_blob_storage_container
      @attributes[:azure_blob_storage_container]
    end

    def azure_blob_storage_container=(value)
      @attributes[:azure_blob_storage_container] = value
    end

    # string - Azure File Storage Account name
    def azure_files_storage_account
      @attributes[:azure_files_storage_account]
    end

    def azure_files_storage_account=(value)
      @attributes[:azure_files_storage_account] = value
    end

    # string - Shared Access Signature (SAS) token
    def azure_files_storage_sas_token
      @attributes[:azure_files_storage_sas_token]
    end

    def azure_files_storage_sas_token=(value)
      @attributes[:azure_files_storage_sas_token] = value
    end

    # string - Azure File Storage Share name
    def azure_files_storage_share_name
      @attributes[:azure_files_storage_share_name]
    end

    def azure_files_storage_share_name=(value)
      @attributes[:azure_files_storage_share_name] = value
    end

    # string - S3-compatible Bucket name
    def s3_compatible_bucket
      @attributes[:s3_compatible_bucket]
    end

    def s3_compatible_bucket=(value)
      @attributes[:s3_compatible_bucket] = value
    end

    # string - S3-compatible endpoint
    def s3_compatible_endpoint
      @attributes[:s3_compatible_endpoint]
    end

    def s3_compatible_endpoint=(value)
      @attributes[:s3_compatible_endpoint] = value
    end

    # string - S3-compatible endpoint
    def s3_compatible_region
      @attributes[:s3_compatible_region]
    end

    def s3_compatible_region=(value)
      @attributes[:s3_compatible_region] = value
    end

    # string - S3-compatible Access Key.
    def s3_compatible_access_key
      @attributes[:s3_compatible_access_key]
    end

    def s3_compatible_access_key=(value)
      @attributes[:s3_compatible_access_key] = value
    end

    # boolean - `true` if remote server only accepts connections from dedicated IPs
    def enable_dedicated_ips
      @attributes[:enable_dedicated_ips]
    end

    def enable_dedicated_ips=(value)
      @attributes[:enable_dedicated_ips] = value
    end

    # string - Local permissions for files agent. read_only, write_only, or read_write
    def files_agent_permission_set
      @attributes[:files_agent_permission_set]
    end

    def files_agent_permission_set=(value)
      @attributes[:files_agent_permission_set] = value
    end

    # string - Agent local root path
    def files_agent_root
      @attributes[:files_agent_root]
    end

    def files_agent_root=(value)
      @attributes[:files_agent_root] = value
    end

    # string - Files Agent API Token
    def files_agent_api_token
      @attributes[:files_agent_api_token]
    end

    def files_agent_api_token=(value)
      @attributes[:files_agent_api_token] = value
    end

    # string - Filebase Bucket name
    def filebase_bucket
      @attributes[:filebase_bucket]
    end

    def filebase_bucket=(value)
      @attributes[:filebase_bucket] = value
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

    # string - Passphrase for private key if needed.
    def private_key_passphrase
      @attributes[:private_key_passphrase]
    end

    def private_key_passphrase=(value)
      @attributes[:private_key_passphrase] = value
    end

    # string - SSL client certificate.
    def ssl_certificate
      @attributes[:ssl_certificate]
    end

    def ssl_certificate=(value)
      @attributes[:ssl_certificate] = value
    end

    # string - A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
    def google_cloud_storage_credentials_json
      @attributes[:google_cloud_storage_credentials_json]
    end

    def google_cloud_storage_credentials_json=(value)
      @attributes[:google_cloud_storage_credentials_json] = value
    end

    # string - Wasabi secret key.
    def wasabi_secret_key
      @attributes[:wasabi_secret_key]
    end

    def wasabi_secret_key=(value)
      @attributes[:wasabi_secret_key] = value
    end

    # string - Backblaze B2 Cloud Storage keyID.
    def backblaze_b2_key_id
      @attributes[:backblaze_b2_key_id]
    end

    def backblaze_b2_key_id=(value)
      @attributes[:backblaze_b2_key_id] = value
    end

    # string - Backblaze B2 Cloud Storage applicationKey.
    def backblaze_b2_application_key
      @attributes[:backblaze_b2_application_key]
    end

    def backblaze_b2_application_key=(value)
      @attributes[:backblaze_b2_application_key] = value
    end

    # string - Rackspace API key from the Rackspace Cloud Control Panel.
    def rackspace_api_key
      @attributes[:rackspace_api_key]
    end

    def rackspace_api_key=(value)
      @attributes[:rackspace_api_key] = value
    end

    # boolean - Reset authenticated account
    def reset_authentication
      @attributes[:reset_authentication]
    end

    def reset_authentication=(value)
      @attributes[:reset_authentication] = value
    end

    # string - Azure Blob Storage secret key.
    def azure_blob_storage_access_key
      @attributes[:azure_blob_storage_access_key]
    end

    def azure_blob_storage_access_key=(value)
      @attributes[:azure_blob_storage_access_key] = value
    end

    # string - Azure File Storage access key.
    def azure_files_storage_access_key
      @attributes[:azure_files_storage_access_key]
    end

    def azure_files_storage_access_key=(value)
      @attributes[:azure_files_storage_access_key] = value
    end

    # string - S3-compatible secret key
    def s3_compatible_secret_key
      @attributes[:s3_compatible_secret_key]
    end

    def s3_compatible_secret_key=(value)
      @attributes[:s3_compatible_secret_key] = value
    end

    # Post local changes, check in, and download configuration file (used by some Remote Server integrations, such as the Files.com Agent)
    #
    # Parameters:
    #   api_token - string - Files Agent API Token
    #   permission_set - string -
    #   root - string - Agent local root path
    #   hostname - string
    #   port - int64 - Incoming port for files agent connections
    #   status - string - either running or shutdown
    #   config_version - string - agent config version
    #   private_key - string - private key
    #   public_key - string - public key
    #   server_host_key - string
    #   subdomain - string
    def configuration_file(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: api_token must be an String") if params[:api_token] and !params[:api_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if params[:permission_set] and !params[:permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: root must be an String") if params[:root] and !params[:root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params[:hostname] and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: port must be an Integer") if params[:port] and !params[:port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: status must be an String") if params[:status] and !params[:status].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: config_version must be an String") if params[:config_version] and !params[:config_version].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if params[:public_key] and !params[:public_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_host_key must be an String") if params[:server_host_key] and !params[:server_host_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subdomain must be an String") if params[:subdomain] and !params[:subdomain].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/remote_servers/#{@attributes[:id]}/configuration_file", :post, params, @options)
    end

    # Parameters:
    #   aws_access_key - string - AWS Access Key.
    #   aws_secret_key - string - AWS secret key.
    #   password - string - Password if needed.
    #   private_key - string - Private key if needed.
    #   private_key_passphrase - string - Passphrase for private key if needed.
    #   ssl_certificate - string - SSL client certificate.
    #   google_cloud_storage_credentials_json - string - A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
    #   wasabi_access_key - string - Wasabi access key.
    #   wasabi_secret_key - string - Wasabi secret key.
    #   backblaze_b2_key_id - string - Backblaze B2 Cloud Storage keyID.
    #   backblaze_b2_application_key - string - Backblaze B2 Cloud Storage applicationKey.
    #   rackspace_api_key - string - Rackspace API key from the Rackspace Cloud Control Panel.
    #   reset_authentication - boolean - Reset authenticated account
    #   azure_blob_storage_access_key - string - Azure Blob Storage secret key.
    #   azure_files_storage_access_key - string - Azure File Storage access key.
    #   hostname - string - Hostname or IP address
    #   name - string - Internal name for your reference
    #   max_connections - int64 - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
    #   pin_to_site_region - boolean - If true, we will ensure that all communications with this remote server are made through the primary region of the site.  This setting can also be overridden by a sitewide setting which will force it to true.
    #   port - int64 - Port for remote server.  Not needed for S3.
    #   s3_bucket - string - S3 bucket name
    #   s3_region - string - S3 region
    #   server_certificate - string - Remote server certificate
    #   server_host_key - string - Remote server SSH Host Key. If provided, we will require that the server host key matches the provided key. Uses OpenSSH format similar to what would go into ~/.ssh/known_hosts
    #   server_type - string - Remote server type.
    #   ssl - string - Should we require SSL?
    #   username - string - Remote server username.  Not needed for S3 buckets.
    #   google_cloud_storage_bucket - string - Google Cloud Storage bucket name
    #   google_cloud_storage_project_id - string - Google Cloud Project ID
    #   backblaze_b2_bucket - string - Backblaze B2 Cloud Storage Bucket name
    #   backblaze_b2_s3_endpoint - string - Backblaze B2 Cloud Storage S3 Endpoint
    #   wasabi_bucket - string - Wasabi Bucket name
    #   wasabi_region - string - Wasabi region
    #   rackspace_username - string - Rackspace username used to login to the Rackspace Cloud Control Panel.
    #   rackspace_region - string - Three letter airport code for Rackspace region. See https://support.rackspace.com/how-to/about-regions/
    #   rackspace_container - string - The name of the container (top level directory) where files will sync.
    #   one_drive_account_type - string - Either personal or business_other account types
    #   azure_blob_storage_account - string - Azure Blob Storage Account name
    #   azure_blob_storage_container - string - Azure Blob Storage Container name
    #   azure_blob_storage_sas_token - string - Shared Access Signature (SAS) token
    #   azure_files_storage_account - string - Azure File Storage Account name
    #   azure_files_storage_share_name - string - Azure File Storage Share name
    #   azure_files_storage_sas_token - string - Shared Access Signature (SAS) token
    #   s3_compatible_bucket - string - S3-compatible Bucket name
    #   s3_compatible_endpoint - string - S3-compatible endpoint
    #   s3_compatible_region - string - S3-compatible endpoint
    #   enable_dedicated_ips - boolean - `true` if remote server only accepts connections from dedicated IPs
    #   s3_compatible_access_key - string - S3-compatible Access Key.
    #   s3_compatible_secret_key - string - S3-compatible secret key
    #   files_agent_root - string - Agent local root path
    #   files_agent_permission_set - string - Local permissions for files agent. read_only, write_only, or read_write
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if params[:aws_access_key] and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_secret_key must be an String") if params[:aws_secret_key] and !params[:aws_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if params[:private_key_passphrase] and !params[:private_key_passphrase].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate must be an String") if params[:ssl_certificate] and !params[:ssl_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_credentials_json must be an String") if params[:google_cloud_storage_credentials_json] and !params[:google_cloud_storage_credentials_json].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if params[:wasabi_access_key] and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_secret_key must be an String") if params[:wasabi_secret_key] and !params[:wasabi_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_key_id must be an String") if params[:backblaze_b2_key_id] and !params[:backblaze_b2_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_application_key must be an String") if params[:backblaze_b2_application_key] and !params[:backblaze_b2_application_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rackspace_api_key must be an String") if params[:rackspace_api_key] and !params[:rackspace_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_access_key must be an String") if params[:azure_blob_storage_access_key] and !params[:azure_blob_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_access_key must be an String") if params[:azure_files_storage_access_key] and !params[:azure_files_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params[:hostname] and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: max_connections must be an Integer") if params[:max_connections] and !params[:max_connections].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: port must be an Integer") if params[:port] and !params[:port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: s3_bucket must be an String") if params[:s3_bucket] and !params[:s3_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_region must be an String") if params[:s3_region] and !params[:s3_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params[:server_certificate] and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_host_key must be an String") if params[:server_host_key] and !params[:server_host_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if params[:server_type] and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl must be an String") if params[:ssl] and !params[:ssl].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_bucket must be an String") if params[:google_cloud_storage_bucket] and !params[:google_cloud_storage_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_project_id must be an String") if params[:google_cloud_storage_project_id] and !params[:google_cloud_storage_project_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_bucket must be an String") if params[:backblaze_b2_bucket] and !params[:backblaze_b2_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_s3_endpoint must be an String") if params[:backblaze_b2_s3_endpoint] and !params[:backblaze_b2_s3_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_bucket must be an String") if params[:wasabi_bucket] and !params[:wasabi_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_region must be an String") if params[:wasabi_region] and !params[:wasabi_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rackspace_username must be an String") if params[:rackspace_username] and !params[:rackspace_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rackspace_region must be an String") if params[:rackspace_region] and !params[:rackspace_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rackspace_container must be an String") if params[:rackspace_container] and !params[:rackspace_container].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: one_drive_account_type must be an String") if params[:one_drive_account_type] and !params[:one_drive_account_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_account must be an String") if params[:azure_blob_storage_account] and !params[:azure_blob_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_container must be an String") if params[:azure_blob_storage_container] and !params[:azure_blob_storage_container].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_sas_token must be an String") if params[:azure_blob_storage_sas_token] and !params[:azure_blob_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_account must be an String") if params[:azure_files_storage_account] and !params[:azure_files_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_share_name must be an String") if params[:azure_files_storage_share_name] and !params[:azure_files_storage_share_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_sas_token must be an String") if params[:azure_files_storage_sas_token] and !params[:azure_files_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_bucket must be an String") if params[:s3_compatible_bucket] and !params[:s3_compatible_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint must be an String") if params[:s3_compatible_endpoint] and !params[:s3_compatible_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_region must be an String") if params[:s3_compatible_region] and !params[:s3_compatible_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if params[:s3_compatible_access_key] and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_secret_key must be an String") if params[:s3_compatible_secret_key] and !params[:s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_root must be an String") if params[:files_agent_root] and !params[:files_agent_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_permission_set must be an String") if params[:files_agent_permission_set] and !params[:files_agent_permission_set].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/remote_servers/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

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
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(RemoteServer, params) do
        Api.send_request("/remote_servers", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Remote Server ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/remote_servers/#{params[:id]}", :get, params, options)
      RemoteServer.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   id (required) - int64 - Remote Server ID.
    def self.find_configuration_file(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/remote_servers/#{params[:id]}/configuration_file", :get, params, options)
      RemoteServerConfigurationFile.new(response.data, options)
    end

    # Parameters:
    #   aws_access_key - string - AWS Access Key.
    #   aws_secret_key - string - AWS secret key.
    #   password - string - Password if needed.
    #   private_key - string - Private key if needed.
    #   private_key_passphrase - string - Passphrase for private key if needed.
    #   ssl_certificate - string - SSL client certificate.
    #   google_cloud_storage_credentials_json - string - A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
    #   wasabi_access_key - string - Wasabi access key.
    #   wasabi_secret_key - string - Wasabi secret key.
    #   backblaze_b2_key_id - string - Backblaze B2 Cloud Storage keyID.
    #   backblaze_b2_application_key - string - Backblaze B2 Cloud Storage applicationKey.
    #   rackspace_api_key - string - Rackspace API key from the Rackspace Cloud Control Panel.
    #   reset_authentication - boolean - Reset authenticated account
    #   azure_blob_storage_access_key - string - Azure Blob Storage secret key.
    #   azure_files_storage_access_key - string - Azure File Storage access key.
    #   hostname - string - Hostname or IP address
    #   name - string - Internal name for your reference
    #   max_connections - int64 - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
    #   pin_to_site_region - boolean - If true, we will ensure that all communications with this remote server are made through the primary region of the site.  This setting can also be overridden by a sitewide setting which will force it to true.
    #   port - int64 - Port for remote server.  Not needed for S3.
    #   s3_bucket - string - S3 bucket name
    #   s3_region - string - S3 region
    #   server_certificate - string - Remote server certificate
    #   server_host_key - string - Remote server SSH Host Key. If provided, we will require that the server host key matches the provided key. Uses OpenSSH format similar to what would go into ~/.ssh/known_hosts
    #   server_type - string - Remote server type.
    #   ssl - string - Should we require SSL?
    #   username - string - Remote server username.  Not needed for S3 buckets.
    #   google_cloud_storage_bucket - string - Google Cloud Storage bucket name
    #   google_cloud_storage_project_id - string - Google Cloud Project ID
    #   backblaze_b2_bucket - string - Backblaze B2 Cloud Storage Bucket name
    #   backblaze_b2_s3_endpoint - string - Backblaze B2 Cloud Storage S3 Endpoint
    #   wasabi_bucket - string - Wasabi Bucket name
    #   wasabi_region - string - Wasabi region
    #   rackspace_username - string - Rackspace username used to login to the Rackspace Cloud Control Panel.
    #   rackspace_region - string - Three letter airport code for Rackspace region. See https://support.rackspace.com/how-to/about-regions/
    #   rackspace_container - string - The name of the container (top level directory) where files will sync.
    #   one_drive_account_type - string - Either personal or business_other account types
    #   azure_blob_storage_account - string - Azure Blob Storage Account name
    #   azure_blob_storage_container - string - Azure Blob Storage Container name
    #   azure_blob_storage_sas_token - string - Shared Access Signature (SAS) token
    #   azure_files_storage_account - string - Azure File Storage Account name
    #   azure_files_storage_share_name - string - Azure File Storage Share name
    #   azure_files_storage_sas_token - string - Shared Access Signature (SAS) token
    #   s3_compatible_bucket - string - S3-compatible Bucket name
    #   s3_compatible_endpoint - string - S3-compatible endpoint
    #   s3_compatible_region - string - S3-compatible endpoint
    #   enable_dedicated_ips - boolean - `true` if remote server only accepts connections from dedicated IPs
    #   s3_compatible_access_key - string - S3-compatible Access Key.
    #   s3_compatible_secret_key - string - S3-compatible secret key
    #   files_agent_root - string - Agent local root path
    #   files_agent_permission_set - string - Local permissions for files agent. read_only, write_only, or read_write
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if params[:aws_access_key] and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_secret_key must be an String") if params[:aws_secret_key] and !params[:aws_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if params[:private_key_passphrase] and !params[:private_key_passphrase].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate must be an String") if params[:ssl_certificate] and !params[:ssl_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_credentials_json must be an String") if params[:google_cloud_storage_credentials_json] and !params[:google_cloud_storage_credentials_json].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if params[:wasabi_access_key] and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_secret_key must be an String") if params[:wasabi_secret_key] and !params[:wasabi_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_key_id must be an String") if params[:backblaze_b2_key_id] and !params[:backblaze_b2_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_application_key must be an String") if params[:backblaze_b2_application_key] and !params[:backblaze_b2_application_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rackspace_api_key must be an String") if params[:rackspace_api_key] and !params[:rackspace_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_access_key must be an String") if params[:azure_blob_storage_access_key] and !params[:azure_blob_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_access_key must be an String") if params[:azure_files_storage_access_key] and !params[:azure_files_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params[:hostname] and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: max_connections must be an Integer") if params[:max_connections] and !params[:max_connections].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: port must be an Integer") if params[:port] and !params[:port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: s3_bucket must be an String") if params[:s3_bucket] and !params[:s3_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_region must be an String") if params[:s3_region] and !params[:s3_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params[:server_certificate] and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_host_key must be an String") if params[:server_host_key] and !params[:server_host_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if params[:server_type] and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl must be an String") if params[:ssl] and !params[:ssl].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_bucket must be an String") if params[:google_cloud_storage_bucket] and !params[:google_cloud_storage_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_project_id must be an String") if params[:google_cloud_storage_project_id] and !params[:google_cloud_storage_project_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_bucket must be an String") if params[:backblaze_b2_bucket] and !params[:backblaze_b2_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_s3_endpoint must be an String") if params[:backblaze_b2_s3_endpoint] and !params[:backblaze_b2_s3_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_bucket must be an String") if params[:wasabi_bucket] and !params[:wasabi_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_region must be an String") if params[:wasabi_region] and !params[:wasabi_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rackspace_username must be an String") if params[:rackspace_username] and !params[:rackspace_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rackspace_region must be an String") if params[:rackspace_region] and !params[:rackspace_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rackspace_container must be an String") if params[:rackspace_container] and !params[:rackspace_container].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: one_drive_account_type must be an String") if params[:one_drive_account_type] and !params[:one_drive_account_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_account must be an String") if params[:azure_blob_storage_account] and !params[:azure_blob_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_container must be an String") if params[:azure_blob_storage_container] and !params[:azure_blob_storage_container].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_sas_token must be an String") if params[:azure_blob_storage_sas_token] and !params[:azure_blob_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_account must be an String") if params[:azure_files_storage_account] and !params[:azure_files_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_share_name must be an String") if params[:azure_files_storage_share_name] and !params[:azure_files_storage_share_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_sas_token must be an String") if params[:azure_files_storage_sas_token] and !params[:azure_files_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_bucket must be an String") if params[:s3_compatible_bucket] and !params[:s3_compatible_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint must be an String") if params[:s3_compatible_endpoint] and !params[:s3_compatible_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_region must be an String") if params[:s3_compatible_region] and !params[:s3_compatible_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if params[:s3_compatible_access_key] and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_secret_key must be an String") if params[:s3_compatible_secret_key] and !params[:s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_root must be an String") if params[:files_agent_root] and !params[:files_agent_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_permission_set must be an String") if params[:files_agent_permission_set] and !params[:files_agent_permission_set].is_a?(String)

      response, options = Api.send_request("/remote_servers", :post, params, options)
      RemoteServer.new(response.data, options)
    end

    # Post local changes, check in, and download configuration file (used by some Remote Server integrations, such as the Files.com Agent)
    #
    # Parameters:
    #   api_token - string - Files Agent API Token
    #   permission_set - string -
    #   root - string - Agent local root path
    #   hostname - string
    #   port - int64 - Incoming port for files agent connections
    #   status - string - either running or shutdown
    #   config_version - string - agent config version
    #   private_key - string - private key
    #   public_key - string - public key
    #   server_host_key - string
    #   subdomain - string
    def self.configuration_file(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: api_token must be an String") if params[:api_token] and !params[:api_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if params[:permission_set] and !params[:permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: root must be an String") if params[:root] and !params[:root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params[:hostname] and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: port must be an Integer") if params[:port] and !params[:port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: status must be an String") if params[:status] and !params[:status].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: config_version must be an String") if params[:config_version] and !params[:config_version].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: public_key must be an String") if params[:public_key] and !params[:public_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_host_key must be an String") if params[:server_host_key] and !params[:server_host_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subdomain must be an String") if params[:subdomain] and !params[:subdomain].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/remote_servers/#{params[:id]}/configuration_file", :post, params, options)
      RemoteServerConfigurationFile.new(response.data, options)
    end

    # Parameters:
    #   aws_access_key - string - AWS Access Key.
    #   aws_secret_key - string - AWS secret key.
    #   password - string - Password if needed.
    #   private_key - string - Private key if needed.
    #   private_key_passphrase - string - Passphrase for private key if needed.
    #   ssl_certificate - string - SSL client certificate.
    #   google_cloud_storage_credentials_json - string - A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
    #   wasabi_access_key - string - Wasabi access key.
    #   wasabi_secret_key - string - Wasabi secret key.
    #   backblaze_b2_key_id - string - Backblaze B2 Cloud Storage keyID.
    #   backblaze_b2_application_key - string - Backblaze B2 Cloud Storage applicationKey.
    #   rackspace_api_key - string - Rackspace API key from the Rackspace Cloud Control Panel.
    #   reset_authentication - boolean - Reset authenticated account
    #   azure_blob_storage_access_key - string - Azure Blob Storage secret key.
    #   azure_files_storage_access_key - string - Azure File Storage access key.
    #   hostname - string - Hostname or IP address
    #   name - string - Internal name for your reference
    #   max_connections - int64 - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
    #   pin_to_site_region - boolean - If true, we will ensure that all communications with this remote server are made through the primary region of the site.  This setting can also be overridden by a sitewide setting which will force it to true.
    #   port - int64 - Port for remote server.  Not needed for S3.
    #   s3_bucket - string - S3 bucket name
    #   s3_region - string - S3 region
    #   server_certificate - string - Remote server certificate
    #   server_host_key - string - Remote server SSH Host Key. If provided, we will require that the server host key matches the provided key. Uses OpenSSH format similar to what would go into ~/.ssh/known_hosts
    #   server_type - string - Remote server type.
    #   ssl - string - Should we require SSL?
    #   username - string - Remote server username.  Not needed for S3 buckets.
    #   google_cloud_storage_bucket - string - Google Cloud Storage bucket name
    #   google_cloud_storage_project_id - string - Google Cloud Project ID
    #   backblaze_b2_bucket - string - Backblaze B2 Cloud Storage Bucket name
    #   backblaze_b2_s3_endpoint - string - Backblaze B2 Cloud Storage S3 Endpoint
    #   wasabi_bucket - string - Wasabi Bucket name
    #   wasabi_region - string - Wasabi region
    #   rackspace_username - string - Rackspace username used to login to the Rackspace Cloud Control Panel.
    #   rackspace_region - string - Three letter airport code for Rackspace region. See https://support.rackspace.com/how-to/about-regions/
    #   rackspace_container - string - The name of the container (top level directory) where files will sync.
    #   one_drive_account_type - string - Either personal or business_other account types
    #   azure_blob_storage_account - string - Azure Blob Storage Account name
    #   azure_blob_storage_container - string - Azure Blob Storage Container name
    #   azure_blob_storage_sas_token - string - Shared Access Signature (SAS) token
    #   azure_files_storage_account - string - Azure File Storage Account name
    #   azure_files_storage_share_name - string - Azure File Storage Share name
    #   azure_files_storage_sas_token - string - Shared Access Signature (SAS) token
    #   s3_compatible_bucket - string - S3-compatible Bucket name
    #   s3_compatible_endpoint - string - S3-compatible endpoint
    #   s3_compatible_region - string - S3-compatible endpoint
    #   enable_dedicated_ips - boolean - `true` if remote server only accepts connections from dedicated IPs
    #   s3_compatible_access_key - string - S3-compatible Access Key.
    #   s3_compatible_secret_key - string - S3-compatible secret key
    #   files_agent_root - string - Agent local root path
    #   files_agent_permission_set - string - Local permissions for files agent. read_only, write_only, or read_write
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if params[:aws_access_key] and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_secret_key must be an String") if params[:aws_secret_key] and !params[:aws_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if params[:private_key_passphrase] and !params[:private_key_passphrase].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate must be an String") if params[:ssl_certificate] and !params[:ssl_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_credentials_json must be an String") if params[:google_cloud_storage_credentials_json] and !params[:google_cloud_storage_credentials_json].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if params[:wasabi_access_key] and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_secret_key must be an String") if params[:wasabi_secret_key] and !params[:wasabi_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_key_id must be an String") if params[:backblaze_b2_key_id] and !params[:backblaze_b2_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_application_key must be an String") if params[:backblaze_b2_application_key] and !params[:backblaze_b2_application_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rackspace_api_key must be an String") if params[:rackspace_api_key] and !params[:rackspace_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_access_key must be an String") if params[:azure_blob_storage_access_key] and !params[:azure_blob_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_access_key must be an String") if params[:azure_files_storage_access_key] and !params[:azure_files_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params[:hostname] and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: max_connections must be an Integer") if params[:max_connections] and !params[:max_connections].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: port must be an Integer") if params[:port] and !params[:port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: s3_bucket must be an String") if params[:s3_bucket] and !params[:s3_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_region must be an String") if params[:s3_region] and !params[:s3_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params[:server_certificate] and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_host_key must be an String") if params[:server_host_key] and !params[:server_host_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if params[:server_type] and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl must be an String") if params[:ssl] and !params[:ssl].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_bucket must be an String") if params[:google_cloud_storage_bucket] and !params[:google_cloud_storage_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_project_id must be an String") if params[:google_cloud_storage_project_id] and !params[:google_cloud_storage_project_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_bucket must be an String") if params[:backblaze_b2_bucket] and !params[:backblaze_b2_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_s3_endpoint must be an String") if params[:backblaze_b2_s3_endpoint] and !params[:backblaze_b2_s3_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_bucket must be an String") if params[:wasabi_bucket] and !params[:wasabi_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_region must be an String") if params[:wasabi_region] and !params[:wasabi_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rackspace_username must be an String") if params[:rackspace_username] and !params[:rackspace_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rackspace_region must be an String") if params[:rackspace_region] and !params[:rackspace_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: rackspace_container must be an String") if params[:rackspace_container] and !params[:rackspace_container].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: one_drive_account_type must be an String") if params[:one_drive_account_type] and !params[:one_drive_account_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_account must be an String") if params[:azure_blob_storage_account] and !params[:azure_blob_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_container must be an String") if params[:azure_blob_storage_container] and !params[:azure_blob_storage_container].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_sas_token must be an String") if params[:azure_blob_storage_sas_token] and !params[:azure_blob_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_account must be an String") if params[:azure_files_storage_account] and !params[:azure_files_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_share_name must be an String") if params[:azure_files_storage_share_name] and !params[:azure_files_storage_share_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_sas_token must be an String") if params[:azure_files_storage_sas_token] and !params[:azure_files_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_bucket must be an String") if params[:s3_compatible_bucket] and !params[:s3_compatible_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint must be an String") if params[:s3_compatible_endpoint] and !params[:s3_compatible_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_region must be an String") if params[:s3_compatible_region] and !params[:s3_compatible_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if params[:s3_compatible_access_key] and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_secret_key must be an String") if params[:s3_compatible_secret_key] and !params[:s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_root must be an String") if params[:files_agent_root] and !params[:files_agent_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_permission_set must be an String") if params[:files_agent_permission_set] and !params[:files_agent_permission_set].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/remote_servers/#{params[:id]}", :patch, params, options)
      RemoteServer.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, _options = Api.send_request("/remote_servers/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
