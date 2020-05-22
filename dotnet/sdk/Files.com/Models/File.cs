
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Files.com.Models
{
    public class File
    {
        private Dictionary<string, object> attributes;
        private Dictionary<string, object> options;

        public File()
        {
            this.attributes = new Dictionary<string, object>();
            this.options = new Dictionary<string, object>();

            this.attributes.Add("id", null);
            this.attributes.Add("path", null);
            this.attributes.Add("display_name", null);
            this.attributes.Add("type", null);
            this.attributes.Add("size", null);
            this.attributes.Add("mtime", null);
            this.attributes.Add("provided_mtime", null);
            this.attributes.Add("crc32", null);
            this.attributes.Add("md5", null);
            this.attributes.Add("mime_type", null);
            this.attributes.Add("region", null);
            this.attributes.Add("permissions", null);
            this.attributes.Add("subfolders_locked?", false);
            this.attributes.Add("download_uri", null);
            this.attributes.Add("priority_color", null);
            this.attributes.Add("preview_id", null);
            this.attributes.Add("preview", null);
            this.attributes.Add("action", null);
            this.attributes.Add("length", null);
            this.attributes.Add("mkdir_parents", false);
            this.attributes.Add("part", null);
            this.attributes.Add("parts", null);
            this.attributes.Add("ref", null);
            this.attributes.Add("restart", null);
            this.attributes.Add("structure", null);
            this.attributes.Add("with_rename", false);
        }

        public File(Dictionary<string, object> attributes, Dictionary<string, object> options)
        {
            this.attributes = attributes;
            this.options = options;
        }

        /// <summary>
        /// File/Folder ID
        /// </summary>
        [JsonPropertyName("id")]
        public Nullable<Int64> Id
        {
            get { return (Nullable<Int64>) attributes["id"]; }
            set { attributes["id"] = value; }
        }

        /// <summary>
        /// File/Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
        /// </summary>
        [JsonPropertyName("path")]
        public string Path
        {
            get { return (string) attributes["path"]; }
            set { attributes["path"] = value; }
        }

        /// <summary>
        /// File/Folder display name
        /// </summary>
        [JsonPropertyName("display_name")]
        public string DisplayName
        {
            get { return (string) attributes["display_name"]; }
            set { attributes["display_name"] = value; }
        }

        /// <summary>
        /// Type: `directory` or `file`.
        /// </summary>
        [JsonPropertyName("type")]
        public string Type
        {
            get { return (string) attributes["type"]; }
            set { attributes["type"] = value; }
        }

        /// <summary>
        /// File/Folder size
        /// </summary>
        [JsonPropertyName("size")]
        public Nullable<Int64> Size
        {
            get { return (Nullable<Int64>) attributes["size"]; }
            set { attributes["size"] = value; }
        }

        /// <summary>
        /// File last modified date/time, according to the server.  This is the timestamp of the last Files.com operation of the file, regardless of what modified timestamp was sent.
        /// </summary>
        [JsonPropertyName("mtime")]
        public Nullable<DateTime> Mtime
        {
            get { return (Nullable<DateTime>) attributes["mtime"]; }
            set { attributes["mtime"] = value; }
        }

        /// <summary>
        /// File last modified date/time, according to the client who set it.  Files.com allows desktop, FTP, SFTP, and WebDAV clients to set modified at times.  This allows Desktop<->Cloud syncing to preserve modified at times.
        /// </summary>
        [JsonPropertyName("provided_mtime")]
        public Nullable<DateTime> ProvidedMtime
        {
            get { return (Nullable<DateTime>) attributes["provided_mtime"]; }
            set { attributes["provided_mtime"] = value; }
        }

        /// <summary>
        /// File CRC32 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
        /// </summary>
        [JsonPropertyName("crc32")]
        public string Crc32
        {
            get { return (string) attributes["crc32"]; }
            set { attributes["crc32"] = value; }
        }

        /// <summary>
        /// File MD5 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
        /// </summary>
        [JsonPropertyName("md5")]
        public string Md5
        {
            get { return (string) attributes["md5"]; }
            set { attributes["md5"] = value; }
        }

        /// <summary>
        /// MIME Type.  This is determined by the filename extension and is not stored separately internally.
        /// </summary>
        [JsonPropertyName("mime_type")]
        public string MimeType
        {
            get { return (string) attributes["mime_type"]; }
            set { attributes["mime_type"] = value; }
        }

        /// <summary>
        /// Region location
        /// </summary>
        [JsonPropertyName("region")]
        public string Region
        {
            get { return (string) attributes["region"]; }
            set { attributes["region"] = value; }
        }

        /// <summary>
        /// A short string representing the current user's permissions.  Can be `r`,`w`,`p`, or any combination
        /// </summary>
        [JsonPropertyName("permissions")]
        public string Permissions
        {
            get { return (string) attributes["permissions"]; }
            set { attributes["permissions"] = value; }
        }

        /// <summary>
        /// Are subfolders locked and unable to be modified?
        /// </summary>
        [JsonPropertyName("subfolders_locked?")]
        public bool SubfoldersLocked
        {
            get { return (bool) attributes["subfolders_locked?"]; }
            set { attributes["subfolders_locked?"] = value; }
        }

        /// <summary>
        /// Link to download file. Provided only in response to a download request.
        /// </summary>
        [JsonPropertyName("download_uri")]
        public string DownloadUri
        {
            get { return (string) attributes["download_uri"]; }
            set { attributes["download_uri"] = value; }
        }

        /// <summary>
        /// Bookmark/priority color of file/folder
        /// </summary>
        [JsonPropertyName("priority_color")]
        public string PriorityColor
        {
            get { return (string) attributes["priority_color"]; }
            set { attributes["priority_color"] = value; }
        }

        /// <summary>
        /// File preview ID
        /// </summary>
        [JsonPropertyName("preview_id")]
        public Nullable<Int64> PreviewId
        {
            get { return (Nullable<Int64>) attributes["preview_id"]; }
            set { attributes["preview_id"] = value; }
        }

        /// <summary>
        /// File preview
        /// </summary>
        [JsonPropertyName("preview")]
        public object Preview
        {
            get { return (object) attributes["preview"]; }
            set { attributes["preview"] = value; }
        }

        /// <summary>
        /// The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
        /// </summary>
        [JsonPropertyName("action")]
        public string Action
        {
            get { return (string) attributes["action"]; }
            set { attributes["action"] = value; }
        }

        /// <summary>
        /// Length of file.
        /// </summary>
        [JsonPropertyName("length")]
        public Nullable<Int64> Length
        {
            get { return (Nullable<Int64>) attributes["length"]; }
            set { attributes["length"] = value; }
        }

        /// <summary>
        /// Create parent directories if they do not exist?
        /// </summary>
        [JsonPropertyName("mkdir_parents")]
        public bool MkdirParents
        {
            get { return (bool) attributes["mkdir_parents"]; }
            set { attributes["mkdir_parents"] = value; }
        }

        /// <summary>
        /// Part if uploading a part.
        /// </summary>
        [JsonPropertyName("part")]
        public Nullable<Int64> Part
        {
            get { return (Nullable<Int64>) attributes["part"]; }
            set { attributes["part"] = value; }
        }

        /// <summary>
        /// How many parts to fetch?
        /// </summary>
        [JsonPropertyName("parts")]
        public Nullable<Int64> Parts
        {
            get { return (Nullable<Int64>) attributes["parts"]; }
            set { attributes["parts"] = value; }
        }

        /// <summary>
        /// </summary>
        [JsonPropertyName("ref")]
        public string Ref
        {
            get { return (string) attributes["ref"]; }
            set { attributes["ref"] = value; }
        }

        /// <summary>
        /// File byte offset to restart from.
        /// </summary>
        [JsonPropertyName("restart")]
        public Nullable<Int64> Restart
        {
            get { return (Nullable<Int64>) attributes["restart"]; }
            set { attributes["restart"] = value; }
        }

        /// <summary>
        /// If copying folder, copy just the structure?
        /// </summary>
        [JsonPropertyName("structure")]
        public string Structure
        {
            get { return (string) attributes["structure"]; }
            set { attributes["structure"] = value; }
        }

        /// <summary>
        /// Allow file rename instead of overwrite?
        /// </summary>
        [JsonPropertyName("with_rename")]
        public bool WithRename
        {
            get { return (bool) attributes["with_rename"]; }
            set { attributes["with_rename"] = value; }
        }

        /// <summary>
        /// Download file
        ///
        /// Parameters:
        ///   action - string - Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
        ///   id - integer - If provided, lookup the file by id instead of path.
        ///   with_previews - boolean - Include file preview information?
        ///   with_priority_color - boolean - Include file priority color information?
        /// </summary>
        public async Task<File> Download(Dictionary<string, object> parameters)
        {
            // TODO: Fill in operation implementation
            return null;
        }


        /// <summary>
        /// Parameters:
        ///   provided_mtime - string - Modified time of file.
        ///   priority_color - string - Priority/Bookmark color of file.
        /// </summary>
        public async Task<File> Update(Dictionary<string, object> parameters)
        {
            // TODO: Fill in operation implementation
            return null;
        }


        /// <summary>
        /// Parameters:
        ///   recursive - boolean - If true, will recursively delete folers.  Otherwise, will error on non-empty folders.  For legacy reasons, this parameter may also be provided as the HTTP header `Depth: Infinity`
        /// </summary>
        public async Task<File> Delete(Dictionary<string, object> parameters)
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
            if (this.attributes["path"] != null)
            {
                await this.Update(this.attributes);
            }
            else
            {
                // TODO: Remove this cast after return types are implemented
                var newObj = (File) await File.Create(this.attributes, this.options);
                this.attributes = newObj.attributes;
            }
        }

        /// <summary>
        /// Download file
        ///
        /// Parameters:
        ///   action - string - Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
        ///   id - integer - If provided, lookup the file by id instead of path.
        ///   with_previews - boolean - Include file preview information?
        ///   with_priority_color - boolean - Include file priority color information?
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Download(
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
            if (parameters.ContainsKey("action") && !(parameters["action"] is string ))
            {
                throw new ArgumentException("Bad parameter: action must be of type string", "parameters[\"action\"]");
            }
            if (parameters.ContainsKey("id") && !(parameters["id"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: id must be of type Nullable<Int64>", "parameters[\"id\"]");
            }
            if (parameters.ContainsKey("with_previews") && !(parameters["with_previews"] is bool ))
            {
                throw new ArgumentException("Bad parameter: with_previews must be of type bool", "parameters[\"with_previews\"]");
            }
            if (parameters.ContainsKey("with_priority_color") && !(parameters["with_priority_color"] is bool ))
            {
                throw new ArgumentException("Bad parameter: with_priority_color must be of type bool", "parameters[\"with_priority_color\"]");
            }
            if (!parameters.ContainsKey("path") || parameters["path"] == null)
            {
                throw new ArgumentNullException("Parameter missing: path", "parameters[\"path\"]");
            }

            string responseJson = await FilesApi.SendRequest("/files/?*path", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<File>(responseJson);
        }


        /// <summary>
        /// Parameters:
        ///   path (required) - string - Path to operate on.
        ///   action - string - The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
        ///   etags[etag] (required) - array - etag identifier.
        ///   etags[part] (required) - array - Part number.
        ///   length - integer - Length of file.
        ///   mkdir_parents - boolean - Create parent directories if they do not exist?
        ///   part - integer - Part if uploading a part.
        ///   parts - integer - How many parts to fetch?
        ///   provided_mtime - string - User provided modification time.
        ///   ref - string -
        ///   restart - integer - File byte offset to restart from.
        ///   size - integer - Size of file.
        ///   structure - string - If copying folder, copy just the structure?
        ///   with_rename - boolean - Allow file rename instead of overwrite?
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
            if (parameters.ContainsKey("action") && !(parameters["action"] is string ))
            {
                throw new ArgumentException("Bad parameter: action must be of type string", "parameters[\"action\"]");
            }
            if (parameters.ContainsKey("length") && !(parameters["length"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: length must be of type Nullable<Int64>", "parameters[\"length\"]");
            }
            if (parameters.ContainsKey("mkdir_parents") && !(parameters["mkdir_parents"] is bool ))
            {
                throw new ArgumentException("Bad parameter: mkdir_parents must be of type bool", "parameters[\"mkdir_parents\"]");
            }
            if (parameters.ContainsKey("part") && !(parameters["part"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: part must be of type Nullable<Int64>", "parameters[\"part\"]");
            }
            if (parameters.ContainsKey("parts") && !(parameters["parts"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: parts must be of type Nullable<Int64>", "parameters[\"parts\"]");
            }
            if (parameters.ContainsKey("provided_mtime") && !(parameters["provided_mtime"] is string ))
            {
                throw new ArgumentException("Bad parameter: provided_mtime must be of type string", "parameters[\"provided_mtime\"]");
            }
            if (parameters.ContainsKey("ref") && !(parameters["ref"] is string ))
            {
                throw new ArgumentException("Bad parameter: ref must be of type string", "parameters[\"ref\"]");
            }
            if (parameters.ContainsKey("restart") && !(parameters["restart"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: restart must be of type Nullable<Int64>", "parameters[\"restart\"]");
            }
            if (parameters.ContainsKey("size") && !(parameters["size"] is Nullable<Int64> ))
            {
                throw new ArgumentException("Bad parameter: size must be of type Nullable<Int64>", "parameters[\"size\"]");
            }
            if (parameters.ContainsKey("structure") && !(parameters["structure"] is string ))
            {
                throw new ArgumentException("Bad parameter: structure must be of type string", "parameters[\"structure\"]");
            }
            if (parameters.ContainsKey("with_rename") && !(parameters["with_rename"] is bool ))
            {
                throw new ArgumentException("Bad parameter: with_rename must be of type bool", "parameters[\"with_rename\"]");
            }
            if (!parameters.ContainsKey("path") || parameters["path"] == null)
            {
                throw new ArgumentNullException("Parameter missing: path", "parameters[\"path\"]");
            }

            string responseJson = await FilesApi.SendRequest("/files/?*path", HttpMethod.Post, parameters, options);

            return JsonSerializer.Deserialize<File>(responseJson);
        }


        /// <summary>
        /// Parameters:
        ///   provided_mtime - string - Modified time of file.
        ///   priority_color - string - Priority/Bookmark color of file.
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Update(
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
            if (parameters.ContainsKey("provided_mtime") && !(parameters["provided_mtime"] is string ))
            {
                throw new ArgumentException("Bad parameter: provided_mtime must be of type string", "parameters[\"provided_mtime\"]");
            }
            if (parameters.ContainsKey("priority_color") && !(parameters["priority_color"] is string ))
            {
                throw new ArgumentException("Bad parameter: priority_color must be of type string", "parameters[\"priority_color\"]");
            }
            if (!parameters.ContainsKey("path") || parameters["path"] == null)
            {
                throw new ArgumentNullException("Parameter missing: path", "parameters[\"path\"]");
            }

            string responseJson = await FilesApi.SendRequest("/files/?*path", HttpMethod.Patch, parameters, options);

            return JsonSerializer.Deserialize<File>(responseJson);
        }


        /// <summary>
        /// Parameters:
        ///   recursive - boolean - If true, will recursively delete folers.  Otherwise, will error on non-empty folders.  For legacy reasons, this parameter may also be provided as the HTTP header `Depth: Infinity`
        /// </summary>
        /// TODO: Use types for path_and_primary_params
        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Delete(
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
            if (parameters.ContainsKey("recursive") && !(parameters["recursive"] is bool ))
            {
                throw new ArgumentException("Bad parameter: recursive must be of type bool", "parameters[\"recursive\"]");
            }
            if (!parameters.ContainsKey("path") || parameters["path"] == null)
            {
                throw new ArgumentNullException("Parameter missing: path", "parameters[\"path\"]");
            }

            string responseJson = await FilesApi.SendRequest("/files/?*path", HttpMethod.Delete, parameters, options);

            // TODO: Confirm out what needs to be done when it's not an entity to be converted to.
            return responseJson;
        }

        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> Destroy(
            string path, 
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            return await Delete(path, parameters, options);
        }

    }
}

