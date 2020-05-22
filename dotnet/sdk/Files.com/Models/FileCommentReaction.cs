
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Files.com.Models
{
    public class FileCommentReaction
    {
        private Dictionary<string, object> attributes;
        private Dictionary<string, object> options;

        public FileCommentReaction()
        {
            this.attributes = new Dictionary<string, object>();
            this.options = new Dictionary<string, object>();

            this.attributes.Add("id", null);
            this.attributes.Add("emoji", null);
            this.attributes.Add("user_id", null);
            this.attributes.Add("file_comment_id", null);
        }

        public FileCommentReaction(Dictionary<string, object> attributes, Dictionary<string, object> options)
        {
            this.attributes = attributes;
            this.options = options;
        }

        /// <summary>
        /// Reaction ID
        /// </summary>
        [JsonPropertyName("id")]
        public Nullable<Int64> Id
        {
            get { return (Nullable<Int64>) attributes["id"]; }
            set { attributes["id"] = value; }
        }

        /// <summary>
        /// Emoji used in the reaction.
        /// </summary>
        [JsonPropertyName("emoji")]
        public string Emoji
        {
            get { return (string) attributes["emoji"]; }
            set { attributes["emoji"] = value; }
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
        /// ID of file comment to attach reaction to.
        /// </summary>
        [JsonPropertyName("file_comment_id")]
        public Nullable<Int64> FileCommentId
        {
            get { return (Nullable<Int64>) attributes["file_comment_id"]; }
            set { attributes["file_comment_id"] = value; }
        }

        /// <summary>
        /// </summary>
        public async Task<FileCommentReaction> Delete(Dictionary<string, object> parameters)
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
                throw new NotImplementedException("The FileCommentReaction object doesn't support updates.");
            }
            else
            {
                // TODO: Remove this cast after return types are implemented
                var newObj = (FileCommentReaction) await FileCommentReaction.Create(this.attributes, this.options);
                this.attributes = newObj.attributes;
            }
        }

        /// <summary>
        /// Parameters:
        ///   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
        ///   file_comment_id (required) - integer - ID of file comment to attach reaction to.
        ///   emoji (required) - string - Emoji to react with.
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
            if (parameters.ContainsKey("file_comment_id") && !(parameters["file_comment_id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: file_comment_id must be of type Nullable<Int64>", "parameters[\"file_comment_id\"]");
            }
            if (parameters.ContainsKey("emoji") && !(parameters["emoji"] is string ))
            {
                throw new ArgumentException("Bad parameter: emoji must be of type string", "parameters[\"emoji\"]");
            }
            if (!parameters.ContainsKey("file_comment_id") || parameters["file_comment_id"] == null)
            {
                throw new ArgumentNullException("Parameter missing: file_comment_id", "parameters[\"file_comment_id\"]");
            }
            if (!parameters.ContainsKey("emoji") || parameters["emoji"] == null)
            {
                throw new ArgumentNullException("Parameter missing: emoji", "parameters[\"emoji\"]");
            }

            string responseJson = await FilesApi.SendRequest("/file_comment_reactions", HttpMethod.Post, parameters, options);

            return JsonSerializer.Deserialize<FileCommentReaction>(responseJson);
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

            string responseJson = await FilesApi.SendRequest("/file_comment_reactions/{id}", HttpMethod.Delete, parameters, options);

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

