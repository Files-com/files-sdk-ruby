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

    # string - Folder path.  Note that Behavior paths cannot be updated once initially set.  You will need to remove and re-create the behavior on the new path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
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

    # boolean - If true, the parent folder's behavior will be disabled for this folder and its children.
    def disable_parent_folder_behavior
      @attributes[:disable_parent_folder_behavior]
    end

    def disable_parent_folder_behavior=(value)
      @attributes[:disable_parent_folder_behavior] = value
    end

    # boolean - Is behavior recursive?
    def recursive
      @attributes[:recursive]
    end

    def recursive=(value)
      @attributes[:recursive] = value
    end

    # file - Certain behaviors may require a file, for instance, the `watermark` behavior requires a watermark image. Attach that file here.
    def attachment_file
      @attributes[:attachment_file]
    end

    def attachment_file=(value)
      @attributes[:attachment_file] = value
    end

    # boolean - If `true`, delete the file stored in `attachment`.
    def attachment_delete
      @attributes[:attachment_delete]
    end

    def attachment_delete=(value)
      @attributes[:attachment_delete] = value
    end

    # Parameters:
    #   value - string - This field stores a hash of data specific to the type of behavior. See The Behavior Types section for example values for each type of behavior.
    #   attachment_file - file - Certain behaviors may require a file, for instance, the `watermark` behavior requires a watermark image. Attach that file here.
    #   disable_parent_folder_behavior - boolean - If `true`, the parent folder's behavior will be disabled for this folder and its children. This is the main mechanism for canceling out a `recursive` behavior higher in the folder tree.
    #   recursive - boolean - If `true`, behavior is treated as recursive, meaning that it impacts child folders as well.
    #   name - string - Name for this behavior.
    #   description - string - Description for this behavior.
    #   attachment_delete - boolean - If `true`, delete the file stored in `attachment`.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: value must be an String") if params[:value] and !params[:value].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/behaviors/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/behaviors/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = Behavior.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `behavior` and `impacts_ui`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `impacts_ui` and `behavior`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `behavior`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)

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
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/behaviors/#{params[:id]}", :get, params, options)
      Behavior.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `behavior` and `impacts_ui`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `impacts_ui` and `behavior`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `behavior`.
    #   path (required) - string - Path to operate on.
    #   ancestor_behaviors - boolean - If `true`, behaviors above this path are shown.
    def self.list_for(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      List.new(Behavior, params) do
        Api.send_request("/behaviors/folders/#{params[:path]}", :get, params, options)
      end
    end

    # Parameters:
    #   value - string - This field stores a hash of data specific to the type of behavior. See The Behavior Types section for example values for each type of behavior.
    #   attachment_file - file - Certain behaviors may require a file, for instance, the `watermark` behavior requires a watermark image. Attach that file here.
    #   disable_parent_folder_behavior - boolean - If `true`, the parent folder's behavior will be disabled for this folder and its children. This is the main mechanism for canceling out a `recursive` behavior higher in the folder tree.
    #   recursive - boolean - If `true`, behavior is treated as recursive, meaning that it impacts child folders as well.
    #   name - string - Name for this behavior.
    #   description - string - Description for this behavior.
    #   path (required) - string - Path where this behavior should apply.
    #   behavior (required) - string - Behavior type.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: value must be an String") if params[:value] and !params[:value].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: behavior must be an String") if params[:behavior] and !params[:behavior].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]
      raise MissingParameterError.new("Parameter missing: behavior") unless params[:behavior]

      response, options = Api.send_request("/behaviors", :post, params, options)
      Behavior.new(response.data, options)
    end

    # Parameters:
    #   url (required) - string - URL for testing the webhook.
    #   method - string - HTTP request method (GET or POST).
    #   encoding - string - Encoding type for the webhook payload. Can be JSON, XML, or RAW (form data).
    #   headers - object - Additional request headers to send via HTTP.
    #   body - object - Additional body parameters to include in the webhook payload.
    #   action - string - Action for test body.
    def self.webhook_test(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: url must be an String") if params[:url] and !params[:url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: method must be an String") if params[:method] and !params[:method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: encoding must be an String") if params[:encoding] and !params[:encoding].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: headers must be an Hash") if params[:headers] and !params[:headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: body must be an Hash") if params[:body] and !params[:body].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params[:action] and !params[:action].is_a?(String)
      raise MissingParameterError.new("Parameter missing: url") unless params[:url]

      Api.send_request("/behaviors/webhook/test", :post, params, options)
      nil
    end

    # Parameters:
    #   value - string - This field stores a hash of data specific to the type of behavior. See The Behavior Types section for example values for each type of behavior.
    #   attachment_file - file - Certain behaviors may require a file, for instance, the `watermark` behavior requires a watermark image. Attach that file here.
    #   disable_parent_folder_behavior - boolean - If `true`, the parent folder's behavior will be disabled for this folder and its children. This is the main mechanism for canceling out a `recursive` behavior higher in the folder tree.
    #   recursive - boolean - If `true`, behavior is treated as recursive, meaning that it impacts child folders as well.
    #   name - string - Name for this behavior.
    #   description - string - Description for this behavior.
    #   attachment_delete - boolean - If `true`, delete the file stored in `attachment`.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be one of String, Integer, Hash") if params[:id] and [ String, Integer, Hash ].none? { |klass| params[:id].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: value must be an String") if params[:value] and !params[:value].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: attachment_delete must be one of String, Integer, Hash") if params[:attachment_delete] and [ String, Integer, Hash ].none? { |klass| params[:attachment_delete].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/behaviors/#{params[:id]}", :patch, params, options)
      Behavior.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/behaviors/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
