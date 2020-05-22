
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Files.com.Models
{
    public class Message
    {
        private Dictionary<string, object> attributes;
        private Dictionary<string, object> options;

        public Message()
        {
            this.attributes = new Dictionary<string, object>();
            this.options = new Dictionary<string, object>();

            this.attributes.Add("id", null);
            this.attributes.Add("subject", null);
            this.attributes.Add("body", null);
            this.attributes.Add("comments", new object[0]);
            this.attributes.Add("user_id", null);
            this.attributes.Add("project_id", null);
        }

        public Message(Dictionary<string, object> attributes, Dictionary<string, object> options)
        {
            this.attributes = attributes;
            this.options = options;
        }

        /// <summary>
        /// Message ID
        /// </summary>
        [JsonPropertyName("id")]
        public Nullable<Int64> Id
        {
            get { return (Nullable<Int64>) attributes["id"]; }
            set { attributes["id"] = value; }
        }

        /// <summary>
        /// Message subject.
        /// </summary>
        [JsonPropertyName("subject")]
        public string Subject
        {
            get { return (string) attributes["subject"]; }
            set { attributes["subject"] = value; }
        }

        /// <summary>
        /// Message body.
        /// </summary>
        [JsonPropertyName("body")]
        public string Body
        {
            get { return (string) attributes["body"]; }
            set { attributes["body"] = value; }
        }

        /// <summary>
        /// Comments.
        /// </summary>
        [JsonPropertyName("comments")]
        public object[] Comments
        {
            get { return (object[]) attributes["comments"]; }
            set { attributes["comments"] = value; }
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
        /// Project to attach the message to.
        /// </summary>
        [JsonPropertyName("project_id")]
        public Nullable<Int64> ProjectId
        {
            get { return (Nullable<Int64>) attributes["project_id"]; }
            set { attributes["project_id"] = value; }
        }

        /// <summary>
        /// Parameters:
        ///   project_id (required) - integer - Project to attach the message to.
        ///   subject (required) - string - Message subject.
        ///   body (required) - string - Message body.
        /// </summary>
        public async Task<Message> Update(Dictionary<string, object> parameters)
        {
            // TODO: Fill in operation implementation
            return null;
        }


        /// <summary>
        /// </summary>
        public async Task<Message> Delete(Dictionary<string, object> parameters)
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
                var newObj = (Message) await Message.Create(this.attributes, this.options);
                this.attributes = newObj.attributes;
            }
        }

        /// <summary>
        /// Parameters:
        ///   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
        ///   page - integer - Current page number.
        ///   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
        ///   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
        ///   project_id (required) - integer - Project to return messages for.
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
            if (parameters.ContainsKey("project_id") && !(parameters["project_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: project_id must be of type Nullable<Int64>", "parameters[\"project_id\"]");
            }
            if (!parameters.ContainsKey("project_id") || parameters["project_id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: project_id", "parameters[\"project_id\"]");
            }

            string responseJson = await FilesApi.SendRequest("/messages", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<Message[]>(responseJson);
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
        ///   id (required) - integer - Message ID.
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

            string responseJson = await FilesApi.SendRequest("/messages/{id}", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<Message>(responseJson);
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
        ///   project_id (required) - integer - Project to attach the message to.
        ///   subject (required) - string - Message subject.
        ///   body (required) - string - Message body.
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
            if (parameters.ContainsKey("project_id") && !(parameters["project_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: project_id must be of type Nullable<Int64>", "parameters[\"project_id\"]");
            }
            if (parameters.ContainsKey("subject") && !(parameters["subject"] is string ))
            {
                throw new ArgumentException("Bad parameter: subject must be of type string", "parameters[\"subject\"]");
            }
            if (parameters.ContainsKey("body") && !(parameters["body"] is string ))
            {
                throw new ArgumentException("Bad parameter: body must be of type string", "parameters[\"body\"]");
            }
            if (!parameters.ContainsKey("project_id") || parameters["project_id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: project_id", "parameters[\"project_id\"]");
            }
            if (!parameters.ContainsKey("subject") || parameters["subject"] == null)
            {
                throw new ArgumentNullException("Parameter missing: subject", "parameters[\"subject\"]");
            }
            if (!parameters.ContainsKey("body") || parameters["body"] == null)
            {
                throw new ArgumentNullException("Parameter missing: body", "parameters[\"body\"]");
            }

            string responseJson = await FilesApi.SendRequest("/messages", HttpMethod.Post, parameters, options);

            return JsonSerializer.Deserialize<Message>(responseJson);
        }


        /// <summary>
        /// Parameters:
        ///   project_id (required) - integer - Project to attach the message to.
        ///   subject (required) - string - Message subject.
        ///   body (required) - string - Message body.
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
            if (parameters.ContainsKey("project_id") && !(parameters["project_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: project_id must be of type Nullable<Int64>", "parameters[\"project_id\"]");
            }
            if (parameters.ContainsKey("subject") && !(parameters["subject"] is string ))
            {
                throw new ArgumentException("Bad parameter: subject must be of type string", "parameters[\"subject\"]");
            }
            if (parameters.ContainsKey("body") && !(parameters["body"] is string ))
            {
                throw new ArgumentException("Bad parameter: body must be of type string", "parameters[\"body\"]");
            }
            if (!parameters.ContainsKey("id") || parameters["id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: id", "parameters[\"id\"]");
            }
            if (!parameters.ContainsKey("project_id") || parameters["project_id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: project_id", "parameters[\"project_id\"]");
            }
            if (!parameters.ContainsKey("subject") || parameters["subject"] == null)
            {
                throw new ArgumentNullException("Parameter missing: subject", "parameters[\"subject\"]");
            }
            if (!parameters.ContainsKey("body") || parameters["body"] == null)
            {
                throw new ArgumentNullException("Parameter missing: body", "parameters[\"body\"]");
            }

            string responseJson = await FilesApi.SendRequest("/messages/{id}", HttpMethod.Patch, parameters, options);

            return JsonSerializer.Deserialize<Message>(responseJson);
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

            string responseJson = await FilesApi.SendRequest("/messages/{id}", HttpMethod.Delete, parameters, options);

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

