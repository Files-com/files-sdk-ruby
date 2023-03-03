# frozen_string_literal: true

module Files
  class Lock
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # int64 - Lock timeout in seconds
    def timeout
      @attributes[:timeout]
    end

    def timeout=(value)
      @attributes[:timeout] = value
    end

    # string - DEPRECATED: Lock depth
    def depth
      @attributes[:depth]
    end

    def depth=(value)
      @attributes[:depth] = value
    end

    # boolean - Does lock apply to subfolders?
    def recursive
      @attributes[:recursive]
    end

    def recursive=(value)
      @attributes[:recursive] = value
    end

    # string - Owner of the lock.  This can be any arbitrary string.
    def owner
      @attributes[:owner]
    end

    def owner=(value)
      @attributes[:owner] = value
    end

    # string - DEPRECATED: Lock scope
    def scope
      @attributes[:scope]
    end

    def scope=(value)
      @attributes[:scope] = value
    end

    # boolean - Is lock exclusive?
    def exclusive
      @attributes[:exclusive]
    end

    def exclusive=(value)
      @attributes[:exclusive] = value
    end

    # string - Lock token.  Use to release lock.
    def token
      @attributes[:token]
    end

    def token=(value)
      @attributes[:token] = value
    end

    # string - DEPRECATED: Lock type
    def type
      @attributes[:type]
    end

    def type=(value)
      @attributes[:type] = value
    end

    # boolean - Can lock be modified by users other than its creator?
    def allow_access_by_any_user
      @attributes[:allow_access_by_any_user]
    end

    def allow_access_by_any_user=(value)
      @attributes[:allow_access_by_any_user] = value
    end

    # int64 - Lock creator user ID
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # string - Lock creator username
    def username
      @attributes[:username]
    end

    def username=(value)
      @attributes[:username] = value
    end

    # Parameters:
    #   token (required) - string - Lock token
    def delete(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: token must be an String") if params[:token] and !params[:token].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]
      raise MissingParameterError.new("Parameter missing: token") unless params[:token]

      Api.send_request("/locks/#{@attributes[:path]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      new_obj = Lock.create(path, @attributes, @options)
      @attributes = new_obj.attributes
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   path (required) - string - Path to operate on.
    #   include_children - boolean - Include locks from children objects?
    def self.list_for(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      List.new(Lock, params) do
        Api.send_request("/locks/#{params[:path]}", :get, params, options)
      end
    end

    # Parameters:
    #   path (required) - string - Path
    #   allow_access_by_any_user - boolean - Allow lock to be updated by any user?
    #   exclusive - boolean - Is lock exclusive?
    #   recursive - string - Does lock apply to subfolders?
    #   timeout - int64 - Lock timeout length
    def self.create(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recursive must be an String") if params[:recursive] and !params[:recursive].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: timeout must be an Integer") if params[:timeout] and !params[:timeout].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      response, options = Api.send_request("/locks/#{params[:path]}", :post, params, options)
      Lock.new(response.data, options)
    end

    # Parameters:
    #   token (required) - string - Lock token
    def self.delete(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: token must be an String") if params[:token] and !params[:token].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]
      raise MissingParameterError.new("Parameter missing: token") unless params[:token]

      response, _options = Api.send_request("/locks/#{params[:path]}", :delete, params, options)
      response.data
    end

    def self.destroy(path, params = {}, options = {})
      delete(path, params, options)
    end
  end
end
