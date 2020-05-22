
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Files.com.Models
{
    public class Notification
    {
        private Dictionary<string, object> attributes;
        private Dictionary<string, object> options;

        public Notification()
        {
            this.attributes = new Dictionary<string, object>();
            this.options = new Dictionary<string, object>();

            this.attributes.Add("id", null);
            this.attributes.Add("path", null);
            this.attributes.Add("group_id", null);
            this.attributes.Add("group_name", null);
            this.attributes.Add("notify_user_actions", false);
            this.attributes.Add("notify_on_copy", false);
            this.attributes.Add("send_interval", null);
            this.attributes.Add("unsubscribed", false);
            this.attributes.Add("unsubscribed_reason", null);
            this.attributes.Add("user_id", null);
            this.attributes.Add("username", null);
            this.attributes.Add("suppressed_email", false);
        }

        public Notification(Dictionary<string, object> attributes, Dictionary<string, object> options)
        {
            this.attributes = attributes;
            this.options = options;
        }

        /// <summary>
        /// Notification ID
        /// </summary>
        [JsonPropertyName("id")]
        public Nullable<Int64> Id
        {
            get { return (Nullable<Int64>) attributes["id"]; }
            set { attributes["id"] = value; }
        }

        /// <summary>
        /// Folder path to notify on This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
        /// </summary>
        [JsonPropertyName("path")]
        public string Path
        {
            get { return (string) attributes["path"]; }
            set { attributes["path"] = value; }
        }

        /// <summary>
        /// Notification group id
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
        /// Trigger notification on notification user actions?
        /// </summary>
        [JsonPropertyName("notify_user_actions")]
        public bool NotifyUserActions
        {
            get { return (bool) attributes["notify_user_actions"]; }
            set { attributes["notify_user_actions"] = value; }
        }

        /// <summary>
        /// Triggers notification when moving or copying files to this path
        /// </summary>
        [JsonPropertyName("notify_on_copy")]
        public bool NotifyOnCopy
        {
            get { return (bool) attributes["notify_on_copy"]; }
            set { attributes["notify_on_copy"] = value; }
        }

        /// <summary>
        /// The time interval that notifications are aggregated to
        /// </summary>
        [JsonPropertyName("send_interval")]
        public string SendInterval
        {
            get { return (string) attributes["send_interval"]; }
            set { attributes["send_interval"] = value; }
        }

        /// <summary>
        /// Is the user unsubscribed from this notification?
        /// </summary>
        [JsonPropertyName("unsubscribed")]
        public bool Unsubscribed
        {
            get { return (bool) attributes["unsubscribed"]; }
            set { attributes["unsubscribed"] = value; }
        }

        /// <summary>
        /// The reason that the user unsubscribed
        /// </summary>
        [JsonPropertyName("unsubscribed_reason")]
        public string UnsubscribedReason
        {
            get { return (string) attributes["unsubscribed_reason"]; }
            set { attributes["unsubscribed_reason"] = value; }
        }

        /// <summary>
        /// Notification user ID
        /// </summary>
        [JsonPropertyName("user_id")]
        public Nullable<Int64> UserId
        {
            get { return (Nullable<Int64>) attributes["user_id"]; }
            set { attributes["user_id"] = value; }
        }

        /// <summary>
        /// Notification username
        /// </summary>
        [JsonPropertyName("username")]
        public string Username
        {
            get { return (string) attributes["username"]; }
            set { attributes["username"] = value; }
        }

        /// <summary>
        /// If true, it means that the recipient at this user's email address has manually unsubscribed from all emails, or had their email "hard bounce", which means that we are unable to send mail to this user's current email address. Notifications will resume if the user changes their email address.
        /// </summary>
        [JsonPropertyName("suppressed_email")]
        public bool SuppressedEmail
        {
            get { return (bool) attributes["suppressed_email"]; }
            set { attributes["suppressed_email"] = value; }
        }

        /// <summary>
        /// Parameters:
        ///   notify_on_copy - boolean - If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
        ///   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
        ///   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
        /// </summary>
        public async Task<Notification> Update(Dictionary<string, object> parameters)
        {
            // TODO: Fill in operation implementation
            return null;
        }


        /// <summary>
        /// </summary>
        public async Task<Notification> Delete(Dictionary<string, object> parameters)
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
                await this.Update(this.attributes);
            }
            else
            {
                // TODO: Remove this cast after return types are implemented
                var newObj = (Notification) await Notification.Create(this.attributes, this.options);
                this.attributes = newObj.attributes;
            }
        }

        /// <summary>
        /// Parameters:
        ///   user_id - integer - Show notifications for this User ID.
        ///   page - integer - Current page number.
        ///   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
        ///   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
        ///   group_id - integer - Show notifications for this Group ID.
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
            if (parameters.ContainsKey("group_id") && !(parameters["group_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: group_id must be of type Nullable<Int64>", "parameters[\"group_id\"]");
            }

            string responseJson = await FilesApi.SendRequest("/notifications", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<Notification[]>(responseJson);
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
        ///   id (required) - integer - Notification ID.
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

            string responseJson = await FilesApi.SendRequest("/notifications/{id}", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<Notification>(responseJson);
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
        ///   user_id - integer - The id of the user to notify. Provide `user_id`, `username` or `group_id`.
        ///   notify_on_copy - boolean - If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
        ///   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
        ///   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
        ///   group_id - integer - The ID of the group to notify.  Provide `user_id`, `username` or `group_id`.
        ///   path - string - Path
        ///   username - string - The username of the user to notify.  Provide `user_id`, `username` or `group_id`.
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
            if (parameters.ContainsKey("notify_on_copy") && !(parameters["notify_on_copy"] is bool ))
            {
                throw new ArgumentException("Bad parameter: notify_on_copy must be of type bool", "parameters[\"notify_on_copy\"]");
            }
            if (parameters.ContainsKey("notify_user_actions") && !(parameters["notify_user_actions"] is bool ))
            {
                throw new ArgumentException("Bad parameter: notify_user_actions must be of type bool", "parameters[\"notify_user_actions\"]");
            }
            if (parameters.ContainsKey("send_interval") && !(parameters["send_interval"] is string ))
            {
                throw new ArgumentException("Bad parameter: send_interval must be of type string", "parameters[\"send_interval\"]");
            }
            if (parameters.ContainsKey("group_id") && !(parameters["group_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: group_id must be of type Nullable<Int64>", "parameters[\"group_id\"]");
            }
            if (parameters.ContainsKey("path") && !(parameters["path"] is string ))
            {
                throw new ArgumentException("Bad parameter: path must be of type string", "parameters[\"path\"]");
            }
            if (parameters.ContainsKey("username") && !(parameters["username"] is string ))
            {
                throw new ArgumentException("Bad parameter: username must be of type string", "parameters[\"username\"]");
            }

            string responseJson = await FilesApi.SendRequest("/notifications", HttpMethod.Post, parameters, options);

            return JsonSerializer.Deserialize<Notification>(responseJson);
        }


        /// <summary>
        /// Parameters:
        ///   notify_on_copy - boolean - If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
        ///   notify_user_actions - boolean - If `true` actions initiated by the user will still result in a notification
        ///   send_interval - string - The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Update(
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
            if (parameters.ContainsKey("notify_on_copy") && !(parameters["notify_on_copy"] is bool ))
            {
                throw new ArgumentException("Bad parameter: notify_on_copy must be of type bool", "parameters[\"notify_on_copy\"]");
            }
            if (parameters.ContainsKey("notify_user_actions") && !(parameters["notify_user_actions"] is bool ))
            {
                throw new ArgumentException("Bad parameter: notify_user_actions must be of type bool", "parameters[\"notify_user_actions\"]");
            }
            if (parameters.ContainsKey("send_interval") && !(parameters["send_interval"] is string ))
            {
                throw new ArgumentException("Bad parameter: send_interval must be of type string", "parameters[\"send_interval\"]");
            }
            if (!parameters.ContainsKey("id") || parameters["id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: id", "parameters[\"id\"]");
            }

            string responseJson = await FilesApi.SendRequest("/notifications/{id}", HttpMethod.Patch, parameters, options);

            return JsonSerializer.Deserialize<Notification>(responseJson);
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

            string responseJson = await FilesApi.SendRequest("/notifications/{id}", HttpMethod.Delete, parameters, options);

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

