# frozen_string_literal: true

module Files
  # Files::RemoteServerCredential is the Ruby SDK's representation of Files.com API RemoteServerCredential objects.
  # Each instance keeps its API field values in +attributes+.
  class RemoteServerCredential
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

    # Remote Server Credential ID
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

    # Remote server type.  Remote Server Credentials are only valid for a single type of Remote Server.
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

    # ID of Remote Server Credential to copy omitted values from.
    # @return [Integer, nil] the field value, or nil when absent.
    def copy_values_from_credential_id
      @attributes[:copy_values_from_credential_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def copy_values_from_credential_id=(value)
      @attributes[:copy_values_from_credential_id] = value
    end

    # Update Remote Server Credential
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Internal name for your reference
    # @option params [String] description Internal description for your reference
    # @option params [String] server_type Remote server type.  Remote Server Credentials are only valid for a single type of Remote Server.
    # @option params [String] aws_access_key AWS Access Key.
    # @option params [String] s3_assume_role_arn AWS IAM Role ARN for AssumeRole authentication.
    # @option params [Integer] s3_assume_role_duration_seconds Session duration in seconds for AssumeRole authentication (900-43200).
    # @option params [String] cloudflare_access_key Cloudflare: Access Key.
    # @option params [String] filebase_access_key Filebase: Access Key.
    # @option params [String] google_cloud_storage_s3_compatible_access_key Google Cloud Storage: S3-compatible Access Key.
    # @option params [String] linode_access_key Linode: Access Key
    # @option params [String] s3_compatible_access_key S3-compatible: Access Key
    # @option params [String] sharepoint_client_id SharePoint: Microsoft Entra application client ID for app-only authentication.
    # @option params [String] sharepoint_tenant_id SharePoint: Microsoft Entra tenant ID for app-only authentication.
    # @option params [String] username Remote server username.
    # @option params [String] wasabi_access_key Wasabi: Access Key.
    # @option params [String] password Password, if needed.
    # @option params [String] private_key Private key, if needed.
    # @option params [String] private_key_passphrase Passphrase for private key if needed.
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
    # @option params [String] sharepoint_client_certificate SharePoint: PEM-encoded certificate and unencrypted private key for app-only authentication.
    # @option params [String] sharepoint_client_secret SharePoint: Microsoft Entra application client secret for app-only authentication.
    # @option params [String] wasabi_secret_key Wasabi: Secret Key
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if !params[:server_type].nil? and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if !params[:aws_access_key].nil? and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_assume_role_arn must be an String") if !params[:s3_assume_role_arn].nil? and !params[:s3_assume_role_arn].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_assume_role_duration_seconds must be an Integer") if !params[:s3_assume_role_duration_seconds].nil? and !params[:s3_assume_role_duration_seconds].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cloudflare_access_key must be an String") if !params[:cloudflare_access_key].nil? and !params[:cloudflare_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_access_key must be an String") if !params[:filebase_access_key].nil? and !params[:filebase_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_access_key must be an String") if !params[:google_cloud_storage_s3_compatible_access_key].nil? and !params[:google_cloud_storage_s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_access_key must be an String") if !params[:linode_access_key].nil? and !params[:linode_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if !params[:s3_compatible_access_key].nil? and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_id must be an String") if !params[:sharepoint_client_id].nil? and !params[:sharepoint_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_tenant_id must be an String") if !params[:sharepoint_tenant_id].nil? and !params[:sharepoint_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if !params[:username].nil? and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if !params[:wasabi_access_key].nil? and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if !params[:private_key_passphrase].nil? and !params[:private_key_passphrase].is_a?(String)
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
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_certificate must be an String") if !params[:sharepoint_client_certificate].nil? and !params[:sharepoint_client_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_secret must be an String") if !params[:sharepoint_client_secret].nil? and !params[:sharepoint_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_secret_key must be an String") if !params[:wasabi_secret_key].nil? and !params[:wasabi_secret_key].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_server_credentials/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("RemoteServerCredential") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Remote Server Credential
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

      response, options = Api.send_request("/remote_server_credentials/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = RemoteServerCredential.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Remote Server Credentials
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id` and `name`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `workspace_id` and `name`. Valid field combinations are `[ workspace_id, name ]`.
    # @option params [Hash] filter_prefix If set, return records where the specified field is prefixed by the supplied value. Valid fields are `name`.
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
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if !params[:filter_prefix].nil? and !params[:filter_prefix].is_a?(Hash)

      list_options = options.dup
      List.new(RemoteServerCredential, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/remote_server_credentials", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Remote Server Credential
    #
    # @param id [Integer] Remote Server Credential ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::RemoteServerCredential] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_server_credentials/#{params[:id]}", :get, params, options) { |reply| reply.require_object("RemoteServerCredential") }
      RemoteServerCredential.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Remote Server Credential
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Internal name for your reference
    # @option params [String] description Internal description for your reference
    # @option params [String] server_type Remote server type.  Remote Server Credentials are only valid for a single type of Remote Server.
    # @option params [String] aws_access_key AWS Access Key.
    # @option params [String] s3_assume_role_arn AWS IAM Role ARN for AssumeRole authentication.
    # @option params [Integer] s3_assume_role_duration_seconds Session duration in seconds for AssumeRole authentication (900-43200).
    # @option params [String] cloudflare_access_key Cloudflare: Access Key.
    # @option params [String] filebase_access_key Filebase: Access Key.
    # @option params [String] google_cloud_storage_s3_compatible_access_key Google Cloud Storage: S3-compatible Access Key.
    # @option params [String] linode_access_key Linode: Access Key
    # @option params [String] s3_compatible_access_key S3-compatible: Access Key
    # @option params [String] sharepoint_client_id SharePoint: Microsoft Entra application client ID for app-only authentication.
    # @option params [String] sharepoint_tenant_id SharePoint: Microsoft Entra tenant ID for app-only authentication.
    # @option params [String] username Remote server username.
    # @option params [String] wasabi_access_key Wasabi: Access Key.
    # @option params [String] password Password, if needed.
    # @option params [String] private_key Private key, if needed.
    # @option params [String] private_key_passphrase Passphrase for private key if needed.
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
    # @option params [String] sharepoint_client_certificate SharePoint: PEM-encoded certificate and unencrypted private key for app-only authentication.
    # @option params [String] sharepoint_client_secret SharePoint: Microsoft Entra application client secret for app-only authentication.
    # @option params [String] wasabi_secret_key Wasabi: Secret Key
    # @option params [Integer] workspace_id Workspace ID (0 for default workspace)
    # @option params [Integer] copy_values_from_credential_id ID of Remote Server Credential to copy omitted values from.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::RemoteServerCredential] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if !params[:server_type].nil? and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if !params[:aws_access_key].nil? and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_assume_role_arn must be an String") if !params[:s3_assume_role_arn].nil? and !params[:s3_assume_role_arn].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_assume_role_duration_seconds must be an Integer") if !params[:s3_assume_role_duration_seconds].nil? and !params[:s3_assume_role_duration_seconds].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cloudflare_access_key must be an String") if !params[:cloudflare_access_key].nil? and !params[:cloudflare_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_access_key must be an String") if !params[:filebase_access_key].nil? and !params[:filebase_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_access_key must be an String") if !params[:google_cloud_storage_s3_compatible_access_key].nil? and !params[:google_cloud_storage_s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_access_key must be an String") if !params[:linode_access_key].nil? and !params[:linode_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if !params[:s3_compatible_access_key].nil? and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_id must be an String") if !params[:sharepoint_client_id].nil? and !params[:sharepoint_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_tenant_id must be an String") if !params[:sharepoint_tenant_id].nil? and !params[:sharepoint_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if !params[:username].nil? and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if !params[:wasabi_access_key].nil? and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if !params[:private_key_passphrase].nil? and !params[:private_key_passphrase].is_a?(String)
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
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_certificate must be an String") if !params[:sharepoint_client_certificate].nil? and !params[:sharepoint_client_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_secret must be an String") if !params[:sharepoint_client_secret].nil? and !params[:sharepoint_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_secret_key must be an String") if !params[:wasabi_secret_key].nil? and !params[:wasabi_secret_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: copy_values_from_credential_id must be an Integer") if !params[:copy_values_from_credential_id].nil? and !params[:copy_values_from_credential_id].is_a?(Integer)

      response, options = Api.send_request("/remote_server_credentials", :post, params, options) { |reply| reply.require_object("RemoteServerCredential") }
      RemoteServerCredential.new(response.data, options)
    end

    # Update Remote Server Credential
    #
    # @param id [Integer] Remote Server Credential ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Internal name for your reference
    # @option params [String] description Internal description for your reference
    # @option params [String] server_type Remote server type.  Remote Server Credentials are only valid for a single type of Remote Server.
    # @option params [String] aws_access_key AWS Access Key.
    # @option params [String] s3_assume_role_arn AWS IAM Role ARN for AssumeRole authentication.
    # @option params [Integer] s3_assume_role_duration_seconds Session duration in seconds for AssumeRole authentication (900-43200).
    # @option params [String] cloudflare_access_key Cloudflare: Access Key.
    # @option params [String] filebase_access_key Filebase: Access Key.
    # @option params [String] google_cloud_storage_s3_compatible_access_key Google Cloud Storage: S3-compatible Access Key.
    # @option params [String] linode_access_key Linode: Access Key
    # @option params [String] s3_compatible_access_key S3-compatible: Access Key
    # @option params [String] sharepoint_client_id SharePoint: Microsoft Entra application client ID for app-only authentication.
    # @option params [String] sharepoint_tenant_id SharePoint: Microsoft Entra tenant ID for app-only authentication.
    # @option params [String] username Remote server username.
    # @option params [String] wasabi_access_key Wasabi: Access Key.
    # @option params [String] password Password, if needed.
    # @option params [String] private_key Private key, if needed.
    # @option params [String] private_key_passphrase Passphrase for private key if needed.
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
    # @option params [String] sharepoint_client_certificate SharePoint: PEM-encoded certificate and unencrypted private key for app-only authentication.
    # @option params [String] sharepoint_client_secret SharePoint: Microsoft Entra application client secret for app-only authentication.
    # @option params [String] wasabi_secret_key Wasabi: Secret Key
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::RemoteServerCredential] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: server_type must be an String") if !params[:server_type].nil? and !params[:server_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_access_key must be an String") if !params[:aws_access_key].nil? and !params[:aws_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_assume_role_arn must be an String") if !params[:s3_assume_role_arn].nil? and !params[:s3_assume_role_arn].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_assume_role_duration_seconds must be an Integer") if !params[:s3_assume_role_duration_seconds].nil? and !params[:s3_assume_role_duration_seconds].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cloudflare_access_key must be an String") if !params[:cloudflare_access_key].nil? and !params[:cloudflare_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filebase_access_key must be an String") if !params[:filebase_access_key].nil? and !params[:filebase_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: google_cloud_storage_s3_compatible_access_key must be an String") if !params[:google_cloud_storage_s3_compatible_access_key].nil? and !params[:google_cloud_storage_s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: linode_access_key must be an String") if !params[:linode_access_key].nil? and !params[:linode_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: s3_compatible_access_key must be an String") if !params[:s3_compatible_access_key].nil? and !params[:s3_compatible_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_id must be an String") if !params[:sharepoint_client_id].nil? and !params[:sharepoint_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_tenant_id must be an String") if !params[:sharepoint_tenant_id].nil? and !params[:sharepoint_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: username must be an String") if !params[:username].nil? and !params[:username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_access_key must be an String") if !params[:wasabi_access_key].nil? and !params[:wasabi_access_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key must be an String") if !params[:private_key].nil? and !params[:private_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: private_key_passphrase must be an String") if !params[:private_key_passphrase].nil? and !params[:private_key_passphrase].is_a?(String)
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
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_certificate must be an String") if !params[:sharepoint_client_certificate].nil? and !params[:sharepoint_client_certificate].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sharepoint_client_secret must be an String") if !params[:sharepoint_client_secret].nil? and !params[:sharepoint_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: wasabi_secret_key must be an String") if !params[:wasabi_secret_key].nil? and !params[:wasabi_secret_key].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/remote_server_credentials/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("RemoteServerCredential") }
      RemoteServerCredential.new(response.data, options)
    end

    # Delete Remote Server Credential
    #
    # @param id [Integer] Remote Server Credential ID.
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

      Api.send_request("/remote_server_credentials/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
