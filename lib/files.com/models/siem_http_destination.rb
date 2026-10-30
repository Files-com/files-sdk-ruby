# frozen_string_literal: true

module Files
  # Files::SiemHttpDestination is the Ruby SDK's representation of Files.com API SiemHttpDestination objects.
  # Each instance keeps its API field values in +attributes+.
  class SiemHttpDestination
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

    # SIEM HTTP Destination ID
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

    # Name for this Destination
    # @return [String, nil] the field value, or nil when absent.
    def name
      @attributes[:name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def name=(value)
      @attributes[:name] = value
    end

    # Destination Type
    # @return [String, nil] the field value, or nil when absent.
    def destination_type
      @attributes[:destination_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def destination_type=(value)
      @attributes[:destination_type] = value
    end

    # Destination Url
    # @return [String, nil] the field value, or nil when absent.
    def destination_url
      @attributes[:destination_url]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def destination_url=(value)
      @attributes[:destination_url] = value
    end

    # Applicable only for destination type: file. Destination folder path on Files.com.
    # @return [String, nil] the field value, or nil when absent.
    def file_destination_path
      @attributes[:file_destination_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def file_destination_path=(value)
      @attributes[:file_destination_path] = value
    end

    # Applicable only for destination type: file. Generated file format.
    # @return [String, nil] the field value, or nil when absent.
    def file_format
      @attributes[:file_format]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def file_format=(value)
      @attributes[:file_format] = value
    end

    # Applicable only for destination type: file. Interval, in minutes, between file deliveries.
    # @return [Integer, nil] the field value, or nil when absent.
    def file_interval_minutes
      @attributes[:file_interval_minutes]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def file_interval_minutes=(value)
      @attributes[:file_interval_minutes] = value
    end

    # Additional HTTP Headers included in calls to the destination URL
    # @return [Hash, nil] the field value, or nil when absent.
    def additional_headers
      @attributes[:additional_headers]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def additional_headers=(value)
      @attributes[:additional_headers] = value
    end

    # Whether this SIEM HTTP Destination is currently being sent to or not
    # @return [Boolean, nil] the field value, or nil when absent.
    def sending_active
      @attributes[:sending_active]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def sending_active=(value)
      @attributes[:sending_active] = value
    end

    # Applicable only for destination type: generic. Indicates the type of HTTP body. Can be json_newline or json_array. json_newline is multiple log entries as JSON separated by newlines. json_array is a single JSON array containing multiple log entries as JSON.
    # @return [String, nil] the field value, or nil when absent.
    def generic_payload_type
      @attributes[:generic_payload_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def generic_payload_type=(value)
      @attributes[:generic_payload_type] = value
    end

    # Applicable only for destination types: splunk, splunk_compatible. Authentication token for the destination.
    # @return [String, nil] the field value, or nil when absent.
    def splunk_token_masked
      @attributes[:splunk_token_masked]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def splunk_token_masked=(value)
      @attributes[:splunk_token_masked] = value
    end

    # Applicable only for destination type: crowdstrike. Authentication token provided by Crowdstrike.
    # @return [String, nil] the field value, or nil when absent.
    def crowdstrike_token_masked
      @attributes[:crowdstrike_token_masked]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def crowdstrike_token_masked=(value)
      @attributes[:crowdstrike_token_masked] = value
    end

    # Applicable only for destination types: azure, azure_legacy. Immutable ID of the Data Collection Rule.
    # @return [String, nil] the field value, or nil when absent.
    def azure_dcr_immutable_id
      @attributes[:azure_dcr_immutable_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_dcr_immutable_id=(value)
      @attributes[:azure_dcr_immutable_id] = value
    end

    # Applicable only for destination type: azure. Name of the stream in the DCR that represents the destination table.
    # @return [String, nil] the field value, or nil when absent.
    def azure_stream_name
      @attributes[:azure_stream_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_stream_name=(value)
      @attributes[:azure_stream_name] = value
    end

    # Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Tenant ID.
    # @return [String, nil] the field value, or nil when absent.
    def azure_oauth_client_credentials_tenant_id
      @attributes[:azure_oauth_client_credentials_tenant_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_oauth_client_credentials_tenant_id=(value)
      @attributes[:azure_oauth_client_credentials_tenant_id] = value
    end

    # Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Client ID.
    # @return [String, nil] the field value, or nil when absent.
    def azure_oauth_client_credentials_client_id
      @attributes[:azure_oauth_client_credentials_client_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_oauth_client_credentials_client_id=(value)
      @attributes[:azure_oauth_client_credentials_client_id] = value
    end

    # Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Client Secret.
    # @return [String, nil] the field value, or nil when absent.
    def azure_oauth_client_credentials_client_secret_masked
      @attributes[:azure_oauth_client_credentials_client_secret_masked]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_oauth_client_credentials_client_secret_masked=(value)
      @attributes[:azure_oauth_client_credentials_client_secret_masked] = value
    end

    # Applicable only for destination type: qradar. Basic auth username provided by QRadar.
    # @return [String, nil] the field value, or nil when absent.
    def qradar_username
      @attributes[:qradar_username]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def qradar_username=(value)
      @attributes[:qradar_username] = value
    end

    # Applicable only for destination type: qradar. Basic auth password provided by QRadar.
    # @return [String, nil] the field value, or nil when absent.
    def qradar_password_masked
      @attributes[:qradar_password_masked]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def qradar_password_masked=(value)
      @attributes[:qradar_password_masked] = value
    end

    # Applicable only for destination type: solar_winds. Authentication token provided by Solar Winds.
    # @return [String, nil] the field value, or nil when absent.
    def solar_winds_token_masked
      @attributes[:solar_winds_token_masked]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def solar_winds_token_masked=(value)
      @attributes[:solar_winds_token_masked] = value
    end

    # Applicable only for destination type: new_relic. API key provided by New Relic.
    # @return [String, nil] the field value, or nil when absent.
    def new_relic_api_key_masked
      @attributes[:new_relic_api_key_masked]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def new_relic_api_key_masked=(value)
      @attributes[:new_relic_api_key_masked] = value
    end

    # Applicable only for destination type: datadog. API key provided by Datadog.
    # @return [String, nil] the field value, or nil when absent.
    def datadog_api_key_masked
      @attributes[:datadog_api_key_masked]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def datadog_api_key_masked=(value)
      @attributes[:datadog_api_key_masked] = value
    end

    # Whether or not sending is enabled for action logs.
    # @return [Boolean, nil] the field value, or nil when absent.
    def action_send_enabled
      @attributes[:action_send_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def action_send_enabled=(value)
      @attributes[:action_send_enabled] = value
    end

    # Number of log entries sent for the lifetime of this destination.
    # @return [Integer, nil] the field value, or nil when absent.
    def action_entries_sent
      @attributes[:action_entries_sent]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def action_entries_sent=(value)
      @attributes[:action_entries_sent] = value
    end

    # Whether or not sending is enabled for sftp_action logs.
    # @return [Boolean, nil] the field value, or nil when absent.
    def sftp_action_send_enabled
      @attributes[:sftp_action_send_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def sftp_action_send_enabled=(value)
      @attributes[:sftp_action_send_enabled] = value
    end

    # Number of log entries sent for the lifetime of this destination.
    # @return [Integer, nil] the field value, or nil when absent.
    def sftp_action_entries_sent
      @attributes[:sftp_action_entries_sent]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def sftp_action_entries_sent=(value)
      @attributes[:sftp_action_entries_sent] = value
    end

    # Whether or not sending is enabled for ftp_action logs.
    # @return [Boolean, nil] the field value, or nil when absent.
    def ftp_action_send_enabled
      @attributes[:ftp_action_send_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def ftp_action_send_enabled=(value)
      @attributes[:ftp_action_send_enabled] = value
    end

    # Number of log entries sent for the lifetime of this destination.
    # @return [Integer, nil] the field value, or nil when absent.
    def ftp_action_entries_sent
      @attributes[:ftp_action_entries_sent]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def ftp_action_entries_sent=(value)
      @attributes[:ftp_action_entries_sent] = value
    end

    # Whether or not sending is enabled for web_dav_action logs.
    # @return [Boolean, nil] the field value, or nil when absent.
    def web_dav_action_send_enabled
      @attributes[:web_dav_action_send_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def web_dav_action_send_enabled=(value)
      @attributes[:web_dav_action_send_enabled] = value
    end

    # Number of log entries sent for the lifetime of this destination.
    # @return [Integer, nil] the field value, or nil when absent.
    def web_dav_action_entries_sent
      @attributes[:web_dav_action_entries_sent]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def web_dav_action_entries_sent=(value)
      @attributes[:web_dav_action_entries_sent] = value
    end

    # Whether or not sending is enabled for sync logs.
    # @return [Boolean, nil] the field value, or nil when absent.
    def sync_send_enabled
      @attributes[:sync_send_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def sync_send_enabled=(value)
      @attributes[:sync_send_enabled] = value
    end

    # Number of log entries sent for the lifetime of this destination.
    # @return [Integer, nil] the field value, or nil when absent.
    def sync_entries_sent
      @attributes[:sync_entries_sent]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def sync_entries_sent=(value)
      @attributes[:sync_entries_sent] = value
    end

    # Whether or not sending is enabled for outbound_connection logs.
    # @return [Boolean, nil] the field value, or nil when absent.
    def outbound_connection_send_enabled
      @attributes[:outbound_connection_send_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def outbound_connection_send_enabled=(value)
      @attributes[:outbound_connection_send_enabled] = value
    end

    # Number of log entries sent for the lifetime of this destination.
    # @return [Integer, nil] the field value, or nil when absent.
    def outbound_connection_entries_sent
      @attributes[:outbound_connection_entries_sent]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def outbound_connection_entries_sent=(value)
      @attributes[:outbound_connection_entries_sent] = value
    end

    # Whether or not sending is enabled for automation logs.
    # @return [Boolean, nil] the field value, or nil when absent.
    def automation_send_enabled
      @attributes[:automation_send_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def automation_send_enabled=(value)
      @attributes[:automation_send_enabled] = value
    end

    # Number of log entries sent for the lifetime of this destination.
    # @return [Integer, nil] the field value, or nil when absent.
    def automation_entries_sent
      @attributes[:automation_entries_sent]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def automation_entries_sent=(value)
      @attributes[:automation_entries_sent] = value
    end

    # Whether or not sending is enabled for api_request logs.
    # @return [Boolean, nil] the field value, or nil when absent.
    def api_request_send_enabled
      @attributes[:api_request_send_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def api_request_send_enabled=(value)
      @attributes[:api_request_send_enabled] = value
    end

    # Number of log entries sent for the lifetime of this destination.
    # @return [Integer, nil] the field value, or nil when absent.
    def api_request_entries_sent
      @attributes[:api_request_entries_sent]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def api_request_entries_sent=(value)
      @attributes[:api_request_entries_sent] = value
    end

    # Whether or not sending is enabled for public_hosting_request logs.
    # @return [Boolean, nil] the field value, or nil when absent.
    def public_hosting_request_send_enabled
      @attributes[:public_hosting_request_send_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def public_hosting_request_send_enabled=(value)
      @attributes[:public_hosting_request_send_enabled] = value
    end

    # Number of log entries sent for the lifetime of this destination.
    # @return [Integer, nil] the field value, or nil when absent.
    def public_hosting_request_entries_sent
      @attributes[:public_hosting_request_entries_sent]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def public_hosting_request_entries_sent=(value)
      @attributes[:public_hosting_request_entries_sent] = value
    end

    # Whether or not sending is enabled for email logs.
    # @return [Boolean, nil] the field value, or nil when absent.
    def email_send_enabled
      @attributes[:email_send_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def email_send_enabled=(value)
      @attributes[:email_send_enabled] = value
    end

    # Number of log entries sent for the lifetime of this destination.
    # @return [Integer, nil] the field value, or nil when absent.
    def email_entries_sent
      @attributes[:email_entries_sent]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def email_entries_sent=(value)
      @attributes[:email_entries_sent] = value
    end

    # Whether or not sending is enabled for exavault_api_request logs.
    # @return [Boolean, nil] the field value, or nil when absent.
    def exavault_api_request_send_enabled
      @attributes[:exavault_api_request_send_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def exavault_api_request_send_enabled=(value)
      @attributes[:exavault_api_request_send_enabled] = value
    end

    # Number of log entries sent for the lifetime of this destination.
    # @return [Integer, nil] the field value, or nil when absent.
    def exavault_api_request_entries_sent
      @attributes[:exavault_api_request_entries_sent]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def exavault_api_request_entries_sent=(value)
      @attributes[:exavault_api_request_entries_sent] = value
    end

    # Whether or not sending is enabled for settings_change logs.
    # @return [Boolean, nil] the field value, or nil when absent.
    def settings_change_send_enabled
      @attributes[:settings_change_send_enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def settings_change_send_enabled=(value)
      @attributes[:settings_change_send_enabled] = value
    end

    # Number of log entries sent for the lifetime of this destination.
    # @return [Integer, nil] the field value, or nil when absent.
    def settings_change_entries_sent
      @attributes[:settings_change_entries_sent]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def settings_change_entries_sent=(value)
      @attributes[:settings_change_entries_sent] = value
    end

    # Type of URL that was last called. Can be `destination_url` or `azure_oauth_client_credentials_url`
    # @return [String, nil] the field value, or nil when absent.
    def last_http_call_target_type
      @attributes[:last_http_call_target_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_http_call_target_type=(value)
      @attributes[:last_http_call_target_type] = value
    end

    # Was the last HTTP call made successful?
    # @return [Boolean, nil] the field value, or nil when absent.
    def last_http_call_success
      @attributes[:last_http_call_success]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def last_http_call_success=(value)
      @attributes[:last_http_call_success] = value
    end

    # Last HTTP Call Response Code
    # @return [Integer, nil] the field value, or nil when absent.
    def last_http_call_response_code
      @attributes[:last_http_call_response_code]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def last_http_call_response_code=(value)
      @attributes[:last_http_call_response_code] = value
    end

    # Last HTTP Call Response Body. Large responses are truncated.
    # @return [String, nil] the field value, or nil when absent.
    def last_http_call_response_body
      @attributes[:last_http_call_response_body]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_http_call_response_body=(value)
      @attributes[:last_http_call_response_body] = value
    end

    # Last HTTP Call Error Message if applicable
    # @return [String, nil] the field value, or nil when absent.
    def last_http_call_error_message
      @attributes[:last_http_call_error_message]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_http_call_error_message=(value)
      @attributes[:last_http_call_error_message] = value
    end

    # Time of Last HTTP Call
    # @return [String, nil] the field value, or nil when absent.
    def last_http_call_time
      @attributes[:last_http_call_time]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def last_http_call_time=(value)
      @attributes[:last_http_call_time] = value
    end

    # Duration of the last HTTP Call in milliseconds
    # @return [Integer, nil] the field value, or nil when absent.
    def last_http_call_duration_ms
      @attributes[:last_http_call_duration_ms]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def last_http_call_duration_ms=(value)
      @attributes[:last_http_call_duration_ms] = value
    end

    # Time of Most Recent Successful HTTP Call
    # @return [String, nil] the field value, or nil when absent.
    def most_recent_http_call_success_time
      @attributes[:most_recent_http_call_success_time]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def most_recent_http_call_success_time=(value)
      @attributes[:most_recent_http_call_success_time] = value
    end

    # Connection Test Entry
    # @return [String, nil] the field value, or nil when absent.
    def connection_test_entry
      @attributes[:connection_test_entry]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def connection_test_entry=(value)
      @attributes[:connection_test_entry] = value
    end

    # Applicable only for destination types: splunk, splunk_compatible. Authentication token for the destination.
    # @return [String, nil] the field value, or nil when absent.
    def splunk_token
      @attributes[:splunk_token]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def splunk_token=(value)
      @attributes[:splunk_token] = value
    end

    # Applicable only for destination type: crowdstrike. Authentication token provided by Crowdstrike.
    # @return [String, nil] the field value, or nil when absent.
    def crowdstrike_token
      @attributes[:crowdstrike_token]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def crowdstrike_token=(value)
      @attributes[:crowdstrike_token] = value
    end

    # Applicable only for destination type: azure. Client Credentials OAuth Client Secret.
    # @return [String, nil] the field value, or nil when absent.
    def azure_oauth_client_credentials_client_secret
      @attributes[:azure_oauth_client_credentials_client_secret]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def azure_oauth_client_credentials_client_secret=(value)
      @attributes[:azure_oauth_client_credentials_client_secret] = value
    end

    # Applicable only for destination type: qradar. Basic auth password provided by QRadar.
    # @return [String, nil] the field value, or nil when absent.
    def qradar_password
      @attributes[:qradar_password]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def qradar_password=(value)
      @attributes[:qradar_password] = value
    end

    # Applicable only for destination type: solar_winds. Authentication token provided by Solar Winds.
    # @return [String, nil] the field value, or nil when absent.
    def solar_winds_token
      @attributes[:solar_winds_token]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def solar_winds_token=(value)
      @attributes[:solar_winds_token] = value
    end

    # Applicable only for destination type: new_relic. API key provided by New Relic.
    # @return [String, nil] the field value, or nil when absent.
    def new_relic_api_key
      @attributes[:new_relic_api_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def new_relic_api_key=(value)
      @attributes[:new_relic_api_key] = value
    end

    # Applicable only for destination type: datadog. API key provided by Datadog.
    # @return [String, nil] the field value, or nil when absent.
    def datadog_api_key
      @attributes[:datadog_api_key]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def datadog_api_key=(value)
      @attributes[:datadog_api_key] = value
    end

    # Update SIEM HTTP Destination
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Name for this Destination
    # @option params [Hash] additional_headers Additional HTTP Headers included in calls to the destination URL
    # @option params [Boolean] sending_active Whether this SIEM HTTP Destination is currently being sent to or not
    # @option params [String] generic_payload_type Applicable only for destination type: generic. Indicates the type of HTTP body. Can be json_newline or json_array. json_newline is multiple log entries as JSON separated by newlines. json_array is a single JSON array containing multiple log entries as JSON.
    # @option params [String] file_destination_path Applicable only for destination type: file. Destination folder path on Files.com.
    # @option params [String] file_format Applicable only for destination type: file. Generated file format.
    # @option params [Integer] file_interval_minutes Applicable only for destination type: file. Interval, in minutes, between file deliveries. Valid values are 5, 10, 15, 20, 30, 60, 90, 180, 240, 360.
    # @option params [String] splunk_token Applicable only for destination types: splunk, splunk_compatible. Authentication token for the destination.
    # @option params [String] crowdstrike_token Applicable only for destination type: crowdstrike. Authentication token provided by Crowdstrike.
    # @option params [String] azure_dcr_immutable_id Applicable only for destination types: azure, azure_legacy. Immutable ID of the Data Collection Rule.
    # @option params [String] azure_stream_name Applicable only for destination type: azure. Name of the stream in the DCR that represents the destination table.
    # @option params [String] azure_oauth_client_credentials_tenant_id Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Tenant ID.
    # @option params [String] azure_oauth_client_credentials_client_id Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Client ID.
    # @option params [String] azure_oauth_client_credentials_client_secret Applicable only for destination type: azure. Client Credentials OAuth Client Secret.
    # @option params [String] qradar_username Applicable only for destination type: qradar. Basic auth username provided by QRadar.
    # @option params [String] qradar_password Applicable only for destination type: qradar. Basic auth password provided by QRadar.
    # @option params [String] solar_winds_token Applicable only for destination type: solar_winds. Authentication token provided by Solar Winds.
    # @option params [String] new_relic_api_key Applicable only for destination type: new_relic. API key provided by New Relic.
    # @option params [String] datadog_api_key Applicable only for destination type: datadog. API key provided by Datadog.
    # @option params [Boolean] action_send_enabled Whether or not sending is enabled for action logs.
    # @option params [Boolean] sftp_action_send_enabled Whether or not sending is enabled for sftp_action logs.
    # @option params [Boolean] ftp_action_send_enabled Whether or not sending is enabled for ftp_action logs.
    # @option params [Boolean] web_dav_action_send_enabled Whether or not sending is enabled for web_dav_action logs.
    # @option params [Boolean] sync_send_enabled Whether or not sending is enabled for sync logs.
    # @option params [Boolean] outbound_connection_send_enabled Whether or not sending is enabled for outbound_connection logs.
    # @option params [Boolean] automation_send_enabled Whether or not sending is enabled for automation logs.
    # @option params [Boolean] api_request_send_enabled Whether or not sending is enabled for api_request logs.
    # @option params [Boolean] public_hosting_request_send_enabled Whether or not sending is enabled for public_hosting_request logs.
    # @option params [Boolean] email_send_enabled Whether or not sending is enabled for email logs.
    # @option params [Boolean] exavault_api_request_send_enabled Whether or not sending is enabled for exavault_api_request logs.
    # @option params [Boolean] settings_change_send_enabled Whether or not sending is enabled for settings_change logs.
    # @option params [String] destination_type Destination Type
    # @option params [String] destination_url Destination Url
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: additional_headers must be an Hash") if !params[:additional_headers].nil? and !params[:additional_headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: sending_active must be a single value, not #{params[:sending_active].class}") if [ Array, Hash ].any? { |klass| params[:sending_active].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: generic_payload_type must be an String") if !params[:generic_payload_type].nil? and !params[:generic_payload_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_destination_path must be an String") if !params[:file_destination_path].nil? and !params[:file_destination_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_format must be an String") if !params[:file_format].nil? and !params[:file_format].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_interval_minutes must be an Integer") if !params[:file_interval_minutes].nil? and !params[:file_interval_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: splunk_token must be an String") if !params[:splunk_token].nil? and !params[:splunk_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: crowdstrike_token must be an String") if !params[:crowdstrike_token].nil? and !params[:crowdstrike_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_dcr_immutable_id must be an String") if !params[:azure_dcr_immutable_id].nil? and !params[:azure_dcr_immutable_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_stream_name must be an String") if !params[:azure_stream_name].nil? and !params[:azure_stream_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_tenant_id must be an String") if !params[:azure_oauth_client_credentials_tenant_id].nil? and !params[:azure_oauth_client_credentials_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_id must be an String") if !params[:azure_oauth_client_credentials_client_id].nil? and !params[:azure_oauth_client_credentials_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_secret must be an String") if !params[:azure_oauth_client_credentials_client_secret].nil? and !params[:azure_oauth_client_credentials_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_username must be an String") if !params[:qradar_username].nil? and !params[:qradar_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_password must be an String") if !params[:qradar_password].nil? and !params[:qradar_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: solar_winds_token must be an String") if !params[:solar_winds_token].nil? and !params[:solar_winds_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: new_relic_api_key must be an String") if !params[:new_relic_api_key].nil? and !params[:new_relic_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: datadog_api_key must be an String") if !params[:datadog_api_key].nil? and !params[:datadog_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action_send_enabled must be a single value, not #{params[:action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_action_send_enabled must be a single value, not #{params[:sftp_action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:sftp_action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ftp_action_send_enabled must be a single value, not #{params[:ftp_action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:ftp_action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: web_dav_action_send_enabled must be a single value, not #{params[:web_dav_action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:web_dav_action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sync_send_enabled must be a single value, not #{params[:sync_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:sync_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: outbound_connection_send_enabled must be a single value, not #{params[:outbound_connection_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:outbound_connection_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: automation_send_enabled must be a single value, not #{params[:automation_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:automation_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: api_request_send_enabled must be a single value, not #{params[:api_request_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:api_request_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: public_hosting_request_send_enabled must be a single value, not #{params[:public_hosting_request_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:public_hosting_request_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: email_send_enabled must be a single value, not #{params[:email_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:email_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: exavault_api_request_send_enabled must be a single value, not #{params[:exavault_api_request_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:exavault_api_request_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: settings_change_send_enabled must be a single value, not #{params[:settings_change_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:settings_change_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: destination_type must be an String") if !params[:destination_type].nil? and !params[:destination_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_url must be an String") if !params[:destination_url].nil? and !params[:destination_url].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/siem_http_destinations/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("SiemHttpDestination") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete SIEM HTTP Destination
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/siem_http_destinations/#{@attributes[:id]}", :delete, params, @options)
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
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = SiemHttpDestination.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List SIEM HTTP Destinations
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)

      list_options = options.dup
      List.new(SiemHttpDestination, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/siem_http_destinations", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show SIEM HTTP Destination
    #
    # @param id [Integer] Siem Http Destination ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::SiemHttpDestination] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/siem_http_destinations/#{params[:id]}", :get, params, options) { |reply| reply.require_object("SiemHttpDestination") }
      SiemHttpDestination.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create SIEM HTTP Destination
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Name for this Destination
    # @option params [Hash] additional_headers Additional HTTP Headers included in calls to the destination URL
    # @option params [Boolean] sending_active Whether this SIEM HTTP Destination is currently being sent to or not
    # @option params [String] generic_payload_type Applicable only for destination type: generic. Indicates the type of HTTP body. Can be json_newline or json_array. json_newline is multiple log entries as JSON separated by newlines. json_array is a single JSON array containing multiple log entries as JSON.
    # @option params [String] file_destination_path Applicable only for destination type: file. Destination folder path on Files.com.
    # @option params [String] file_format Applicable only for destination type: file. Generated file format.
    # @option params [Integer] file_interval_minutes Applicable only for destination type: file. Interval, in minutes, between file deliveries. Valid values are 5, 10, 15, 20, 30, 60, 90, 180, 240, 360.
    # @option params [String] splunk_token Applicable only for destination types: splunk, splunk_compatible. Authentication token for the destination.
    # @option params [String] crowdstrike_token Applicable only for destination type: crowdstrike. Authentication token provided by Crowdstrike.
    # @option params [String] azure_dcr_immutable_id Applicable only for destination types: azure, azure_legacy. Immutable ID of the Data Collection Rule.
    # @option params [String] azure_stream_name Applicable only for destination type: azure. Name of the stream in the DCR that represents the destination table.
    # @option params [String] azure_oauth_client_credentials_tenant_id Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Tenant ID.
    # @option params [String] azure_oauth_client_credentials_client_id Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Client ID.
    # @option params [String] azure_oauth_client_credentials_client_secret Applicable only for destination type: azure. Client Credentials OAuth Client Secret.
    # @option params [String] qradar_username Applicable only for destination type: qradar. Basic auth username provided by QRadar.
    # @option params [String] qradar_password Applicable only for destination type: qradar. Basic auth password provided by QRadar.
    # @option params [String] solar_winds_token Applicable only for destination type: solar_winds. Authentication token provided by Solar Winds.
    # @option params [String] new_relic_api_key Applicable only for destination type: new_relic. API key provided by New Relic.
    # @option params [String] datadog_api_key Applicable only for destination type: datadog. API key provided by Datadog.
    # @option params [Boolean] action_send_enabled Whether or not sending is enabled for action logs.
    # @option params [Boolean] sftp_action_send_enabled Whether or not sending is enabled for sftp_action logs.
    # @option params [Boolean] ftp_action_send_enabled Whether or not sending is enabled for ftp_action logs.
    # @option params [Boolean] web_dav_action_send_enabled Whether or not sending is enabled for web_dav_action logs.
    # @option params [Boolean] sync_send_enabled Whether or not sending is enabled for sync logs.
    # @option params [Boolean] outbound_connection_send_enabled Whether or not sending is enabled for outbound_connection logs.
    # @option params [Boolean] automation_send_enabled Whether or not sending is enabled for automation logs.
    # @option params [Boolean] api_request_send_enabled Whether or not sending is enabled for api_request logs.
    # @option params [Boolean] public_hosting_request_send_enabled Whether or not sending is enabled for public_hosting_request logs.
    # @option params [Boolean] email_send_enabled Whether or not sending is enabled for email logs.
    # @option params [Boolean] exavault_api_request_send_enabled Whether or not sending is enabled for exavault_api_request logs.
    # @option params [Boolean] settings_change_send_enabled Whether or not sending is enabled for settings_change logs.
    # @option params [String] destination_type Required. Destination Type
    # @option params [String] destination_url Destination Url
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::SiemHttpDestination] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: additional_headers must be an Hash") if !params[:additional_headers].nil? and !params[:additional_headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: sending_active must be a single value, not #{params[:sending_active].class}") if [ Array, Hash ].any? { |klass| params[:sending_active].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: generic_payload_type must be an String") if !params[:generic_payload_type].nil? and !params[:generic_payload_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_destination_path must be an String") if !params[:file_destination_path].nil? and !params[:file_destination_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_format must be an String") if !params[:file_format].nil? and !params[:file_format].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_interval_minutes must be an Integer") if !params[:file_interval_minutes].nil? and !params[:file_interval_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: splunk_token must be an String") if !params[:splunk_token].nil? and !params[:splunk_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: crowdstrike_token must be an String") if !params[:crowdstrike_token].nil? and !params[:crowdstrike_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_dcr_immutable_id must be an String") if !params[:azure_dcr_immutable_id].nil? and !params[:azure_dcr_immutable_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_stream_name must be an String") if !params[:azure_stream_name].nil? and !params[:azure_stream_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_tenant_id must be an String") if !params[:azure_oauth_client_credentials_tenant_id].nil? and !params[:azure_oauth_client_credentials_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_id must be an String") if !params[:azure_oauth_client_credentials_client_id].nil? and !params[:azure_oauth_client_credentials_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_secret must be an String") if !params[:azure_oauth_client_credentials_client_secret].nil? and !params[:azure_oauth_client_credentials_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_username must be an String") if !params[:qradar_username].nil? and !params[:qradar_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_password must be an String") if !params[:qradar_password].nil? and !params[:qradar_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: solar_winds_token must be an String") if !params[:solar_winds_token].nil? and !params[:solar_winds_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: new_relic_api_key must be an String") if !params[:new_relic_api_key].nil? and !params[:new_relic_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: datadog_api_key must be an String") if !params[:datadog_api_key].nil? and !params[:datadog_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action_send_enabled must be a single value, not #{params[:action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_action_send_enabled must be a single value, not #{params[:sftp_action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:sftp_action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ftp_action_send_enabled must be a single value, not #{params[:ftp_action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:ftp_action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: web_dav_action_send_enabled must be a single value, not #{params[:web_dav_action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:web_dav_action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sync_send_enabled must be a single value, not #{params[:sync_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:sync_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: outbound_connection_send_enabled must be a single value, not #{params[:outbound_connection_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:outbound_connection_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: automation_send_enabled must be a single value, not #{params[:automation_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:automation_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: api_request_send_enabled must be a single value, not #{params[:api_request_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:api_request_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: public_hosting_request_send_enabled must be a single value, not #{params[:public_hosting_request_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:public_hosting_request_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: email_send_enabled must be a single value, not #{params[:email_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:email_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: exavault_api_request_send_enabled must be a single value, not #{params[:exavault_api_request_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:exavault_api_request_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: settings_change_send_enabled must be a single value, not #{params[:settings_change_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:settings_change_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: destination_type must be an String") if !params[:destination_type].nil? and !params[:destination_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_url must be an String") if !params[:destination_url].nil? and !params[:destination_url].is_a?(String)
      raise MissingParameterError.new("Parameter missing: destination_type") if params[:destination_type].nil?

      response, options = Api.send_request("/siem_http_destinations", :post, params, options) { |reply| reply.require_object("SiemHttpDestination") }
      SiemHttpDestination.new(response.data, options)
    end

    # send_test_entry SIEM HTTP Destination
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] siem_http_destination_id SIEM HTTP Destination ID
    # @option params [String] destination_type Destination Type
    # @option params [String] destination_url Destination Url
    # @option params [String] name Name for this Destination
    # @option params [Hash] additional_headers Additional HTTP Headers included in calls to the destination URL
    # @option params [Boolean] sending_active Whether this SIEM HTTP Destination is currently being sent to or not
    # @option params [String] generic_payload_type Applicable only for destination type: generic. Indicates the type of HTTP body. Can be json_newline or json_array. json_newline is multiple log entries as JSON separated by newlines. json_array is a single JSON array containing multiple log entries as JSON.
    # @option params [String] file_destination_path Applicable only for destination type: file. Destination folder path on Files.com.
    # @option params [String] file_format Applicable only for destination type: file. Generated file format.
    # @option params [Integer] file_interval_minutes Applicable only for destination type: file. Interval, in minutes, between file deliveries. Valid values are 5, 10, 15, 20, 30, 60, 90, 180, 240, 360.
    # @option params [String] splunk_token Applicable only for destination types: splunk, splunk_compatible. Authentication token for the destination.
    # @option params [String] crowdstrike_token Applicable only for destination type: crowdstrike. Authentication token provided by Crowdstrike.
    # @option params [String] azure_dcr_immutable_id Applicable only for destination types: azure, azure_legacy. Immutable ID of the Data Collection Rule.
    # @option params [String] azure_stream_name Applicable only for destination type: azure. Name of the stream in the DCR that represents the destination table.
    # @option params [String] azure_oauth_client_credentials_tenant_id Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Tenant ID.
    # @option params [String] azure_oauth_client_credentials_client_id Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Client ID.
    # @option params [String] azure_oauth_client_credentials_client_secret Applicable only for destination type: azure. Client Credentials OAuth Client Secret.
    # @option params [String] qradar_username Applicable only for destination type: qradar. Basic auth username provided by QRadar.
    # @option params [String] qradar_password Applicable only for destination type: qradar. Basic auth password provided by QRadar.
    # @option params [String] solar_winds_token Applicable only for destination type: solar_winds. Authentication token provided by Solar Winds.
    # @option params [String] new_relic_api_key Applicable only for destination type: new_relic. API key provided by New Relic.
    # @option params [String] datadog_api_key Applicable only for destination type: datadog. API key provided by Datadog.
    # @option params [Boolean] action_send_enabled Whether or not sending is enabled for action logs.
    # @option params [Boolean] sftp_action_send_enabled Whether or not sending is enabled for sftp_action logs.
    # @option params [Boolean] ftp_action_send_enabled Whether or not sending is enabled for ftp_action logs.
    # @option params [Boolean] web_dav_action_send_enabled Whether or not sending is enabled for web_dav_action logs.
    # @option params [Boolean] sync_send_enabled Whether or not sending is enabled for sync logs.
    # @option params [Boolean] outbound_connection_send_enabled Whether or not sending is enabled for outbound_connection logs.
    # @option params [Boolean] automation_send_enabled Whether or not sending is enabled for automation logs.
    # @option params [Boolean] api_request_send_enabled Whether or not sending is enabled for api_request logs.
    # @option params [Boolean] public_hosting_request_send_enabled Whether or not sending is enabled for public_hosting_request logs.
    # @option params [Boolean] email_send_enabled Whether or not sending is enabled for email logs.
    # @option params [Boolean] exavault_api_request_send_enabled Whether or not sending is enabled for exavault_api_request logs.
    # @option params [Boolean] settings_change_send_enabled Whether or not sending is enabled for settings_change logs.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.send_test_entry(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: siem_http_destination_id must be an Integer") if !params[:siem_http_destination_id].nil? and !params[:siem_http_destination_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: destination_type must be an String") if !params[:destination_type].nil? and !params[:destination_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_url must be an String") if !params[:destination_url].nil? and !params[:destination_url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: additional_headers must be an Hash") if !params[:additional_headers].nil? and !params[:additional_headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: sending_active must be a single value, not #{params[:sending_active].class}") if [ Array, Hash ].any? { |klass| params[:sending_active].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: generic_payload_type must be an String") if !params[:generic_payload_type].nil? and !params[:generic_payload_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_destination_path must be an String") if !params[:file_destination_path].nil? and !params[:file_destination_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_format must be an String") if !params[:file_format].nil? and !params[:file_format].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_interval_minutes must be an Integer") if !params[:file_interval_minutes].nil? and !params[:file_interval_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: splunk_token must be an String") if !params[:splunk_token].nil? and !params[:splunk_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: crowdstrike_token must be an String") if !params[:crowdstrike_token].nil? and !params[:crowdstrike_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_dcr_immutable_id must be an String") if !params[:azure_dcr_immutable_id].nil? and !params[:azure_dcr_immutable_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_stream_name must be an String") if !params[:azure_stream_name].nil? and !params[:azure_stream_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_tenant_id must be an String") if !params[:azure_oauth_client_credentials_tenant_id].nil? and !params[:azure_oauth_client_credentials_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_id must be an String") if !params[:azure_oauth_client_credentials_client_id].nil? and !params[:azure_oauth_client_credentials_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_secret must be an String") if !params[:azure_oauth_client_credentials_client_secret].nil? and !params[:azure_oauth_client_credentials_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_username must be an String") if !params[:qradar_username].nil? and !params[:qradar_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_password must be an String") if !params[:qradar_password].nil? and !params[:qradar_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: solar_winds_token must be an String") if !params[:solar_winds_token].nil? and !params[:solar_winds_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: new_relic_api_key must be an String") if !params[:new_relic_api_key].nil? and !params[:new_relic_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: datadog_api_key must be an String") if !params[:datadog_api_key].nil? and !params[:datadog_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action_send_enabled must be a single value, not #{params[:action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_action_send_enabled must be a single value, not #{params[:sftp_action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:sftp_action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ftp_action_send_enabled must be a single value, not #{params[:ftp_action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:ftp_action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: web_dav_action_send_enabled must be a single value, not #{params[:web_dav_action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:web_dav_action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sync_send_enabled must be a single value, not #{params[:sync_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:sync_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: outbound_connection_send_enabled must be a single value, not #{params[:outbound_connection_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:outbound_connection_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: automation_send_enabled must be a single value, not #{params[:automation_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:automation_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: api_request_send_enabled must be a single value, not #{params[:api_request_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:api_request_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: public_hosting_request_send_enabled must be a single value, not #{params[:public_hosting_request_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:public_hosting_request_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: email_send_enabled must be a single value, not #{params[:email_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:email_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: exavault_api_request_send_enabled must be a single value, not #{params[:exavault_api_request_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:exavault_api_request_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: settings_change_send_enabled must be a single value, not #{params[:settings_change_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:settings_change_send_enabled].is_a?(klass) }

      Api.send_request("/siem_http_destinations/send_test_entry", :post, params, options)
      nil
    end

    # Update SIEM HTTP Destination
    #
    # @param id [Integer] Siem Http Destination ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] name Name for this Destination
    # @option params [Hash] additional_headers Additional HTTP Headers included in calls to the destination URL
    # @option params [Boolean] sending_active Whether this SIEM HTTP Destination is currently being sent to or not
    # @option params [String] generic_payload_type Applicable only for destination type: generic. Indicates the type of HTTP body. Can be json_newline or json_array. json_newline is multiple log entries as JSON separated by newlines. json_array is a single JSON array containing multiple log entries as JSON.
    # @option params [String] file_destination_path Applicable only for destination type: file. Destination folder path on Files.com.
    # @option params [String] file_format Applicable only for destination type: file. Generated file format.
    # @option params [Integer] file_interval_minutes Applicable only for destination type: file. Interval, in minutes, between file deliveries. Valid values are 5, 10, 15, 20, 30, 60, 90, 180, 240, 360.
    # @option params [String] splunk_token Applicable only for destination types: splunk, splunk_compatible. Authentication token for the destination.
    # @option params [String] crowdstrike_token Applicable only for destination type: crowdstrike. Authentication token provided by Crowdstrike.
    # @option params [String] azure_dcr_immutable_id Applicable only for destination types: azure, azure_legacy. Immutable ID of the Data Collection Rule.
    # @option params [String] azure_stream_name Applicable only for destination type: azure. Name of the stream in the DCR that represents the destination table.
    # @option params [String] azure_oauth_client_credentials_tenant_id Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Tenant ID.
    # @option params [String] azure_oauth_client_credentials_client_id Applicable only for destination types: azure, azure_legacy. Client Credentials OAuth Client ID.
    # @option params [String] azure_oauth_client_credentials_client_secret Applicable only for destination type: azure. Client Credentials OAuth Client Secret.
    # @option params [String] qradar_username Applicable only for destination type: qradar. Basic auth username provided by QRadar.
    # @option params [String] qradar_password Applicable only for destination type: qradar. Basic auth password provided by QRadar.
    # @option params [String] solar_winds_token Applicable only for destination type: solar_winds. Authentication token provided by Solar Winds.
    # @option params [String] new_relic_api_key Applicable only for destination type: new_relic. API key provided by New Relic.
    # @option params [String] datadog_api_key Applicable only for destination type: datadog. API key provided by Datadog.
    # @option params [Boolean] action_send_enabled Whether or not sending is enabled for action logs.
    # @option params [Boolean] sftp_action_send_enabled Whether or not sending is enabled for sftp_action logs.
    # @option params [Boolean] ftp_action_send_enabled Whether or not sending is enabled for ftp_action logs.
    # @option params [Boolean] web_dav_action_send_enabled Whether or not sending is enabled for web_dav_action logs.
    # @option params [Boolean] sync_send_enabled Whether or not sending is enabled for sync logs.
    # @option params [Boolean] outbound_connection_send_enabled Whether or not sending is enabled for outbound_connection logs.
    # @option params [Boolean] automation_send_enabled Whether or not sending is enabled for automation logs.
    # @option params [Boolean] api_request_send_enabled Whether or not sending is enabled for api_request logs.
    # @option params [Boolean] public_hosting_request_send_enabled Whether or not sending is enabled for public_hosting_request logs.
    # @option params [Boolean] email_send_enabled Whether or not sending is enabled for email logs.
    # @option params [Boolean] exavault_api_request_send_enabled Whether or not sending is enabled for exavault_api_request logs.
    # @option params [Boolean] settings_change_send_enabled Whether or not sending is enabled for settings_change logs.
    # @option params [String] destination_type Destination Type
    # @option params [String] destination_url Destination Url
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::SiemHttpDestination] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: additional_headers must be an Hash") if !params[:additional_headers].nil? and !params[:additional_headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: sending_active must be a single value, not #{params[:sending_active].class}") if [ Array, Hash ].any? { |klass| params[:sending_active].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: generic_payload_type must be an String") if !params[:generic_payload_type].nil? and !params[:generic_payload_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_destination_path must be an String") if !params[:file_destination_path].nil? and !params[:file_destination_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_format must be an String") if !params[:file_format].nil? and !params[:file_format].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_interval_minutes must be an Integer") if !params[:file_interval_minutes].nil? and !params[:file_interval_minutes].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: splunk_token must be an String") if !params[:splunk_token].nil? and !params[:splunk_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: crowdstrike_token must be an String") if !params[:crowdstrike_token].nil? and !params[:crowdstrike_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_dcr_immutable_id must be an String") if !params[:azure_dcr_immutable_id].nil? and !params[:azure_dcr_immutable_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_stream_name must be an String") if !params[:azure_stream_name].nil? and !params[:azure_stream_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_tenant_id must be an String") if !params[:azure_oauth_client_credentials_tenant_id].nil? and !params[:azure_oauth_client_credentials_tenant_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_id must be an String") if !params[:azure_oauth_client_credentials_client_id].nil? and !params[:azure_oauth_client_credentials_client_id].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: azure_oauth_client_credentials_client_secret must be an String") if !params[:azure_oauth_client_credentials_client_secret].nil? and !params[:azure_oauth_client_credentials_client_secret].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_username must be an String") if !params[:qradar_username].nil? and !params[:qradar_username].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: qradar_password must be an String") if !params[:qradar_password].nil? and !params[:qradar_password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: solar_winds_token must be an String") if !params[:solar_winds_token].nil? and !params[:solar_winds_token].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: new_relic_api_key must be an String") if !params[:new_relic_api_key].nil? and !params[:new_relic_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: datadog_api_key must be an String") if !params[:datadog_api_key].nil? and !params[:datadog_api_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action_send_enabled must be a single value, not #{params[:action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sftp_action_send_enabled must be a single value, not #{params[:sftp_action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:sftp_action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ftp_action_send_enabled must be a single value, not #{params[:ftp_action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:ftp_action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: web_dav_action_send_enabled must be a single value, not #{params[:web_dav_action_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:web_dav_action_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: sync_send_enabled must be a single value, not #{params[:sync_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:sync_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: outbound_connection_send_enabled must be a single value, not #{params[:outbound_connection_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:outbound_connection_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: automation_send_enabled must be a single value, not #{params[:automation_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:automation_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: api_request_send_enabled must be a single value, not #{params[:api_request_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:api_request_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: public_hosting_request_send_enabled must be a single value, not #{params[:public_hosting_request_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:public_hosting_request_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: email_send_enabled must be a single value, not #{params[:email_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:email_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: exavault_api_request_send_enabled must be a single value, not #{params[:exavault_api_request_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:exavault_api_request_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: settings_change_send_enabled must be a single value, not #{params[:settings_change_send_enabled].class}") if [ Array, Hash ].any? { |klass| params[:settings_change_send_enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: destination_type must be an String") if !params[:destination_type].nil? and !params[:destination_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination_url must be an String") if !params[:destination_url].nil? and !params[:destination_url].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/siem_http_destinations/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("SiemHttpDestination") }
      SiemHttpDestination.new(response.data, options)
    end

    # Delete SIEM HTTP Destination
    #
    # @param id [Integer] Siem Http Destination ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/siem_http_destinations/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
