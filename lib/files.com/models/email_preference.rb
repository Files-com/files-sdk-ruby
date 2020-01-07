# frozen_string_literal: true

module Files
  class EmailPreference
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # email - Email address
    def email
      @attributes[:email]
    end

    # array - A list of notifications
    def notifications
      @attributes[:notifications]
    end

    # boolean - Receive admin alerts?
    def receive_admin_alerts
      @attributes[:receive_admin_alerts]
    end

    # Parameters:
    #   token (required) - string - Email preferences token.
    #   user[receive_admin_alerts] - boolean
    #   user[unsubscribed] - boolean
    #   user[notifications][id] (required) - array
    #   user[notifications][group] - array
    #   user[notifications][send_interval] - array
    #   user[notifications][unsubscribe] - array
    #   user[unsubscribe] - string
    def self.update(token, params = {}, options = {})
      params ||= {}
      params[:token] = token
      raise InvalidParameterError.new("Bad parameter: token must be an String") if params.dig(:token) and !params.dig(:token).is_a?(String)
      raise MissingParameterError.new("Parameter missing: token") unless params.dig(:token)

      response, options = Api.send_request("/email_preferences/#{params[:token]}", :patch, params, options)
      EmailPreference.new(response.data, options)
    end
  end
end
