
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Files.com.Models
{
    public class UsageSnapshot
    {
        private Dictionary<string, object> attributes;
        private Dictionary<string, object> options;

        public UsageSnapshot()
        {
            this.attributes = new Dictionary<string, object>();
            this.options = new Dictionary<string, object>();

            this.attributes.Add("id", null);
            this.attributes.Add("start_at", null);
            this.attributes.Add("end_at", null);
            this.attributes.Add("created_at", null);
            this.attributes.Add("current_storage", null);
            this.attributes.Add("high_water_storage", null);
            this.attributes.Add("total_downloads", null);
            this.attributes.Add("total_uploads", null);
            this.attributes.Add("updated_at", null);
            this.attributes.Add("usage_by_top_level_dir", null);
            this.attributes.Add("root_storage", null);
            this.attributes.Add("deleted_files_counted_in_minimum", null);
            this.attributes.Add("deleted_files_storage", null);
        }

        public UsageSnapshot(Dictionary<string, object> attributes, Dictionary<string, object> options)
        {
            this.attributes = attributes;
            this.options = options;
        }

        /// <summary>
        /// Site usage ID
        /// </summary>
        [JsonPropertyName("id")]
        public Nullable<Int64> Id
        {
            get { return (Nullable<Int64>) attributes["id"]; }
        }

        /// <summary>
        /// Site usage report start date/time
        /// </summary>
        [JsonPropertyName("start_at")]
        public Nullable<DateTime> StartAt
        {
            get { return (Nullable<DateTime>) attributes["start_at"]; }
        }

        /// <summary>
        /// Site usage report end date/time
        /// </summary>
        [JsonPropertyName("end_at")]
        public Nullable<DateTime> EndAt
        {
            get { return (Nullable<DateTime>) attributes["end_at"]; }
        }

        /// <summary>
        /// Site usage report created at date/time
        /// </summary>
        [JsonPropertyName("created_at")]
        public Nullable<DateTime> CreatedAt
        {
            get { return (Nullable<DateTime>) attributes["created_at"]; }
        }

        /// <summary>
        /// Current site usage as of report
        /// </summary>
        [JsonPropertyName("current_storage")]
        public double CurrentStorage
        {
            get { return (double) attributes["current_storage"]; }
        }

        /// <summary>
        /// Site usage report highest usage in time period
        /// </summary>
        [JsonPropertyName("high_water_storage")]
        public double HighWaterStorage
        {
            get { return (double) attributes["high_water_storage"]; }
        }

        /// <summary>
        /// Number of downloads in report time period
        /// </summary>
        [JsonPropertyName("total_downloads")]
        public Nullable<Int64> TotalDownloads
        {
            get { return (Nullable<Int64>) attributes["total_downloads"]; }
        }

        /// <summary>
        /// Number of uploads in time period
        /// </summary>
        [JsonPropertyName("total_uploads")]
        public Nullable<Int64> TotalUploads
        {
            get { return (Nullable<Int64>) attributes["total_uploads"]; }
        }

        /// <summary>
        /// The last time this site usage report was updated
        /// </summary>
        [JsonPropertyName("updated_at")]
        public Nullable<DateTime> UpdatedAt
        {
            get { return (Nullable<DateTime>) attributes["updated_at"]; }
        }

        /// <summary>
        /// A map of root folders to their total usage
        /// </summary>
        [JsonPropertyName("usage_by_top_level_dir")]
        public object UsageByTopLevelDir
        {
            get { return (object) attributes["usage_by_top_level_dir"]; }
        }

        /// <summary>
        /// Usage for root folder
        /// </summary>
        [JsonPropertyName("root_storage")]
        public double RootStorage
        {
            get { return (double) attributes["root_storage"]; }
        }

        /// <summary>
        /// Usage for files that are deleted but uploaded within last 30 days
        /// </summary>
        [JsonPropertyName("deleted_files_counted_in_minimum")]
        public double DeletedFilesCountedInMinimum
        {
            get { return (double) attributes["deleted_files_counted_in_minimum"]; }
        }

        /// <summary>
        /// Usage for files that are deleted but retained as backups
        /// </summary>
        [JsonPropertyName("deleted_files_storage")]
        public double DeletedFilesStorage
        {
            get { return (double) attributes["deleted_files_storage"]; }
        }



        /// <summary>
        /// Parameters:
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

            string responseJson = await FilesApi.SendRequest("/usage_snapshots", HttpMethod.Get, parameters, options);

            return JsonSerializer.Deserialize<UsageSnapshot[]>(responseJson);
        }

        /// TODO: Get return values from the operation (either model.class_name or an array of them)
        public static async Task<Object> All(
            
            Dictionary<string, object> parameters = null,
            Dictionary<string, object> options = null
        )
        {
            return await List(parameters, options);
        }

    }
}

