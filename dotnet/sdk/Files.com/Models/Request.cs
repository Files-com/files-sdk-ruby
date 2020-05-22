
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Files.com.Models
{
    public class Request
    {
        private Dictionary<string, object> attributes;
        private Dictionary<string, object> options;

        public Request()
        {
            this.attributes = new Dictionary<string, object>();
            this.options = new Dictionary<string, object>();

            this.attributes.Add("id", null);
            this.attributes.Add("path", null);
            this.attributes.Add("source", null);
            this.attributes.Add("destination", null);
            this.attributes.Add("automation_id", null);
            this.attributes.Add("user_display_name", null);
            this.attributes.Add("user_ids", null);
            this.attributes.Add("group_ids", null);
        }

        public Request(Dictionary<string, object> attributes, Dictionary<string, object> options)
        {
            this.attributes = attributes;
            this.options = options;
        }

        /// <summary>
        /// Request ID
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
        /// Source filename, if applicable
        /// </summary>
        [JsonPropertyName("source")]
        public string Source
        {
            get { return (string) attributes["source"]; }
            set { attributes["source"] = value; }
        }

        /// <summary>
        /// Destination filename
        /// </summary>
        [JsonPropertyName("destination")]
        public string Destination
        {
            get { return (string) attributes["destination"]; }
            set { attributes["destination"] = value; }
        }

        /// <summary>
        /// ID of automation that created request
        /// </summary>
        [JsonPropertyName("automation_id")]
        public string AutomationId
        {
            get { return (string) attributes["automation_id"]; }
            set { attributes["automation_id"] = value; }
        }

        /// <summary>
        /// User making the request (if applicable)
        /// </summary>
        [JsonPropertyName("user_display_name")]
        public string UserDisplayName
        {
            get { return (string) attributes["user_display_name"]; }
            set { attributes["user_display_name"] = value; }
        }

        /// <summary>
        /// A list of user IDs to request the file from. If sent as a string, it should be comma-delimited.
        /// </summary>
        [JsonPropertyName("user_ids")]
        public string UserIds
        {
            get { return (string) attributes["user_ids"]; }
            set { attributes["user_ids"] = value; }
        }

        /// <summary>
        /// A list of group IDs to request the file from. If sent as a string, it should be comma-delimited.
        /// </summary>
        [JsonPropertyName("group_ids")]
        public string GroupIds
        {
            get { return (string) attributes["group_ids"]; }
            set { attributes["group_ids"] = value; }
        }

        /// <summary>
        /// List Requests
        ///
        /// Parameters:
        ///   page - integer - Current page number.
        ///   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
        ///   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
        ///   mine - boolean - Only show requests of the current user?  (Defaults to true if current user is not a site admin.)
        /// </summary>
        public async Task<Request> Folders(Dictionary<string, object> parameters)
        {
            // TODO: Fill in operation implementation
            return null;
        }



        public async Task Save()
        {
            if (this.attributes["path"] != null)
            {
                throw new NotImplementedException("The Request object doesn't support updates.");
            }
            else
            {
                // TODO: Remove this cast after return types are implemented
                var newObj = (Request) await Request.Create(this.attributes, this.options);
                this.attributes = newObj.attributes;
            }
        }

        /// <summary>
        /// Parameters:
        ///   page - integer - Current page number.
        ///   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
        ///   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
        ///   mine - boolean - Only show requests of the current user?  (Defaults to true if current user is not a site admin.)
        ///   path - string - Path to show requests for.  If omitted, shows all paths. Send `/` to represent the root directory.
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
            if (parameters.ContainsKey("mine") && !(parameters["mine"] is bool ))
            {
                throw new ArgumentException("Bad parameter: mine must be of type bool", "parameters[\"mine\"]");
            }
            if (parameters.ContainsKey("path") && !(parameters["path"] is string ))
            {
                throw new ArgumentException("Bad parameter: path must be of type string", "parameters[\"path\"]");
            }

            string responseJson = await FilesApi.SendRequest("/requests", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<Request[]>(responseJson);
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
        /// List Requests
        ///
        /// Parameters:
        ///   page - integer - Current page number.
        ///   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
        ///   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
        ///   mine - boolean - Only show requests of the current user?  (Defaults to true if current user is not a site admin.)
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Folders(
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
            if (parameters.ContainsKey("mine") && !(parameters["mine"] is bool ))
            {
                throw new ArgumentException("Bad parameter: mine must be of type bool", "parameters[\"mine\"]");
            }
            if (parameters.ContainsKey("path") && !(parameters["path"] is string ))
            {
                throw new ArgumentException("Bad parameter: path must be of type string", "parameters[\"path\"]");
            }

            string responseJson = await FilesApi.SendRequest("/requests/folders/?*path", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<Request[]>(responseJson);
        }


        /// <summary>
        /// Parameters:
        ///   path (required) - string - Folder path on which to request the file.
        ///   destination (required) - string - Destination filename (without extension) to request.
        ///   user_ids - string - A list of user IDs to request the file from. If sent as a string, it should be comma-delimited.
        ///   group_ids - string - A list of group IDs to request the file from. If sent as a string, it should be comma-delimited.
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
            if (parameters.ContainsKey("path") && !(parameters["path"] is string ))
            {
                throw new ArgumentException("Bad parameter: path must be of type string", "parameters[\"path\"]");
            }
            if (parameters.ContainsKey("destination") && !(parameters["destination"] is string ))
            {
                throw new ArgumentException("Bad parameter: destination must be of type string", "parameters[\"destination\"]");
            }
            if (parameters.ContainsKey("user_ids") && !(parameters["user_ids"] is string ))
            {
                throw new ArgumentException("Bad parameter: user_ids must be of type string", "parameters[\"user_ids\"]");
            }
            if (parameters.ContainsKey("group_ids") && !(parameters["group_ids"] is string ))
            {
                throw new ArgumentException("Bad parameter: group_ids must be of type string", "parameters[\"group_ids\"]");
            }
            if (!parameters.ContainsKey("path") || parameters["path"] == null)
            {
                throw new ArgumentNullException("Parameter missing: path", "parameters[\"path\"]");
            }
            if (!parameters.ContainsKey("destination") || parameters["destination"] == null)
            {
                throw new ArgumentNullException("Parameter missing: destination", "parameters[\"destination\"]");
            }

            string responseJson = await FilesApi.SendRequest("/requests", HttpMethod.Post, parameters, options);

            return JsonSerializer.Deserialize<Request>(responseJson);
        }


        /// <summary>
        /// Parameters:
        ///   id (required) - integer - Request ID.
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

            string responseJson = await FilesApi.SendRequest("/requests/{id}", HttpMethod.Delete, parameters, options);

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

