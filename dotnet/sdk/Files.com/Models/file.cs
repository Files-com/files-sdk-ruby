
        public static File Create(Dictionary<string, object> attributes, Dictionary<string, object> options)
        {
            return File.Create((string)attributes["path"], attributes, options);
        }
