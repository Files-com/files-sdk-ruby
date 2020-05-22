using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Files.com
{
    public class FilesApi
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(typeof(FilesApi));

        private static FilesClient FilesClientInstance
        {
            get
            {
                if (FilesClient.Instance == null)
                {
                    log.Error("FilesClient instance must be created via 'new FilesClient()' before using http");
                    throw new NullReferenceException("FilesClient.Instance");
                }
                return FilesClient.Instance;
            }
        }

        public static async Task<string> SendRequest(
            string path,
            HttpMethod verb,
            Dictionary<string, object> parameters,
            Dictionary<string, object> options
        )
        {
            return await SendRequest(path, verb, parameters, options, FilesClientInstance);
        }

        public static async Task<string> SendRequest(
            string path,
            HttpMethod verb,
            Dictionary<string, object> parameters,
            Dictionary<string, object> options,
            FilesClient filesClient
        )
        {
            // TODO: check params vs. options

            string parsedPath = ParsePathParameters(path, parameters);
            string url = $"{filesClient.BaseUrl}/api/rest/v1{parsedPath}.json";

            var httpRequestMessage = new HttpRequestMessage
            {
                Method = verb,
                RequestUri = new Uri(url),
                Headers = {
                    { HttpRequestHeader.Accept.ToString(), "application/json" },
                    { "X-FilesAPI-Key", filesClient.ApiKey }
                },
            };

            log.Info($"Sending {verb} request: {url}");

            HttpClient httpClient = filesClient.GetHttpClient();
            HttpResponseMessage response = await httpClient.SendAsync(httpRequestMessage);
            string responseJson = await response.Content.ReadAsStringAsync();

            log.Debug(responseJson);
            return responseJson;
        }

        public static string ParsePathParameters(string path, Dictionary<string, object> parameters)
        {
            Regex regex = new Regex(@"(?<param>\{\w+\})", RegexOptions.Compiled);
            MatchCollection matches = regex.Matches(path);

            string parsedPath = path;
            foreach (Match match in matches)
            {
                Group param = match.Groups["param"];
                string name = param.Value.Substring(1, param.Value.Length - 2);
                object value = parameters[name];

                if (value == null) {
                    throw new InvalidOperationException($"Expected {name} parameter for path: {path}");
                }

                parsedPath = parsedPath.Replace(param.Value, value.ToString());
            }
            return parsedPath;
        }
    }
}

