
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Files.com.Models
{
    public class Permission
    {
        private Dictionary<string, object> attributes;
        private Dictionary<string, object> options;

        public Permission()
        {
            this.attributes = new Dictionary<string, object>();
            this.options = new Dictionary<string, object>();

            this.attributes.Add("id", null);
            this.attributes.Add("path", null);
            this.attributes.Add("user_id", null);
            this.attributes.Add("username", null);
            this.attributes.Add("group_id", null);
            this.attributes.Add("group_name", null);
            this.attributes.Add("permission", null);
            this.attributes.Add("recursive", false);
        }

        public Permission(Dictionary<string, object> attributes, Dictionary<string, object> options)
        {
            this.attributes = attributes;
            this.options = options;
        }

        /// <summary>
        /// Permission ID
        /// </summary>
        [JsonPropertyName("id")]
        public Nullable<Int64> Id
        {
            get { return (Nullable<Int64>) attributes["id"]; }
            set { attributes["id"] = value; }
        }

        /// <summary>
        /// Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
        /// </summary>
        [JsonPropertyName("path")]
        public string Path
        {
            get { return (string) attributes["path"]; }
            set { attributes["path"] = value; }
        }

        /// <summary>
        /// User ID
        /// </summary>
        [JsonPropertyName("user_id")]
        public Nullable<Int64> UserId
        {
            get { return (Nullable<Int64>) attributes["user_id"]; }
            set { attributes["user_id"] = value; }
        }

        /// <summary>
        /// User's username
        /// </summary>
        [JsonPropertyName("username")]
        public string Username
        {
            get { return (string) attributes["username"]; }
            set { attributes["username"] = value; }
        }

        /// <summary>
        /// Group ID
        /// </summary>
        [JsonPropertyName("group_id")]
        public Nullable<Int64> GroupId
        {
            get { return (Nullable<Int64>) attributes["group_id"]; }
            set { attributes["group_id"] = value; }
        }

        /// <summary>
        /// Group name if applicable
        /// </summary>
        [JsonPropertyName("group_name")]
        public string GroupName
        {
            get { return (string) attributes["group_name"]; }
            set { attributes["group_name"] = value; }
        }

        /// <summary>
        /// Permission type
        /// </summary>
        [JsonPropertyName("permission")]
        public string PermissionType
        {
            get { return (string) attributes["permission"]; }
            set { attributes["permission"] = value; }
        }

        /// <summary>
        /// Does this permission apply to subfolders?
        /// </summary>
        [JsonPropertyName("recursive")]
        public bool Recursive
        {
            get { return (bool) attributes["recursive"]; }
            set { attributes["recursive"] = value; }
        }


        public async Task Save()
        {
            if (this.attributes["path"] != null)
            {
                throw new NotImplementedException("The Permission object doesn't support updates.");
            }
            else
            {
                // TODO: Remove this cast after return types are implemented
                var newObj = (Permission) await Permission.Create(this.attributes, this.options);
                this.attributes = newObj.attributes;
            }
        }

        /// <summary>
        /// Parameters:
        ///   page - integer - Current page number.
        ///   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
        ///   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
        ///   path - string - Permission path.  If provided, will scope permissions to this path.
        ///   group_id - string - Group ID.  If provided, will scope permissions to this group.
        ///   user_id - string - User ID.  If provided, will scope permissions to this user.
        ///   include_groups - boolean - If searching by user or group, also include user's permissions that are inherited from its groups?
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> List(
            string path, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            parameters.Add("path", path);
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
            if (parameters.ContainsKey("path") && !(parameters["path"] is string ))
            {
                throw new ArgumentException("Bad parameter: path must be of type string", "parameters[\"path\"]");
            }
            if (parameters.ContainsKey("group_id") && !(parameters["group_id"] is string ))
            {
                throw new ArgumentException("Bad parameter: group_id must be of type string", "parameters[\"group_id\"]");
            }
            if (parameters.ContainsKey("user_id") && !(parameters["user_id"] is string ))
            {
                throw new ArgumentException("Bad parameter: user_id must be of type string", "parameters[\"user_id\"]");
            }
            if (parameters.ContainsKey("include_groups") && !(parameters["include_groups"] is bool ))
            {
                throw new ArgumentException("Bad parameter: include_groups must be of type bool", "parameters[\"include_groups\"]");
            }

            string responseJson = await FilesApi.SendRequest("/permissions", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<Permission[]>(responseJson);
        }

        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> All(
            string path, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            return await List(path, parameters, options);
        }

        /// <summary>
        /// Parameters:
        ///   group_id - integer - Group ID
        ///   path - string - Folder path
        ///   permission - string -  Permission type.  Can be `admin`, `full`, `readonly`, `writeonly`, `previewonly`, or `history`
        ///   recursive - boolean - Apply to subfolders recursively?
        ///   user_id - integer - User ID.  Provide `username` or `user_id`
        ///   username - string - User username.  Provide `username` or `user_id`
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Create(
            string path, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            parameters = parameters != null ? parameters : new Dictionary<string, object>();
            options = options != null ? options : new Dictionary<string, object>();

            parameters.Add("path", path);
            if (parameters.ContainsKey("group_id") && !(parameters["group_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: group_id must be of type Nullable<Int64>", "parameters[\"group_id\"]");
            }
            if (parameters.ContainsKey("path") && !(parameters["path"] is string ))
            {
                throw new ArgumentException("Bad parameter: path must be of type string", "parameters[\"path\"]");
            }
            if (parameters.ContainsKey("permission") && !(parameters["permission"] is string ))
            {
                throw new ArgumentException("Bad parameter: permission must be of type string", "parameters[\"permission\"]");
            }
            if (parameters.ContainsKey("recursive") && !(parameters["recursive"] is bool ))
            {
                throw new ArgumentException("Bad parameter: recursive must be of type bool", "parameters[\"recursive\"]");
            }
            if (parameters.ContainsKey("user_id") && !(parameters["user_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: user_id must be of type Nullable<Int64>", "parameters[\"user_id\"]");
            }
            if (parameters.ContainsKey("username") && !(parameters["username"] is string ))
            {
                throw new ArgumentException("Bad parameter: username must be of type string", "parameters[\"username\"]");
            }

            string responseJson = await FilesApi.SendRequest("/permissions", HttpMethod.Post, parameters, options);

            return JsonSerializer.Deserialize<Permission>(responseJson);
        }


        /// <summary>
        /// Parameters:
        ///   id (required) - integer - Permission ID.
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

            string responseJson = await FilesApi.SendRequest("/permissions/{id}", HttpMethod.Delete, parameters, options);

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

