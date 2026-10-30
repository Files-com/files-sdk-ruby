# frozen_string_literal: true

module Files
  # Files::ActionNotificationExport is the Ruby SDK's representation of Files.com API ActionNotificationExport objects.
  # Each instance keeps its API field values in +attributes+.
  class ActionNotificationExport
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

    # History Export ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def id=(value)
      @attributes[:id] = value
    end

    # Workspace whose logs are exported. Set to `0` for the default workspace. A null value means a site-wide export.
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # Version of the underlying records for the export.
    # @return [String, nil] the field value, or nil when absent.
    def export_version
      @attributes[:export_version]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def export_version=(value)
      @attributes[:export_version] = value
    end

    # Start date/time of export range.
    # @return [String, nil] the field value, or nil when absent.
    def start_at
      @attributes[:start_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def start_at=(value)
      @attributes[:start_at] = value
    end

    # End date/time of export range.
    # @return [String, nil] the field value, or nil when absent.
    def end_at
      @attributes[:end_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def end_at=(value)
      @attributes[:end_at] = value
    end

    # Status of export.  Valid values: `building`, `ready`, or `failed`
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def status=(value)
      @attributes[:status] = value
    end

    # Return notifications that were triggered by actions on this specific path.
    # @return [String, nil] the field value, or nil when absent.
    def query_path
      @attributes[:query_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_path=(value)
      @attributes[:query_path] = value
    end

    # Return notifications that were triggered by actions in this folder.
    # @return [String, nil] the field value, or nil when absent.
    def query_folder
      @attributes[:query_folder]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_folder=(value)
      @attributes[:query_folder] = value
    end

    # Error message associated with the request, if any.
    # @return [String, nil] the field value, or nil when absent.
    def query_message
      @attributes[:query_message]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_message=(value)
      @attributes[:query_message] = value
    end

    # The HTTP request method used by the webhook.
    # @return [String, nil] the field value, or nil when absent.
    def query_request_method
      @attributes[:query_request_method]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_request_method=(value)
      @attributes[:query_request_method] = value
    end

    # The target webhook URL.
    # @return [String, nil] the field value, or nil when absent.
    def query_request_url
      @attributes[:query_request_url]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_request_url=(value)
      @attributes[:query_request_url] = value
    end

    # The HTTP status returned from the server in response to the webhook request.
    # @return [String, nil] the field value, or nil when absent.
    def query_status
      @attributes[:query_status]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def query_status=(value)
      @attributes[:query_status] = value
    end

    # true if the webhook request succeeded (i.e. returned a 200 or 204 response status). false otherwise.
    # @return [Boolean, nil] the field value, or nil when absent.
    def query_success
      @attributes[:query_success]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def query_success=(value)
      @attributes[:query_success] = value
    end

    # If `status` is `ready`, this will be a URL where all the results can be downloaded at once as a CSV.
    # @return [String, nil] the field value, or nil when absent.
    def results_url
      @attributes[:results_url]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def results_url=(value)
      @attributes[:results_url] = value
    end

    # User ID.  Provide a value of `0` to operate the current session's user.
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

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    # @raise [Files::NotImplementedError] if this record already has an id; updates are unsupported.
    def save
      if @attributes[:id]
        raise NotImplementedError.new("The ActionNotificationExport object doesn't support updates.")
      else
        new_obj = ActionNotificationExport.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # Show Action Notification Export
    #
    # @param id [Integer] Action Notification Export ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ActionNotificationExport] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/action_notification_exports/#{params[:id]}", :get, params, options) { |reply| reply.require_object("ActionNotificationExport") }
      ActionNotificationExport.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Action Notification Export
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [Integer] workspace_id Workspace whose logs are exported. Set to `0` for the default workspace. A null value means a site-wide export.
    # @option params [String] start_at Start date/time of export range.
    # @option params [String] end_at End date/time of export range.
    # @option params [String] query_message Error message associated with the request, if any.
    # @option params [String] query_request_method The HTTP request method used by the webhook.
    # @option params [String] query_request_url The target webhook URL.
    # @option params [String] query_status The HTTP status returned from the server in response to the webhook request.
    # @option params [Boolean] query_success true if the webhook request succeeded (i.e. returned a 200 or 204 response status). false otherwise.
    # @option params [String] query_path Return notifications that were triggered by actions on this specific path.
    # @option params [String] query_folder Return notifications that were triggered by actions in this folder.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::ActionNotificationExport] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if !params[:start_at].nil? and !params[:start_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if !params[:end_at].nil? and !params[:end_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_message must be an String") if !params[:query_message].nil? and !params[:query_message].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_request_method must be an String") if !params[:query_request_method].nil? and !params[:query_request_method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_request_url must be an String") if !params[:query_request_url].nil? and !params[:query_request_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_status must be an String") if !params[:query_status].nil? and !params[:query_status].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_success must be a single value, not #{params[:query_success].class}") if [ Array, Hash ].any? { |klass| params[:query_success].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: query_path must be an String") if !params[:query_path].nil? and !params[:query_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_folder must be an String") if !params[:query_folder].nil? and !params[:query_folder].is_a?(String)

      response, options = Api.send_request("/action_notification_exports", :post, params, options) { |reply| reply.require_object("ActionNotificationExport") }
      ActionNotificationExport.new(response.data, options)
    end
  end
end
