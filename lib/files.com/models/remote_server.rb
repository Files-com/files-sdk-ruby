# frozen_string_literal: true

module Files
  class RemoteServer
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Remote Server ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # boolean - If true, this Remote Server has been disabled due to failures.  Make any change or set disabled to false to clear this flag.
    def disabled
      @attributes[:disabled]
    end

    def disabled=(value)
      @attributes[:disabled] = value
    end

    # string - Type of authentication method to use
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

    # string - Upload staging path.  Applies to SFTP only.  If a path is provided here, files will first be uploaded to this path on the remote folder and the moved into the final correct path via an SFTP move command.  This is required by some remote MFT systems to emulate atomic uploads, which are otherwise not supoprted by SFTP.
    def upload_staging_path
      @attributes[:upload_staging_path]
    end

    def upload_staging_path=(value)
      @attributes[:upload_staging_path] = value
    end

    # boolean - Allow relative paths in SFTP. If true, paths will not be forced to be absolute, allowing operations relative to the user's home directory.
    def allow_relative_paths
      @attributes[:allow_relative_paths]
    end

    def allow_relative_paths=(value)
      @attributes[:allow_relative_paths] = value
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

    # int64 - Port for remote server.
    def port
      @attributes[:port]
    end

    def port=(value)
      @attributes[:port] = value
    end

    # string - If set to always, uploads to this server will be uploaded first to Files.com before being sent to the remote server. This can improve performance in certain access patterns, such as high-latency connections.  It will cause data to be temporarily stored in Files.com. If set to auto, we will perform this optimization if we believe it to be a benefit in a given situation.
    def buffer_uploads
      @attributes[:buffer_uploads]
    end

    def buffer_uploads=(value)
      @attributes[:buffer_uploads] = value
    end

    # int64 - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
    def max_connections
      @attributes[:max_connections]
    end

    def max_connections=(value)
      @attributes[:max_connections] = value
    end

    # boolean - If true, we will ensure that all communications with this remote server are made through the primary region of the site.  This setting can also be overridden by a site-wide setting which will force it to true.
    def pin_to_site_region
      @attributes[:pin_to_site_region]
    end

    def pin_to_site_region=(value)
      @attributes[:pin_to_site_region] = value
    end

    # string - If set, all communications with this remote server are made through the provided region.
    def pinned_region
      @attributes[:pinned_region]
    end

    def pinned_region=(value)
      @attributes[:pinned_region] = value
    end

    # int64 - ID of Remote Server Credential, if applicable.
    def remote_server_credential_id
      @attributes[:remote_server_credential_id]
    end

    def remote_server_credential_id=(value)
      @attributes[:remote_server_credential_id] = value
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

    # int64 - Workspace ID (0 for default workspace)
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # string - Should we require SSL?
    def ssl
      @attributes[:ssl]
    end

    def ssl=(value)
      @attributes[:ssl] = value
    end

    # string - Remote server username.
    def username
      @attributes[:username]
    end

    def username=(value)
      @attributes[:username] = value
    end

    # string - Google Cloud Storage: Bucket Name
    def google_cloud_storage_bucket
      @attributes[:google_cloud_storage_bucket]
    end

    def google_cloud_storage_bucket=(value)
      @attributes[:google_cloud_storage_bucket] = value
    end

    # string - Google Cloud Storage: Project ID
    def google_cloud_storage_project_id
      @attributes[:google_cloud_storage_project_id]
    end

    def google_cloud_storage_project_id=(value)
      @attributes[:google_cloud_storage_project_id] = value
    end

    # string - Google Cloud Storage: S3-compatible Access Key.
    def google_cloud_storage_s3_compatible_access_key
      @attributes[:google_cloud_storage_s3_compatible_access_key]
    end

    def google_cloud_storage_s3_compatible_access_key=(value)
      @attributes[:google_cloud_storage_s3_compatible_access_key] = value
    end

    # string - Backblaze B2 Cloud Storage: S3 Endpoint
    def backblaze_b2_s3_endpoint
      @attributes[:backblaze_b2_s3_endpoint]
    end

    def backblaze_b2_s3_endpoint=(value)
      @attributes[:backblaze_b2_s3_endpoint] = value
    end

    # string - Backblaze B2 Cloud Storage: Bucket name
    def backblaze_b2_bucket
      @attributes[:backblaze_b2_bucket]
    end

    def backblaze_b2_bucket=(value)
      @attributes[:backblaze_b2_bucket] = value
    end

    # string - Wasabi: Bucket name
    def wasabi_bucket
      @attributes[:wasabi_bucket]
    end

    def wasabi_bucket=(value)
      @attributes[:wasabi_bucket] = value
    end

    # string - Wasabi: Region
    def wasabi_region
      @attributes[:wasabi_region]
    end

    def wasabi_region=(value)
      @attributes[:wasabi_region] = value
    end

    # string - Wasabi: Access Key.
    def wasabi_access_key
      @attributes[:wasabi_access_key]
    end

    def wasabi_access_key=(value)
      @attributes[:wasabi_access_key] = value
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

    # string - OneDrive: Either personal or business_other account types
    def one_drive_account_type
      @attributes[:one_drive_account_type]
    end

    def one_drive_account_type=(value)
      @attributes[:one_drive_account_type] = value
    end

    # string - Azure Blob Storage: Account name
    def azure_blob_storage_account
      @attributes[:azure_blob_storage_account]
    end

    def azure_blob_storage_account=(value)
      @attributes[:azure_blob_storage_account] = value
    end

    # string - Azure Blob Storage: Container name
    def azure_blob_storage_container
      @attributes[:azure_blob_storage_container]
    end

    def azure_blob_storage_container=(value)
      @attributes[:azure_blob_storage_container] = value
    end

    # boolean - Azure Blob Storage: Does the storage account has hierarchical namespace feature enabled?
    def azure_blob_storage_hierarchical_namespace
      @attributes[:azure_blob_storage_hierarchical_namespace]
    end

    def azure_blob_storage_hierarchical_namespace=(value)
      @attributes[:azure_blob_storage_hierarchical_namespace] = value
    end

    # string - Azure Blob Storage: Custom DNS suffix
    def azure_blob_storage_dns_suffix
      @attributes[:azure_blob_storage_dns_suffix]
    end

    def azure_blob_storage_dns_suffix=(value)
      @attributes[:azure_blob_storage_dns_suffix] = value
    end

    # string - Azure Files: Storage Account name
    def azure_files_storage_account
      @attributes[:azure_files_storage_account]
    end

    def azure_files_storage_account=(value)
      @attributes[:azure_files_storage_account] = value
    end

    # string - Azure Files:  Storage Share name
    def azure_files_storage_share_name
      @attributes[:azure_files_storage_share_name]
    end

    def azure_files_storage_share_name=(value)
      @attributes[:azure_files_storage_share_name] = value
    end

    # string - Azure Files: Custom DNS suffix
    def azure_files_storage_dns_suffix
      @attributes[:azure_files_storage_dns_suffix]
    end

    def azure_files_storage_dns_suffix=(value)
      @attributes[:azure_files_storage_dns_suffix] = value
    end

    # string - S3-compatible: Bucket name
    def s3_compatible_bucket
      @attributes[:s3_compatible_bucket]
    end

    def s3_compatible_bucket=(value)
      @attributes[:s3_compatible_bucket] = value
    end

    # string - S3-compatible: endpoint
    def s3_compatible_endpoint
      @attributes[:s3_compatible_endpoint]
    end

    def s3_compatible_endpoint=(value)
      @attributes[:s3_compatible_endpoint] = value
    end

    # string - S3-compatible: region
    def s3_compatible_region
      @attributes[:s3_compatible_region]
    end

    def s3_compatible_region=(value)
      @attributes[:s3_compatible_region] = value
    end

    # string - S3-compatible: Access Key
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

    # string - Files Agent version
    def files_agent_version
      @attributes[:files_agent_version]
    end

    def files_agent_version=(value)
      @attributes[:files_agent_version] = value
    end

    # boolean - If true, the Files Agent is up to date.
    def files_agent_up_to_date
      @attributes[:files_agent_up_to_date]
    end

    def files_agent_up_to_date=(value)
      @attributes[:files_agent_up_to_date] = value
    end

    # string - Latest available Files Agent version
    def files_agent_latest_version
      @attributes[:files_agent_latest_version]
    end

    def files_agent_latest_version=(value)
      @attributes[:files_agent_latest_version] = value
    end

    # boolean - Files Agent supports receiving push updates
    def files_agent_supports_push_updates
      @attributes[:files_agent_supports_push_updates]
    end

    def files_agent_supports_push_updates=(value)
      @attributes[:files_agent_supports_push_updates] = value
    end

    # int64 - Route traffic to outbound on a files-agent
    def outbound_agent_id
      @attributes[:outbound_agent_id]
    end

    def outbound_agent_id=(value)
      @attributes[:outbound_agent_id] = value
    end

    # string - Filebase: Bucket name
    def filebase_bucket
      @attributes[:filebase_bucket]
    end

    def filebase_bucket=(value)
      @attributes[:filebase_bucket] = value
    end

    # string - Filebase: Access Key.
    def filebase_access_key
      @attributes[:filebase_access_key]
    end

    def filebase_access_key=(value)
      @attributes[:filebase_access_key] = value
    end

    # string - Cloudflare: Bucket name
    def cloudflare_bucket
      @attributes[:cloudflare_bucket]
    end

    def cloudflare_bucket=(value)
      @attributes[:cloudflare_bucket] = value
    end

    # string - Cloudflare: Access Key.
    def cloudflare_access_key
      @attributes[:cloudflare_access_key]
    end

    def cloudflare_access_key=(value)
      @attributes[:cloudflare_access_key] = value
    end

    # string - Cloudflare: endpoint
    def cloudflare_endpoint
      @attributes[:cloudflare_endpoint]
    end

    def cloudflare_endpoint=(value)
      @attributes[:cloudflare_endpoint] = value
    end

    # boolean - Dropbox: If true, list Team folders in root?
    def dropbox_teams
      @attributes[:dropbox_teams]
    end

    def dropbox_teams=(value)
      @attributes[:dropbox_teams] = value
    end

    # string - Linode: Bucket name
    def linode_bucket
      @attributes[:linode_bucket]
    end

    def linode_bucket=(value)
      @attributes[:linode_bucket] = value
    end

    # string - Linode: Access Key
    def linode_access_key
      @attributes[:linode_access_key]
    end

    def linode_access_key=(value)
      @attributes[:linode_access_key] = value
    end

    # string - Linode: region
    def linode_region
      @attributes[:linode_region]
    end

    def linode_region=(value)
      @attributes[:linode_region] = value
    end

    # boolean - If true, this remote server supports file versioning. This value is determined automatically by Files.com.
    def supports_versioning
      @attributes[:supports_versioning]
    end

    def supports_versioning=(value)
      @attributes[:supports_versioning] = value
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

    # boolean - Reset authenticated account?
    def reset_authentication
      @attributes[:reset_authentication]
    end

    def reset_authentication=(value)
      @attributes[:reset_authentication] = value
    end

    # string - SSL client certificate.
    def ssl_certificate
      @attributes[:ssl_certificate]
    end

    def ssl_certificate=(value)
      @attributes[:ssl_certificate] = value
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

    # Push update to Files Agent
    def agent_push_update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/remote_servers/#{@attributes[:id]}/agent_push_update", :post, params, @options)
    end

    # Post local changes, check in, and download configuration file (used by some Remote Server integrations, such as the Files.com Agent)
    #
    # Parameters:
    #   api_token - string - Files Agent API Token
    #   permission_set - string - The permission set for the agent ['read_write', 'read_only', 'write_only']
    #   root - string - The root directory for the agent
    #   hostname - string
    #   port - int64 - Incoming port for files agent connections
    #   status - string - either running or shutdown
    #   config_version - string - agent config version
    #   private_key - string - The private key for the agent
    #   public_key - string - public key
    #   server_host_key - string
    #   subdomain - string - Files.com subdomain site name
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
    #   password - string - Password, if needed.
    #   private_key - string - Private key, if needed.
    #   private_key_passphrase - string - Passphrase for private key if needed.
    #   reset_authentication - boolean - Reset authenticated account?
    #   ssl_certificate - string - SSL client certificate.
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
    #   allow_relative_paths - boolean - Allow relative paths in SFTP. If true, paths will not be forced to be absolute, allowing operations relative to the user's home directory.
    #   aws_access_key - string - AWS Access Key.
    #   azure_blob_storage_account - string - Azure Blob Storage: Account name
    #   azure_blob_storage_container - string - Azure Blob Storage: Container name
    #   azure_blob_storage_dns_suffix - string - Azure Blob Storage: Custom DNS suffix
    #   azure_blob_storage_hierarchical_namespace - boolean - Azure Blob Storage: Does the storage account has hierarchical namespace feature enabled?
    #   azure_files_storage_account - string - Azure Files: Storage Account name
    #   azure_files_storage_dns_suffix - string - Azure Files: Custom DNS suffix
    #   azure_files_storage_share_name - string - Azure Files:  Storage Share name
    #   backblaze_b2_bucket - string - Backblaze B2 Cloud Storage: Bucket name
    #   backblaze_b2_s3_endpoint - string - Backblaze B2 Cloud Storage: S3 Endpoint
    #   buffer_uploads - string - If set to always, uploads to this server will be uploaded first to Files.com before being sent to the remote server. This can improve performance in certain access patterns, such as high-latency connections.  It will cause data to be temporarily stored in Files.com. If set to auto, we will perform this optimization if we believe it to be a benefit in a given situation.
    #   cloudflare_access_key - string - Cloudflare: Access Key.
    #   cloudflare_bucket - string - Cloudflare: Bucket name
    #   cloudflare_endpoint - string - Cloudflare: endpoint
    #   description - string - Internal description for your reference
    #   dropbox_teams - boolean - Dropbox: If true, list Team folders in root?
    #   enable_dedicated_ips - boolean - `true` if remote server only accepts connections from dedicated IPs
    #   filebase_access_key - string - Filebase: Access Key.
    #   filebase_bucket - string - Filebase: Bucket name
    #   files_agent_permission_set - string - Local permissions for files agent. read_only, write_only, or read_write
    #   files_agent_root - string - Agent local root path
    #   files_agent_version - string - Files Agent version
    #   outbound_agent_id - int64 - Route traffic to outbound on a files-agent
    #   google_cloud_storage_bucket - string - Google Cloud Storage: Bucket Name
    #   google_cloud_storage_project_id - string - Google Cloud Storage: Project ID
    #   google_cloud_storage_s3_compatible_access_key - string - Google Cloud Storage: S3-compatible Access Key.
    #   hostname - string - Hostname or IP address
    #   linode_access_key - string - Linode: Access Key
    #   linode_bucket - string - Linode: Bucket name
    #   linode_region - string - Linode: region
    #   max_connections - int64 - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
    #   name - string - Internal name for your reference
    #   one_drive_account_type - string - OneDrive: Either personal or business_other account types
    #   pin_to_site_region - boolean - If true, we will ensure that all communications with this remote server are made through the primary region of the site.  This setting can also be overridden by a site-wide setting which will force it to true.
    #   port - int64 - Port for remote server.
    #   upload_staging_path - string - Upload staging path.  Applies to SFTP only.  If a path is provided here, files will first be uploaded to this path on the remote folder and the moved into the final correct path via an SFTP move command.  This is required by some remote MFT systems to emulate atomic uploads, which are otherwise not supoprted by SFTP.
    #   remote_server_credential_id - int64 - ID of Remote Server Credential, if applicable.
    #   s3_bucket - string - S3 bucket name
    #   s3_compatible_access_key - string - S3-compatible: Access Key
    #   s3_compatible_bucket - string - S3-compatible: Bucket name
    #   s3_compatible_endpoint - string - S3-compatible: endpoint
    #   s3_compatible_region - string - S3-compatible: region
    #   s3_region - string - S3 region
    #   server_certificate - string - Remote server certificate
    #   server_host_key - string - Remote server SSH Host Key. If provided, we will require that the server host key matches the provided key. Uses OpenSSH format similar to what would go into ~/.ssh/known_hosts
    #   server_type - string - Remote server type.
    #   ssl - string - Should we require SSL?
    #   username - string - Remote server username.
    #   wasabi_access_key - string - Wasabi: Access Key.
    #   wasabi_bucket - string - Wasabi: Bucket name
    #   wasabi_region - string - Wasabi: Region
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if params[:private_key_passphrase] and !params[:private_key_passphrase].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate must be an String") if params[:ssl_certificate] and !params[:ssl_certificate].is_a?(String)
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
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if params[:aws_access_key] and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_account must be an String") if params[:azure_blob_storage_account] and !params[:azure_blob_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_container must be an String") if params[:azure_blob_storage_container] and !params[:azure_blob_storage_container].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_dns_suffix must be an String") if params[:azure_blob_storage_dns_suffix] and !params[:azure_blob_storage_dns_suffix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_account must be an String") if params[:azure_files_storage_account] and !params[:azure_files_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_dns_suffix must be an String") if params[:azure_files_storage_dns_suffix] and !params[:azure_files_storage_dns_suffix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_share_name must be an String") if params[:azure_files_storage_share_name] and !params[:azure_files_storage_share_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_bucket must be an String") if params[:backblaze_b2_bucket] and !params[:backblaze_b2_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_s3_endpoint must be an String") if params[:backblaze_b2_s3_endpoint] and !params[:backblaze_b2_s3_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: buffer_uploads must be an String") if params[:buffer_uploads] and !params[:buffer_uploads].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_access_key must be an String") if params[:cloudflare_access_key] and !params[:cloudflare_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_bucket must be an String") if params[:cloudflare_bucket] and !params[:cloudflare_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_endpoint must be an String") if params[:cloudflare_endpoint] and !params[:cloudflare_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_access_key must be an String") if params[:filebase_access_key] and !params[:filebase_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_bucket must be an String") if params[:filebase_bucket] and !params[:filebase_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_permission_set must be an String") if params[:files_agent_permission_set] and !params[:files_agent_permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_root must be an String") if params[:files_agent_root] and !params[:files_agent_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_version must be an String") if params[:files_agent_version] and !params[:files_agent_version].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: outbound_agent_id must be an Integer") if params[:outbound_agent_id] and !params[:outbound_agent_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_bucket must be an String") if params[:google_cloud_storage_bucket] and !params[:google_cloud_storage_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_project_id must be an String") if params[:google_cloud_storage_project_id] and !params[:google_cloud_storage_project_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_access_key must be an String") if params[:google_cloud_storage_s3_compatible_access_key] and !params[:google_cloud_storage_s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params[:hostname] and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_access_key must be an String") if params[:linode_access_key] and !params[:linode_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_bucket must be an String") if params[:linode_bucket] and !params[:linode_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_region must be an String") if params[:linode_region] and !params[:linode_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: max_connections must be an Integer") if params[:max_connections] and !params[:max_connections].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: one_drive_account_type must be an String") if params[:one_drive_account_type] and !params[:one_drive_account_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: port must be an Integer") if params[:port] and !params[:port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: upload_staging_path must be an String") if params[:upload_staging_path] and !params[:upload_staging_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: remote_server_credential_id must be an Integer") if params[:remote_server_credential_id] and !params[:remote_server_credential_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: s3_bucket must be an String") if params[:s3_bucket] and !params[:s3_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if params[:s3_compatible_access_key] and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_bucket must be an String") if params[:s3_compatible_bucket] and !params[:s3_compatible_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint must be an String") if params[:s3_compatible_endpoint] and !params[:s3_compatible_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_region must be an String") if params[:s3_compatible_region] and !params[:s3_compatible_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_region must be an String") if params[:s3_region] and !params[:s3_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params[:server_certificate] and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_host_key must be an String") if params[:server_host_key] and !params[:server_host_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if params[:server_type] and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl must be an String") if params[:ssl] and !params[:ssl].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if params[:wasabi_access_key] and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_bucket must be an String") if params[:wasabi_bucket] and !params[:wasabi_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_region must be an String") if params[:wasabi_region] and !params[:wasabi_region].is_a?(String)
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
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = RemoteServer.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `name`, `server_type`, `backblaze_b2_bucket`, `google_cloud_storage_bucket`, `wasabi_bucket`, `s3_bucket`, `azure_blob_storage_container`, `azure_files_storage_share_name`, `s3_compatible_bucket`, `filebase_bucket`, `cloudflare_bucket` or `linode_bucket`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `name`, `server_type`, `workspace_id`, `backblaze_b2_bucket`, `google_cloud_storage_bucket`, `wasabi_bucket`, `s3_bucket`, `azure_blob_storage_container`, `azure_files_storage_share_name`, `s3_compatible_bucket`, `filebase_bucket`, `cloudflare_bucket` or `linode_bucket`. Valid field combinations are `[ server_type, name ]`, `[ workspace_id, name ]`, `[ backblaze_b2_bucket, name ]`, `[ google_cloud_storage_bucket, name ]`, `[ wasabi_bucket, name ]`, `[ s3_bucket, name ]`, `[ azure_blob_storage_container, name ]`, `[ azure_files_storage_share_name, name ]`, `[ s3_compatible_bucket, name ]`, `[ filebase_bucket, name ]`, `[ cloudflare_bucket, name ]`, `[ linode_bucket, name ]`, `[ workspace_id, server_type ]` or `[ workspace_id, server_type, name ]`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `name`, `backblaze_b2_bucket`, `google_cloud_storage_bucket`, `wasabi_bucket`, `s3_bucket`, `azure_blob_storage_container`, `azure_files_storage_share_name`, `s3_compatible_bucket`, `filebase_bucket`, `cloudflare_bucket` or `linode_bucket`. Valid field combinations are `[ backblaze_b2_bucket, name ]`, `[ google_cloud_storage_bucket, name ]`, `[ wasabi_bucket, name ]`, `[ s3_bucket, name ]`, `[ azure_blob_storage_container, name ]`, `[ azure_files_storage_share_name, name ]`, `[ s3_compatible_bucket, name ]`, `[ filebase_bucket, name ]`, `[ cloudflare_bucket, name ]` or `[ linode_bucket, name ]`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

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
    #   password - string - Password, if needed.
    #   private_key - string - Private key, if needed.
    #   private_key_passphrase - string - Passphrase for private key if needed.
    #   reset_authentication - boolean - Reset authenticated account?
    #   ssl_certificate - string - SSL client certificate.
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
    #   allow_relative_paths - boolean - Allow relative paths in SFTP. If true, paths will not be forced to be absolute, allowing operations relative to the user's home directory.
    #   aws_access_key - string - AWS Access Key.
    #   azure_blob_storage_account - string - Azure Blob Storage: Account name
    #   azure_blob_storage_container - string - Azure Blob Storage: Container name
    #   azure_blob_storage_dns_suffix - string - Azure Blob Storage: Custom DNS suffix
    #   azure_blob_storage_hierarchical_namespace - boolean - Azure Blob Storage: Does the storage account has hierarchical namespace feature enabled?
    #   azure_files_storage_account - string - Azure Files: Storage Account name
    #   azure_files_storage_dns_suffix - string - Azure Files: Custom DNS suffix
    #   azure_files_storage_share_name - string - Azure Files:  Storage Share name
    #   backblaze_b2_bucket - string - Backblaze B2 Cloud Storage: Bucket name
    #   backblaze_b2_s3_endpoint - string - Backblaze B2 Cloud Storage: S3 Endpoint
    #   buffer_uploads - string - If set to always, uploads to this server will be uploaded first to Files.com before being sent to the remote server. This can improve performance in certain access patterns, such as high-latency connections.  It will cause data to be temporarily stored in Files.com. If set to auto, we will perform this optimization if we believe it to be a benefit in a given situation.
    #   cloudflare_access_key - string - Cloudflare: Access Key.
    #   cloudflare_bucket - string - Cloudflare: Bucket name
    #   cloudflare_endpoint - string - Cloudflare: endpoint
    #   description - string - Internal description for your reference
    #   dropbox_teams - boolean - Dropbox: If true, list Team folders in root?
    #   enable_dedicated_ips - boolean - `true` if remote server only accepts connections from dedicated IPs
    #   filebase_access_key - string - Filebase: Access Key.
    #   filebase_bucket - string - Filebase: Bucket name
    #   files_agent_permission_set - string - Local permissions for files agent. read_only, write_only, or read_write
    #   files_agent_root - string - Agent local root path
    #   files_agent_version - string - Files Agent version
    #   outbound_agent_id - int64 - Route traffic to outbound on a files-agent
    #   google_cloud_storage_bucket - string - Google Cloud Storage: Bucket Name
    #   google_cloud_storage_project_id - string - Google Cloud Storage: Project ID
    #   google_cloud_storage_s3_compatible_access_key - string - Google Cloud Storage: S3-compatible Access Key.
    #   hostname - string - Hostname or IP address
    #   linode_access_key - string - Linode: Access Key
    #   linode_bucket - string - Linode: Bucket name
    #   linode_region - string - Linode: region
    #   max_connections - int64 - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
    #   name - string - Internal name for your reference
    #   one_drive_account_type - string - OneDrive: Either personal or business_other account types
    #   pin_to_site_region - boolean - If true, we will ensure that all communications with this remote server are made through the primary region of the site.  This setting can also be overridden by a site-wide setting which will force it to true.
    #   port - int64 - Port for remote server.
    #   upload_staging_path - string - Upload staging path.  Applies to SFTP only.  If a path is provided here, files will first be uploaded to this path on the remote folder and the moved into the final correct path via an SFTP move command.  This is required by some remote MFT systems to emulate atomic uploads, which are otherwise not supoprted by SFTP.
    #   remote_server_credential_id - int64 - ID of Remote Server Credential, if applicable.
    #   s3_bucket - string - S3 bucket name
    #   s3_compatible_access_key - string - S3-compatible: Access Key
    #   s3_compatible_bucket - string - S3-compatible: Bucket name
    #   s3_compatible_endpoint - string - S3-compatible: endpoint
    #   s3_compatible_region - string - S3-compatible: region
    #   s3_region - string - S3 region
    #   server_certificate - string - Remote server certificate
    #   server_host_key - string - Remote server SSH Host Key. If provided, we will require that the server host key matches the provided key. Uses OpenSSH format similar to what would go into ~/.ssh/known_hosts
    #   server_type - string - Remote server type.
    #   ssl - string - Should we require SSL?
    #   username - string - Remote server username.
    #   wasabi_access_key - string - Wasabi: Access Key.
    #   wasabi_bucket - string - Wasabi: Bucket name
    #   wasabi_region - string - Wasabi: Region
    #   workspace_id - int64 - Workspace ID (0 for default workspace)
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if params[:private_key_passphrase] and !params[:private_key_passphrase].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate must be an String") if params[:ssl_certificate] and !params[:ssl_certificate].is_a?(String)
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
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if params[:aws_access_key] and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_account must be an String") if params[:azure_blob_storage_account] and !params[:azure_blob_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_container must be an String") if params[:azure_blob_storage_container] and !params[:azure_blob_storage_container].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_dns_suffix must be an String") if params[:azure_blob_storage_dns_suffix] and !params[:azure_blob_storage_dns_suffix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_account must be an String") if params[:azure_files_storage_account] and !params[:azure_files_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_dns_suffix must be an String") if params[:azure_files_storage_dns_suffix] and !params[:azure_files_storage_dns_suffix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_share_name must be an String") if params[:azure_files_storage_share_name] and !params[:azure_files_storage_share_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_bucket must be an String") if params[:backblaze_b2_bucket] and !params[:backblaze_b2_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_s3_endpoint must be an String") if params[:backblaze_b2_s3_endpoint] and !params[:backblaze_b2_s3_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: buffer_uploads must be an String") if params[:buffer_uploads] and !params[:buffer_uploads].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_access_key must be an String") if params[:cloudflare_access_key] and !params[:cloudflare_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_bucket must be an String") if params[:cloudflare_bucket] and !params[:cloudflare_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_endpoint must be an String") if params[:cloudflare_endpoint] and !params[:cloudflare_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_access_key must be an String") if params[:filebase_access_key] and !params[:filebase_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_bucket must be an String") if params[:filebase_bucket] and !params[:filebase_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_permission_set must be an String") if params[:files_agent_permission_set] and !params[:files_agent_permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_root must be an String") if params[:files_agent_root] and !params[:files_agent_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_version must be an String") if params[:files_agent_version] and !params[:files_agent_version].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: outbound_agent_id must be an Integer") if params[:outbound_agent_id] and !params[:outbound_agent_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_bucket must be an String") if params[:google_cloud_storage_bucket] and !params[:google_cloud_storage_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_project_id must be an String") if params[:google_cloud_storage_project_id] and !params[:google_cloud_storage_project_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_access_key must be an String") if params[:google_cloud_storage_s3_compatible_access_key] and !params[:google_cloud_storage_s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params[:hostname] and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_access_key must be an String") if params[:linode_access_key] and !params[:linode_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_bucket must be an String") if params[:linode_bucket] and !params[:linode_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_region must be an String") if params[:linode_region] and !params[:linode_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: max_connections must be an Integer") if params[:max_connections] and !params[:max_connections].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: one_drive_account_type must be an String") if params[:one_drive_account_type] and !params[:one_drive_account_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: port must be an Integer") if params[:port] and !params[:port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: upload_staging_path must be an String") if params[:upload_staging_path] and !params[:upload_staging_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: remote_server_credential_id must be an Integer") if params[:remote_server_credential_id] and !params[:remote_server_credential_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: s3_bucket must be an String") if params[:s3_bucket] and !params[:s3_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if params[:s3_compatible_access_key] and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_bucket must be an String") if params[:s3_compatible_bucket] and !params[:s3_compatible_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint must be an String") if params[:s3_compatible_endpoint] and !params[:s3_compatible_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_region must be an String") if params[:s3_compatible_region] and !params[:s3_compatible_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_region must be an String") if params[:s3_region] and !params[:s3_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params[:server_certificate] and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_host_key must be an String") if params[:server_host_key] and !params[:server_host_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if params[:server_type] and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl must be an String") if params[:ssl] and !params[:ssl].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if params[:wasabi_access_key] and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_bucket must be an String") if params[:wasabi_bucket] and !params[:wasabi_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_region must be an String") if params[:wasabi_region] and !params[:wasabi_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if params[:workspace_id] and !params[:workspace_id].is_a?(Integer)

      response, options = Api.send_request("/remote_servers", :post, params, options)
      RemoteServer.new(response.data, options)
    end

    # Push update to Files Agent
    def self.agent_push_update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/remote_servers/#{params[:id]}/agent_push_update", :post, params, options)
      AgentPushUpdate.new(response.data, options)
    end

    # Post local changes, check in, and download configuration file (used by some Remote Server integrations, such as the Files.com Agent)
    #
    # Parameters:
    #   api_token - string - Files Agent API Token
    #   permission_set - string - The permission set for the agent ['read_write', 'read_only', 'write_only']
    #   root - string - The root directory for the agent
    #   hostname - string
    #   port - int64 - Incoming port for files agent connections
    #   status - string - either running or shutdown
    #   config_version - string - agent config version
    #   private_key - string - The private key for the agent
    #   public_key - string - public key
    #   server_host_key - string
    #   subdomain - string - Files.com subdomain site name
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
    #   password - string - Password, if needed.
    #   private_key - string - Private key, if needed.
    #   private_key_passphrase - string - Passphrase for private key if needed.
    #   reset_authentication - boolean - Reset authenticated account?
    #   ssl_certificate - string - SSL client certificate.
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
    #   allow_relative_paths - boolean - Allow relative paths in SFTP. If true, paths will not be forced to be absolute, allowing operations relative to the user's home directory.
    #   aws_access_key - string - AWS Access Key.
    #   azure_blob_storage_account - string - Azure Blob Storage: Account name
    #   azure_blob_storage_container - string - Azure Blob Storage: Container name
    #   azure_blob_storage_dns_suffix - string - Azure Blob Storage: Custom DNS suffix
    #   azure_blob_storage_hierarchical_namespace - boolean - Azure Blob Storage: Does the storage account has hierarchical namespace feature enabled?
    #   azure_files_storage_account - string - Azure Files: Storage Account name
    #   azure_files_storage_dns_suffix - string - Azure Files: Custom DNS suffix
    #   azure_files_storage_share_name - string - Azure Files:  Storage Share name
    #   backblaze_b2_bucket - string - Backblaze B2 Cloud Storage: Bucket name
    #   backblaze_b2_s3_endpoint - string - Backblaze B2 Cloud Storage: S3 Endpoint
    #   buffer_uploads - string - If set to always, uploads to this server will be uploaded first to Files.com before being sent to the remote server. This can improve performance in certain access patterns, such as high-latency connections.  It will cause data to be temporarily stored in Files.com. If set to auto, we will perform this optimization if we believe it to be a benefit in a given situation.
    #   cloudflare_access_key - string - Cloudflare: Access Key.
    #   cloudflare_bucket - string - Cloudflare: Bucket name
    #   cloudflare_endpoint - string - Cloudflare: endpoint
    #   description - string - Internal description for your reference
    #   dropbox_teams - boolean - Dropbox: If true, list Team folders in root?
    #   enable_dedicated_ips - boolean - `true` if remote server only accepts connections from dedicated IPs
    #   filebase_access_key - string - Filebase: Access Key.
    #   filebase_bucket - string - Filebase: Bucket name
    #   files_agent_permission_set - string - Local permissions for files agent. read_only, write_only, or read_write
    #   files_agent_root - string - Agent local root path
    #   files_agent_version - string - Files Agent version
    #   outbound_agent_id - int64 - Route traffic to outbound on a files-agent
    #   google_cloud_storage_bucket - string - Google Cloud Storage: Bucket Name
    #   google_cloud_storage_project_id - string - Google Cloud Storage: Project ID
    #   google_cloud_storage_s3_compatible_access_key - string - Google Cloud Storage: S3-compatible Access Key.
    #   hostname - string - Hostname or IP address
    #   linode_access_key - string - Linode: Access Key
    #   linode_bucket - string - Linode: Bucket name
    #   linode_region - string - Linode: region
    #   max_connections - int64 - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
    #   name - string - Internal name for your reference
    #   one_drive_account_type - string - OneDrive: Either personal or business_other account types
    #   pin_to_site_region - boolean - If true, we will ensure that all communications with this remote server are made through the primary region of the site.  This setting can also be overridden by a site-wide setting which will force it to true.
    #   port - int64 - Port for remote server.
    #   upload_staging_path - string - Upload staging path.  Applies to SFTP only.  If a path is provided here, files will first be uploaded to this path on the remote folder and the moved into the final correct path via an SFTP move command.  This is required by some remote MFT systems to emulate atomic uploads, which are otherwise not supoprted by SFTP.
    #   remote_server_credential_id - int64 - ID of Remote Server Credential, if applicable.
    #   s3_bucket - string - S3 bucket name
    #   s3_compatible_access_key - string - S3-compatible: Access Key
    #   s3_compatible_bucket - string - S3-compatible: Bucket name
    #   s3_compatible_endpoint - string - S3-compatible: endpoint
    #   s3_compatible_region - string - S3-compatible: region
    #   s3_region - string - S3 region
    #   server_certificate - string - Remote server certificate
    #   server_host_key - string - Remote server SSH Host Key. If provided, we will require that the server host key matches the provided key. Uses OpenSSH format similar to what would go into ~/.ssh/known_hosts
    #   server_type - string - Remote server type.
    #   ssl - string - Should we require SSL?
    #   username - string - Remote server username.
    #   wasabi_access_key - string - Wasabi: Access Key.
    #   wasabi_bucket - string - Wasabi: Bucket name
    #   wasabi_region - string - Wasabi: Region
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if params[:private_key] and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if params[:private_key_passphrase] and !params[:private_key_passphrase].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate must be an String") if params[:ssl_certificate] and !params[:ssl_certificate].is_a?(String)
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
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if params[:aws_access_key] and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_account must be an String") if params[:azure_blob_storage_account] and !params[:azure_blob_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_container must be an String") if params[:azure_blob_storage_container] and !params[:azure_blob_storage_container].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_dns_suffix must be an String") if params[:azure_blob_storage_dns_suffix] and !params[:azure_blob_storage_dns_suffix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_account must be an String") if params[:azure_files_storage_account] and !params[:azure_files_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_dns_suffix must be an String") if params[:azure_files_storage_dns_suffix] and !params[:azure_files_storage_dns_suffix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_share_name must be an String") if params[:azure_files_storage_share_name] and !params[:azure_files_storage_share_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_bucket must be an String") if params[:backblaze_b2_bucket] and !params[:backblaze_b2_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_s3_endpoint must be an String") if params[:backblaze_b2_s3_endpoint] and !params[:backblaze_b2_s3_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: buffer_uploads must be an String") if params[:buffer_uploads] and !params[:buffer_uploads].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_access_key must be an String") if params[:cloudflare_access_key] and !params[:cloudflare_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_bucket must be an String") if params[:cloudflare_bucket] and !params[:cloudflare_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_endpoint must be an String") if params[:cloudflare_endpoint] and !params[:cloudflare_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_access_key must be an String") if params[:filebase_access_key] and !params[:filebase_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_bucket must be an String") if params[:filebase_bucket] and !params[:filebase_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_permission_set must be an String") if params[:files_agent_permission_set] and !params[:files_agent_permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_root must be an String") if params[:files_agent_root] and !params[:files_agent_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_version must be an String") if params[:files_agent_version] and !params[:files_agent_version].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: outbound_agent_id must be an Integer") if params[:outbound_agent_id] and !params[:outbound_agent_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_bucket must be an String") if params[:google_cloud_storage_bucket] and !params[:google_cloud_storage_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_project_id must be an String") if params[:google_cloud_storage_project_id] and !params[:google_cloud_storage_project_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_access_key must be an String") if params[:google_cloud_storage_s3_compatible_access_key] and !params[:google_cloud_storage_s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params[:hostname] and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_access_key must be an String") if params[:linode_access_key] and !params[:linode_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_bucket must be an String") if params[:linode_bucket] and !params[:linode_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_region must be an String") if params[:linode_region] and !params[:linode_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: max_connections must be an Integer") if params[:max_connections] and !params[:max_connections].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: one_drive_account_type must be an String") if params[:one_drive_account_type] and !params[:one_drive_account_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: port must be an Integer") if params[:port] and !params[:port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: upload_staging_path must be an String") if params[:upload_staging_path] and !params[:upload_staging_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: remote_server_credential_id must be an Integer") if params[:remote_server_credential_id] and !params[:remote_server_credential_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: s3_bucket must be an String") if params[:s3_bucket] and !params[:s3_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if params[:s3_compatible_access_key] and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_bucket must be an String") if params[:s3_compatible_bucket] and !params[:s3_compatible_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint must be an String") if params[:s3_compatible_endpoint] and !params[:s3_compatible_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_region must be an String") if params[:s3_compatible_region] and !params[:s3_compatible_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_region must be an String") if params[:s3_region] and !params[:s3_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if params[:server_certificate] and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_host_key must be an String") if params[:server_host_key] and !params[:server_host_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if params[:server_type] and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl must be an String") if params[:ssl] and !params[:ssl].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if params[:username] and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if params[:wasabi_access_key] and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_bucket must be an String") if params[:wasabi_bucket] and !params[:wasabi_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_region must be an String") if params[:wasabi_region] and !params[:wasabi_region].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/remote_servers/#{params[:id]}", :patch, params, options)
      RemoteServer.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/remote_servers/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
