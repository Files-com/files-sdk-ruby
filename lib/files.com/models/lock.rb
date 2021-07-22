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
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: token must be an String") if params.dig(:token) and !params.dig(:token).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: token") unless params.dig(:token)

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
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   path (required) - string - Path to operate on.
    #   include_children - boolean - Include locks from children objects?
    def self.list_for(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

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
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recursive must be an String") if params.dig(:recursive) and !params.dig(:recursive).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: timeout must be an Integer") if params.dig(:timeout) and !params.dig(:timeout).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, options = Api.send_request("/locks/#{params[:path]}", :post, params, options)
      Lock.new(response.data, options)
    end

    # Parameters:
    #   token (required) - string - Lock token
    def self.delete(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: token must be an String") if params.dig(:token) and !params.dig(:token).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)
      raise MissingParameterError.new("Parameter missing: token") unless params.dig(:token)

      response, _options = Api.send_request("/locks/#{params[:path]}", :delete, params, options)
      response.data
    end

    def self.destroy(path, params = {}, options = {})
      delete(path, params, options)
    end
  end
end
