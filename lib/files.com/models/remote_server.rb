# frozen_string_literal: true

module Files
  # Files::RemoteServer is the Ruby SDK's representation of Files.com API RemoteServer objects.
  # Each instance keeps its API field values in +attributes+.
  class RemoteServer
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

    # Remote Server ID
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

    # If true, this Remote Server is disabled. Updating it clears this flag, except for retired Agent v1 records, which remain disabled.
    # @return [Boolean, nil] the field value, or nil when absent.
    def disabled
      @attributes[:disabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def disabled=(value)
      @attributes[:disabled] = value
    end

    # Type of authentication method to use
    # @return [String, nil] the field value, or nil when absent.
    def authentication_method
      @attributes[:authentication_method]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def authentication_method=(value)
      @attributes[:authentication_method] = value
    end

    # Hostname or IP address. For Agent Remote Servers, the Agent reports the hostname it connects from at each registration, replacing the stored value. This field is not included in the generated Agent configuration file. Setting it on Create or Update does not change the running Agent.
    # @return [String, nil] the field value, or nil when absent.
    def hostname
      @attributes[:hostname]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def hostname=(value)
      @attributes[:hostname] = value
    end

    # Initial home folder on remote server
    # @return [String, nil] the field value, or nil when absent.
    def remote_home_path
      @attributes[:remote_home_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def remote_home_path=(value)
      @attributes[:remote_home_path] = value
    end

    # Upload staging path.  Applies to SFTP only.  If a path is provided here, files will first be uploaded to this path on the remote folder and the moved into the final correct path via an SFTP move command.  This is required by some remote MFT systems to emulate atomic uploads, which are otherwise not supoprted by SFTP.
    # @return [String, nil] the field value, or nil when absent.
    def upload_staging_path
      @attributes[:upload_staging_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def upload_staging_path=(value)
      @attributes[:upload_staging_path] = value
    end

    # Allow relative paths in SFTP. If true, paths will not be forced to be absolute, allowing operations relative to the user's home directory.
    # @return [Boolean, nil] the field value, or nil when absent.
    def allow_relative_paths
      @attributes[:allow_relative_paths]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def allow_relative_paths=(value)
      @attributes[:allow_relative_paths] = value
    end

    # Internal name for your reference
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

    # Internal description for your reference
    # @return [String, nil] the field value, or nil when absent.
    def description
      @attributes[:description]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def description=(value)
      @attributes[:description] = value
    end

    # Port for remote server. For Agent Remote Servers, the Agent reports its downstream proxy port at each registration, replacing the stored value. This field is not included in the generated Agent configuration file. Setting it on Create or Update does not change the running Agent.
    # @return [Integer, nil] the field value, or nil when absent.
    def port
      @attributes[:port]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def port=(value)
      @attributes[:port] = value
    end

    # If set to always, uploads to this server will be uploaded first to Files.com before being sent to the remote server. This can improve performance in certain access patterns, such as high-latency connections.  It will cause data to be temporarily stored in Files.com. If set to auto, we will perform this optimization if we believe it to be a benefit in a given situation.
    # @return [String, nil] the field value, or nil when absent.
    def buffer_uploads
      @attributes[:buffer_uploads]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def buffer_uploads=(value)
      @attributes[:buffer_uploads] = value
    end

    # Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
    # @return [Integer, nil] the field value, or nil when absent.
    def max_connections
      @attributes[:max_connections]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def max_connections=(value)
      @attributes[:max_connections] = value
    end

    # If true, we will ensure that all communications with this remote server are made through the primary region of the site.  This setting can also be overridden by a site-wide setting which will force it to true.
    # @return [Boolean, nil] the field value, or nil when absent.
    def pin_to_site_region
      @attributes[:pin_to_site_region]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def pin_to_site_region=(value)
      @attributes[:pin_to_site_region] = value
    end

    # If set, all communications with this remote server are made through the provided region.
    # @return [String, nil] the field value, or nil when absent.
    def pinned_region
      @attributes[:pinned_region]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def pinned_region=(value)
      @attributes[:pinned_region] = value
    end

    # ID of Remote Server Credential, if applicable.
    # @return [Integer, nil] the field value, or nil when absent.
    def remote_server_credential_id
      @attributes[:remote_server_credential_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def remote_server_credential_id=(value)
      @attributes[:remote_server_credential_id] = value
    end

    # S3 bucket name
    # @return [String, nil] the field value, or nil when absent.
    def s3_bucket
      @attributes[:s3_bucket]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def s3_bucket=(value)
      @attributes[:s3_bucket] = value
    end

    # S3 region
    # @return [String, nil] the field value, or nil when absent.
    def s3_region
      @attributes[:s3_region]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def s3_region=(value)
      @attributes[:s3_region] = value
    end

    # ARN of the AWS KMS key that encrypts files written to the bucket (SSE-KMS). Leave blank unless your bucket requires a specific key.
    # @return [String, nil] the field value, or nil when absent.
    def s3_kms_key_id
      @attributes[:s3_kms_key_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def s3_kms_key_id=(value)
      @attributes[:s3_kms_key_id] = value
    end

    # AWS Access Key.
    # @return [String, nil] the field value, or nil when absent.
    def aws_access_key
      @attributes[:aws_access_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def aws_access_key=(value)
      @attributes[:aws_access_key] = value
    end

    # AWS IAM Role ARN for AssumeRole authentication.
    # @return [String, nil] the field value, or nil when absent.
    def s3_assume_role_arn
      @attributes[:s3_assume_role_arn]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def s3_assume_role_arn=(value)
      @attributes[:s3_assume_role_arn] = value
    end

    # Session duration in seconds for AssumeRole authentication (900-43200).
    # @return [Integer, nil] the field value, or nil when absent.
    def s3_assume_role_duration_seconds
      @attributes[:s3_assume_role_duration_seconds]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def s3_assume_role_duration_seconds=(value)
      @attributes[:s3_assume_role_duration_seconds] = value
    end

    # External ID for AssumeRole authentication.
    # @return [String, nil] the field value, or nil when absent.
    def s3_assume_role_external_id
      @attributes[:s3_assume_role_external_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def s3_assume_role_external_id=(value)
      @attributes[:s3_assume_role_external_id] = value
    end

    # Remote server certificate
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

    # Pinned SSH host key or OpenSSH host certificate for SFTP. If omitted, Files.com detects and stores a host key, preferring plain keys over certificates. With `server_certificate=require_match` (the default), the server must present the exact pinned key or certificate and prove it holds the matching private key. A pinned certificate is compared in full, so renewal can require updating `server_host_key` even when its underlying key is unchanged. Files.com does not check certificate CA signatures, principals, or validity periods. Certificate expiration alone does not end the pin. Update `server_host_key` to replace the pin.
    # @return [String, nil] the field value, or nil when absent.
    def server_host_key
      @attributes[:server_host_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def server_host_key=(value)
      @attributes[:server_host_key] = value
    end

    # Remote server type.
    # @return [String, nil] the field value, or nil when absent.
    def server_type
      @attributes[:server_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def server_type=(value)
      @attributes[:server_type] = value
    end

    # Workspace ID (0 for default workspace)
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

    # Should we require SSL?
    # @return [String, nil] the field value, or nil when absent.
    def ssl
      @attributes[:ssl]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def ssl=(value)
      @attributes[:ssl] = value
    end

    # Remote server username.
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def username=(value)
      @attributes[:username] = value
    end

    # Google Cloud Storage: Bucket Name
    # @return [String, nil] the field value, or nil when absent.
    def google_cloud_storage_bucket
      @attributes[:google_cloud_storage_bucket]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def google_cloud_storage_bucket=(value)
      @attributes[:google_cloud_storage_bucket] = value
    end

    # Google Cloud Storage: Authentication method. Can be json, hmac, or oauth.
    # @return [String, nil] the field value, or nil when absent.
    def google_cloud_storage_authentication_method
      @attributes[:google_cloud_storage_authentication_method]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def google_cloud_storage_authentication_method=(value)
      @attributes[:google_cloud_storage_authentication_method] = value
    end

    # Google Cloud Storage: OAuth scope. Can be https://www.googleapis.com/auth/devstorage.read_only or https://www.googleapis.com/auth/devstorage.read_write.
    # @return [String, nil] the field value, or nil when absent.
    def google_cloud_storage_oauth_scope
      @attributes[:google_cloud_storage_oauth_scope]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def google_cloud_storage_oauth_scope=(value)
      @attributes[:google_cloud_storage_oauth_scope] = value
    end

    # Google Cloud Storage: Project ID
    # @return [String, nil] the field value, or nil when absent.
    def google_cloud_storage_project_id
      @attributes[:google_cloud_storage_project_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def google_cloud_storage_project_id=(value)
      @attributes[:google_cloud_storage_project_id] = value
    end

    # Google Cloud Storage: S3-compatible Access Key.
    # @return [String, nil] the field value, or nil when absent.
    def google_cloud_storage_s3_compatible_access_key
      @attributes[:google_cloud_storage_s3_compatible_access_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def google_cloud_storage_s3_compatible_access_key=(value)
      @attributes[:google_cloud_storage_s3_compatible_access_key] = value
    end

    # Backblaze B2 Cloud Storage: S3 Endpoint
    # @return [String, nil] the field value, or nil when absent.
    def backblaze_b2_s3_endpoint
      @attributes[:backblaze_b2_s3_endpoint]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def backblaze_b2_s3_endpoint=(value)
      @attributes[:backblaze_b2_s3_endpoint] = value
    end

    # Backblaze B2 Cloud Storage: Bucket name
    # @return [String, nil] the field value, or nil when absent.
    def backblaze_b2_bucket
      @attributes[:backblaze_b2_bucket]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def backblaze_b2_bucket=(value)
      @attributes[:backblaze_b2_bucket] = value
    end

    # Wasabi: Bucket name
    # @return [String, nil] the field value, or nil when absent.
    def wasabi_bucket
      @attributes[:wasabi_bucket]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def wasabi_bucket=(value)
      @attributes[:wasabi_bucket] = value
    end

    # Wasabi: Region
    # @return [String, nil] the field value, or nil when absent.
    def wasabi_region
      @attributes[:wasabi_region]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def wasabi_region=(value)
      @attributes[:wasabi_region] = value
    end

    # Wasabi: Access Key.
    # @return [String, nil] the field value, or nil when absent.
    def wasabi_access_key
      @attributes[:wasabi_access_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def wasabi_access_key=(value)
      @attributes[:wasabi_access_key] = value
    end

    # Either `in_setup` or `complete`
    # @return [String, nil] the field value, or nil when absent.
    def auth_status
      @attributes[:auth_status]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def auth_status=(value)
      @attributes[:auth_status] = value
    end

    # Describes the authorized account
    # @return [String, nil] the field value, or nil when absent.
    def auth_account_name
      @attributes[:auth_account_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def auth_account_name=(value)
      @attributes[:auth_account_name] = value
    end

    # OneDrive: Either personal or business_other account types
    # @return [String, nil] the field value, or nil when absent.
    def one_drive_account_type
      @attributes[:one_drive_account_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def one_drive_account_type=(value)
      @attributes[:one_drive_account_type] = value
    end

    # SharePoint: Microsoft Entra tenant ID for app-only authentication.
    # @return [String, nil] the field value, or nil when absent.
    def sharepoint_tenant_id
      @attributes[:sharepoint_tenant_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def sharepoint_tenant_id=(value)
      @attributes[:sharepoint_tenant_id] = value
    end

    # SharePoint: Microsoft Entra application client ID for app-only authentication.
    # @return [String, nil] the field value, or nil when absent.
    def sharepoint_client_id
      @attributes[:sharepoint_client_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def sharepoint_client_id=(value)
      @attributes[:sharepoint_client_id] = value
    end

    # SharePoint: If true, this remote server uses Microsoft Entra app-only authentication.
    # @return [Boolean, nil] the field value, or nil when absent.
    def sharepoint_app_authentication
      @attributes[:sharepoint_app_authentication]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def sharepoint_app_authentication=(value)
      @attributes[:sharepoint_app_authentication] = value
    end

    # SharePoint: App-only credential type. Either secret or certificate.
    # @return [String, nil] the field value, or nil when absent.
    def sharepoint_app_credential_type
      @attributes[:sharepoint_app_credential_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def sharepoint_app_credential_type=(value)
      @attributes[:sharepoint_app_credential_type] = value
    end

    # SharePoint: Site URL to scope app-only authentication to a single site. Leave blank to browse all sites.
    # @return [String, nil] the field value, or nil when absent.
    def sharepoint_site_url
      @attributes[:sharepoint_site_url]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def sharepoint_site_url=(value)
      @attributes[:sharepoint_site_url] = value
    end

    # Azure Blob Storage: Account name
    # @return [String, nil] the field value, or nil when absent.
    def azure_blob_storage_account
      @attributes[:azure_blob_storage_account]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_blob_storage_account=(value)
      @attributes[:azure_blob_storage_account] = value
    end

    # Azure Blob Storage: Container name
    # @return [String, nil] the field value, or nil when absent.
    def azure_blob_storage_container
      @attributes[:azure_blob_storage_container]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_blob_storage_container=(value)
      @attributes[:azure_blob_storage_container] = value
    end

    # Azure Blob Storage: Does the storage account has hierarchical namespace feature enabled?
    # @return [Boolean, nil] the field value, or nil when absent.
    def azure_blob_storage_hierarchical_namespace
      @attributes[:azure_blob_storage_hierarchical_namespace]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def azure_blob_storage_hierarchical_namespace=(value)
      @attributes[:azure_blob_storage_hierarchical_namespace] = value
    end

    # Azure Blob Storage: Custom DNS suffix
    # @return [String, nil] the field value, or nil when absent.
    def azure_blob_storage_dns_suffix
      @attributes[:azure_blob_storage_dns_suffix]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_blob_storage_dns_suffix=(value)
      @attributes[:azure_blob_storage_dns_suffix] = value
    end

    # Azure Files: Storage Account name
    # @return [String, nil] the field value, or nil when absent.
    def azure_files_storage_account
      @attributes[:azure_files_storage_account]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_files_storage_account=(value)
      @attributes[:azure_files_storage_account] = value
    end

    # Azure Files:  Storage Share name
    # @return [String, nil] the field value, or nil when absent.
    def azure_files_storage_share_name
      @attributes[:azure_files_storage_share_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_files_storage_share_name=(value)
      @attributes[:azure_files_storage_share_name] = value
    end

    # Azure Files: Custom DNS suffix
    # @return [String, nil] the field value, or nil when absent.
    def azure_files_storage_dns_suffix
      @attributes[:azure_files_storage_dns_suffix]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_files_storage_dns_suffix=(value)
      @attributes[:azure_files_storage_dns_suffix] = value
    end

    # S3-compatible: Bucket name
    # @return [String, nil] the field value, or nil when absent.
    def s3_compatible_bucket
      @attributes[:s3_compatible_bucket]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def s3_compatible_bucket=(value)
      @attributes[:s3_compatible_bucket] = value
    end

    # S3-compatible: endpoint
    # @return [String, nil] the field value, or nil when absent.
    def s3_compatible_endpoint
      @attributes[:s3_compatible_endpoint]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def s3_compatible_endpoint=(value)
      @attributes[:s3_compatible_endpoint] = value
    end

    # S3-compatible: region
    # @return [String, nil] the field value, or nil when absent.
    def s3_compatible_region
      @attributes[:s3_compatible_region]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def s3_compatible_region=(value)
      @attributes[:s3_compatible_region] = value
    end

    # S3-compatible: If true, use virtual-hosted-style URLs instead of path-style URLs
    # @return [Boolean, nil] the field value, or nil when absent.
    def s3_compatible_virtual_hosted_style
      @attributes[:s3_compatible_virtual_hosted_style]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def s3_compatible_virtual_hosted_style=(value)
      @attributes[:s3_compatible_virtual_hosted_style] = value
    end

    # S3-compatible: Access Key
    # @return [String, nil] the field value, or nil when absent.
    def s3_compatible_access_key
      @attributes[:s3_compatible_access_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def s3_compatible_access_key=(value)
      @attributes[:s3_compatible_access_key] = value
    end

    # `true` if remote server only accepts connections from dedicated IPs
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

    # Custom Domain ID whose dedicated IP addresses are selected when this Remote Server uses dedicated IPs. Must be available to this Remote Server's workspace. Requires enable_dedicated_ips and cannot be combined with an outbound Agent. Set to null to use the site's default dedicated IPs.
    # @return [Integer, nil] the field value, or nil when absent.
    def custom_domain_id
      @attributes[:custom_domain_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def custom_domain_id=(value)
      @attributes[:custom_domain_id] = value
    end

    # Current eligible public IP addresses for the selected Custom Domain. Any address in this list may originate a connection. Empty when no domain is selected or its configuration is unavailable. Only included in responses for a single Remote Server.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def outbound_ip_addresses
      @attributes[:outbound_ip_addresses]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def outbound_ip_addresses=(value)
      @attributes[:outbound_ip_addresses] = value
    end

    # Agent file permissions: `read_only`, `write_only`, or `read_write`. Files.com writes this value as `permission_set` in the configuration file generated for this Remote Server. Setting it on Create or Update changes the generated file, not a running Agent. The Agent enforces the permissions in its local configuration file, controlled by the host's system administrator, and reports them at registration, replacing the stored value.
    # @return [String, nil] the field value, or nil when absent.
    def files_agent_permission_set
      @attributes[:files_agent_permission_set]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def files_agent_permission_set=(value)
      @attributes[:files_agent_permission_set] = value
    end

    # Agent local root path. Files.com writes this value as `root` in the configuration file generated for this Remote Server. Setting it on Create or Update changes the generated file, not a running Agent. The Agent enforces the root in its local configuration file, controlled by the host's system administrator, and reports it at registration, replacing the stored value.
    # @return [String, nil] the field value, or nil when absent.
    def files_agent_root
      @attributes[:files_agent_root]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def files_agent_root=(value)
      @attributes[:files_agent_root] = value
    end

    # Files.com Agent version reported by the Agent at each registration, replacing the stored value. This field is not included in the generated Agent configuration file. Setting it on Create or Update does not update the running Agent.
    # @return [String, nil] the field value, or nil when absent.
    def files_agent_version
      @attributes[:files_agent_version]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def files_agent_version=(value)
      @attributes[:files_agent_version] = value
    end

    # If true, the Files Agent is up to date.
    # @return [Boolean, nil] the field value, or nil when absent.
    def files_agent_up_to_date
      @attributes[:files_agent_up_to_date]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def files_agent_up_to_date=(value)
      @attributes[:files_agent_up_to_date] = value
    end

    # Latest available Files Agent version
    # @return [String, nil] the field value, or nil when absent.
    def files_agent_latest_version
      @attributes[:files_agent_latest_version]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def files_agent_latest_version=(value)
      @attributes[:files_agent_latest_version] = value
    end

    # Files Agent supports receiving push updates
    # @return [Boolean, nil] the field value, or nil when absent.
    def files_agent_supports_push_updates
      @attributes[:files_agent_supports_push_updates]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def files_agent_supports_push_updates=(value)
      @attributes[:files_agent_supports_push_updates] = value
    end

    # Whether the Files Agent Proxy recently validated a direct transfer connection. `true` means a direct connection was recently validated (actual availability can vary by client network), `false` means direct transfers are enabled but not currently available, and `null` means direct transfers are disabled or unsupported. Only provided for a connected Files Agent when showing a single Remote Server.
    # @return [Boolean, nil] the field value, or nil when absent.
    def direct_transfer_available
      @attributes[:direct_transfer_available]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def direct_transfer_available=(value)
      @attributes[:direct_transfer_available] = value
    end

    # Route traffic to outbound on a files-agent
    # @return [Integer, nil] the field value, or nil when absent.
    def outbound_agent_id
      @attributes[:outbound_agent_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def outbound_agent_id=(value)
      @attributes[:outbound_agent_id] = value
    end

    # Filebase: Bucket name
    # @return [String, nil] the field value, or nil when absent.
    def filebase_bucket
      @attributes[:filebase_bucket]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def filebase_bucket=(value)
      @attributes[:filebase_bucket] = value
    end

    # Filebase: Access Key.
    # @return [String, nil] the field value, or nil when absent.
    def filebase_access_key
      @attributes[:filebase_access_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def filebase_access_key=(value)
      @attributes[:filebase_access_key] = value
    end

    # Files.com direct link: paired API key prefix.
    # @return [String, nil] the field value, or nil when absent.
    def files_api_key_prefix
      @attributes[:files_api_key_prefix]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def files_api_key_prefix=(value)
      @attributes[:files_api_key_prefix] = value
    end

    # Cloudflare: Bucket name
    # @return [String, nil] the field value, or nil when absent.
    def cloudflare_bucket
      @attributes[:cloudflare_bucket]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def cloudflare_bucket=(value)
      @attributes[:cloudflare_bucket] = value
    end

    # Cloudflare: Access Key.
    # @return [String, nil] the field value, or nil when absent.
    def cloudflare_access_key
      @attributes[:cloudflare_access_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def cloudflare_access_key=(value)
      @attributes[:cloudflare_access_key] = value
    end

    # Cloudflare: endpoint
    # @return [String, nil] the field value, or nil when absent.
    def cloudflare_endpoint
      @attributes[:cloudflare_endpoint]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def cloudflare_endpoint=(value)
      @attributes[:cloudflare_endpoint] = value
    end

    # Dropbox: If true, list Team folders in root?
    # @return [Boolean, nil] the field value, or nil when absent.
    def dropbox_teams
      @attributes[:dropbox_teams]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def dropbox_teams=(value)
      @attributes[:dropbox_teams] = value
    end

    # Linode: Bucket name
    # @return [String, nil] the field value, or nil when absent.
    def linode_bucket
      @attributes[:linode_bucket]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def linode_bucket=(value)
      @attributes[:linode_bucket] = value
    end

    # Linode: Access Key
    # @return [String, nil] the field value, or nil when absent.
    def linode_access_key
      @attributes[:linode_access_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def linode_access_key=(value)
      @attributes[:linode_access_key] = value
    end

    # Linode: region
    # @return [String, nil] the field value, or nil when absent.
    def linode_region
      @attributes[:linode_region]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def linode_region=(value)
      @attributes[:linode_region] = value
    end

    # If true, this remote server supports file versioning. This value is determined automatically by Files.com.
    # @return [Boolean, nil] the field value, or nil when absent.
    def supports_versioning
      @attributes[:supports_versioning]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def supports_versioning=(value)
      @attributes[:supports_versioning] = value
    end

    # User ID.  Provide a value of `0` to operate the current session's user.
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def user_id=(value)
      @attributes[:user_id] = value
    end

    # Password, if needed.
    # @return [String, nil] the field value, or nil when absent.
    def password
      @attributes[:password]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def password=(value)
      @attributes[:password] = value
    end

    # Private key, if needed.
    # @return [String, nil] the field value, or nil when absent.
    def private_key
      @attributes[:private_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def private_key=(value)
      @attributes[:private_key] = value
    end

    # Passphrase for private key if needed.
    # @return [String, nil] the field value, or nil when absent.
    def private_key_passphrase
      @attributes[:private_key_passphrase]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def private_key_passphrase=(value)
      @attributes[:private_key_passphrase] = value
    end

    # Reset authenticated account?
    # @return [Boolean, nil] the field value, or nil when absent.
    def reset_authentication
      @attributes[:reset_authentication]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def reset_authentication=(value)
      @attributes[:reset_authentication] = value
    end

    # SharePoint: PEM-encoded certificate and unencrypted private key for app-only authentication.
    # @return [String, nil] the field value, or nil when absent.
    def sharepoint_client_certificate
      @attributes[:sharepoint_client_certificate]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def sharepoint_client_certificate=(value)
      @attributes[:sharepoint_client_certificate] = value
    end

    # SharePoint: Microsoft Entra application client secret for app-only authentication.
    # @return [String, nil] the field value, or nil when absent.
    def sharepoint_client_secret
      @attributes[:sharepoint_client_secret]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def sharepoint_client_secret=(value)
      @attributes[:sharepoint_client_secret] = value
    end

    # SSL client certificate.
    # @return [String, nil] the field value, or nil when absent.
    def ssl_certificate
      @attributes[:ssl_certificate]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def ssl_certificate=(value)
      @attributes[:ssl_certificate] = value
    end

    # AWS: secret key.
    # @return [String, nil] the field value, or nil when absent.
    def aws_secret_key
      @attributes[:aws_secret_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def aws_secret_key=(value)
      @attributes[:aws_secret_key] = value
    end

    # Azure Blob Storage: Access Key
    # @return [String, nil] the field value, or nil when absent.
    def azure_blob_storage_access_key
      @attributes[:azure_blob_storage_access_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_blob_storage_access_key=(value)
      @attributes[:azure_blob_storage_access_key] = value
    end

    # Azure Blob Storage: Shared Access Signature (SAS) token
    # @return [String, nil] the field value, or nil when absent.
    def azure_blob_storage_sas_token
      @attributes[:azure_blob_storage_sas_token]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_blob_storage_sas_token=(value)
      @attributes[:azure_blob_storage_sas_token] = value
    end

    # Azure File Storage: Access Key
    # @return [String, nil] the field value, or nil when absent.
    def azure_files_storage_access_key
      @attributes[:azure_files_storage_access_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_files_storage_access_key=(value)
      @attributes[:azure_files_storage_access_key] = value
    end

    # Azure File Storage: Shared Access Signature (SAS) token
    # @return [String, nil] the field value, or nil when absent.
    def azure_files_storage_sas_token
      @attributes[:azure_files_storage_sas_token]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_files_storage_sas_token=(value)
      @attributes[:azure_files_storage_sas_token] = value
    end

    # Backblaze B2 Cloud Storage: applicationKey
    # @return [String, nil] the field value, or nil when absent.
    def backblaze_b2_application_key
      @attributes[:backblaze_b2_application_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def backblaze_b2_application_key=(value)
      @attributes[:backblaze_b2_application_key] = value
    end

    # Backblaze B2 Cloud Storage: keyID
    # @return [String, nil] the field value, or nil when absent.
    def backblaze_b2_key_id
      @attributes[:backblaze_b2_key_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def backblaze_b2_key_id=(value)
      @attributes[:backblaze_b2_key_id] = value
    end

    # Cloudflare: Secret Key
    # @return [String, nil] the field value, or nil when absent.
    def cloudflare_secret_key
      @attributes[:cloudflare_secret_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def cloudflare_secret_key=(value)
      @attributes[:cloudflare_secret_key] = value
    end

    # Filebase: Secret Key
    # @return [String, nil] the field value, or nil when absent.
    def filebase_secret_key
      @attributes[:filebase_secret_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def filebase_secret_key=(value)
      @attributes[:filebase_secret_key] = value
    end

    # Google Cloud Storage: JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
    # @return [String, nil] the field value, or nil when absent.
    def google_cloud_storage_credentials_json
      @attributes[:google_cloud_storage_credentials_json]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def google_cloud_storage_credentials_json=(value)
      @attributes[:google_cloud_storage_credentials_json] = value
    end

    # Google Cloud Storage: S3-compatible secret key
    # @return [String, nil] the field value, or nil when absent.
    def google_cloud_storage_s3_compatible_secret_key
      @attributes[:google_cloud_storage_s3_compatible_secret_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def google_cloud_storage_s3_compatible_secret_key=(value)
      @attributes[:google_cloud_storage_s3_compatible_secret_key] = value
    end

    # Linode: Secret Key
    # @return [String, nil] the field value, or nil when absent.
    def linode_secret_key
      @attributes[:linode_secret_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def linode_secret_key=(value)
      @attributes[:linode_secret_key] = value
    end

    # S3-compatible: Secret Key
    # @return [String, nil] the field value, or nil when absent.
    def s3_compatible_secret_key
      @attributes[:s3_compatible_secret_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def s3_compatible_secret_key=(value)
      @attributes[:s3_compatible_secret_key] = value
    end

    # Wasabi: Secret Key
    # @return [String, nil] the field value, or nil when absent.
    def wasabi_secret_key
      @attributes[:wasabi_secret_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def wasabi_secret_key=(value)
      @attributes[:wasabi_secret_key] = value
    end

    # Files.com direct link: API key used once to pair the remote server.
    # @return [String, nil] the field value, or nil when absent.
    def files_api_key
      @attributes[:files_api_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def files_api_key=(value)
      @attributes[:files_api_key] = value
    end

    # List Files.com Agent nodes
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def agent_nodes(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_servers/#{@attributes[:id]}/agent_nodes", :get, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Push update to Files Agent
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def agent_push_update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_servers/#{@attributes[:id]}/agent_push_update", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Update Remote Server
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] password Password, if needed.
    # @option params [String] private_key Private key, if needed.
    # @option params [String] private_key_passphrase Passphrase for private key if needed.
    # @option params [Boolean] reset_authentication Reset authenticated account?
    # @option params [String] sharepoint_client_certificate SharePoint: PEM-encoded certificate and unencrypted private key for app-only authentication.
    # @option params [String] sharepoint_client_secret SharePoint: Microsoft Entra application client secret for app-only authentication.
    # @option params [String] ssl_certificate SSL client certificate.
    # @option params [String] aws_secret_key AWS: secret key.
    # @option params [String] azure_blob_storage_access_key Azure Blob Storage: Access Key
    # @option params [String] azure_blob_storage_sas_token Azure Blob Storage: Shared Access Signature (SAS) token
    # @option params [String] azure_files_storage_access_key Azure File Storage: Access Key
    # @option params [String] azure_files_storage_sas_token Azure File Storage: Shared Access Signature (SAS) token
    # @option params [String] backblaze_b2_application_key Backblaze B2 Cloud Storage: applicationKey
    # @option params [String] backblaze_b2_key_id Backblaze B2 Cloud Storage: keyID
    # @option params [String] cloudflare_secret_key Cloudflare: Secret Key
    # @option params [String] filebase_secret_key Filebase: Secret Key
    # @option params [String] google_cloud_storage_credentials_json Google Cloud Storage: JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
    # @option params [String] google_cloud_storage_s3_compatible_secret_key Google Cloud Storage: S3-compatible secret key
    # @option params [String] linode_secret_key Linode: Secret Key
    # @option params [String] s3_compatible_secret_key S3-compatible: Secret Key
    # @option params [String] wasabi_secret_key Wasabi: Secret Key
    # @option params [Boolean] allow_relative_paths Allow relative paths in SFTP. If true, paths will not be forced to be absolute, allowing operations relative to the user's home directory.
    # @option params [String] aws_access_key AWS Access Key.
    # @option params [String] azure_blob_storage_account Azure Blob Storage: Account name
    # @option params [String] azure_blob_storage_container Azure Blob Storage: Container name
    # @option params [String] azure_blob_storage_dns_suffix Azure Blob Storage: Custom DNS suffix
    # @option params [Boolean] azure_blob_storage_hierarchical_namespace Azure Blob Storage: Does the storage account has hierarchical namespace feature enabled?
    # @option params [String] azure_files_storage_account Azure Files: Storage Account name
    # @option params [String] azure_files_storage_dns_suffix Azure Files: Custom DNS suffix
    # @option params [String] azure_files_storage_share_name Azure Files:  Storage Share name
    # @option params [String] backblaze_b2_bucket Backblaze B2 Cloud Storage: Bucket name
    # @option params [String] backblaze_b2_s3_endpoint Backblaze B2 Cloud Storage: S3 Endpoint
    # @option params [String] buffer_uploads If set to always, uploads to this server will be uploaded first to Files.com before being sent to the remote server. This can improve performance in certain access patterns, such as high-latency connections.  It will cause data to be temporarily stored in Files.com. If set to auto, we will perform this optimization if we believe it to be a benefit in a given situation.
    # @option params [String] cloudflare_access_key Cloudflare: Access Key.
    # @option params [String] cloudflare_bucket Cloudflare: Bucket name
    # @option params [String] cloudflare_endpoint Cloudflare: endpoint
    # @option params [String] description Internal description for your reference
    # @option params [Boolean] dropbox_teams Dropbox: If true, list Team folders in root?
    # @option params [Boolean] enable_dedicated_ips `true` if remote server only accepts connections from dedicated IPs
    # @option params [String] filebase_access_key Filebase: Access Key.
    # @option params [String] filebase_bucket Filebase: Bucket name
    # @option params [String] files_api_key Files.com direct link: API key used once to pair the remote server.
    # @option params [String] files_agent_permission_set Agent file permissions: `read_only`, `write_only`, or `read_write`. Files.com writes this value as `permission_set` in the configuration file generated for this Remote Server. Setting it on Create or Update changes the generated file, not a running Agent. The Agent enforces the permissions in its local configuration file, controlled by the host's system administrator, and reports them at registration, replacing the stored value.
    # @option params [String] files_agent_root Agent local root path. Files.com writes this value as `root` in the configuration file generated for this Remote Server. Setting it on Create or Update changes the generated file, not a running Agent. The Agent enforces the root in its local configuration file, controlled by the host's system administrator, and reports it at registration, replacing the stored value.
    # @option params [String] files_agent_version Files.com Agent version reported by the Agent at each registration, replacing the stored value. This field is not included in the generated Agent configuration file. Setting it on Create or Update does not update the running Agent.
    # @option params [Integer] outbound_agent_id Route traffic to outbound on a files-agent
    # @option params [Integer] custom_domain_id Custom Domain ID whose dedicated IP addresses are selected when this Remote Server uses dedicated IPs. Must be available to this Remote Server's workspace. Requires enable_dedicated_ips and cannot be combined with an outbound Agent. Set to null to use the site's default dedicated IPs.
    # @option params [String] google_cloud_storage_authentication_method Google Cloud Storage: Authentication method. Can be json, hmac, or oauth.
    # @option params [String] google_cloud_storage_bucket Google Cloud Storage: Bucket Name
    # @option params [String] google_cloud_storage_oauth_scope Google Cloud Storage: OAuth scope. Can be https://www.googleapis.com/auth/devstorage.read_only or https://www.googleapis.com/auth/devstorage.read_write.
    # @option params [String] google_cloud_storage_project_id Google Cloud Storage: Project ID
    # @option params [String] google_cloud_storage_s3_compatible_access_key Google Cloud Storage: S3-compatible Access Key.
    # @option params [String] hostname Hostname or IP address. For Agent Remote Servers, the Agent reports the hostname it connects from at each registration, replacing the stored value. This field is not included in the generated Agent configuration file. Setting it on Create or Update does not change the running Agent.
    # @option params [String] linode_access_key Linode: Access Key
    # @option params [String] linode_bucket Linode: Bucket name
    # @option params [String] linode_region Linode: region
    # @option params [Integer] max_connections Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
    # @option params [String] name Internal name for your reference
    # @option params [String] one_drive_account_type OneDrive: Either personal or business_other account types
    # @option params [Boolean] pin_to_site_region If true, we will ensure that all communications with this remote server are made through the primary region of the site.  This setting can also be overridden by a site-wide setting which will force it to true.
    # @option params [Integer] port Port for remote server. For Agent Remote Servers, the Agent reports its downstream proxy port at each registration, replacing the stored value. This field is not included in the generated Agent configuration file. Setting it on Create or Update does not change the running Agent.
    # @option params [String] upload_staging_path Upload staging path.  Applies to SFTP only.  If a path is provided here, files will first be uploaded to this path on the remote folder and the moved into the final correct path via an SFTP move command.  This is required by some remote MFT systems to emulate atomic uploads, which are otherwise not supoprted by SFTP.
    # @option params [Integer] remote_server_credential_id ID of Remote Server Credential, if applicable.
    # @option params [String] s3_assume_role_arn AWS IAM Role ARN for AssumeRole authentication.
    # @option params [Integer] s3_assume_role_duration_seconds Session duration in seconds for AssumeRole authentication (900-43200).
    # @option params [String] s3_bucket S3 bucket name
    # @option params [String] s3_compatible_access_key S3-compatible: Access Key
    # @option params [String] s3_compatible_bucket S3-compatible: Bucket name
    # @option params [String] s3_compatible_endpoint S3-compatible: endpoint
    # @option params [String] s3_compatible_region S3-compatible: region
    # @option params [Boolean] s3_compatible_virtual_hosted_style S3-compatible: If true, use virtual-hosted-style URLs instead of path-style URLs
    # @option params [String] s3_kms_key_id ARN of the AWS KMS key that encrypts files written to the bucket (SSE-KMS). Leave blank unless your bucket requires a specific key.
    # @option params [String] s3_region S3 region
    # @option params [String] server_certificate Remote server certificate
    # @option params [String] server_host_key Pinned SSH host key or OpenSSH host certificate for SFTP. If omitted, Files.com detects and stores a host key, preferring plain keys over certificates. With `server_certificate=require_match` (the default), the server must present the exact pinned key or certificate and prove it holds the matching private key. A pinned certificate is compared in full, so renewal can require updating `server_host_key` even when its underlying key is unchanged. Files.com does not check certificate CA signatures, principals, or validity periods. Certificate expiration alone does not end the pin. Update `server_host_key` to replace the pin.
    # @option params [String] server_type Remote server type.
    # @option params [String] sharepoint_client_id SharePoint: Microsoft Entra application client ID for app-only authentication.
    # @option params [String] sharepoint_site_url SharePoint: Site URL to scope app-only authentication to a single site. Leave blank to browse all sites.
    # @option params [String] sharepoint_tenant_id SharePoint: Microsoft Entra tenant ID for app-only authentication.
    # @option params [String] ssl Should we require SSL?
    # @option params [String] username Remote server username.
    # @option params [String] wasabi_access_key Wasabi: Access Key.
    # @option params [String] wasabi_bucket Wasabi: Bucket name
    # @option params [String] wasabi_region Wasabi: Region
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if !params[:private_key_passphrase].nil? and !params[:private_key_passphrase].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: reset_authentication must be a single value, not #{params[:reset_authentication].class}") if [ Array, Hash ].any? { |klass| params[:reset_authentication].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_certificate must be an String") if !params[:sharepoint_client_certificate].nil? and !params[:sharepoint_client_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_secret must be an String") if !params[:sharepoint_client_secret].nil? and !params[:sharepoint_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate must be an String") if !params[:ssl_certificate].nil? and !params[:ssl_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_secret_key must be an String") if !params[:aws_secret_key].nil? and !params[:aws_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_access_key must be an String") if !params[:azure_blob_storage_access_key].nil? and !params[:azure_blob_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_sas_token must be an String") if !params[:azure_blob_storage_sas_token].nil? and !params[:azure_blob_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_access_key must be an String") if !params[:azure_files_storage_access_key].nil? and !params[:azure_files_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_sas_token must be an String") if !params[:azure_files_storage_sas_token].nil? and !params[:azure_files_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_application_key must be an String") if !params[:backblaze_b2_application_key].nil? and !params[:backblaze_b2_application_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_key_id must be an String") if !params[:backblaze_b2_key_id].nil? and !params[:backblaze_b2_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_secret_key must be an String") if !params[:cloudflare_secret_key].nil? and !params[:cloudflare_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_secret_key must be an String") if !params[:filebase_secret_key].nil? and !params[:filebase_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_credentials_json must be an String") if !params[:google_cloud_storage_credentials_json].nil? and !params[:google_cloud_storage_credentials_json].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_secret_key must be an String") if !params[:google_cloud_storage_s3_compatible_secret_key].nil? and !params[:google_cloud_storage_s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_secret_key must be an String") if !params[:linode_secret_key].nil? and !params[:linode_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_secret_key must be an String") if !params[:s3_compatible_secret_key].nil? and !params[:s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_secret_key must be an String") if !params[:wasabi_secret_key].nil? and !params[:wasabi_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allow_relative_paths must be a single value, not #{params[:allow_relative_paths].class}") if [ Array, Hash ].any? { |klass| params[:allow_relative_paths].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if !params[:aws_access_key].nil? and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_account must be an String") if !params[:azure_blob_storage_account].nil? and !params[:azure_blob_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_container must be an String") if !params[:azure_blob_storage_container].nil? and !params[:azure_blob_storage_container].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_dns_suffix must be an String") if !params[:azure_blob_storage_dns_suffix].nil? and !params[:azure_blob_storage_dns_suffix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_hierarchical_namespace must be a single value, not #{params[:azure_blob_storage_hierarchical_namespace].class}") if [ Array, Hash ].any? { |klass| params[:azure_blob_storage_hierarchical_namespace].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_account must be an String") if !params[:azure_files_storage_account].nil? and !params[:azure_files_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_dns_suffix must be an String") if !params[:azure_files_storage_dns_suffix].nil? and !params[:azure_files_storage_dns_suffix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_share_name must be an String") if !params[:azure_files_storage_share_name].nil? and !params[:azure_files_storage_share_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_bucket must be an String") if !params[:backblaze_b2_bucket].nil? and !params[:backblaze_b2_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_s3_endpoint must be an String") if !params[:backblaze_b2_s3_endpoint].nil? and !params[:backblaze_b2_s3_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: buffer_uploads must be an String") if !params[:buffer_uploads].nil? and !params[:buffer_uploads].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_access_key must be an String") if !params[:cloudflare_access_key].nil? and !params[:cloudflare_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_bucket must be an String") if !params[:cloudflare_bucket].nil? and !params[:cloudflare_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_endpoint must be an String") if !params[:cloudflare_endpoint].nil? and !params[:cloudflare_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dropbox_teams must be a single value, not #{params[:dropbox_teams].class}") if [ Array, Hash ].any? { |klass| params[:dropbox_teams].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: enable_dedicated_ips must be a single value, not #{params[:enable_dedicated_ips].class}") if [ Array, Hash ].any? { |klass| params[:enable_dedicated_ips].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: filebase_access_key must be an String") if !params[:filebase_access_key].nil? and !params[:filebase_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_bucket must be an String") if !params[:filebase_bucket].nil? and !params[:filebase_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_api_key must be an String") if !params[:files_api_key].nil? and !params[:files_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_permission_set must be an String") if !params[:files_agent_permission_set].nil? and !params[:files_agent_permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_root must be an String") if !params[:files_agent_root].nil? and !params[:files_agent_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_version must be an String") if !params[:files_agent_version].nil? and !params[:files_agent_version].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: outbound_agent_id must be an Integer") if !params[:outbound_agent_id].nil? and !params[:outbound_agent_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: custom_domain_id must be an Integer") if !params[:custom_domain_id].nil? and !params[:custom_domain_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_authentication_method must be an String") if !params[:google_cloud_storage_authentication_method].nil? and !params[:google_cloud_storage_authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_bucket must be an String") if !params[:google_cloud_storage_bucket].nil? and !params[:google_cloud_storage_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_oauth_scope must be an String") if !params[:google_cloud_storage_oauth_scope].nil? and !params[:google_cloud_storage_oauth_scope].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_project_id must be an String") if !params[:google_cloud_storage_project_id].nil? and !params[:google_cloud_storage_project_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_access_key must be an String") if !params[:google_cloud_storage_s3_compatible_access_key].nil? and !params[:google_cloud_storage_s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if !params[:hostname].nil? and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_access_key must be an String") if !params[:linode_access_key].nil? and !params[:linode_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_bucket must be an String") if !params[:linode_bucket].nil? and !params[:linode_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_region must be an String") if !params[:linode_region].nil? and !params[:linode_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: max_connections must be an Integer") if !params[:max_connections].nil? and !params[:max_connections].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: one_drive_account_type must be an String") if !params[:one_drive_account_type].nil? and !params[:one_drive_account_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pin_to_site_region must be a single value, not #{params[:pin_to_site_region].class}") if [ Array, Hash ].any? { |klass| params[:pin_to_site_region].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: port must be an Integer") if !params[:port].nil? and !params[:port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: upload_staging_path must be an String") if !params[:upload_staging_path].nil? and !params[:upload_staging_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: remote_server_credential_id must be an Integer") if !params[:remote_server_credential_id].nil? and !params[:remote_server_credential_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: s3_assume_role_arn must be an String") if !params[:s3_assume_role_arn].nil? and !params[:s3_assume_role_arn].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_assume_role_duration_seconds must be an Integer") if !params[:s3_assume_role_duration_seconds].nil? and !params[:s3_assume_role_duration_seconds].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: s3_bucket must be an String") if !params[:s3_bucket].nil? and !params[:s3_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if !params[:s3_compatible_access_key].nil? and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_bucket must be an String") if !params[:s3_compatible_bucket].nil? and !params[:s3_compatible_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint must be an String") if !params[:s3_compatible_endpoint].nil? and !params[:s3_compatible_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_region must be an String") if !params[:s3_compatible_region].nil? and !params[:s3_compatible_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_virtual_hosted_style must be a single value, not #{params[:s3_compatible_virtual_hosted_style].class}") if [ Array, Hash ].any? { |klass| params[:s3_compatible_virtual_hosted_style].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: s3_kms_key_id must be an String") if !params[:s3_kms_key_id].nil? and !params[:s3_kms_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_region must be an String") if !params[:s3_region].nil? and !params[:s3_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if !params[:server_certificate].nil? and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_host_key must be an String") if !params[:server_host_key].nil? and !params[:server_host_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if !params[:server_type].nil? and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_id must be an String") if !params[:sharepoint_client_id].nil? and !params[:sharepoint_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_site_url must be an String") if !params[:sharepoint_site_url].nil? and !params[:sharepoint_site_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_tenant_id must be an String") if !params[:sharepoint_tenant_id].nil? and !params[:sharepoint_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl must be an String") if !params[:ssl].nil? and !params[:ssl].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if !params[:username].nil? and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if !params[:wasabi_access_key].nil? and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_bucket must be an String") if !params[:wasabi_bucket].nil? and !params[:wasabi_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_region must be an String") if !params[:wasabi_region].nil? and !params[:wasabi_region].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_servers/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("RemoteServer") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Remote Server
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

      response, options = Api.send_request("/remote_servers/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = RemoteServer.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Remote Servers
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `name`, `server_type`, `backblaze_b2_bucket`, `google_cloud_storage_bucket`, `wasabi_bucket`, `s3_bucket`, `azure_blob_storage_container`, `azure_files_storage_share_name`, `s3_compatible_bucket`, `filebase_bucket`, `cloudflare_bucket` or `linode_bucket`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `name`, `server_type`, `workspace_id`, `backblaze_b2_bucket`, `google_cloud_storage_bucket`, `wasabi_bucket`, `s3_bucket`, `azure_blob_storage_container`, `azure_files_storage_share_name`, `s3_compatible_bucket`, `filebase_bucket`, `cloudflare_bucket` or `linode_bucket`. Valid field combinations are `[ server_type, name ]`, `[ workspace_id, name ]`, `[ backblaze_b2_bucket, name ]`, `[ google_cloud_storage_bucket, name ]`, `[ wasabi_bucket, name ]`, `[ s3_bucket, name ]`, `[ azure_blob_storage_container, name ]`, `[ azure_files_storage_share_name, name ]`, `[ s3_compatible_bucket, name ]`, `[ filebase_bucket, name ]`, `[ cloudflare_bucket, name ]`, `[ linode_bucket, name ]`, `[ workspace_id, server_type ]` or `[ workspace_id, server_type, name ]`.
    # @option params [Hash] filter_prefix If set, return records where the specified field is prefixed by the supplied value. Valid fields are `name`, `backblaze_b2_bucket`, `google_cloud_storage_bucket`, `wasabi_bucket`, `s3_bucket`, `azure_blob_storage_container`, `azure_files_storage_share_name`, `s3_compatible_bucket`, `filebase_bucket`, `cloudflare_bucket` or `linode_bucket`. Valid field combinations are `[ backblaze_b2_bucket, name ]`, `[ google_cloud_storage_bucket, name ]`, `[ wasabi_bucket, name ]`, `[ s3_bucket, name ]`, `[ azure_blob_storage_container, name ]`, `[ azure_files_storage_share_name, name ]`, `[ s3_compatible_bucket, name ]`, `[ filebase_bucket, name ]`, `[ cloudflare_bucket, name ]` or `[ linode_bucket, name ]`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if !params[:filter_prefix].nil? and !params[:filter_prefix].is_a?(Hash)

      list_options = options.dup
      List.new(RemoteServer, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/remote_servers", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Remote Server
    #
    # @param id [Integer] Remote Server ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::RemoteServer] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_servers/#{params[:id]}", :get, params, options) { |reply| reply.require_object("RemoteServer") }
      RemoteServer.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # List Files.com Agent nodes
    #
    # @param id [Integer] Remote Server ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AgentNode] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.agent_nodes(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_servers/#{params[:id]}/agent_nodes", :get, params, options) { |reply| reply.require_object("AgentNode") }
      AgentNode.new(response.data, options)
    end

    # Download configuration file (required for some Remote Server integrations, such as the Files.com Agent)
    #
    # @param id [Integer] Remote Server ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::RemoteServerConfigurationFile] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find_configuration_file(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_servers/#{params[:id]}/configuration_file", :get, params, options) { |reply| reply.require_object("RemoteServerConfigurationFile") }
      RemoteServerConfigurationFile.new(response.data, options)
    end

    # Create Remote Server
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] password Password, if needed.
    # @option params [String] private_key Private key, if needed.
    # @option params [String] private_key_passphrase Passphrase for private key if needed.
    # @option params [Boolean] reset_authentication Reset authenticated account?
    # @option params [String] sharepoint_client_certificate SharePoint: PEM-encoded certificate and unencrypted private key for app-only authentication.
    # @option params [String] sharepoint_client_secret SharePoint: Microsoft Entra application client secret for app-only authentication.
    # @option params [String] ssl_certificate SSL client certificate.
    # @option params [String] aws_secret_key AWS: secret key.
    # @option params [String] azure_blob_storage_access_key Azure Blob Storage: Access Key
    # @option params [String] azure_blob_storage_sas_token Azure Blob Storage: Shared Access Signature (SAS) token
    # @option params [String] azure_files_storage_access_key Azure File Storage: Access Key
    # @option params [String] azure_files_storage_sas_token Azure File Storage: Shared Access Signature (SAS) token
    # @option params [String] backblaze_b2_application_key Backblaze B2 Cloud Storage: applicationKey
    # @option params [String] backblaze_b2_key_id Backblaze B2 Cloud Storage: keyID
    # @option params [String] cloudflare_secret_key Cloudflare: Secret Key
    # @option params [String] filebase_secret_key Filebase: Secret Key
    # @option params [String] google_cloud_storage_credentials_json Google Cloud Storage: JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
    # @option params [String] google_cloud_storage_s3_compatible_secret_key Google Cloud Storage: S3-compatible secret key
    # @option params [String] linode_secret_key Linode: Secret Key
    # @option params [String] s3_compatible_secret_key S3-compatible: Secret Key
    # @option params [String] wasabi_secret_key Wasabi: Secret Key
    # @option params [Boolean] allow_relative_paths Allow relative paths in SFTP. If true, paths will not be forced to be absolute, allowing operations relative to the user's home directory.
    # @option params [String] aws_access_key AWS Access Key.
    # @option params [String] azure_blob_storage_account Azure Blob Storage: Account name
    # @option params [String] azure_blob_storage_container Azure Blob Storage: Container name
    # @option params [String] azure_blob_storage_dns_suffix Azure Blob Storage: Custom DNS suffix
    # @option params [Boolean] azure_blob_storage_hierarchical_namespace Azure Blob Storage: Does the storage account has hierarchical namespace feature enabled?
    # @option params [String] azure_files_storage_account Azure Files: Storage Account name
    # @option params [String] azure_files_storage_dns_suffix Azure Files: Custom DNS suffix
    # @option params [String] azure_files_storage_share_name Azure Files:  Storage Share name
    # @option params [String] backblaze_b2_bucket Backblaze B2 Cloud Storage: Bucket name
    # @option params [String] backblaze_b2_s3_endpoint Backblaze B2 Cloud Storage: S3 Endpoint
    # @option params [String] buffer_uploads If set to always, uploads to this server will be uploaded first to Files.com before being sent to the remote server. This can improve performance in certain access patterns, such as high-latency connections.  It will cause data to be temporarily stored in Files.com. If set to auto, we will perform this optimization if we believe it to be a benefit in a given situation.
    # @option params [String] cloudflare_access_key Cloudflare: Access Key.
    # @option params [String] cloudflare_bucket Cloudflare: Bucket name
    # @option params [String] cloudflare_endpoint Cloudflare: endpoint
    # @option params [String] description Internal description for your reference
    # @option params [Boolean] dropbox_teams Dropbox: If true, list Team folders in root?
    # @option params [Boolean] enable_dedicated_ips `true` if remote server only accepts connections from dedicated IPs
    # @option params [String] filebase_access_key Filebase: Access Key.
    # @option params [String] filebase_bucket Filebase: Bucket name
    # @option params [String] files_api_key Files.com direct link: API key used once to pair the remote server.
    # @option params [String] files_agent_permission_set Agent file permissions: `read_only`, `write_only`, or `read_write`. Files.com writes this value as `permission_set` in the configuration file generated for this Remote Server. Setting it on Create or Update changes the generated file, not a running Agent. The Agent enforces the permissions in its local configuration file, controlled by the host's system administrator, and reports them at registration, replacing the stored value.
    # @option params [String] files_agent_root Agent local root path. Files.com writes this value as `root` in the configuration file generated for this Remote Server. Setting it on Create or Update changes the generated file, not a running Agent. The Agent enforces the root in its local configuration file, controlled by the host's system administrator, and reports it at registration, replacing the stored value.
    # @option params [String] files_agent_version Files.com Agent version reported by the Agent at each registration, replacing the stored value. This field is not included in the generated Agent configuration file. Setting it on Create or Update does not update the running Agent.
    # @option params [Integer] outbound_agent_id Route traffic to outbound on a files-agent
    # @option params [Integer] custom_domain_id Custom Domain ID whose dedicated IP addresses are selected when this Remote Server uses dedicated IPs. Must be available to this Remote Server's workspace. Requires enable_dedicated_ips and cannot be combined with an outbound Agent. Set to null to use the site's default dedicated IPs.
    # @option params [String] google_cloud_storage_authentication_method Google Cloud Storage: Authentication method. Can be json, hmac, or oauth.
    # @option params [String] google_cloud_storage_bucket Google Cloud Storage: Bucket Name
    # @option params [String] google_cloud_storage_oauth_scope Google Cloud Storage: OAuth scope. Can be https://www.googleapis.com/auth/devstorage.read_only or https://www.googleapis.com/auth/devstorage.read_write.
    # @option params [String] google_cloud_storage_project_id Google Cloud Storage: Project ID
    # @option params [String] google_cloud_storage_s3_compatible_access_key Google Cloud Storage: S3-compatible Access Key.
    # @option params [String] hostname Hostname or IP address. For Agent Remote Servers, the Agent reports the hostname it connects from at each registration, replacing the stored value. This field is not included in the generated Agent configuration file. Setting it on Create or Update does not change the running Agent.
    # @option params [String] linode_access_key Linode: Access Key
    # @option params [String] linode_bucket Linode: Bucket name
    # @option params [String] linode_region Linode: region
    # @option params [Integer] max_connections Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
    # @option params [String] name Internal name for your reference
    # @option params [String] one_drive_account_type OneDrive: Either personal or business_other account types
    # @option params [Boolean] pin_to_site_region If true, we will ensure that all communications with this remote server are made through the primary region of the site.  This setting can also be overridden by a site-wide setting which will force it to true.
    # @option params [Integer] port Port for remote server. For Agent Remote Servers, the Agent reports its downstream proxy port at each registration, replacing the stored value. This field is not included in the generated Agent configuration file. Setting it on Create or Update does not change the running Agent.
    # @option params [String] upload_staging_path Upload staging path.  Applies to SFTP only.  If a path is provided here, files will first be uploaded to this path on the remote folder and the moved into the final correct path via an SFTP move command.  This is required by some remote MFT systems to emulate atomic uploads, which are otherwise not supoprted by SFTP.
    # @option params [Integer] remote_server_credential_id ID of Remote Server Credential, if applicable.
    # @option params [String] s3_assume_role_arn AWS IAM Role ARN for AssumeRole authentication.
    # @option params [Integer] s3_assume_role_duration_seconds Session duration in seconds for AssumeRole authentication (900-43200).
    # @option params [String] s3_bucket S3 bucket name
    # @option params [String] s3_compatible_access_key S3-compatible: Access Key
    # @option params [String] s3_compatible_bucket S3-compatible: Bucket name
    # @option params [String] s3_compatible_endpoint S3-compatible: endpoint
    # @option params [String] s3_compatible_region S3-compatible: region
    # @option params [Boolean] s3_compatible_virtual_hosted_style S3-compatible: If true, use virtual-hosted-style URLs instead of path-style URLs
    # @option params [String] s3_kms_key_id ARN of the AWS KMS key that encrypts files written to the bucket (SSE-KMS). Leave blank unless your bucket requires a specific key.
    # @option params [String] s3_region S3 region
    # @option params [String] server_certificate Remote server certificate
    # @option params [String] server_host_key Pinned SSH host key or OpenSSH host certificate for SFTP. If omitted, Files.com detects and stores a host key, preferring plain keys over certificates. With `server_certificate=require_match` (the default), the server must present the exact pinned key or certificate and prove it holds the matching private key. A pinned certificate is compared in full, so renewal can require updating `server_host_key` even when its underlying key is unchanged. Files.com does not check certificate CA signatures, principals, or validity periods. Certificate expiration alone does not end the pin. Update `server_host_key` to replace the pin.
    # @option params [String] server_type Remote server type.
    # @option params [String] sharepoint_client_id SharePoint: Microsoft Entra application client ID for app-only authentication.
    # @option params [String] sharepoint_site_url SharePoint: Site URL to scope app-only authentication to a single site. Leave blank to browse all sites.
    # @option params [String] sharepoint_tenant_id SharePoint: Microsoft Entra tenant ID for app-only authentication.
    # @option params [String] ssl Should we require SSL?
    # @option params [String] username Remote server username.
    # @option params [String] wasabi_access_key Wasabi: Access Key.
    # @option params [String] wasabi_bucket Wasabi: Bucket name
    # @option params [String] wasabi_region Wasabi: Region
    # @option params [Integer] workspace_id Workspace ID (0 for default workspace)
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::RemoteServer] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if !params[:private_key_passphrase].nil? and !params[:private_key_passphrase].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: reset_authentication must be a single value, not #{params[:reset_authentication].class}") if [ Array, Hash ].any? { |klass| params[:reset_authentication].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_certificate must be an String") if !params[:sharepoint_client_certificate].nil? and !params[:sharepoint_client_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_secret must be an String") if !params[:sharepoint_client_secret].nil? and !params[:sharepoint_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate must be an String") if !params[:ssl_certificate].nil? and !params[:ssl_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_secret_key must be an String") if !params[:aws_secret_key].nil? and !params[:aws_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_access_key must be an String") if !params[:azure_blob_storage_access_key].nil? and !params[:azure_blob_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_sas_token must be an String") if !params[:azure_blob_storage_sas_token].nil? and !params[:azure_blob_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_access_key must be an String") if !params[:azure_files_storage_access_key].nil? and !params[:azure_files_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_sas_token must be an String") if !params[:azure_files_storage_sas_token].nil? and !params[:azure_files_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_application_key must be an String") if !params[:backblaze_b2_application_key].nil? and !params[:backblaze_b2_application_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_key_id must be an String") if !params[:backblaze_b2_key_id].nil? and !params[:backblaze_b2_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_secret_key must be an String") if !params[:cloudflare_secret_key].nil? and !params[:cloudflare_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_secret_key must be an String") if !params[:filebase_secret_key].nil? and !params[:filebase_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_credentials_json must be an String") if !params[:google_cloud_storage_credentials_json].nil? and !params[:google_cloud_storage_credentials_json].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_secret_key must be an String") if !params[:google_cloud_storage_s3_compatible_secret_key].nil? and !params[:google_cloud_storage_s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_secret_key must be an String") if !params[:linode_secret_key].nil? and !params[:linode_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_secret_key must be an String") if !params[:s3_compatible_secret_key].nil? and !params[:s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_secret_key must be an String") if !params[:wasabi_secret_key].nil? and !params[:wasabi_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allow_relative_paths must be a single value, not #{params[:allow_relative_paths].class}") if [ Array, Hash ].any? { |klass| params[:allow_relative_paths].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if !params[:aws_access_key].nil? and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_account must be an String") if !params[:azure_blob_storage_account].nil? and !params[:azure_blob_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_container must be an String") if !params[:azure_blob_storage_container].nil? and !params[:azure_blob_storage_container].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_dns_suffix must be an String") if !params[:azure_blob_storage_dns_suffix].nil? and !params[:azure_blob_storage_dns_suffix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_hierarchical_namespace must be a single value, not #{params[:azure_blob_storage_hierarchical_namespace].class}") if [ Array, Hash ].any? { |klass| params[:azure_blob_storage_hierarchical_namespace].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_account must be an String") if !params[:azure_files_storage_account].nil? and !params[:azure_files_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_dns_suffix must be an String") if !params[:azure_files_storage_dns_suffix].nil? and !params[:azure_files_storage_dns_suffix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_share_name must be an String") if !params[:azure_files_storage_share_name].nil? and !params[:azure_files_storage_share_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_bucket must be an String") if !params[:backblaze_b2_bucket].nil? and !params[:backblaze_b2_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_s3_endpoint must be an String") if !params[:backblaze_b2_s3_endpoint].nil? and !params[:backblaze_b2_s3_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: buffer_uploads must be an String") if !params[:buffer_uploads].nil? and !params[:buffer_uploads].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_access_key must be an String") if !params[:cloudflare_access_key].nil? and !params[:cloudflare_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_bucket must be an String") if !params[:cloudflare_bucket].nil? and !params[:cloudflare_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_endpoint must be an String") if !params[:cloudflare_endpoint].nil? and !params[:cloudflare_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dropbox_teams must be a single value, not #{params[:dropbox_teams].class}") if [ Array, Hash ].any? { |klass| params[:dropbox_teams].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: enable_dedicated_ips must be a single value, not #{params[:enable_dedicated_ips].class}") if [ Array, Hash ].any? { |klass| params[:enable_dedicated_ips].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: filebase_access_key must be an String") if !params[:filebase_access_key].nil? and !params[:filebase_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_bucket must be an String") if !params[:filebase_bucket].nil? and !params[:filebase_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_api_key must be an String") if !params[:files_api_key].nil? and !params[:files_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_permission_set must be an String") if !params[:files_agent_permission_set].nil? and !params[:files_agent_permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_root must be an String") if !params[:files_agent_root].nil? and !params[:files_agent_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_version must be an String") if !params[:files_agent_version].nil? and !params[:files_agent_version].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: outbound_agent_id must be an Integer") if !params[:outbound_agent_id].nil? and !params[:outbound_agent_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: custom_domain_id must be an Integer") if !params[:custom_domain_id].nil? and !params[:custom_domain_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_authentication_method must be an String") if !params[:google_cloud_storage_authentication_method].nil? and !params[:google_cloud_storage_authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_bucket must be an String") if !params[:google_cloud_storage_bucket].nil? and !params[:google_cloud_storage_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_oauth_scope must be an String") if !params[:google_cloud_storage_oauth_scope].nil? and !params[:google_cloud_storage_oauth_scope].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_project_id must be an String") if !params[:google_cloud_storage_project_id].nil? and !params[:google_cloud_storage_project_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_access_key must be an String") if !params[:google_cloud_storage_s3_compatible_access_key].nil? and !params[:google_cloud_storage_s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if !params[:hostname].nil? and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_access_key must be an String") if !params[:linode_access_key].nil? and !params[:linode_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_bucket must be an String") if !params[:linode_bucket].nil? and !params[:linode_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_region must be an String") if !params[:linode_region].nil? and !params[:linode_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: max_connections must be an Integer") if !params[:max_connections].nil? and !params[:max_connections].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: one_drive_account_type must be an String") if !params[:one_drive_account_type].nil? and !params[:one_drive_account_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pin_to_site_region must be a single value, not #{params[:pin_to_site_region].class}") if [ Array, Hash ].any? { |klass| params[:pin_to_site_region].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: port must be an Integer") if !params[:port].nil? and !params[:port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: upload_staging_path must be an String") if !params[:upload_staging_path].nil? and !params[:upload_staging_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: remote_server_credential_id must be an Integer") if !params[:remote_server_credential_id].nil? and !params[:remote_server_credential_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: s3_assume_role_arn must be an String") if !params[:s3_assume_role_arn].nil? and !params[:s3_assume_role_arn].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_assume_role_duration_seconds must be an Integer") if !params[:s3_assume_role_duration_seconds].nil? and !params[:s3_assume_role_duration_seconds].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: s3_bucket must be an String") if !params[:s3_bucket].nil? and !params[:s3_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if !params[:s3_compatible_access_key].nil? and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_bucket must be an String") if !params[:s3_compatible_bucket].nil? and !params[:s3_compatible_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint must be an String") if !params[:s3_compatible_endpoint].nil? and !params[:s3_compatible_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_region must be an String") if !params[:s3_compatible_region].nil? and !params[:s3_compatible_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_virtual_hosted_style must be a single value, not #{params[:s3_compatible_virtual_hosted_style].class}") if [ Array, Hash ].any? { |klass| params[:s3_compatible_virtual_hosted_style].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: s3_kms_key_id must be an String") if !params[:s3_kms_key_id].nil? and !params[:s3_kms_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_region must be an String") if !params[:s3_region].nil? and !params[:s3_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if !params[:server_certificate].nil? and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_host_key must be an String") if !params[:server_host_key].nil? and !params[:server_host_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if !params[:server_type].nil? and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_id must be an String") if !params[:sharepoint_client_id].nil? and !params[:sharepoint_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_site_url must be an String") if !params[:sharepoint_site_url].nil? and !params[:sharepoint_site_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_tenant_id must be an String") if !params[:sharepoint_tenant_id].nil? and !params[:sharepoint_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl must be an String") if !params[:ssl].nil? and !params[:ssl].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if !params[:username].nil? and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if !params[:wasabi_access_key].nil? and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_bucket must be an String") if !params[:wasabi_bucket].nil? and !params[:wasabi_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_region must be an String") if !params[:wasabi_region].nil? and !params[:wasabi_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)

      response, options = Api.send_request("/remote_servers", :post, params, options) { |reply| reply.require_object("RemoteServer") }
      RemoteServer.new(response.data, options)
    end

    # Push update to Files Agent
    #
    # @param id [Integer] Remote Server ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::AgentPushUpdate] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.agent_push_update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_servers/#{params[:id]}/agent_push_update", :post, params, options) { |reply| reply.require_object("AgentPushUpdate") }
      AgentPushUpdate.new(response.data, options)
    end

    # Update Remote Server
    #
    # @param id [Integer] Remote Server ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] password Password, if needed.
    # @option params [String] private_key Private key, if needed.
    # @option params [String] private_key_passphrase Passphrase for private key if needed.
    # @option params [Boolean] reset_authentication Reset authenticated account?
    # @option params [String] sharepoint_client_certificate SharePoint: PEM-encoded certificate and unencrypted private key for app-only authentication.
    # @option params [String] sharepoint_client_secret SharePoint: Microsoft Entra application client secret for app-only authentication.
    # @option params [String] ssl_certificate SSL client certificate.
    # @option params [String] aws_secret_key AWS: secret key.
    # @option params [String] azure_blob_storage_access_key Azure Blob Storage: Access Key
    # @option params [String] azure_blob_storage_sas_token Azure Blob Storage: Shared Access Signature (SAS) token
    # @option params [String] azure_files_storage_access_key Azure File Storage: Access Key
    # @option params [String] azure_files_storage_sas_token Azure File Storage: Shared Access Signature (SAS) token
    # @option params [String] backblaze_b2_application_key Backblaze B2 Cloud Storage: applicationKey
    # @option params [String] backblaze_b2_key_id Backblaze B2 Cloud Storage: keyID
    # @option params [String] cloudflare_secret_key Cloudflare: Secret Key
    # @option params [String] filebase_secret_key Filebase: Secret Key
    # @option params [String] google_cloud_storage_credentials_json Google Cloud Storage: JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
    # @option params [String] google_cloud_storage_s3_compatible_secret_key Google Cloud Storage: S3-compatible secret key
    # @option params [String] linode_secret_key Linode: Secret Key
    # @option params [String] s3_compatible_secret_key S3-compatible: Secret Key
    # @option params [String] wasabi_secret_key Wasabi: Secret Key
    # @option params [Boolean] allow_relative_paths Allow relative paths in SFTP. If true, paths will not be forced to be absolute, allowing operations relative to the user's home directory.
    # @option params [String] aws_access_key AWS Access Key.
    # @option params [String] azure_blob_storage_account Azure Blob Storage: Account name
    # @option params [String] azure_blob_storage_container Azure Blob Storage: Container name
    # @option params [String] azure_blob_storage_dns_suffix Azure Blob Storage: Custom DNS suffix
    # @option params [Boolean] azure_blob_storage_hierarchical_namespace Azure Blob Storage: Does the storage account has hierarchical namespace feature enabled?
    # @option params [String] azure_files_storage_account Azure Files: Storage Account name
    # @option params [String] azure_files_storage_dns_suffix Azure Files: Custom DNS suffix
    # @option params [String] azure_files_storage_share_name Azure Files:  Storage Share name
    # @option params [String] backblaze_b2_bucket Backblaze B2 Cloud Storage: Bucket name
    # @option params [String] backblaze_b2_s3_endpoint Backblaze B2 Cloud Storage: S3 Endpoint
    # @option params [String] buffer_uploads If set to always, uploads to this server will be uploaded first to Files.com before being sent to the remote server. This can improve performance in certain access patterns, such as high-latency connections.  It will cause data to be temporarily stored in Files.com. If set to auto, we will perform this optimization if we believe it to be a benefit in a given situation.
    # @option params [String] cloudflare_access_key Cloudflare: Access Key.
    # @option params [String] cloudflare_bucket Cloudflare: Bucket name
    # @option params [String] cloudflare_endpoint Cloudflare: endpoint
    # @option params [String] description Internal description for your reference
    # @option params [Boolean] dropbox_teams Dropbox: If true, list Team folders in root?
    # @option params [Boolean] enable_dedicated_ips `true` if remote server only accepts connections from dedicated IPs
    # @option params [String] filebase_access_key Filebase: Access Key.
    # @option params [String] filebase_bucket Filebase: Bucket name
    # @option params [String] files_api_key Files.com direct link: API key used once to pair the remote server.
    # @option params [String] files_agent_permission_set Agent file permissions: `read_only`, `write_only`, or `read_write`. Files.com writes this value as `permission_set` in the configuration file generated for this Remote Server. Setting it on Create or Update changes the generated file, not a running Agent. The Agent enforces the permissions in its local configuration file, controlled by the host's system administrator, and reports them at registration, replacing the stored value.
    # @option params [String] files_agent_root Agent local root path. Files.com writes this value as `root` in the configuration file generated for this Remote Server. Setting it on Create or Update changes the generated file, not a running Agent. The Agent enforces the root in its local configuration file, controlled by the host's system administrator, and reports it at registration, replacing the stored value.
    # @option params [String] files_agent_version Files.com Agent version reported by the Agent at each registration, replacing the stored value. This field is not included in the generated Agent configuration file. Setting it on Create or Update does not update the running Agent.
    # @option params [Integer] outbound_agent_id Route traffic to outbound on a files-agent
    # @option params [Integer] custom_domain_id Custom Domain ID whose dedicated IP addresses are selected when this Remote Server uses dedicated IPs. Must be available to this Remote Server's workspace. Requires enable_dedicated_ips and cannot be combined with an outbound Agent. Set to null to use the site's default dedicated IPs.
    # @option params [String] google_cloud_storage_authentication_method Google Cloud Storage: Authentication method. Can be json, hmac, or oauth.
    # @option params [String] google_cloud_storage_bucket Google Cloud Storage: Bucket Name
    # @option params [String] google_cloud_storage_oauth_scope Google Cloud Storage: OAuth scope. Can be https://www.googleapis.com/auth/devstorage.read_only or https://www.googleapis.com/auth/devstorage.read_write.
    # @option params [String] google_cloud_storage_project_id Google Cloud Storage: Project ID
    # @option params [String] google_cloud_storage_s3_compatible_access_key Google Cloud Storage: S3-compatible Access Key.
    # @option params [String] hostname Hostname or IP address. For Agent Remote Servers, the Agent reports the hostname it connects from at each registration, replacing the stored value. This field is not included in the generated Agent configuration file. Setting it on Create or Update does not change the running Agent.
    # @option params [String] linode_access_key Linode: Access Key
    # @option params [String] linode_bucket Linode: Bucket name
    # @option params [String] linode_region Linode: region
    # @option params [Integer] max_connections Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
    # @option params [String] name Internal name for your reference
    # @option params [String] one_drive_account_type OneDrive: Either personal or business_other account types
    # @option params [Boolean] pin_to_site_region If true, we will ensure that all communications with this remote server are made through the primary region of the site.  This setting can also be overridden by a site-wide setting which will force it to true.
    # @option params [Integer] port Port for remote server. For Agent Remote Servers, the Agent reports its downstream proxy port at each registration, replacing the stored value. This field is not included in the generated Agent configuration file. Setting it on Create or Update does not change the running Agent.
    # @option params [String] upload_staging_path Upload staging path.  Applies to SFTP only.  If a path is provided here, files will first be uploaded to this path on the remote folder and the moved into the final correct path via an SFTP move command.  This is required by some remote MFT systems to emulate atomic uploads, which are otherwise not supoprted by SFTP.
    # @option params [Integer] remote_server_credential_id ID of Remote Server Credential, if applicable.
    # @option params [String] s3_assume_role_arn AWS IAM Role ARN for AssumeRole authentication.
    # @option params [Integer] s3_assume_role_duration_seconds Session duration in seconds for AssumeRole authentication (900-43200).
    # @option params [String] s3_bucket S3 bucket name
    # @option params [String] s3_compatible_access_key S3-compatible: Access Key
    # @option params [String] s3_compatible_bucket S3-compatible: Bucket name
    # @option params [String] s3_compatible_endpoint S3-compatible: endpoint
    # @option params [String] s3_compatible_region S3-compatible: region
    # @option params [Boolean] s3_compatible_virtual_hosted_style S3-compatible: If true, use virtual-hosted-style URLs instead of path-style URLs
    # @option params [String] s3_kms_key_id ARN of the AWS KMS key that encrypts files written to the bucket (SSE-KMS). Leave blank unless your bucket requires a specific key.
    # @option params [String] s3_region S3 region
    # @option params [String] server_certificate Remote server certificate
    # @option params [String] server_host_key Pinned SSH host key or OpenSSH host certificate for SFTP. If omitted, Files.com detects and stores a host key, preferring plain keys over certificates. With `server_certificate=require_match` (the default), the server must present the exact pinned key or certificate and prove it holds the matching private key. A pinned certificate is compared in full, so renewal can require updating `server_host_key` even when its underlying key is unchanged. Files.com does not check certificate CA signatures, principals, or validity periods. Certificate expiration alone does not end the pin. Update `server_host_key` to replace the pin.
    # @option params [String] server_type Remote server type.
    # @option params [String] sharepoint_client_id SharePoint: Microsoft Entra application client ID for app-only authentication.
    # @option params [String] sharepoint_site_url SharePoint: Site URL to scope app-only authentication to a single site. Leave blank to browse all sites.
    # @option params [String] sharepoint_tenant_id SharePoint: Microsoft Entra tenant ID for app-only authentication.
    # @option params [String] ssl Should we require SSL?
    # @option params [String] username Remote server username.
    # @option params [String] wasabi_access_key Wasabi: Access Key.
    # @option params [String] wasabi_bucket Wasabi: Bucket name
    # @option params [String] wasabi_region Wasabi: Region
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::RemoteServer] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if !params[:private_key_passphrase].nil? and !params[:private_key_passphrase].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: reset_authentication must be a single value, not #{params[:reset_authentication].class}") if [ Array, Hash ].any? { |klass| params[:reset_authentication].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_certificate must be an String") if !params[:sharepoint_client_certificate].nil? and !params[:sharepoint_client_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_secret must be an String") if !params[:sharepoint_client_secret].nil? and !params[:sharepoint_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl_certificate must be an String") if !params[:ssl_certificate].nil? and !params[:ssl_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_secret_key must be an String") if !params[:aws_secret_key].nil? and !params[:aws_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_access_key must be an String") if !params[:azure_blob_storage_access_key].nil? and !params[:azure_blob_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_sas_token must be an String") if !params[:azure_blob_storage_sas_token].nil? and !params[:azure_blob_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_access_key must be an String") if !params[:azure_files_storage_access_key].nil? and !params[:azure_files_storage_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_sas_token must be an String") if !params[:azure_files_storage_sas_token].nil? and !params[:azure_files_storage_sas_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_application_key must be an String") if !params[:backblaze_b2_application_key].nil? and !params[:backblaze_b2_application_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_key_id must be an String") if !params[:backblaze_b2_key_id].nil? and !params[:backblaze_b2_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_secret_key must be an String") if !params[:cloudflare_secret_key].nil? and !params[:cloudflare_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_secret_key must be an String") if !params[:filebase_secret_key].nil? and !params[:filebase_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_credentials_json must be an String") if !params[:google_cloud_storage_credentials_json].nil? and !params[:google_cloud_storage_credentials_json].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_secret_key must be an String") if !params[:google_cloud_storage_s3_compatible_secret_key].nil? and !params[:google_cloud_storage_s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_secret_key must be an String") if !params[:linode_secret_key].nil? and !params[:linode_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_secret_key must be an String") if !params[:s3_compatible_secret_key].nil? and !params[:s3_compatible_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_secret_key must be an String") if !params[:wasabi_secret_key].nil? and !params[:wasabi_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allow_relative_paths must be a single value, not #{params[:allow_relative_paths].class}") if [ Array, Hash ].any? { |klass| params[:allow_relative_paths].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if !params[:aws_access_key].nil? and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_account must be an String") if !params[:azure_blob_storage_account].nil? and !params[:azure_blob_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_container must be an String") if !params[:azure_blob_storage_container].nil? and !params[:azure_blob_storage_container].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_dns_suffix must be an String") if !params[:azure_blob_storage_dns_suffix].nil? and !params[:azure_blob_storage_dns_suffix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_blob_storage_hierarchical_namespace must be a single value, not #{params[:azure_blob_storage_hierarchical_namespace].class}") if [ Array, Hash ].any? { |klass| params[:azure_blob_storage_hierarchical_namespace].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_account must be an String") if !params[:azure_files_storage_account].nil? and !params[:azure_files_storage_account].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_dns_suffix must be an String") if !params[:azure_files_storage_dns_suffix].nil? and !params[:azure_files_storage_dns_suffix].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_files_storage_share_name must be an String") if !params[:azure_files_storage_share_name].nil? and !params[:azure_files_storage_share_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_bucket must be an String") if !params[:backblaze_b2_bucket].nil? and !params[:backblaze_b2_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: backblaze_b2_s3_endpoint must be an String") if !params[:backblaze_b2_s3_endpoint].nil? and !params[:backblaze_b2_s3_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: buffer_uploads must be an String") if !params[:buffer_uploads].nil? and !params[:buffer_uploads].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_access_key must be an String") if !params[:cloudflare_access_key].nil? and !params[:cloudflare_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_bucket must be an String") if !params[:cloudflare_bucket].nil? and !params[:cloudflare_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cloudflare_endpoint must be an String") if !params[:cloudflare_endpoint].nil? and !params[:cloudflare_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dropbox_teams must be a single value, not #{params[:dropbox_teams].class}") if [ Array, Hash ].any? { |klass| params[:dropbox_teams].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: enable_dedicated_ips must be a single value, not #{params[:enable_dedicated_ips].class}") if [ Array, Hash ].any? { |klass| params[:enable_dedicated_ips].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: filebase_access_key must be an String") if !params[:filebase_access_key].nil? and !params[:filebase_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_bucket must be an String") if !params[:filebase_bucket].nil? and !params[:filebase_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_api_key must be an String") if !params[:files_api_key].nil? and !params[:files_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_permission_set must be an String") if !params[:files_agent_permission_set].nil? and !params[:files_agent_permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_root must be an String") if !params[:files_agent_root].nil? and !params[:files_agent_root].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: files_agent_version must be an String") if !params[:files_agent_version].nil? and !params[:files_agent_version].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: outbound_agent_id must be an Integer") if !params[:outbound_agent_id].nil? and !params[:outbound_agent_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: custom_domain_id must be an Integer") if !params[:custom_domain_id].nil? and !params[:custom_domain_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_authentication_method must be an String") if !params[:google_cloud_storage_authentication_method].nil? and !params[:google_cloud_storage_authentication_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_bucket must be an String") if !params[:google_cloud_storage_bucket].nil? and !params[:google_cloud_storage_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_oauth_scope must be an String") if !params[:google_cloud_storage_oauth_scope].nil? and !params[:google_cloud_storage_oauth_scope].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_project_id must be an String") if !params[:google_cloud_storage_project_id].nil? and !params[:google_cloud_storage_project_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_access_key must be an String") if !params[:google_cloud_storage_s3_compatible_access_key].nil? and !params[:google_cloud_storage_s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if !params[:hostname].nil? and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_access_key must be an String") if !params[:linode_access_key].nil? and !params[:linode_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_bucket must be an String") if !params[:linode_bucket].nil? and !params[:linode_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_region must be an String") if !params[:linode_region].nil? and !params[:linode_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: max_connections must be an Integer") if !params[:max_connections].nil? and !params[:max_connections].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: one_drive_account_type must be an String") if !params[:one_drive_account_type].nil? and !params[:one_drive_account_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: pin_to_site_region must be a single value, not #{params[:pin_to_site_region].class}") if [ Array, Hash ].any? { |klass| params[:pin_to_site_region].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: port must be an Integer") if !params[:port].nil? and !params[:port].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: upload_staging_path must be an String") if !params[:upload_staging_path].nil? and !params[:upload_staging_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: remote_server_credential_id must be an Integer") if !params[:remote_server_credential_id].nil? and !params[:remote_server_credential_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: s3_assume_role_arn must be an String") if !params[:s3_assume_role_arn].nil? and !params[:s3_assume_role_arn].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_assume_role_duration_seconds must be an Integer") if !params[:s3_assume_role_duration_seconds].nil? and !params[:s3_assume_role_duration_seconds].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: s3_bucket must be an String") if !params[:s3_bucket].nil? and !params[:s3_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if !params[:s3_compatible_access_key].nil? and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_bucket must be an String") if !params[:s3_compatible_bucket].nil? and !params[:s3_compatible_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_endpoint must be an String") if !params[:s3_compatible_endpoint].nil? and !params[:s3_compatible_endpoint].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_region must be an String") if !params[:s3_compatible_region].nil? and !params[:s3_compatible_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_virtual_hosted_style must be a single value, not #{params[:s3_compatible_virtual_hosted_style].class}") if [ Array, Hash ].any? { |klass| params[:s3_compatible_virtual_hosted_style].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: s3_kms_key_id must be an String") if !params[:s3_kms_key_id].nil? and !params[:s3_kms_key_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_region must be an String") if !params[:s3_region].nil? and !params[:s3_region].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_certificate must be an String") if !params[:server_certificate].nil? and !params[:server_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_host_key must be an String") if !params[:server_host_key].nil? and !params[:server_host_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if !params[:server_type].nil? and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_id must be an String") if !params[:sharepoint_client_id].nil? and !params[:sharepoint_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_site_url must be an String") if !params[:sharepoint_site_url].nil? and !params[:sharepoint_site_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_tenant_id must be an String") if !params[:sharepoint_tenant_id].nil? and !params[:sharepoint_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ssl must be an String") if !params[:ssl].nil? and !params[:ssl].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if !params[:username].nil? and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if !params[:wasabi_access_key].nil? and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_bucket must be an String") if !params[:wasabi_bucket].nil? and !params[:wasabi_bucket].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_region must be an String") if !params[:wasabi_region].nil? and !params[:wasabi_region].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_servers/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("RemoteServer") }
      RemoteServer.new(response.data, options)
    end

    # Delete Remote Server
    #
    # @param id [Integer] Remote Server ID.
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

      Api.send_request("/remote_servers/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
