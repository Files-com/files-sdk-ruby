
package com.files.models;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.HashMap;

public class RemoteServer
{
    private HashMap<String, Object> attributes;
    private HashMap<String, Object> options;

    public RemoteServer(HashMap<String, Object> attributes, HashMap<String, Object> options)
    {
        this.attributes = attributes;
        this.options = options;
    }

    /**
     * Remote server ID
     */
    @Getter
    @Setter
    public Long id;

    /**
     * Type of authentication method
     */
    @Getter
    @Setter
    public String authenticationMethod;

    /**
     * Hostname or IP address
     */
    @Getter
    @Setter
    public String hostname;

    /**
     * Internal name for your reference
     */
    @Getter
    @Setter
    public String name;

    /**
     * Port for remote server.  Not needed for S3.
     */
    @Getter
    @Setter
    public Long port;

    /**
     * Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
     */
    @Getter
    @Setter
    public Long maxConnections;

    /**
     * S3 bucket name
     */
    @Getter
    @Setter
    public String s3Bucket;

    /**
     * S3 region
     */
    @Getter
    @Setter
    public String s3Region;

    /**
     * Remote server certificate
     */
    @Getter
    @Setter
    public String serverCertificate;

    /**
     * Remote server type.
     */
    @Getter
    @Setter
    public String serverType;

    /**
     * Should we require SSL?
     */
    @Getter
    @Setter
    public String ssl;

    /**
     * Remote server username.  Not needed for S3 buckets.
     */
    @Getter
    @Setter
    public String username;

    /**
     * Google Cloud Storage bucket name
     */
    @Getter
    @Setter
    public String googleCloudStorageBucket;

    /**
     * Google Cloud Project ID
     */
    @Getter
    @Setter
    public String googleCloudStorageProjectId;

    /**
     * Backblaze B2 Cloud Storage S3 Endpoint
     */
    @Getter
    @Setter
    public String backblazeB2S3Endpoint;

    /**
     * Backblaze B2 Cloud Storage Bucket name
     */
    @Getter
    @Setter
    public String backblazeB2Bucket;

    /**
     * Wasabi region
     */
    @Getter
    @Setter
    public String wasabiBucket;

    /**
     * Wasabi Bucket name
     */
    @Getter
    @Setter
    public String wasabiRegion;

    /**
     * AWS Access Key.
     */
    @Getter
    @Setter
    public String awsAccessKey;

    /**
     * AWS secret key.
     */
    @Getter
    @Setter
    public String awsSecretKey;

    /**
     * Password if needed.
     */
    @Getter
    @Setter
    public String password;

    /**
     * Private key if needed.
     */
    @Getter
    @Setter
    public String privateKey;

    /**
     * A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
     */
    @Getter
    @Setter
    public String googleCloudStorageCredentialsJson;

    /**
     * Wasabi access key.
     */
    @Getter
    @Setter
    public String wasabiAccessKey;

    /**
     * Wasabi secret key.
     */
    @Getter
    @Setter
    public String wasabiSecretKey;

    /**
     * Backblaze B2 Cloud Storage keyID.
     */
    @Getter
    @Setter
    public String backblazeB2KeyId;

    /**
     * Backblaze B2 Cloud Storage applicationKey.
     */
    @Getter
    @Setter
    public String backblazeB2ApplicationKey;

    /**
     * Parameters:
     *   aws_access_key - string - AWS Access Key.
     *   aws_secret_key - string - AWS secret key.
     *   password - string - Password if needed.
     *   private_key - string - Private key if needed.
     *   google_cloud_storage_credentials_json - string - A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
     *   wasabi_access_key - string - Wasabi access key.
     *   wasabi_secret_key - string - Wasabi secret key.
     *   backblaze_b2_key_id - string - Backblaze B2 Cloud Storage keyID.
     *   backblaze_b2_application_key - string - Backblaze B2 Cloud Storage applicationKey.
     *   hostname - string - Hostname or IP address
     *   name - string - Internal name for your reference
     *   max_connections - integer - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
     *   port - integer - Port for remote server.  Not needed for S3.
     *   s3_bucket - string - S3 bucket name
     *   s3_region - string - S3 region
     *   server_certificate - string - Remote server certificate
     *   server_type - string - Remote server type.
     *   ssl - string - Should we require SSL?
     *   username - string - Remote server username.  Not needed for S3 buckets.
     *   google_cloud_storage_bucket - string - Google Cloud Storage bucket name
     *   google_cloud_storage_project_id - string - Google Cloud Project ID
     *   backblaze_b2_bucket - string - Backblaze B2 Cloud Storage Bucket name
     *   backblaze_b2_s3_endpoint - string - Backblaze B2 Cloud Storage S3 Endpoint
     *   wasabi_bucket - string - Wasabi region
     *   wasabi_region - string - Wasabi Bucket name
     */
    public RemoteServer update(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    /**
     */
    public RemoteServer delete(HashMap<String, Object> parameters)
    {
    // TODO: Fill in operation implementation
    return null;
    }

    public void destroy(HashMap<String, Object> parameters)
    {
        delete(parameters);
    }

    public void save()
    {
        if (this.attributes.get("id") != null)
        {
        update(this.attributes);
        }
        else
        {
        //var newObj = RemoteServer.create(this.attributes, this.options);
        //this.attributes = newObj.attributes;
        }
    }

    /**
     * Parameters:
     *   page - integer - Current page number.
     *   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
     *   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
     */
    // TODO: Use types for path_and_primary_params
    public static RemoteServer list( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("page") && !(parameters.get("page") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: page must be of type Long parameters[\"page\"]");
        }
        if (parameters.containsKey("per_page") && !(parameters.get("per_page") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: per_page must be of type Long parameters[\"per_page\"]");
        }
        if (parameters.containsKey("action") && !(parameters.get("action") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: action must be of type String parameters[\"action\"]");
        }
        // TODO: Send request
        return null;
    }

    public static RemoteServer all(HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return list(parameters, options);
    }
    /**
     * Parameters:
     *   id (required) - integer - Remote Server ID.
     */
    // TODO: Use types for path_and_primary_params
    public static RemoteServer find(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (!parameters.containsKey("id") || parameters.get("id") == null)
        {
            throw new NullPointerException("Parameter missing: id parameters[\"id\"]");
        }
        // TODO: Send request
        return null;
    }

    public static RemoteServer get(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return find(id, parameters, options);
    }
    /**
     * Parameters:
     *   aws_access_key - string - AWS Access Key.
     *   aws_secret_key - string - AWS secret key.
     *   password - string - Password if needed.
     *   private_key - string - Private key if needed.
     *   google_cloud_storage_credentials_json - string - A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
     *   wasabi_access_key - string - Wasabi access key.
     *   wasabi_secret_key - string - Wasabi secret key.
     *   backblaze_b2_key_id - string - Backblaze B2 Cloud Storage keyID.
     *   backblaze_b2_application_key - string - Backblaze B2 Cloud Storage applicationKey.
     *   hostname - string - Hostname or IP address
     *   name - string - Internal name for your reference
     *   max_connections - integer - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
     *   port - integer - Port for remote server.  Not needed for S3.
     *   s3_bucket - string - S3 bucket name
     *   s3_region - string - S3 region
     *   server_certificate - string - Remote server certificate
     *   server_type - string - Remote server type.
     *   ssl - string - Should we require SSL?
     *   username - string - Remote server username.  Not needed for S3 buckets.
     *   google_cloud_storage_bucket - string - Google Cloud Storage bucket name
     *   google_cloud_storage_project_id - string - Google Cloud Project ID
     *   backblaze_b2_bucket - string - Backblaze B2 Cloud Storage Bucket name
     *   backblaze_b2_s3_endpoint - string - Backblaze B2 Cloud Storage S3 Endpoint
     *   wasabi_bucket - string - Wasabi region
     *   wasabi_region - string - Wasabi Bucket name
     */
    // TODO: Use types for path_and_primary_params
    public static RemoteServer create( HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        if (parameters.containsKey("aws_access_key") && !(parameters.get("aws_access_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: aws_access_key must be of type String parameters[\"aws_access_key\"]");
        }
        if (parameters.containsKey("aws_secret_key") && !(parameters.get("aws_secret_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: aws_secret_key must be of type String parameters[\"aws_secret_key\"]");
        }
        if (parameters.containsKey("password") && !(parameters.get("password") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: password must be of type String parameters[\"password\"]");
        }
        if (parameters.containsKey("private_key") && !(parameters.get("private_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: private_key must be of type String parameters[\"private_key\"]");
        }
        if (parameters.containsKey("google_cloud_storage_credentials_json") && !(parameters.get("google_cloud_storage_credentials_json") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: google_cloud_storage_credentials_json must be of type String parameters[\"google_cloud_storage_credentials_json\"]");
        }
        if (parameters.containsKey("wasabi_access_key") && !(parameters.get("wasabi_access_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: wasabi_access_key must be of type String parameters[\"wasabi_access_key\"]");
        }
        if (parameters.containsKey("wasabi_secret_key") && !(parameters.get("wasabi_secret_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: wasabi_secret_key must be of type String parameters[\"wasabi_secret_key\"]");
        }
        if (parameters.containsKey("backblaze_b2_key_id") && !(parameters.get("backblaze_b2_key_id") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: backblaze_b2_key_id must be of type String parameters[\"backblaze_b2_key_id\"]");
        }
        if (parameters.containsKey("backblaze_b2_application_key") && !(parameters.get("backblaze_b2_application_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: backblaze_b2_application_key must be of type String parameters[\"backblaze_b2_application_key\"]");
        }
        if (parameters.containsKey("hostname") && !(parameters.get("hostname") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: hostname must be of type String parameters[\"hostname\"]");
        }
        if (parameters.containsKey("name") && !(parameters.get("name") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: name must be of type String parameters[\"name\"]");
        }
        if (parameters.containsKey("max_connections") && !(parameters.get("max_connections") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: max_connections must be of type Long parameters[\"max_connections\"]");
        }
        if (parameters.containsKey("port") && !(parameters.get("port") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: port must be of type Long parameters[\"port\"]");
        }
        if (parameters.containsKey("s3_bucket") && !(parameters.get("s3_bucket") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: s3_bucket must be of type String parameters[\"s3_bucket\"]");
        }
        if (parameters.containsKey("s3_region") && !(parameters.get("s3_region") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: s3_region must be of type String parameters[\"s3_region\"]");
        }
        if (parameters.containsKey("server_certificate") && !(parameters.get("server_certificate") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: server_certificate must be of type String parameters[\"server_certificate\"]");
        }
        if (parameters.containsKey("server_type") && !(parameters.get("server_type") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: server_type must be of type String parameters[\"server_type\"]");
        }
        if (parameters.containsKey("ssl") && !(parameters.get("ssl") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: ssl must be of type String parameters[\"ssl\"]");
        }
        if (parameters.containsKey("username") && !(parameters.get("username") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: username must be of type String parameters[\"username\"]");
        }
        if (parameters.containsKey("google_cloud_storage_bucket") && !(parameters.get("google_cloud_storage_bucket") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: google_cloud_storage_bucket must be of type String parameters[\"google_cloud_storage_bucket\"]");
        }
        if (parameters.containsKey("google_cloud_storage_project_id") && !(parameters.get("google_cloud_storage_project_id") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: google_cloud_storage_project_id must be of type String parameters[\"google_cloud_storage_project_id\"]");
        }
        if (parameters.containsKey("backblaze_b2_bucket") && !(parameters.get("backblaze_b2_bucket") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: backblaze_b2_bucket must be of type String parameters[\"backblaze_b2_bucket\"]");
        }
        if (parameters.containsKey("backblaze_b2_s3_endpoint") && !(parameters.get("backblaze_b2_s3_endpoint") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: backblaze_b2_s3_endpoint must be of type String parameters[\"backblaze_b2_s3_endpoint\"]");
        }
        if (parameters.containsKey("wasabi_bucket") && !(parameters.get("wasabi_bucket") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: wasabi_bucket must be of type String parameters[\"wasabi_bucket\"]");
        }
        if (parameters.containsKey("wasabi_region") && !(parameters.get("wasabi_region") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: wasabi_region must be of type String parameters[\"wasabi_region\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     * Parameters:
     *   aws_access_key - string - AWS Access Key.
     *   aws_secret_key - string - AWS secret key.
     *   password - string - Password if needed.
     *   private_key - string - Private key if needed.
     *   google_cloud_storage_credentials_json - string - A JSON file that contains the private key. To generate see https://cloud.google.com/storage/docs/json_api/v1/how-tos/authorizing#APIKey
     *   wasabi_access_key - string - Wasabi access key.
     *   wasabi_secret_key - string - Wasabi secret key.
     *   backblaze_b2_key_id - string - Backblaze B2 Cloud Storage keyID.
     *   backblaze_b2_application_key - string - Backblaze B2 Cloud Storage applicationKey.
     *   hostname - string - Hostname or IP address
     *   name - string - Internal name for your reference
     *   max_connections - integer - Max number of parallel connections.  Ignored for S3 connections (we will parallelize these as much as possible).
     *   port - integer - Port for remote server.  Not needed for S3.
     *   s3_bucket - string - S3 bucket name
     *   s3_region - string - S3 region
     *   server_certificate - string - Remote server certificate
     *   server_type - string - Remote server type.
     *   ssl - string - Should we require SSL?
     *   username - string - Remote server username.  Not needed for S3 buckets.
     *   google_cloud_storage_bucket - string - Google Cloud Storage bucket name
     *   google_cloud_storage_project_id - string - Google Cloud Project ID
     *   backblaze_b2_bucket - string - Backblaze B2 Cloud Storage Bucket name
     *   backblaze_b2_s3_endpoint - string - Backblaze B2 Cloud Storage S3 Endpoint
     *   wasabi_bucket - string - Wasabi region
     *   wasabi_region - string - Wasabi Bucket name
     */
    // TODO: Use types for path_and_primary_params
    public static RemoteServer update(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (parameters.containsKey("aws_access_key") && !(parameters.get("aws_access_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: aws_access_key must be of type String parameters[\"aws_access_key\"]");
        }
        if (parameters.containsKey("aws_secret_key") && !(parameters.get("aws_secret_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: aws_secret_key must be of type String parameters[\"aws_secret_key\"]");
        }
        if (parameters.containsKey("password") && !(parameters.get("password") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: password must be of type String parameters[\"password\"]");
        }
        if (parameters.containsKey("private_key") && !(parameters.get("private_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: private_key must be of type String parameters[\"private_key\"]");
        }
        if (parameters.containsKey("google_cloud_storage_credentials_json") && !(parameters.get("google_cloud_storage_credentials_json") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: google_cloud_storage_credentials_json must be of type String parameters[\"google_cloud_storage_credentials_json\"]");
        }
        if (parameters.containsKey("wasabi_access_key") && !(parameters.get("wasabi_access_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: wasabi_access_key must be of type String parameters[\"wasabi_access_key\"]");
        }
        if (parameters.containsKey("wasabi_secret_key") && !(parameters.get("wasabi_secret_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: wasabi_secret_key must be of type String parameters[\"wasabi_secret_key\"]");
        }
        if (parameters.containsKey("backblaze_b2_key_id") && !(parameters.get("backblaze_b2_key_id") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: backblaze_b2_key_id must be of type String parameters[\"backblaze_b2_key_id\"]");
        }
        if (parameters.containsKey("backblaze_b2_application_key") && !(parameters.get("backblaze_b2_application_key") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: backblaze_b2_application_key must be of type String parameters[\"backblaze_b2_application_key\"]");
        }
        if (parameters.containsKey("hostname") && !(parameters.get("hostname") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: hostname must be of type String parameters[\"hostname\"]");
        }
        if (parameters.containsKey("name") && !(parameters.get("name") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: name must be of type String parameters[\"name\"]");
        }
        if (parameters.containsKey("max_connections") && !(parameters.get("max_connections") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: max_connections must be of type Long parameters[\"max_connections\"]");
        }
        if (parameters.containsKey("port") && !(parameters.get("port") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: port must be of type Long parameters[\"port\"]");
        }
        if (parameters.containsKey("s3_bucket") && !(parameters.get("s3_bucket") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: s3_bucket must be of type String parameters[\"s3_bucket\"]");
        }
        if (parameters.containsKey("s3_region") && !(parameters.get("s3_region") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: s3_region must be of type String parameters[\"s3_region\"]");
        }
        if (parameters.containsKey("server_certificate") && !(parameters.get("server_certificate") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: server_certificate must be of type String parameters[\"server_certificate\"]");
        }
        if (parameters.containsKey("server_type") && !(parameters.get("server_type") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: server_type must be of type String parameters[\"server_type\"]");
        }
        if (parameters.containsKey("ssl") && !(parameters.get("ssl") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: ssl must be of type String parameters[\"ssl\"]");
        }
        if (parameters.containsKey("username") && !(parameters.get("username") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: username must be of type String parameters[\"username\"]");
        }
        if (parameters.containsKey("google_cloud_storage_bucket") && !(parameters.get("google_cloud_storage_bucket") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: google_cloud_storage_bucket must be of type String parameters[\"google_cloud_storage_bucket\"]");
        }
        if (parameters.containsKey("google_cloud_storage_project_id") && !(parameters.get("google_cloud_storage_project_id") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: google_cloud_storage_project_id must be of type String parameters[\"google_cloud_storage_project_id\"]");
        }
        if (parameters.containsKey("backblaze_b2_bucket") && !(parameters.get("backblaze_b2_bucket") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: backblaze_b2_bucket must be of type String parameters[\"backblaze_b2_bucket\"]");
        }
        if (parameters.containsKey("backblaze_b2_s3_endpoint") && !(parameters.get("backblaze_b2_s3_endpoint") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: backblaze_b2_s3_endpoint must be of type String parameters[\"backblaze_b2_s3_endpoint\"]");
        }
        if (parameters.containsKey("wasabi_bucket") && !(parameters.get("wasabi_bucket") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: wasabi_bucket must be of type String parameters[\"wasabi_bucket\"]");
        }
        if (parameters.containsKey("wasabi_region") && !(parameters.get("wasabi_region") instanceof String ))
        {
            throw new IllegalArgumentException("Bad parameter: wasabi_region must be of type String parameters[\"wasabi_region\"]");
        }
        if (!parameters.containsKey("id") || parameters.get("id") == null)
        {
            throw new NullPointerException("Parameter missing: id parameters[\"id\"]");
        }
        // TODO: Send request
        return null;
    }

    /**
     */
    // TODO: Use types for path_and_primary_params
    public static RemoteServer delete(Long id,  HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        parameters = parameters != null ? parameters : new HashMap<String, Object>();
        options = options != null ? options : new HashMap<String, Object>();

        parameters.put("id", id);
        if (parameters.containsKey("id") && !(parameters.get("id") instanceof Long ))
        {
            throw new IllegalArgumentException("Bad parameter: id must be of type Long parameters[\"id\"]");
        }
        if (!parameters.containsKey("id") || parameters.get("id") == null)
        {
            throw new NullPointerException("Parameter missing: id parameters[\"id\"]");
        }
        // TODO: Send request
        return null;
    }

    public static RemoteServer destroy(Long id, HashMap<String, Object> parameters, HashMap<String, Object> options)
    {
        return delete(id, parameters, options);
    }
}


