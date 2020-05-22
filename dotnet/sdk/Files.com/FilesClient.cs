using System;
using System.Configuration;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;

namespace Files.com
{
    public class FilesClient
    {
        private const string ConfigManagerSectionName = "files.com/filesConfiguration";

        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(typeof(FilesConfiguration));

        private readonly FilesConfiguration config;
        private readonly HttpClient httpClient = new HttpClient();

        public static FilesClient Instance { get; private set; }

        public FilesClient() : this((FilesConfiguration)ConfigurationManager.GetSection(ConfigManagerSectionName)) { }

        public FilesClient(FilesConfiguration config)
        {
            if (Instance != null) {
                log.Info("Files.com Client instance already exists, replacing instance with new one");
            }

            Instance = this;
            this.config = config;

            // TODO: Add user/password support?
            if (this.config.ApiKey != null)
            {
                log.Info("Files.com Client created with API Key");
            }
            else
            {
                log.Error("Files.com Client Settings must have ApiKey");
                throw new InvalidOperationException("Incomplete settings for Files.com Client");
            }
        }

        public string BaseUrl
        { 
            get { return config.BaseUrl; }
        }

        public string ApiKey
        { 
            get { return config.ApiKey; }
        }

        public HttpClient GetHttpClient()
        {
            // TODO: Use IHttpClientFactory
            // https://docs.microsoft.com/en-us/dotnet/architecture/microservices/implement-resilient-applications/use-httpclientfactory-to-implement-resilient-http-requests
            return httpClient;
        }

        public async Task Test()
        {
            string path = "users";
            HttpMethod verb = HttpMethod.Get;
            var parameters = new System.Collections.Generic.Dictionary<string, object>();
            var options = new System.Collections.Generic.Dictionary<string, object>();

            string responseJson = await FilesApi.SendRequest(path, verb, parameters, options);
            Console.WriteLine(responseJson);
        }
    }
}

