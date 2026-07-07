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

    # array(object) - A list of notifications
    def notifications
      @attributes[:notifications]
    end

    # array(object) - A list of bundle notifications
    def bundle_notifications
      @attributes[:bundle_notifications]
    end

    # boolean - Deprecated. Use granular admin email preferences instead.
    def receive_admin_alerts
      @attributes[:receive_admin_alerts]
    end

    # boolean - Receive site warnings?
    def notify_on_all_site_warnings
      @attributes[:notify_on_all_site_warnings]
    end

    # boolean - Receive sso/scim/ldap configuration/sync failures?
    def notify_on_all_sso_failures
      @attributes[:notify_on_all_sso_failures]
    end

    # boolean - Receive user security events?
    def notify_on_all_user_security_events
      @attributes[:notify_on_all_user_security_events]
    end

    # boolean - Receive pending work failures?
    def notify_on_all_pending_work_failures
      @attributes[:notify_on_all_pending_work_failures]
    end

    # boolean - Receive siem failures?
    def notify_on_all_siem_http_destination_failures
      @attributes[:notify_on_all_siem_http_destination_failures]
    end

    # boolean - Receive sync failures?
    def notify_on_all_sync_failures
      @attributes[:notify_on_all_sync_failures]
    end

    # boolean - Receive automation failures?
    def notify_on_all_automation_failures
      @attributes[:notify_on_all_automation_failures]
    end

    # boolean - Receive expectation failures and misses?
    def notify_on_all_expectation_failures
      @attributes[:notify_on_all_expectation_failures]
    end

    # boolean - Receive marketing mail?
    def receive_marketing_mail
      @attributes[:receive_marketing_mail]
    end

    # boolean - Receive transactional (service-related) mail?
    def receive_transactional_mail
      @attributes[:receive_transactional_mail]
    end

    # Parameters:
    #   token (required) - string - Email preferences token.
    def self.get(token, params = {}, options = {})
      params ||= {}
      params[:token] = token
      raise InvalidParameterError.new("Bad parameter: token must be an String") if params[:token] and !params[:token].is_a?(String)
      raise MissingParameterError.new("Parameter missing: token") unless params[:token]

      response, options = Api.send_request("/email_preferences/#{params[:token]}", :get, params, options)
      EmailPreference.new(response.data, options)
    end

    # Parameters:
    #   token (required) - string - Email preferences token.
    #   user[receive_admin_alerts] - boolean
    #   user[notify_on_all_site_warnings] - boolean
    #   user[notify_on_all_sso_failures] - boolean
    #   user[notify_on_all_user_security_events] - boolean
    #   user[notify_on_all_pending_work_failures] - boolean
    #   user[notify_on_all_siem_http_destination_failures] - boolean
    #   user[notify_on_all_sync_failures] - boolean
    #   user[notify_on_all_automation_failures] - boolean
    #   user[notify_on_all_expectation_failures] - boolean
    #   user[unsubscribe_marketing] - boolean
    #   user[unsubscribe_transactional] - boolean
    #   user[unsubscribe] - boolean
    #   user[notifications][id] (required) - array(int64)
    #   user[notifications][group] - array(boolean)
    #   user[notifications][send_interval] - array(string)
    #   user[notifications][unsubscribe] - array(boolean)
    #   user[bundle_notifications][id] (required) - array(int64)
    #   user[bundle_notifications][unsubscribe] - array(boolean)
    def self.update(token, params = {}, options = {})
      params ||= {}
      params[:token] = token
      raise InvalidParameterError.new("Bad parameter: token must be an String") if params[:token] and !params[:token].is_a?(String)
      raise MissingParameterError.new("Parameter missing: token") unless params[:token]

      response, options = Api.send_request("/email_preferences/#{params[:token]}", :patch, params, options)
      EmailPreference.new(response.data, options)
    end
  end
end
