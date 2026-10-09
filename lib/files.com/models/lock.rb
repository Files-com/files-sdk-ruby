# frozen_string_literal: true

module Files
  class Lock
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
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

    # string
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

    # string - Arbitrary descriptive label for the lock. Does not change the lock creator or permissions.
    def owner
      @attributes[:owner]
    end

    def owner=(value)
      @attributes[:owner] = value
    end

    # string
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

    # string
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

    # string - Require this existing, unexpired token before refreshing or replacing a lock. Set token to the same value to refresh, or a different value to replace.
    def expected_token
      @attributes[:expected_token]
    end

    def expected_token=(value)
      @attributes[:expected_token] = value
    end

    # Parameters:
    #   token (required) - string - Lock token
    #
    # Returns the [response, options] pair from Files::Api.send_request.
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

    # Alias for #delete. Returns nil.
    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      new_obj = Lock.create(path, @attributes, @options)
      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   path (required) - string - Path to operate on.
    #   include_children - boolean - Include locks from children objects?
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::List of Files::Lock objects.
    def self.list_for(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      List.new(Lock, params) do |page_params, &check_page|
        Api.send_request("/locks/#{page_params[:path]}", :get, page_params, options, &check_page)
      end
    end

    # Parameters:
    #   path (required) - string - Path
    #   token - string - Lock token. With expected_token, use the same value to refresh or a different value to replace the existing token.
    #   expected_token - string - Require this existing, unexpired token before refreshing or replacing a lock. Set token to the same value to refresh, or a different value to replace.
    #   allow_access_by_any_user - boolean - Can lock be modified by users other than its creator?
    #   exclusive - boolean - Is lock exclusive?
    #   recursive - boolean - Does lock apply to subfolders?
    #   owner - string - Arbitrary descriptive label for the lock. Does not change the lock creator or permissions.
    #   timeout - int64 - Lock timeout in seconds
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::Lock.
    def self.create(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: token must be an String") if params[:token] and !params[:token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expected_token must be an String") if params[:expected_token] and !params[:expected_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: owner must be an String") if params[:owner] and !params[:owner].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: timeout must be an Integer") if params[:timeout] and !params[:timeout].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      response, options = Api.send_request("/locks/#{params[:path]}", :post, params, options) { |reply| reply.require_object("Lock") }
      Lock.new(response.data, options)
    end

    # Parameters:
    #   token (required) - string - Lock token
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns nil.
    def self.delete(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: token must be an String") if params[:token] and !params[:token].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]
      raise MissingParameterError.new("Parameter missing: token") unless params[:token]

      Api.send_request("/locks/#{params[:path]}", :delete, params, options)
      nil
    end

    # Alias for ::delete. Returns nil.
    def self.destroy(path, params = {}, options = {})
      delete(path, params, options)
      nil
    end
  end
end
