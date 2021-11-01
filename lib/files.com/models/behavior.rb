# frozen_string_literal: true

module Files
  class Behavior
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Folder behavior ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # string - URL for attached file
    def attachment_url
      @attributes[:attachment_url]
    end

    def attachment_url=(value)
      @attributes[:attachment_url] = value
    end

    # string - Behavior type.
    def behavior
      @attributes[:behavior]
    end

    def behavior=(value)
      @attributes[:behavior] = value
    end

    # string - Name for this behavior.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Description for this behavior.
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # object - Settings for this behavior.  See the section above for an example value to provide here.  Formatting is different for each Behavior type.  May be sent as nested JSON or a single JSON-encoded string.  If using XML encoding for the API call, this data must be sent as a JSON-encoded string.
    def value
      @attributes[:value]
    end

    def value=(value)
      @attributes[:value] = value
    end

    # file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
    def attachment_file
      @attributes[:attachment_file]
    end

    def attachment_file=(value)
      @attributes[:attachment_file] = value
    end

    # Parameters:
    #   value - string - The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior. See The Behavior Types section for example values for each type of behavior.
    #   attachment_file - file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
    #   name - string - Name for this behavior.
    #   description - string - Description for this behavior.
    #   behavior - string - Behavior type.
    #   path - string - Folder behaviors path.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: value must be an String") if params.dig(:value) and !params.dig(:value).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params.dig(:description) and !params.dig(:description).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: behavior must be an String") if params.dig(:behavior) and !params.dig(:behavior).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/behaviors/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/behaviors/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = Behavior.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `behavior`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `behavior`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `behavior`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal to the supplied value. Valid fields are `behavior`.
    #   filter_like - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `behavior`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `behavior`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal to the supplied value. Valid fields are `behavior`.
    #   behavior - string - If set, only shows folder behaviors matching this behavior type.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params.dig(:sort_by) and !params.dig(:sort_by).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params.dig(:filter) and !params.dig(:filter).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params.dig(:filter_gt) and !params.dig(:filter_gt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params.dig(:filter_gteq) and !params.dig(:filter_gteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params.dig(:filter_like) and !params.dig(:filter_like).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params.dig(:filter_lt) and !params.dig(:filter_lt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params.dig(:filter_lteq) and !params.dig(:filter_lteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: behavior must be an String") if params.dig(:behavior) and !params.dig(:behavior).is_a?(String)

      List.new(Behavior, params) do
        Api.send_request("/behaviors", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Behavior ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/behaviors/#{params[:id]}", :get, params, options)
      Behavior.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `behavior`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `behavior`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `behavior`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal to the supplied value. Valid fields are `behavior`.
    #   filter_like - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `behavior`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `behavior`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal to the supplied value. Valid fields are `behavior`.
    #   path (required) - string - Path to operate on.
    #   recursive - string - Show behaviors above this path?
    #   behavior - string - DEPRECATED: If set only shows folder behaviors matching this behavior type. Use `filter[behavior]` instead.
    def self.list_for(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params.dig(:sort_by) and !params.dig(:sort_by).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params.dig(:filter) and !params.dig(:filter).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params.dig(:filter_gt) and !params.dig(:filter_gt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params.dig(:filter_gteq) and !params.dig(:filter_gteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params.dig(:filter_like) and !params.dig(:filter_like).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params.dig(:filter_lt) and !params.dig(:filter_lt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params.dig(:filter_lteq) and !params.dig(:filter_lteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recursive must be an String") if params.dig(:recursive) and !params.dig(:recursive).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: behavior must be an String") if params.dig(:behavior) and !params.dig(:behavior).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      List.new(Behavior, params) do
        Api.send_request("/behaviors/folders/#{params[:path]}", :get, params, options)
      end
    end

    # Parameters:
    #   value - string - The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior. See The Behavior Types section for example values for each type of behavior.
    #   attachment_file - file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
    #   name - string - Name for this behavior.
    #   description - string - Description for this behavior.
    #   path (required) - string - Folder behaviors path.
    #   behavior (required) - string - Behavior type.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: value must be an String") if params.dig(:value) and !params.dig(:value).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params.dig(:description) and !params.dig(:description).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: behavior must be an String") if params.dig(:behavior) and !params.dig(:behavior).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: behavior") unless params.dig(:behavior)

      response, options = Api.send_request("/behaviors", :post, params, options)
      Behavior.new(response.data, options)
    end

    # Parameters:
    #   url (required) - string - URL for testing the webhook.
    #   method - string - HTTP method(GET or POST).
    #   encoding - string - HTTP encoding method.  Can be JSON, XML, or RAW (form data).
    #   headers - object - Additional request headers.
    #   body - object - Additional body parameters.
    #   action - string - action for test body
    def self.webhook_test(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: url must be an String") if params.dig(:url) and !params.dig(:url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: method must be an String") if params.dig(:method) and !params.dig(:method).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: encoding must be an String") if params.dig(:encoding) and !params.dig(:encoding).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: headers must be an Hash") if params.dig(:headers) and !params.dig(:headers).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: body must be an Hash") if params.dig(:body) and !params.dig(:body).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise MissingParameterError.new("Parameter missing: url") unless params.dig(:url)

      response, _options = Api.send_request("/behaviors/webhook/test", :post, params, options)
      response.data
    end

    # Parameters:
    #   value - string - The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior. See The Behavior Types section for example values for each type of behavior.
    #   attachment_file - file - Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
    #   name - string - Name for this behavior.
    #   description - string - Description for this behavior.
    #   behavior - string - Behavior type.
    #   path - string - Folder behaviors path.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be one of String, Integer, Hash") if params.dig(:id) and [ String, Integer, Hash ].none? { |klass| params.dig(:id).is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: value must be an String") if params.dig(:value) and !params.dig(:value).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params.dig(:name) and !params.dig(:name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params.dig(:description) and !params.dig(:description).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: behavior must be an String") if params.dig(:behavior) and !params.dig(:behavior).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be one of String, Integer, Hash") if params.dig(:path) and [ String, Integer, Hash ].none? { |klass| params.dig(:path).is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/behaviors/#{params[:id]}", :patch, params, options)
      Behavior.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/behaviors/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
