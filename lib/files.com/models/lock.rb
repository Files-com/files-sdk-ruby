# frozen_string_literal: true

module Files
  # Files::Lock is the Ruby SDK's representation of Files.com API Lock objects.
  # Each instance keeps its API field values in +attributes+.
  class Lock
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def path=(value)
      @attributes[:path] = value
    end

    # Lock timeout in seconds
    # @return [Integer, nil] the field value, or nil when absent.
    def timeout
      @attributes[:timeout]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def timeout=(value)
      @attributes[:timeout] = value
    end

    #
    # @return [String, nil] the field value, or nil when absent.
    def depth
      @attributes[:depth]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def depth=(value)
      @attributes[:depth] = value
    end

    # Does lock apply to subfolders?
    # @return [Boolean, nil] the field value, or nil when absent.
    def recursive
      @attributes[:recursive]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def recursive=(value)
      @attributes[:recursive] = value
    end

    # Arbitrary descriptive label for the lock. Does not change the lock creator or permissions.
    # @return [String, nil] the field value, or nil when absent.
    def owner
      @attributes[:owner]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def owner=(value)
      @attributes[:owner] = value
    end

    #
    # @return [String, nil] the field value, or nil when absent.
    def scope
      @attributes[:scope]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def scope=(value)
      @attributes[:scope] = value
    end

    # Is lock exclusive?
    # @return [Boolean, nil] the field value, or nil when absent.
    def exclusive
      @attributes[:exclusive]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def exclusive=(value)
      @attributes[:exclusive] = value
    end

    # Lock token.  Use to release lock.
    # @return [String, nil] the field value, or nil when absent.
    def token
      @attributes[:token]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def token=(value)
      @attributes[:token] = value
    end

    #
    # @return [String, nil] the field value, or nil when absent.
    def type
      @attributes[:type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def type=(value)
      @attributes[:type] = value
    end

    # Can lock be modified by users other than its creator?
    # @return [Boolean, nil] the field value, or nil when absent.
    def allow_access_by_any_user
      @attributes[:allow_access_by_any_user]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def allow_access_by_any_user=(value)
      @attributes[:allow_access_by_any_user] = value
    end

    # Lock creator user ID
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def user_id=(value)
      @attributes[:user_id] = value
    end

    # Lock creator username
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def username=(value)
      @attributes[:username] = value
    end

    # Require this existing, unexpired token before refreshing or replacing a lock. Set token to the same value to refresh, or a different value to replace.
    # @return [String, nil] the field value, or nil when absent.
    def expected_token
      @attributes[:expected_token]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def expected_token=(value)
      @attributes[:expected_token] = value
    end

    # Delete Lock
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] token Required. Lock token
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: token must be an String") if !params[:token].nil? and !params[:token].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: token") if params[:token].nil?

      response, options = Api.send_request("/locks/#{@attributes[:path]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Calls {#delete} and discards its response.
    # @param (see #delete)
    # @option (see #delete)
    # @raise (see #delete)
    # @return [nil]
    def destroy(params = {})
      delete(params)
      nil
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    def save
      new_obj = Lock.create(path, @attributes, @options)
      @attributes = new_obj.attributes
      @options = @options.merge(new_obj.options)
      true
    end

    # List Locks by Path
    #
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Boolean] include_children Include locks from children objects?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list_for(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: include_children must be a single value, not #{params[:include_children].class}") if [ Array, Hash ].any? { |klass| params[:include_children].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      list_options = options.dup
      List.new(Lock, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/locks/#{page_params[:path]}", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # Create Lock
    #
    # @param path [String] Path
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] token Lock token. With expected_token, use the same value to refresh or a different value to replace the existing token.
    # @option params [String] expected_token Require this existing, unexpired token before refreshing or replacing a lock. Set token to the same value to refresh, or a different value to replace.
    # @option params [Boolean] allow_access_by_any_user Can lock be modified by users other than its creator?
    # @option params [Boolean] exclusive Is lock exclusive?
    # @option params [Boolean] recursive Does lock apply to subfolders?
    # @option params [String] owner Arbitrary descriptive label for the lock. Does not change the lock creator or permissions.
    # @option params [Integer] timeout Lock timeout in seconds
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Lock] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: token must be an String") if !params[:token].nil? and !params[:token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expected_token must be an String") if !params[:expected_token].nil? and !params[:expected_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allow_access_by_any_user must be a single value, not #{params[:allow_access_by_any_user].class}") if [ Array, Hash ].any? { |klass| params[:allow_access_by_any_user].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: exclusive must be a single value, not #{params[:exclusive].class}") if [ Array, Hash ].any? { |klass| params[:exclusive].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: owner must be an String") if !params[:owner].nil? and !params[:owner].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: timeout must be an Integer") if !params[:timeout].nil? and !params[:timeout].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/locks/#{params[:path]}", :post, params, options) { |reply| reply.require_object("Lock") }
      Lock.new(response.data, options)
    end

    # Delete Lock
    #
    # @param path [String] Path
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] token Required. Lock token
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: token must be an String") if !params[:token].nil? and !params[:token].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: token") if params[:token].nil?

      Api.send_request("/locks/#{params[:path]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(path, params = {}, options = {})
      delete(path, params, options)
      nil
    end
  end
end
