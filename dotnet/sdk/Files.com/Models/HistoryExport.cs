
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Files.com.Models
{
    public class HistoryExport
    {
        private Dictionary<string, object> attributes;
        private Dictionary<string, object> options;

        public HistoryExport()
        {
            this.attributes = new Dictionary<string, object>();
            this.options = new Dictionary<string, object>();

            this.attributes.Add("id", null);
            this.attributes.Add("start_at", null);
            this.attributes.Add("end_at", null);
            this.attributes.Add("status", null);
            this.attributes.Add("query_action", null);
            this.attributes.Add("query_interface", null);
            this.attributes.Add("query_user_id", null);
            this.attributes.Add("query_file_id", null);
            this.attributes.Add("query_parent_id", null);
            this.attributes.Add("query_path", null);
            this.attributes.Add("query_folder", null);
            this.attributes.Add("query_src", null);
            this.attributes.Add("query_destination", null);
            this.attributes.Add("query_ip", null);
            this.attributes.Add("query_username", null);
            this.attributes.Add("query_failure_type", null);
            this.attributes.Add("query_target_id", null);
            this.attributes.Add("query_target_name", null);
            this.attributes.Add("query_target_permission", null);
            this.attributes.Add("query_target_user_id", null);
            this.attributes.Add("query_target_username", null);
            this.attributes.Add("query_target_platform", null);
            this.attributes.Add("query_target_permission_set", null);
            this.attributes.Add("user_id", null);
        }

        public HistoryExport(Dictionary<string, object> attributes, Dictionary<string, object> options)
        {
            this.attributes = attributes;
            this.options = options;
        }

        /// <summary>
        /// History Export ID
        /// </summary>
        [JsonPropertyName("id")]
        public Nullable<Int64> Id
        {
            get { return (Nullable<Int64>) attributes["id"]; }
            set { attributes["id"] = value; }
        }

        /// <summary>
        /// Start date/time of export range.
        /// </summary>
        [JsonPropertyName("start_at")]
        public Nullable<DateTime> StartAt
        {
            get { return (Nullable<DateTime>) attributes["start_at"]; }
            set { attributes["start_at"] = value; }
        }

        /// <summary>
        /// End date/time of export range.
        /// </summary>
        [JsonPropertyName("end_at")]
        public Nullable<DateTime> EndAt
        {
            get { return (Nullable<DateTime>) attributes["end_at"]; }
            set { attributes["end_at"] = value; }
        }

        /// <summary>
        /// Status of export.  Will be: `building` or `ready`
        /// </summary>
        [JsonPropertyName("status")]
        public string Status
        {
            get { return (string) attributes["status"]; }
            set { attributes["status"] = value; }
        }

        /// <summary>
        /// Filter results by this this action type. Valid values: `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, `api_key_destroy`
        /// </summary>
        [JsonPropertyName("query_action")]
        public string QueryAction
        {
            get { return (string) attributes["query_action"]; }
            set { attributes["query_action"] = value; }
        }

        /// <summary>
        /// Filter results by this this interface type. Valid values: `web`, `ftp`, `robot`, `jsapi`, `webdesktopapi`, `sftp`, `dav`, `desktop`, `restapi`, `scim`
        /// </summary>
        [JsonPropertyName("query_interface")]
        public string QueryInterface
        {
            get { return (string) attributes["query_interface"]; }
            set { attributes["query_interface"] = value; }
        }

        /// <summary>
        /// Return results that are actions performed by the user indiciated by this User ID
        /// </summary>
        [JsonPropertyName("query_user_id")]
        public Nullable<Int64> QueryUserId
        {
            get { return (Nullable<Int64>) attributes["query_user_id"]; }
            set { attributes["query_user_id"] = value; }
        }

        /// <summary>
        /// Return results that are file actions related to the file indicated by this File ID
        /// </summary>
        [JsonPropertyName("query_file_id")]
        public Nullable<Int64> QueryFileId
        {
            get { return (Nullable<Int64>) attributes["query_file_id"]; }
            set { attributes["query_file_id"] = value; }
        }

        /// <summary>
        /// Return results that are file actions inside the parent folder specified by this folder ID
        /// </summary>
        [JsonPropertyName("query_parent_id")]
        public Nullable<Int64> QueryParentId
        {
            get { return (Nullable<Int64>) attributes["query_parent_id"]; }
            set { attributes["query_parent_id"] = value; }
        }

        /// <summary>
        /// Return results that are file actions related to this path.
        /// </summary>
        [JsonPropertyName("query_path")]
        public string QueryPath
        {
            get { return (string) attributes["query_path"]; }
            set { attributes["query_path"] = value; }
        }

        /// <summary>
        /// Return results that are file actions related to files or folders inside this folder path.
        /// </summary>
        [JsonPropertyName("query_folder")]
        public string QueryFolder
        {
            get { return (string) attributes["query_folder"]; }
            set { attributes["query_folder"] = value; }
        }

        /// <summary>
        /// Return results that are file moves originating from this path.
        /// </summary>
        [JsonPropertyName("query_src")]
        public string QuerySrc
        {
            get { return (string) attributes["query_src"]; }
            set { attributes["query_src"] = value; }
        }

        /// <summary>
        /// Return results that are file moves with this path as destination.
        /// </summary>
        [JsonPropertyName("query_destination")]
        public string QueryDestination
        {
            get { return (string) attributes["query_destination"]; }
            set { attributes["query_destination"] = value; }
        }

        /// <summary>
        /// Filter results by this IP address.
        /// </summary>
        [JsonPropertyName("query_ip")]
        public string QueryIp
        {
            get { return (string) attributes["query_ip"]; }
            set { attributes["query_ip"] = value; }
        }

        /// <summary>
        /// Filter results by this username.
        /// </summary>
        [JsonPropertyName("query_username")]
        public string QueryUsername
        {
            get { return (string) attributes["query_username"]; }
            set { attributes["query_username"] = value; }
        }

        /// <summary>
        /// If searching for Histories about login failures, this parameter restricts results to failures of this specific type.  Valid values: `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, `expired_access`, `desktop_ip_mismatch`, `desktop_api_key_not_used_quickly_enough`, `disabled`
        /// </summary>
        [JsonPropertyName("query_failure_type")]
        public string QueryFailureType
        {
            get { return (string) attributes["query_failure_type"]; }
            set { attributes["query_failure_type"] = value; }
        }

        /// <summary>
        /// If searching for Histories about specific objects (such as Users, or API Keys), this paremeter restricts results to objects that match this ID.
        /// </summary>
        [JsonPropertyName("query_target_id")]
        public Nullable<Int64> QueryTargetId
        {
            get { return (Nullable<Int64>) attributes["query_target_id"]; }
            set { attributes["query_target_id"] = value; }
        }

        /// <summary>
        /// If searching for Histories about Users, Groups or other objects with names, this parameter restricts results to objects with this name/username.
        /// </summary>
        [JsonPropertyName("query_target_name")]
        public string QueryTargetName
        {
            get { return (string) attributes["query_target_name"]; }
            set { attributes["query_target_name"] = value; }
        }

        /// <summary>
        /// If searching for Histories about Permisisons, this parameter restricts results to permissions of this level.
        /// </summary>
        [JsonPropertyName("query_target_permission")]
        public string QueryTargetPermission
        {
            get { return (string) attributes["query_target_permission"]; }
            set { attributes["query_target_permission"] = value; }
        }

        /// <summary>
        /// If searching for Histories about API keys, this parameter restricts results to API keys created by/for this user ID.
        /// </summary>
        [JsonPropertyName("query_target_user_id")]
        public Nullable<Int64> QueryTargetUserId
        {
            get { return (Nullable<Int64>) attributes["query_target_user_id"]; }
            set { attributes["query_target_user_id"] = value; }
        }

        /// <summary>
        /// If searching for Histories about API keys, this parameter restricts results to API keys created by/for this username.
        /// </summary>
        [JsonPropertyName("query_target_username")]
        public string QueryTargetUsername
        {
            get { return (string) attributes["query_target_username"]; }
            set { attributes["query_target_username"] = value; }
        }

        /// <summary>
        /// If searching for Histories about API keys, this parameter restricts results to API keys associated with this platform.
        /// </summary>
        [JsonPropertyName("query_target_platform")]
        public string QueryTargetPlatform
        {
            get { return (string) attributes["query_target_platform"]; }
            set { attributes["query_target_platform"] = value; }
        }

        /// <summary>
        /// If searching for Histories about API keys, this parameter restricts results to API keys with this permission set.
        /// </summary>
        [JsonPropertyName("query_target_permission_set")]
        public string QueryTargetPermissionSet
        {
            get { return (string) attributes["query_target_permission_set"]; }
            set { attributes["query_target_permission_set"] = value; }
        }

        /// <summary>
        /// User ID.  Provide a value of `0` to operate the current session's user.
        /// </summary>
        [JsonPropertyName("user_id")]
        public Nullable<Int64> UserId
        {
            get { return (Nullable<Int64>) attributes["user_id"]; }
            set { attributes["user_id"] = value; }
        }

        /// <summary>
        /// </summary>
        public async Task<HistoryExport> Delete(Dictionary<string, object> parameters)
        {
            // TODO: Fill in operation implementation
            return null;
        }

        public async void Destroy(Dictionary<string, object> parameters)
        {
            Delete(parameters);
        }


        public async Task Save()
        {
            if (this.attributes["id"] != null)
            {
                throw new NotImplementedException("The HistoryExport object doesn't support updates.");
            }
            else
            {
                // TODO: Remove this cast after return types are implemented
                var newObj = (HistoryExport) await HistoryExport.Create(this.attributes, this.options);
                this.attributes = newObj.attributes;
            }
        }

        /// <summary>
        /// Parameters:
        ///   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
        ///   page - integer - Current page number.
        ///   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
        ///   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> List(
            
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            if (parameters.ContainsKey("user_id") && !(parameters["user_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: user_id must be of type Nullable<Int64>", "parameters[\"user_id\"]");
            }
            if (parameters.ContainsKey("page") && !(parameters["page"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: page must be of type Nullable<Int64>", "parameters[\"page\"]");
            }
            if (parameters.ContainsKey("per_page") && !(parameters["per_page"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: per_page must be of type Nullable<Int64>", "parameters[\"per_page\"]");
            }
            if (parameters.ContainsKey("action") && !(parameters["action"] is string ))
            {
                throw new ArgumentException("Bad parameter: action must be of type string", "parameters[\"action\"]");
            }

            string responseJson = await FilesApi.SendRequest("/history_exports", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<HistoryExport[]>(responseJson);
        }

        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> All(
            
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            return await List(parameters, options);
        }

        /// <summary>
        /// Parameters:
        ///   id (required) - integer - History Export ID.
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Find(
            Nullable<Int64> id, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            parameters.Add("id", id);
            if (parameters.ContainsKey("id") && !(parameters["id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: id must be of type Nullable<Int64>", "parameters[\"id\"]");
            }
            if (!parameters.ContainsKey("id") || parameters["id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: id", "parameters[\"id\"]");
            }

            string responseJson = await FilesApi.SendRequest("/history_exports/{id}", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<HistoryExport>(responseJson);
        }

        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Get(
            Nullable<Int64> id, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            return await Find(id, parameters, options);
        }

        /// <summary>
        /// Parameters:
        ///   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
        ///   start_at - string - Start date/time of export range.
        ///   end_at - string - End date/time of export range.
        ///   query_action - string - Filter results by this this action type. Valid values: `create`, `read`, `update`, `destroy`, `move`, `login`, `failedlogin`, `copy`, `user_create`, `user_update`, `user_destroy`, `group_create`, `group_update`, `group_destroy`, `permission_create`, `permission_destroy`, `api_key_create`, `api_key_update`, `api_key_destroy`
        ///   query_interface - string - Filter results by this this interface type. Valid values: `web`, `ftp`, `robot`, `jsapi`, `webdesktopapi`, `sftp`, `dav`, `desktop`, `restapi`, `scim`
        ///   query_user_id - integer - Return results that are actions performed by the user indiciated by this User ID
        ///   query_file_id - integer - Return results that are file actions related to the file indicated by this File ID
        ///   query_parent_id - integer - Return results that are file actions inside the parent folder specified by this folder ID
        ///   query_path - string - Return results that are file actions related to this path.
        ///   query_folder - string - Return results that are file actions related to files or folders inside this folder path.
        ///   query_src - string - Return results that are file moves originating from this path.
        ///   query_destination - string - Return results that are file moves with this path as destination.
        ///   query_ip - string - Filter results by this IP address.
        ///   query_username - string - Filter results by this username.
        ///   query_failure_type - string - If searching for Histories about login failures, this parameter restricts results to failures of this specific type.  Valid values: `expired_trial`, `account_overdue`, `locked_out`, `ip_mismatch`, `password_mismatch`, `site_mismatch`, `username_not_found`, `none`, `no_ftp_permission`, `no_web_permission`, `no_directory`, `errno_enoent`, `no_sftp_permission`, `no_dav_permission`, `no_restapi_permission`, `key_mismatch`, `region_mismatch`, `expired_access`, `desktop_ip_mismatch`, `desktop_api_key_not_used_quickly_enough`, `disabled`
        ///   query_target_id - integer - If searching for Histories about specific objects (such as Users, or API Keys), this paremeter restricts results to objects that match this ID.
        ///   query_target_name - string - If searching for Histories about Users, Groups or other objects with names, this parameter restricts results to objects with this name/username.
        ///   query_target_permission - string - If searching for Histories about Permisisons, this parameter restricts results to permissions of this level.
        ///   query_target_user_id - integer - If searching for Histories about API keys, this parameter restricts results to API keys created by/for this user ID.
        ///   query_target_username - string - If searching for Histories about API keys, this parameter restricts results to API keys created by/for this username.
        ///   query_target_platform - string - If searching for Histories about API keys, this parameter restricts results to API keys associated with this platform.
        ///   query_target_permission_set - string - If searching for Histories about API keys, this parameter restricts results to API keys with this permission set.
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Create(
            
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            if (parameters.ContainsKey("user_id") && !(parameters["user_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: user_id must be of type Nullable<Int64>", "parameters[\"user_id\"]");
            }
            if (parameters.ContainsKey("start_at") && !(parameters["start_at"] is string ))
            {
                throw new ArgumentException("Bad parameter: start_at must be of type string", "parameters[\"start_at\"]");
            }
            if (parameters.ContainsKey("end_at") && !(parameters["end_at"] is string ))
            {
                throw new ArgumentException("Bad parameter: end_at must be of type string", "parameters[\"end_at\"]");
            }
            if (parameters.ContainsKey("query_action") && !(parameters["query_action"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_action must be of type string", "parameters[\"query_action\"]");
            }
            if (parameters.ContainsKey("query_interface") && !(parameters["query_interface"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_interface must be of type string", "parameters[\"query_interface\"]");
            }
            if (parameters.ContainsKey("query_user_id") && !(parameters["query_user_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: query_user_id must be of type Nullable<Int64>", "parameters[\"query_user_id\"]");
            }
            if (parameters.ContainsKey("query_file_id") && !(parameters["query_file_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: query_file_id must be of type Nullable<Int64>", "parameters[\"query_file_id\"]");
            }
            if (parameters.ContainsKey("query_parent_id") && !(parameters["query_parent_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: query_parent_id must be of type Nullable<Int64>", "parameters[\"query_parent_id\"]");
            }
            if (parameters.ContainsKey("query_path") && !(parameters["query_path"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_path must be of type string", "parameters[\"query_path\"]");
            }
            if (parameters.ContainsKey("query_folder") && !(parameters["query_folder"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_folder must be of type string", "parameters[\"query_folder\"]");
            }
            if (parameters.ContainsKey("query_src") && !(parameters["query_src"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_src must be of type string", "parameters[\"query_src\"]");
            }
            if (parameters.ContainsKey("query_destination") && !(parameters["query_destination"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_destination must be of type string", "parameters[\"query_destination\"]");
            }
            if (parameters.ContainsKey("query_ip") && !(parameters["query_ip"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_ip must be of type string", "parameters[\"query_ip\"]");
            }
            if (parameters.ContainsKey("query_username") && !(parameters["query_username"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_username must be of type string", "parameters[\"query_username\"]");
            }
            if (parameters.ContainsKey("query_failure_type") && !(parameters["query_failure_type"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_failure_type must be of type string", "parameters[\"query_failure_type\"]");
            }
            if (parameters.ContainsKey("query_target_id") && !(parameters["query_target_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: query_target_id must be of type Nullable<Int64>", "parameters[\"query_target_id\"]");
            }
            if (parameters.ContainsKey("query_target_name") && !(parameters["query_target_name"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_target_name must be of type string", "parameters[\"query_target_name\"]");
            }
            if (parameters.ContainsKey("query_target_permission") && !(parameters["query_target_permission"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_target_permission must be of type string", "parameters[\"query_target_permission\"]");
            }
            if (parameters.ContainsKey("query_target_user_id") && !(parameters["query_target_user_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: query_target_user_id must be of type Nullable<Int64>", "parameters[\"query_target_user_id\"]");
            }
            if (parameters.ContainsKey("query_target_username") && !(parameters["query_target_username"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_target_username must be of type string", "parameters[\"query_target_username\"]");
            }
            if (parameters.ContainsKey("query_target_platform") && !(parameters["query_target_platform"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_target_platform must be of type string", "parameters[\"query_target_platform\"]");
            }
            if (parameters.ContainsKey("query_target_permission_set") && !(parameters["query_target_permission_set"] is string ))
            {
                throw new ArgumentException("Bad parameter: query_target_permission_set must be of type string", "parameters[\"query_target_permission_set\"]");
            }

            string responseJson = await FilesApi.SendRequest("/history_exports", HttpMethod.Post, parameters, options);

            return JsonSerializer.Deserialize<HistoryExport>(responseJson);
        }


        /// <summary>
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Delete(
            Nullable<Int64> id, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            parameters.Add("id", id);
            if (parameters.ContainsKey("id") && !(parameters["id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: id must be of type Nullable<Int64>", "parameters[\"id\"]");
            }
            if (!parameters.ContainsKey("id") || parameters["id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: id", "parameters[\"id\"]");
            }

            string responseJson = await FilesApi.SendRequest("/history_exports/{id}", HttpMethod.Delete, parameters, options);

            // TODO: Confirm out what needs to be done when it's not an entity to be converted to.
            return responseJson;
        }

        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Destroy(
            Nullable<Int64> id, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            return await Delete(id, parameters, options);
        }

    }
}

