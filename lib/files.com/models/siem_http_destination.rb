# frozen_string_literal: true

module Files
  class SiemHttpDestination
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - SIEM HTTP Destination ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Name for this Destination
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Destination Type
    def destination_type
      @attributes[:destination_type]
    end

    def destination_type=(value)
      @attributes[:destination_type] = value
    end

    # string - Destination Url
    def destination_url
      @attributes[:destination_url]
    end

    def destination_url=(value)
      @attributes[:destination_url] = value
    end

    # string - Applicable only for destination type: file. Destination folder path on Files.com.
    def file_destination_path
      @attributes[:file_destination_path]
    end

    def file_destination_path=(value)
      @attributes[:file_destination_path] = value
    end

    # string - Applicable only for destination type: file. Generated file format.
    def file_format
      @attributes[:file_format]
    end

    def file_format=(value)
      @attributes[:file_format] = value
    end

    # int64 - Applicable only for destination type: file. Interval, in minutes, between file deliveries.
    def file_interval_minutes
      @attributes[:file_interval_minutes]
    end

    def file_interval_minutes=(value)
      @attributes[:file_interval_minutes] = value
    end

    # object - Additional HTTP Headers included in calls to the destination URL
    def additional_headers
      @attributes[:additional_headers]
    end

    def additional_headers=(value)
      @attributes[:additional_headers] = value
    end

    # boolean - Whether this SIEM HTTP Destination is currently being sent to or not
    def sending_active
      @attributes[:sending_active]
    end

    def sending_active=(value)
      @attributes[:sending_active] = value
    end

    # string - Applicable only for destination type: generic. Indicates the type of HTTP body. Can be json_newline or json_array. json_newline is multiple log entries as JSON separated by newlines. json_array is a single JSON array containing multiple log entries as JSON.
    def generic_payload_type
      @attributes[:generic_payload_type]
    end

    def generic_payload_type=(value)
      @attributes[:generic_payload_type] = value
    end

    # string - Applicable only for destination type: splunk. Authentication token provided by Splunk.
    def splunk_token_masked
      @attributes[:splunk_token_masked]
    end

    def splunk_token_masked=(value)
      @attributes[:splunk_token_masked] = value
    end

    # string - Applicable only for destination types: azure, azure_legacy. Immutable ID of the Data Collection Rule.
    def azure_dcr_immutable_id
      @attributes[:azure_dcr_immutable_id]
    end

    def azure_dcr_immutable_id=(value)
      @attributes[:azure_dcr_immutable_id] = value
    end

    # string - Applicable only for destination type: azure. Name of the stream in the DCR that represents the destination table.
    def azure_stream_name
      @attributes[:azure_stream_name]
    end

    def azure_stream_name=(value)
      @attributes[:azure_stream_name] = value
    end

    # string - Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Tenant ID.
    def azure_oauth_client_credentials_tenant_id
      @attributes[:azure_oauth_client_credentials_tenant_id]
    end

    def azure_oauth_client_credentials_tenant_id=(value)
      @attributes[:azure_oauth_client_credentials_tenant_id] = value
    end

    # string - Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Client ID.
    def azure_oauth_client_credentials_client_id
      @attributes[:azure_oauth_client_credentials_client_id]
    end

    def azure_oauth_client_credentials_client_id=(value)
      @attributes[:azure_oauth_client_credentials_client_id] = value
    end

    # string - Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Client Secret.
    def azure_oauth_client_credentials_client_secret_masked
      @attributes[:azure_oauth_client_credentials_client_secret_masked]
    end

    def azure_oauth_client_credentials_client_secret_masked=(value)
      @attributes[:azure_oauth_client_credentials_client_secret_masked] = value
    end

    # string - Applicable only for destination type: qradar. Basic auth username provided by QRadar.
    def qradar_username
      @attributes[:qradar_username]
    end

    def qradar_username=(value)
      @attributes[:qradar_username] = value
    end

    # string - Applicable only for destination type: qradar. Basic auth password provided by QRadar.
    def qradar_password_masked
      @attributes[:qradar_password_masked]
    end

    def qradar_password_masked=(value)
      @attributes[:qradar_password_masked] = value
    end

    # string - Applicable only for destination type: solar_winds. Authentication token provided by Solar Winds.
    def solar_winds_token_masked
      @attributes[:solar_winds_token_masked]
    end

    def solar_winds_token_masked=(value)
      @attributes[:solar_winds_token_masked] = value
    end

    # string - Applicable only for destination type: new_relic. API key provided by New Relic.
    def new_relic_api_key_masked
      @attributes[:new_relic_api_key_masked]
    end

    def new_relic_api_key_masked=(value)
      @attributes[:new_relic_api_key_masked] = value
    end

    # string - Applicable only for destination type: datadog. API key provided by Datadog.
    def datadog_api_key_masked
      @attributes[:datadog_api_key_masked]
    end

    def datadog_api_key_masked=(value)
      @attributes[:datadog_api_key_masked] = value
    end

    # boolean - Whether or not sending is enabled for sftp_action logs.
    def sftp_action_send_enabled
      @attributes[:sftp_action_send_enabled]
    end

    def sftp_action_send_enabled=(value)
      @attributes[:sftp_action_send_enabled] = value
    end

    # int64 - Number of log entries sent for the lifetime of this destination.
    def sftp_action_entries_sent
      @attributes[:sftp_action_entries_sent]
    end

    def sftp_action_entries_sent=(value)
      @attributes[:sftp_action_entries_sent] = value
    end

    # boolean - Whether or not sending is enabled for ftp_action logs.
    def ftp_action_send_enabled
      @attributes[:ftp_action_send_enabled]
    end

    def ftp_action_send_enabled=(value)
      @attributes[:ftp_action_send_enabled] = value
    end

    # int64 - Number of log entries sent for the lifetime of this destination.
    def ftp_action_entries_sent
      @attributes[:ftp_action_entries_sent]
    end

    def ftp_action_entries_sent=(value)
      @attributes[:ftp_action_entries_sent] = value
    end

    # boolean - Whether or not sending is enabled for web_dav_action logs.
    def web_dav_action_send_enabled
      @attributes[:web_dav_action_send_enabled]
    end

    def web_dav_action_send_enabled=(value)
      @attributes[:web_dav_action_send_enabled] = value
    end

    # int64 - Number of log entries sent for the lifetime of this destination.
    def web_dav_action_entries_sent
      @attributes[:web_dav_action_entries_sent]
    end

    def web_dav_action_entries_sent=(value)
      @attributes[:web_dav_action_entries_sent] = value
    end

    # boolean - Whether or not sending is enabled for sync logs.
    def sync_send_enabled
      @attributes[:sync_send_enabled]
    end

    def sync_send_enabled=(value)
      @attributes[:sync_send_enabled] = value
    end

    # int64 - Number of log entries sent for the lifetime of this destination.
    def sync_entries_sent
      @attributes[:sync_entries_sent]
    end

    def sync_entries_sent=(value)
      @attributes[:sync_entries_sent] = value
    end

    # boolean - Whether or not sending is enabled for outbound_connection logs.
    def outbound_connection_send_enabled
      @attributes[:outbound_connection_send_enabled]
    end

    def outbound_connection_send_enabled=(value)
      @attributes[:outbound_connection_send_enabled] = value
    end

    # int64 - Number of log entries sent for the lifetime of this destination.
    def outbound_connection_entries_sent
      @attributes[:outbound_connection_entries_sent]
    end

    def outbound_connection_entries_sent=(value)
      @attributes[:outbound_connection_entries_sent] = value
    end

    # boolean - Whether or not sending is enabled for automation logs.
    def automation_send_enabled
      @attributes[:automation_send_enabled]
    end

    def automation_send_enabled=(value)
      @attributes[:automation_send_enabled] = value
    end

    # int64 - Number of log entries sent for the lifetime of this destination.
    def automation_entries_sent
      @attributes[:automation_entries_sent]
    end

    def automation_entries_sent=(value)
      @attributes[:automation_entries_sent] = value
    end

    # boolean - Whether or not sending is enabled for api_request logs.
    def api_request_send_enabled
      @attributes[:api_request_send_enabled]
    end

    def api_request_send_enabled=(value)
      @attributes[:api_request_send_enabled] = value
    end

    # int64 - Number of log entries sent for the lifetime of this destination.
    def api_request_entries_sent
      @attributes[:api_request_entries_sent]
    end

    def api_request_entries_sent=(value)
      @attributes[:api_request_entries_sent] = value
    end

    # boolean - Whether or not sending is enabled for public_hosting_request logs.
    def public_hosting_request_send_enabled
      @attributes[:public_hosting_request_send_enabled]
    end

    def public_hosting_request_send_enabled=(value)
      @attributes[:public_hosting_request_send_enabled] = value
    end

    # int64 - Number of log entries sent for the lifetime of this destination.
    def public_hosting_request_entries_sent
      @attributes[:public_hosting_request_entries_sent]
    end

    def public_hosting_request_entries_sent=(value)
      @attributes[:public_hosting_request_entries_sent] = value
    end

    # boolean - Whether or not sending is enabled for email logs.
    def email_send_enabled
      @attributes[:email_send_enabled]
    end

    def email_send_enabled=(value)
      @attributes[:email_send_enabled] = value
    end

    # int64 - Number of log entries sent for the lifetime of this destination.
    def email_entries_sent
      @attributes[:email_entries_sent]
    end

    def email_entries_sent=(value)
      @attributes[:email_entries_sent] = value
    end

    # boolean - Whether or not sending is enabled for exavault_api_request logs.
    def exavault_api_request_send_enabled
      @attributes[:exavault_api_request_send_enabled]
    end

    def exavault_api_request_send_enabled=(value)
      @attributes[:exavault_api_request_send_enabled] = value
    end

    # int64 - Number of log entries sent for the lifetime of this destination.
    def exavault_api_request_entries_sent
      @attributes[:exavault_api_request_entries_sent]
    end

    def exavault_api_request_entries_sent=(value)
      @attributes[:exavault_api_request_entries_sent] = value
    end

    # boolean - Whether or not sending is enabled for settings_change logs.
    def settings_change_send_enabled
      @attributes[:settings_change_send_enabled]
    end

    def settings_change_send_enabled=(value)
      @attributes[:settings_change_send_enabled] = value
    end

    # int64 - Number of log entries sent for the lifetime of this destination.
    def settings_change_entries_sent
      @attributes[:settings_change_entries_sent]
    end

    def settings_change_entries_sent=(value)
      @attributes[:settings_change_entries_sent] = value
    end

    # string - Type of URL that was last called. Can be `destination_url` or `azure_oauth_client_credentials_url`
    def last_http_call_target_type
      @attributes[:last_http_call_target_type]
    end

    def last_http_call_target_type=(value)
      @attributes[:last_http_call_target_type] = value
    end

    # boolean - Was the last HTTP call made successful?
    def last_http_call_success
      @attributes[:last_http_call_success]
    end

    def last_http_call_success=(value)
      @attributes[:last_http_call_success] = value
    end

    # int64 - Last HTTP Call Response Code
    def last_http_call_response_code
      @attributes[:last_http_call_response_code]
    end

    def last_http_call_response_code=(value)
      @attributes[:last_http_call_response_code] = value
    end

    # string - Last HTTP Call Response Body. Large responses are truncated.
    def last_http_call_response_body
      @attributes[:last_http_call_response_body]
    end

    def last_http_call_response_body=(value)
      @attributes[:last_http_call_response_body] = value
    end

    # string - Last HTTP Call Error Message if applicable
    def last_http_call_error_message
      @attributes[:last_http_call_error_message]
    end

    def last_http_call_error_message=(value)
      @attributes[:last_http_call_error_message] = value
    end

    # string - Time of Last HTTP Call
    def last_http_call_time
      @attributes[:last_http_call_time]
    end

    def last_http_call_time=(value)
      @attributes[:last_http_call_time] = value
    end

    # int64 - Duration of the last HTTP Call in milliseconds
    def last_http_call_duration_ms
      @attributes[:last_http_call_duration_ms]
    end

    def last_http_call_duration_ms=(value)
      @attributes[:last_http_call_duration_ms] = value
    end

    # string - Time of Most Recent Successful HTTP Call
    def most_recent_http_call_success_time
      @attributes[:most_recent_http_call_success_time]
    end

    def most_recent_http_call_success_time=(value)
      @attributes[:most_recent_http_call_success_time] = value
    end

    # string - Connection Test Entry
    def connection_test_entry
      @attributes[:connection_test_entry]
    end

    def connection_test_entry=(value)
      @attributes[:connection_test_entry] = value
    end

    # string - Applicable only for destination type: splunk. Authentication token provided by Splunk.
    def splunk_token
      @attributes[:splunk_token]
    end

    def splunk_token=(value)
      @attributes[:splunk_token] = value
    end

    # string - Applicable only for destination type: azure. Client Credentials OAuth Client Secret.
    def azure_oauth_client_credentials_client_secret
      @attributes[:azure_oauth_client_credentials_client_secret]
    end

    def azure_oauth_client_credentials_client_secret=(value)
      @attributes[:azure_oauth_client_credentials_client_secret] = value
    end

    # string - Applicable only for destination type: qradar. Basic auth password provided by QRadar.
    def qradar_password
      @attributes[:qradar_password]
    end

    def qradar_password=(value)
      @attributes[:qradar_password] = value
    end

    # string - Applicable only for destination type: solar_winds. Authentication token provided by Solar Winds.
    def solar_winds_token
      @attributes[:solar_winds_token]
    end

    def solar_winds_token=(value)
      @attributes[:solar_winds_token] = value
    end

    # string - Applicable only for destination type: new_relic. API key provided by New Relic.
    def new_relic_api_key
      @attributes[:new_relic_api_key]
    end

    def new_relic_api_key=(value)
      @attributes[:new_relic_api_key] = value
    end

    # string - Applicable only for destination type: datadog. API key provided by Datadog.
    def datadog_api_key
      @attributes[:datadog_api_key]
    end

    def datadog_api_key=(value)
      @attributes[:datadog_api_key] = value
    end

    # Parameters:
    #   name - string - Name for this Destination
    #   additional_headers - object - Additional HTTP Headers included in calls to the destination URL
    #   sending_active - boolean - Whether this SIEM HTTP Destination is currently being sent to or not
    #   generic_payload_type - string - Applicable only for destination type: generic. Indicates the type of HTTP body. Can be json_newline or json_array. json_newline is multiple log entries as JSON separated by newlines. json_array is a single JSON array containing multiple log entries as JSON.
    #   file_destination_path - string - Applicable only for destination type: file. Destination folder path on Files.com.
    #   file_format - string - Applicable only for destination type: file. Generated file format.
    #   file_interval_minutes - int64 - Applicable only for destination type: file. Interval, in minutes, between file deliveries. Valid values are 5, 10, 15, 20, 30, 60, 90, 180, 240, 360.
    #   splunk_token - string - Applicable only for destination type: splunk. Authentication token provided by Splunk.
    #   azure_dcr_immutable_id - string - Applicable only for destination types: azure, azure_legacy. Immutable ID of the Data Collection Rule.
    #   azure_stream_name - string - Applicable only for destination type: azure. Name of the stream in the DCR that represents the destination table.
    #   azure_oauth_client_credentials_tenant_id - string - Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Tenant ID.
    #   azure_oauth_client_credentials_client_id - string - Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Client ID.
    #   azure_oauth_client_credentials_client_secret - string - Applicable only for destination type: azure. Client Credentials OAuth Client Secret.
    #   qradar_username - string - Applicable only for destination type: qradar. Basic auth username provided by QRadar.
    #   qradar_password - string - Applicable only for destination type: qradar. Basic auth password provided by QRadar.
    #   solar_winds_token - string - Applicable only for destination type: solar_winds. Authentication token provided by Solar Winds.
    #   new_relic_api_key - string - Applicable only for destination type: new_relic. API key provided by New Relic.
    #   datadog_api_key - string - Applicable only for destination type: datadog. API key provided by Datadog.
    #   sftp_action_send_enabled - boolean - Whether or not sending is enabled for sftp_action logs.
    #   ftp_action_send_enabled - boolean - Whether or not sending is enabled for ftp_action logs.
    #   web_dav_action_send_enabled - boolean - Whether or not sending is enabled for web_dav_action logs.
    #   sync_send_enabled - boolean - Whether or not sending is enabled for sync logs.
    #   outbound_connection_send_enabled - boolean - Whether or not sending is enabled for outbound_connection logs.
    #   automation_send_enabled - boolean - Whether or not sending is enabled for automation logs.
    #   api_request_send_enabled - boolean - Whether or not sending is enabled for api_request logs.
    #   public_hosting_request_send_enabled - boolean - Whether or not sending is enabled for public_hosting_request logs.
    #   email_send_enabled - boolean - Whether or not sending is enabled for email logs.
    #   exavault_api_request_send_enabled - boolean - Whether or not sending is enabled for exavault_api_request logs.
    #   settings_change_send_enabled - boolean - Whether or not sending is enabled for settings_change logs.
    #   destination_type - string - Destination Type
    #   destination_url - string - Destination Url
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: generic_payload_type must be an String") if params[:generic_payload_type] and !params[:generic_payload_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_destination_path must be an String") if params[:file_destination_path] and !params[:file_destination_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_format must be an String") if params[:file_format] and !params[:file_format].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_interval_minutes must be an Integer") if params[:file_interval_minutes] and !params[:file_interval_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: splunk_token must be an String") if params[:splunk_token] and !params[:splunk_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_dcr_immutable_id must be an String") if params[:azure_dcr_immutable_id] and !params[:azure_dcr_immutable_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_stream_name must be an String") if params[:azure_stream_name] and !params[:azure_stream_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_tenant_id must be an String") if params[:azure_oauth_client_credentials_tenant_id] and !params[:azure_oauth_client_credentials_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_id must be an String") if params[:azure_oauth_client_credentials_client_id] and !params[:azure_oauth_client_credentials_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_secret must be an String") if params[:azure_oauth_client_credentials_client_secret] and !params[:azure_oauth_client_credentials_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_username must be an String") if params[:qradar_username] and !params[:qradar_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_password must be an String") if params[:qradar_password] and !params[:qradar_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: solar_winds_token must be an String") if params[:solar_winds_token] and !params[:solar_winds_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: new_relic_api_key must be an String") if params[:new_relic_api_key] and !params[:new_relic_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: datadog_api_key must be an String") if params[:datadog_api_key] and !params[:datadog_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_type must be an String") if params[:destination_type] and !params[:destination_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_url must be an String") if params[:destination_url] and !params[:destination_url].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/siem_http_destinations/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/siem_http_destinations/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = SiemHttpDestination.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      List.new(SiemHttpDestination, params) do
        Api.send_request("/siem_http_destinations", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Siem Http Destination ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/siem_http_destinations/#{params[:id]}", :get, params, options)
      SiemHttpDestination.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   name - string - Name for this Destination
    #   additional_headers - object - Additional HTTP Headers included in calls to the destination URL
    #   sending_active - boolean - Whether this SIEM HTTP Destination is currently being sent to or not
    #   generic_payload_type - string - Applicable only for destination type: generic. Indicates the type of HTTP body. Can be json_newline or json_array. json_newline is multiple log entries as JSON separated by newlines. json_array is a single JSON array containing multiple log entries as JSON.
    #   file_destination_path - string - Applicable only for destination type: file. Destination folder path on Files.com.
    #   file_format - string - Applicable only for destination type: file. Generated file format.
    #   file_interval_minutes - int64 - Applicable only for destination type: file. Interval, in minutes, between file deliveries. Valid values are 5, 10, 15, 20, 30, 60, 90, 180, 240, 360.
    #   splunk_token - string - Applicable only for destination type: splunk. Authentication token provided by Splunk.
    #   azure_dcr_immutable_id - string - Applicable only for destination types: azure, azure_legacy. Immutable ID of the Data Collection Rule.
    #   azure_stream_name - string - Applicable only for destination type: azure. Name of the stream in the DCR that represents the destination table.
    #   azure_oauth_client_credentials_tenant_id - string - Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Tenant ID.
    #   azure_oauth_client_credentials_client_id - string - Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Client ID.
    #   azure_oauth_client_credentials_client_secret - string - Applicable only for destination type: azure. Client Credentials OAuth Client Secret.
    #   qradar_username - string - Applicable only for destination type: qradar. Basic auth username provided by QRadar.
    #   qradar_password - string - Applicable only for destination type: qradar. Basic auth password provided by QRadar.
    #   solar_winds_token - string - Applicable only for destination type: solar_winds. Authentication token provided by Solar Winds.
    #   new_relic_api_key - string - Applicable only for destination type: new_relic. API key provided by New Relic.
    #   datadog_api_key - string - Applicable only for destination type: datadog. API key provided by Datadog.
    #   sftp_action_send_enabled - boolean - Whether or not sending is enabled for sftp_action logs.
    #   ftp_action_send_enabled - boolean - Whether or not sending is enabled for ftp_action logs.
    #   web_dav_action_send_enabled - boolean - Whether or not sending is enabled for web_dav_action logs.
    #   sync_send_enabled - boolean - Whether or not sending is enabled for sync logs.
    #   outbound_connection_send_enabled - boolean - Whether or not sending is enabled for outbound_connection logs.
    #   automation_send_enabled - boolean - Whether or not sending is enabled for automation logs.
    #   api_request_send_enabled - boolean - Whether or not sending is enabled for api_request logs.
    #   public_hosting_request_send_enabled - boolean - Whether or not sending is enabled for public_hosting_request logs.
    #   email_send_enabled - boolean - Whether or not sending is enabled for email logs.
    #   exavault_api_request_send_enabled - boolean - Whether or not sending is enabled for exavault_api_request logs.
    #   settings_change_send_enabled - boolean - Whether or not sending is enabled for settings_change logs.
    #   destination_type (required) - string - Destination Type
    #   destination_url - string - Destination Url
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: additional_headers must be an Hash") if params[:additional_headers] and !params[:additional_headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: generic_payload_type must be an String") if params[:generic_payload_type] and !params[:generic_payload_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_destination_path must be an String") if params[:file_destination_path] and !params[:file_destination_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_format must be an String") if params[:file_format] and !params[:file_format].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_interval_minutes must be an Integer") if params[:file_interval_minutes] and !params[:file_interval_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: splunk_token must be an String") if params[:splunk_token] and !params[:splunk_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_dcr_immutable_id must be an String") if params[:azure_dcr_immutable_id] and !params[:azure_dcr_immutable_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_stream_name must be an String") if params[:azure_stream_name] and !params[:azure_stream_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_tenant_id must be an String") if params[:azure_oauth_client_credentials_tenant_id] and !params[:azure_oauth_client_credentials_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_id must be an String") if params[:azure_oauth_client_credentials_client_id] and !params[:azure_oauth_client_credentials_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_secret must be an String") if params[:azure_oauth_client_credentials_client_secret] and !params[:azure_oauth_client_credentials_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_username must be an String") if params[:qradar_username] and !params[:qradar_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_password must be an String") if params[:qradar_password] and !params[:qradar_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: solar_winds_token must be an String") if params[:solar_winds_token] and !params[:solar_winds_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: new_relic_api_key must be an String") if params[:new_relic_api_key] and !params[:new_relic_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: datadog_api_key must be an String") if params[:datadog_api_key] and !params[:datadog_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_type must be an String") if params[:destination_type] and !params[:destination_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_url must be an String") if params[:destination_url] and !params[:destination_url].is_a?(String)
      raise MissingParameterError.new("Parameter missing: destination_type") unless params[:destination_type]

      response, options = Api.send_request("/siem_http_destinations", :post, params, options)
      SiemHttpDestination.new(response.data, options)
    end

    # Parameters:
    #   siem_http_destination_id - int64 - SIEM HTTP Destination ID
    #   destination_type - string - Destination Type
    #   destination_url - string - Destination Url
    #   name - string - Name for this Destination
    #   additional_headers - object - Additional HTTP Headers included in calls to the destination URL
    #   sending_active - boolean - Whether this SIEM HTTP Destination is currently being sent to or not
    #   generic_payload_type - string - Applicable only for destination type: generic. Indicates the type of HTTP body. Can be json_newline or json_array. json_newline is multiple log entries as JSON separated by newlines. json_array is a single JSON array containing multiple log entries as JSON.
    #   file_destination_path - string - Applicable only for destination type: file. Destination folder path on Files.com.
    #   file_format - string - Applicable only for destination type: file. Generated file format.
    #   file_interval_minutes - int64 - Applicable only for destination type: file. Interval, in minutes, between file deliveries. Valid values are 5, 10, 15, 20, 30, 60, 90, 180, 240, 360.
    #   splunk_token - string - Applicable only for destination type: splunk. Authentication token provided by Splunk.
    #   azure_dcr_immutable_id - string - Applicable only for destination types: azure, azure_legacy. Immutable ID of the Data Collection Rule.
    #   azure_stream_name - string - Applicable only for destination type: azure. Name of the stream in the DCR that represents the destination table.
    #   azure_oauth_client_credentials_tenant_id - string - Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Tenant ID.
    #   azure_oauth_client_credentials_client_id - string - Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Client ID.
    #   azure_oauth_client_credentials_client_secret - string - Applicable only for destination type: azure. Client Credentials OAuth Client Secret.
    #   qradar_username - string - Applicable only for destination type: qradar. Basic auth username provided by QRadar.
    #   qradar_password - string - Applicable only for destination type: qradar. Basic auth password provided by QRadar.
    #   solar_winds_token - string - Applicable only for destination type: solar_winds. Authentication token provided by Solar Winds.
    #   new_relic_api_key - string - Applicable only for destination type: new_relic. API key provided by New Relic.
    #   datadog_api_key - string - Applicable only for destination type: datadog. API key provided by Datadog.
    #   sftp_action_send_enabled - boolean - Whether or not sending is enabled for sftp_action logs.
    #   ftp_action_send_enabled - boolean - Whether or not sending is enabled for ftp_action logs.
    #   web_dav_action_send_enabled - boolean - Whether or not sending is enabled for web_dav_action logs.
    #   sync_send_enabled - boolean - Whether or not sending is enabled for sync logs.
    #   outbound_connection_send_enabled - boolean - Whether or not sending is enabled for outbound_connection logs.
    #   automation_send_enabled - boolean - Whether or not sending is enabled for automation logs.
    #   api_request_send_enabled - boolean - Whether or not sending is enabled for api_request logs.
    #   public_hosting_request_send_enabled - boolean - Whether or not sending is enabled for public_hosting_request logs.
    #   email_send_enabled - boolean - Whether or not sending is enabled for email logs.
    #   exavault_api_request_send_enabled - boolean - Whether or not sending is enabled for exavault_api_request logs.
    #   settings_change_send_enabled - boolean - Whether or not sending is enabled for settings_change logs.
    def self.send_test_entry(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: siem_http_destination_id must be an Integer") if params[:siem_http_destination_id] and !params[:siem_http_destination_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: destination_type must be an String") if params[:destination_type] and !params[:destination_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_url must be an String") if params[:destination_url] and !params[:destination_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: additional_headers must be an Hash") if params[:additional_headers] and !params[:additional_headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: generic_payload_type must be an String") if params[:generic_payload_type] and !params[:generic_payload_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_destination_path must be an String") if params[:file_destination_path] and !params[:file_destination_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_format must be an String") if params[:file_format] and !params[:file_format].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_interval_minutes must be an Integer") if params[:file_interval_minutes] and !params[:file_interval_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: splunk_token must be an String") if params[:splunk_token] and !params[:splunk_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_dcr_immutable_id must be an String") if params[:azure_dcr_immutable_id] and !params[:azure_dcr_immutable_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_stream_name must be an String") if params[:azure_stream_name] and !params[:azure_stream_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_tenant_id must be an String") if params[:azure_oauth_client_credentials_tenant_id] and !params[:azure_oauth_client_credentials_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_id must be an String") if params[:azure_oauth_client_credentials_client_id] and !params[:azure_oauth_client_credentials_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_secret must be an String") if params[:azure_oauth_client_credentials_client_secret] and !params[:azure_oauth_client_credentials_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_username must be an String") if params[:qradar_username] and !params[:qradar_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_password must be an String") if params[:qradar_password] and !params[:qradar_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: solar_winds_token must be an String") if params[:solar_winds_token] and !params[:solar_winds_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: new_relic_api_key must be an String") if params[:new_relic_api_key] and !params[:new_relic_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: datadog_api_key must be an String") if params[:datadog_api_key] and !params[:datadog_api_key].is_a?(String)

      Api.send_request("/siem_http_destinations/send_test_entry", :post, params, options)
      nil
    end

    # Parameters:
    #   name - string - Name for this Destination
    #   additional_headers - object - Additional HTTP Headers included in calls to the destination URL
    #   sending_active - boolean - Whether this SIEM HTTP Destination is currently being sent to or not
    #   generic_payload_type - string - Applicable only for destination type: generic. Indicates the type of HTTP body. Can be json_newline or json_array. json_newline is multiple log entries as JSON separated by newlines. json_array is a single JSON array containing multiple log entries as JSON.
    #   file_destination_path - string - Applicable only for destination type: file. Destination folder path on Files.com.
    #   file_format - string - Applicable only for destination type: file. Generated file format.
    #   file_interval_minutes - int64 - Applicable only for destination type: file. Interval, in minutes, between file deliveries. Valid values are 5, 10, 15, 20, 30, 60, 90, 180, 240, 360.
    #   splunk_token - string - Applicable only for destination type: splunk. Authentication token provided by Splunk.
    #   azure_dcr_immutable_id - string - Applicable only for destination types: azure, azure_legacy. Immutable ID of the Data Collection Rule.
    #   azure_stream_name - string - Applicable only for destination type: azure. Name of the stream in the DCR that represents the destination table.
    #   azure_oauth_client_credentials_tenant_id - string - Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Tenant ID.
    #   azure_oauth_client_credentials_client_id - string - Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Client ID.
    #   azure_oauth_client_credentials_client_secret - string - Applicable only for destination type: azure. Client Credentials OAuth Client Secret.
    #   qradar_username - string - Applicable only for destination type: qradar. Basic auth username provided by QRadar.
    #   qradar_password - string - Applicable only for destination type: qradar. Basic auth password provided by QRadar.
    #   solar_winds_token - string - Applicable only for destination type: solar_winds. Authentication token provided by Solar Winds.
    #   new_relic_api_key - string - Applicable only for destination type: new_relic. API key provided by New Relic.
    #   datadog_api_key - string - Applicable only for destination type: datadog. API key provided by Datadog.
    #   sftp_action_send_enabled - boolean - Whether or not sending is enabled for sftp_action logs.
    #   ftp_action_send_enabled - boolean - Whether or not sending is enabled for ftp_action logs.
    #   web_dav_action_send_enabled - boolean - Whether or not sending is enabled for web_dav_action logs.
    #   sync_send_enabled - boolean - Whether or not sending is enabled for sync logs.
    #   outbound_connection_send_enabled - boolean - Whether or not sending is enabled for outbound_connection logs.
    #   automation_send_enabled - boolean - Whether or not sending is enabled for automation logs.
    #   api_request_send_enabled - boolean - Whether or not sending is enabled for api_request logs.
    #   public_hosting_request_send_enabled - boolean - Whether or not sending is enabled for public_hosting_request logs.
    #   email_send_enabled - boolean - Whether or not sending is enabled for email logs.
    #   exavault_api_request_send_enabled - boolean - Whether or not sending is enabled for exavault_api_request logs.
    #   settings_change_send_enabled - boolean - Whether or not sending is enabled for settings_change logs.
    #   destination_type - string - Destination Type
    #   destination_url - string - Destination Url
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: additional_headers must be an Hash") if params[:additional_headers] and !params[:additional_headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: generic_payload_type must be an String") if params[:generic_payload_type] and !params[:generic_payload_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_destination_path must be an String") if params[:file_destination_path] and !params[:file_destination_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_format must be an String") if params[:file_format] and !params[:file_format].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_interval_minutes must be an Integer") if params[:file_interval_minutes] and !params[:file_interval_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: splunk_token must be an String") if params[:splunk_token] and !params[:splunk_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_dcr_immutable_id must be an String") if params[:azure_dcr_immutable_id] and !params[:azure_dcr_immutable_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_stream_name must be an String") if params[:azure_stream_name] and !params[:azure_stream_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_tenant_id must be an String") if params[:azure_oauth_client_credentials_tenant_id] and !params[:azure_oauth_client_credentials_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_id must be an String") if params[:azure_oauth_client_credentials_client_id] and !params[:azure_oauth_client_credentials_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_secret must be an String") if params[:azure_oauth_client_credentials_client_secret] and !params[:azure_oauth_client_credentials_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_username must be an String") if params[:qradar_username] and !params[:qradar_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_password must be an String") if params[:qradar_password] and !params[:qradar_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: solar_winds_token must be an String") if params[:solar_winds_token] and !params[:solar_winds_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: new_relic_api_key must be an String") if params[:new_relic_api_key] and !params[:new_relic_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: datadog_api_key must be an String") if params[:datadog_api_key] and !params[:datadog_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_type must be an String") if params[:destination_type] and !params[:destination_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_url must be an String") if params[:destination_url] and !params[:destination_url].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/siem_http_destinations/#{params[:id]}", :patch, params, options)
      SiemHttpDestination.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/siem_http_destinations/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
