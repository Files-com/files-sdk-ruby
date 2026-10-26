# frozen_string_literal: true

module Files
  # Files::ApiKey is the Ruby SDK's representation of Files.com API ApiKey objects.
  # Each instance keeps its API field values in +attributes+.
  class ApiKey
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - API Key ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Unique label that describes this API key.  Useful for external systems where you may have API keys from multiple accounts and want a human-readable label for each key.
    def descriptive_label
      @attributes[:descriptive_label]
    end

    def descriptive_label=(value)
      @attributes[:descriptive_label] = value
    end

    # string - User-supplied description of API key.
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # date-time - Time which API Key was created
    def created_at
      @attributes[:created_at]
    end

    # date-time - API Key expiration date
    def expires_at
      @attributes[:expires_at]
    end

    def expires_at=(value)
      @attributes[:expires_at] = value
    end

    # string - API Key actual key string
    def key
      @attributes[:key]
    end

    def key=(value)
      @attributes[:key] = value
    end

    # boolean - If `true`, this API key will be usable with AWS-compatible endpoints, such as our Inbound S3-compatible endpoint.
    def aws_style_credentials
      @attributes[:aws_style_credentials]
    end

    def aws_style_credentials=(value)
      @attributes[:aws_style_credentials] = value
    end

    # string - AWS Access Key ID to use with AWS-compatible endpoints, such as our Inbound S3-compatible endpoint.
    def aws_access_key_id
      @attributes[:aws_access_key_id]
    end

    def aws_access_key_id=(value)
      @attributes[:aws_access_key_id] = value
    end

    # string - AWS Secret Key to use with AWS-compatible endpoints, such as our Inbound S3-compatible endpoint.
    def aws_secret_key
      @attributes[:aws_secret_key]
    end

    def aws_secret_key=(value)
      @attributes[:aws_secret_key] = value
    end

    # date-time - API Key last used - note this value is only updated once per 3 hour period, so the 'actual' time of last use may be up to 3 hours later than this timestamp.
    def last_use_at
      @attributes[:last_use_at]
    end

    def last_use_at=(value)
      @attributes[:last_use_at] = value
    end

    # string - Internal name for the API Key.  For your use.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Permissions for this API Key. Keys with the `desktop_app` permission set only have the ability to do the functions provided in our Desktop App (File and Share Link operations). Keys with the `mobile_app` permission set can only perform the functions provided by our Mobile App (File and Share Link operations). Keys with the `office_integration` permission set are auto generated, and automatically expire, to allow users to interact with office integration platforms. Keys with the `files_only` permission set can use only the files, folders, and file_actions endpoints, excluding the GPG Encrypt and GPG Decrypt file actions, where they perform file operations as a full-access file user in the key's workspace scope, along with `GET /file_migrations/{id}` and `GET /api_key`. On the migration lookup, any key with a `path` can read only migrations it started. Without a `path`, user-owned keys retain user-scoped access; site-wide Workspace-bound keys can read only migrations whose source and destination are both in their Workspace. Every `files_only` key is Workspace-bound, including Workspace `0`, as is a full-access key in a named Workspace. A full-access site-wide key in the default Workspace retains Site-wide migration access. Migrations outside the caller's visibility return `not-found`. Keys with `files_only` cannot use site admin, workspace admin, folder admin, group admin, partner admin, or billing privileges from the owning user. Both GPG file actions and every other endpoint deny them with `not-authorized/api-key-only-for-file-operations`. Folder-configured GPG encryption and decryption still apply to files uploaded with a `files_only` key.
    def permission_set
      @attributes[:permission_set]
    end

    def permission_set=(value)
      @attributes[:permission_set] = value
    end

    # string - If this API key represents a Desktop app, what platform was it created on?
    def platform
      @attributes[:platform]
    end

    def platform=(value)
      @attributes[:platform] = value
    end

    # int64 - Site ID
    def site_id
      @attributes[:site_id]
    end

    def site_id=(value)
      @attributes[:site_id] = value
    end

    # string - Site Name
    def site_name
      @attributes[:site_name]
    end

    def site_name=(value)
      @attributes[:site_name] = value
    end

    # string - URL for API host.
    def url
      @attributes[:url]
    end

    def url=(value)
      @attributes[:url] = value
    end

    # int64 - User ID for the owner of this API Key.  May be blank for Site-wide API Keys.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # int64 - Workspace ID for this API Key. `0` means the default workspace.
    def workspace_id
      @attributes[:workspace_id]
    end

    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # string - Restricts the file and folder operations made with this key, meaning the files, folders, and file_actions endpoints, to the specified folder and its descendants, including copy and move destinations. For `GET /file_migrations/{id}`, a key with a path can read only migrations it started. Does not grant access beyond the owning user's permissions. Optional for `files_only` keys and required for `office_integration` keys, which need a path the owning user can read. Keys with any other permission set cannot have a path.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # Parameters:
    #   description - string - User-supplied description of API key.
    #   expires_at - string - API Key expiration date
    #   name - string - Internal name for the API Key.  For your use.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if !params[:expires_at].nil? and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/api_keys/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("ApiKey") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Returns the [response, options] pair from Files::Api.send_request.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/api_keys/#{@attributes[:id]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Alias for #delete. Returns nil.
    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = ApiKey.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `site_id` and `workspace_id`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `aws_style_credentials` and `expires_at`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `expires_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `expires_at`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `expires_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `expires_at`.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::ApiKey objects.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if !params[:filter_gt].nil? and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if !params[:filter_gteq].nil? and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if !params[:filter_lt].nil? and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if !params[:filter_lteq].nil? and !params[:filter_lteq].is_a?(Hash)

      list_options = options.dup
      List.new(ApiKey, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/api_keys", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::ApiKey.
    def self.find_current(params = {}, options = {})
      response, options = Api.send_request("/api_key", :get, params, options) { |reply| reply.require_object("ApiKey") }
      ApiKey.new(response.data, options)
    end

    # Parameters:
    #   id (required) - int64 - Api Key ID.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::ApiKey.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/api_keys/#{params[:id]}", :get, params, options) { |reply| reply.require_object("ApiKey") }
      ApiKey.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   description - string - User-supplied description of API key.
    #   expires_at - string - API Key expiration date
    #   name (required) - string - Internal name for the API Key.  For your use.
    #   aws_style_credentials - boolean - If `true`, this API key will be usable with AWS-compatible endpoints, such as our Inbound S3-compatible endpoint.
    #   path - string - Restricts the file and folder operations made with this key, meaning the files, folders, and file_actions endpoints, to the specified folder and its descendants, including copy and move destinations. For `GET /file_migrations/{id}`, a key with a path can read only migrations it started. Does not grant access beyond the owning user's permissions. Optional for `files_only` keys and required for `office_integration` keys, which need a path the owning user can read. Keys with any other permission set cannot have a path.
    #   permission_set - string - Permissions for this API Key. Keys with the `desktop_app` permission set only have the ability to do the functions provided in our Desktop App (File and Share Link operations). Keys with the `mobile_app` permission set can only perform the functions provided by our Mobile App (File and Share Link operations). Keys with the `office_integration` permission set are auto generated, and automatically expire, to allow users to interact with office integration platforms. Keys with the `files_only` permission set can use only the files, folders, and file_actions endpoints, excluding the GPG Encrypt and GPG Decrypt file actions, where they perform file operations as a full-access file user in the key's workspace scope, along with `GET /file_migrations/{id}` and `GET /api_key`. On the migration lookup, any key with a `path` can read only migrations it started. Without a `path`, user-owned keys retain user-scoped access; site-wide Workspace-bound keys can read only migrations whose source and destination are both in their Workspace. Every `files_only` key is Workspace-bound, including Workspace `0`, as is a full-access key in a named Workspace. A full-access site-wide key in the default Workspace retains Site-wide migration access. Migrations outside the caller's visibility return `not-found`. Keys with `files_only` cannot use site admin, workspace admin, folder admin, group admin, partner admin, or billing privileges from the owning user. Both GPG file actions and every other endpoint deny them with `not-authorized/api-key-only-for-file-operations`. Folder-configured GPG encryption and decryption still apply to files uploaded with a `files_only` key.
    #   workspace_id - int64 - Workspace ID for this API Key. `0` means the default workspace.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::ApiKey.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if !params[:expires_at].nil? and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: aws_style_credentials must be a single value, not #{params[:aws_style_credentials].class}") if [ Array, Hash ].any? { |klass| params[:aws_style_credentials].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if !params[:permission_set].nil? and !params[:permission_set].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?

      response, options = Api.send_request("/api_keys", :post, params, options) { |reply| reply.require_object("ApiKey") }
      ApiKey.new(response.data, options)
    end

    # Parameters:
    #   expires_at - string - API Key expiration date
    #   name - string - Internal name for the API Key.  For your use.
    #   permission_set - string - Permissions for this API Key. Keys with the `desktop_app` permission set only have the ability to do the functions provided in our Desktop App (File and Share Link operations). Keys with the `mobile_app` permission set can only perform the functions provided by our Mobile App (File and Share Link operations). Keys with the `office_integration` permission set are auto generated, and automatically expire, to allow users to interact with office integration platforms. Keys with the `files_only` permission set can use only the files, folders, and file_actions endpoints, excluding the GPG Encrypt and GPG Decrypt file actions, where they perform file operations as a full-access file user in the key's workspace scope, along with `GET /file_migrations/{id}` and `GET /api_key`. On the migration lookup, any key with a `path` can read only migrations it started. Without a `path`, user-owned keys retain user-scoped access; site-wide Workspace-bound keys can read only migrations whose source and destination are both in their Workspace. Every `files_only` key is Workspace-bound, including Workspace `0`, as is a full-access key in a named Workspace. A full-access site-wide key in the default Workspace retains Site-wide migration access. Migrations outside the caller's visibility return `not-found`. Keys with `files_only` cannot use site admin, workspace admin, folder admin, group admin, partner admin, or billing privileges from the owning user. Both GPG file actions and every other endpoint deny them with `not-authorized/api-key-only-for-file-operations`. Folder-configured GPG encryption and decryption still apply to files uploaded with a `files_only` key.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::ApiKey.
    def self.update_current(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if !params[:expires_at].nil? and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permission_set must be an String") if !params[:permission_set].nil? and !params[:permission_set].is_a?(String)

      response, options = Api.send_request("/api_key", :patch, params, options) { |reply| reply.require_object("ApiKey") }
      ApiKey.new(response.data, options)
    end

    # Parameters:
    #   description - string - User-supplied description of API key.
    #   expires_at - string - API Key expiration date
    #   name - string - Internal name for the API Key.  For your use.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::ApiKey.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if !params[:expires_at].nil? and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/api_keys/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("ApiKey") }
      ApiKey.new(response.data, options)
    end

    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns nil.
    def self.delete_current(params = {}, options = {})
      Api.send_request("/api_key", :delete, params, options)
      nil
    end

    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns nil.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/api_keys/#{params[:id]}", :delete, params, options)
      nil
    end

    # Alias for ::delete. Returns nil.
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
