# frozen_string_literal: true

module Files
  class ActionNotificationExport
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - History Export ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Version of the underlying records for the export.
    def export_version
      @attributes[:export_version]
    end

    def export_version=(value)
      @attributes[:export_version] = value
    end

    # date-time - Start date/time of export range.
    def start_at
      @attributes[:start_at]
    end

    def start_at=(value)
      @attributes[:start_at] = value
    end

    # date-time - End date/time of export range.
    def end_at
      @attributes[:end_at]
    end

    def end_at=(value)
      @attributes[:end_at] = value
    end

    # string - Status of export.  Valid values: `building`, `ready`, or `failed`
    def status
      @attributes[:status]
    end

    def status=(value)
      @attributes[:status] = value
    end

    # string - Return notifications that were triggered by actions on this specific path.
    def query_path
      @attributes[:query_path]
    end

    def query_path=(value)
      @attributes[:query_path] = value
    end

    # string - Return notifications that were triggered by actions in this folder.
    def query_folder
      @attributes[:query_folder]
    end

    def query_folder=(value)
      @attributes[:query_folder] = value
    end

    # string - Error message associated with the request, if any.
    def query_message
      @attributes[:query_message]
    end

    def query_message=(value)
      @attributes[:query_message] = value
    end

    # string - The HTTP request method used by the webhook.
    def query_request_method
      @attributes[:query_request_method]
    end

    def query_request_method=(value)
      @attributes[:query_request_method] = value
    end

    # string - The target webhook URL.
    def query_request_url
      @attributes[:query_request_url]
    end

    def query_request_url=(value)
      @attributes[:query_request_url] = value
    end

    # string - The HTTP status returned from the server in response to the webhook request.
    def query_status
      @attributes[:query_status]
    end

    def query_status=(value)
      @attributes[:query_status] = value
    end

    # boolean - true if the webhook request succeeded (i.e. returned a 200 or 204 response status). false otherwise.
    def query_success
      @attributes[:query_success]
    end

    def query_success=(value)
      @attributes[:query_success] = value
    end

    # string - If `status` is `ready`, this will be a URL where all the results can be downloaded at once as a CSV.
    def results_url
      @attributes[:results_url]
    end

    def results_url=(value)
      @attributes[:results_url] = value
    end

    # int64 - User ID.  Provide a value of `0` to operate the current session's user.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The ActionNotificationExport object doesn't support updates.")
      else
        new_obj = ActionNotificationExport.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   id (required) - int64 - Action Notification Export ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/action_notification_exports/#{params[:id]}", :get, params, options)
      ActionNotificationExport.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   start_at - string - Start date/time of export range.
    #   end_at - string - End date/time of export range.
    #   query_message - string - Error message associated with the request, if any.
    #   query_request_method - string - The HTTP request method used by the webhook.
    #   query_request_url - string - The target webhook URL.
    #   query_status - string - The HTTP status returned from the server in response to the webhook request.
    #   query_success - boolean - true if the webhook request succeeded (i.e. returned a 200 or 204 response status). false otherwise.
    #   query_path - string - Return notifications that were triggered by actions on this specific path.
    #   query_folder - string - Return notifications that were triggered by actions in this folder.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: start_at must be an String") if params.dig(:start_at) and !params.dig(:start_at).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_at must be an String") if params.dig(:end_at) and !params.dig(:end_at).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_message must be an String") if params.dig(:query_message) and !params.dig(:query_message).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_request_method must be an String") if params.dig(:query_request_method) and !params.dig(:query_request_method).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_request_url must be an String") if params.dig(:query_request_url) and !params.dig(:query_request_url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_status must be an String") if params.dig(:query_status) and !params.dig(:query_status).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_path must be an String") if params.dig(:query_path) and !params.dig(:query_path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: query_folder must be an String") if params.dig(:query_folder) and !params.dig(:query_folder).is_a?(String)

      response, options = Api.send_request("/action_notification_exports", :post, params, options)
      ActionNotificationExport.new(response.data, options)
    end
  end
end
