# frozen_string_literal: true

module Files
  # Files::EventSubscription is the Ruby SDK's representation of Files.com API EventSubscription objects.
  # Each instance keeps its API field values in +attributes+.
  class EventSubscription
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

    # Event Subscription ID
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

    # Event Channel ID
    # @return [Integer, nil] the field value, or nil when absent.
    def event_channel_id
      @attributes[:event_channel_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def event_channel_id=(value)
      @attributes[:event_channel_id] = value
    end

    # Workspace ID. 0 means the default workspace or site-wide.
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

    # If true, this default-workspace subscription applies to events from all workspaces.
    # @return [Boolean, nil] the field value, or nil when absent.
    def apply_to_all_workspaces
      @attributes[:apply_to_all_workspaces]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def apply_to_all_workspaces=(value)
      @attributes[:apply_to_all_workspaces] = value
    end

    # Event Subscription name.
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

    # Custom subject line to use for notification emails.
    # @return [String, nil] the field value, or nil when absent.
    def subject
      @attributes[:subject]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def subject=(value)
      @attributes[:subject] = value
    end

    # Custom message to include in notification emails.
    # @return [String, nil] the field value, or nil when absent.
    def message
      @attributes[:message]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def message=(value)
      @attributes[:message] = value
    end

    # If true, notification email bodies contain only the custom message, omitting event details and the review button. Requires a custom message, defaults to false, and does not affect non-email targets.
    # @return [Boolean, nil] the field value, or nil when absent.
    def message_only
      @attributes[:message_only]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def message_only=(value)
      @attributes[:message_only] = value
    end

    # Whether this Event Subscription can dispatch events.
    # @return [Boolean, nil] the field value, or nil when absent.
    def enabled
      @attributes[:enabled]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def enabled=(value)
      @attributes[:enabled] = value
    end

    # Event type strings matched by this subscription. Blank means all event types. Valid values: `automation_run.canceled.v1`, `automation_run.failure.v1`, `automation_run.failure_will_retry.v1`, `automation_run.partial_failure.v1`, `automation_run.partial_failure_will_retry.v1`, `automation_run.skipped.v1`, `automation_run.success.v1`, `expectation_evaluation.invalid.v1`, `expectation_evaluation.late.v1`, `expectation_evaluation.missing.v1`, `expectation_evaluation.success.v1`, `expectation_incident.acknowledged.v1`, `expectation_incident.open.v1`, `expectation_incident.resolved.v1`, `expectation_incident.snoozed.v1`, `external_event.client_log.failure.v1`, `external_event.client_log.partial_failure.v1`, `external_event.client_log.skipped.v1`, `external_event.client_log.success.v1`, `pending_work_event.failure.v1`, `pending_work_event.partial_failure.v1`, `pending_work_event.skipped.v1`, `pending_work_event.success.v1`, `siem_http_destination_event.failure.v1`, `siem_http_destination_event.partial_failure.v1`, `siem_http_destination_event.skipped.v1`, `siem_http_destination_event.success.v1`, `sso_event.ldap_login.failure.v1`, `sso_event.ldap_login.partial_failure.v1`, `sso_event.ldap_login.skipped.v1`, `sso_event.ldap_login.success.v1`, `sso_event.ldap_sync.failure.v1`, `sso_event.ldap_sync.partial_failure.v1`, `sso_event.ldap_sync.skipped.v1`, `sso_event.ldap_sync.success.v1`, `sso_event.saml_login.failure.v1`, `sso_event.saml_login.partial_failure.v1`, `sso_event.saml_login.skipped.v1`, `sso_event.saml_login.success.v1`, `sync_run.failure.v1`, `sync_run.partial_failure.v1`, `sync_run.skipped.v1`, `sync_run.success.v1`, `user_security_event.lockout.v1`
    # @return [Array<String>, nil] the field value, or nil when absent.
    def event_types
      @attributes[:event_types]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def event_types=(value)
      @attributes[:event_types] = value
    end

    # Conditions on event fields that an event must meet to be delivered, keyed by dot-notation field path. All conditions must match.
    # @return [Hash, nil] the field value, or nil when absent.
    def filter
      @attributes[:filter]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def filter=(value)
      @attributes[:filter] = value
    end

    # Event Subscription delivery policy. Overrides retry settings from each Event Target's delivery policy.
    # @return [Hash, nil] the field value, or nil when absent.
    def delivery_policy
      @attributes[:delivery_policy]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def delivery_policy=(value)
      @attributes[:delivery_policy] = value
    end

    # Event Target IDs this subscription sends to.
    # @return [Array<Integer>, nil] the field value, or nil when absent.
    def event_target_ids
      @attributes[:event_target_ids]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Integer>, nil] the new field value.
    # @return [Array<Integer>, nil] the assigned value.
    def event_target_ids=(value)
      @attributes[:event_target_ids] = value
    end

    # Event Subscription create date/time.
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Event Subscription update date/time.
    # @return [String, nil] the field value, or nil when absent.
    def updated_at
      @attributes[:updated_at]
    end

    # Update Event Subscription
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] event_channel_id Event Channel ID
    # @option params [Integer] workspace_id Workspace ID. 0 means the default workspace or site-wide.
    # @option params [Boolean] apply_to_all_workspaces If true, this default-workspace subscription applies to events from all workspaces.
    # @option params [String] name Event Subscription name.
    # @option params [String] subject Custom subject line to use for notification emails.
    # @option params [String] message Custom message to include in notification emails.
    # @option params [Boolean] message_only If true, notification email bodies contain only the custom message, omitting event details and the review button. Requires a custom message, defaults to false, and does not affect non-email targets.
    # @option params [Boolean] enabled Whether this Event Subscription can dispatch events.
    # @option params [Array<String>] event_types Event type strings matched by this subscription. Blank means all event types. Valid values: `automation_run.canceled.v1`, `automation_run.failure.v1`, `automation_run.failure_will_retry.v1`, `automation_run.partial_failure.v1`, `automation_run.partial_failure_will_retry.v1`, `automation_run.skipped.v1`, `automation_run.success.v1`, `expectation_evaluation.invalid.v1`, `expectation_evaluation.late.v1`, `expectation_evaluation.missing.v1`, `expectation_evaluation.success.v1`, `expectation_incident.acknowledged.v1`, `expectation_incident.open.v1`, `expectation_incident.resolved.v1`, `expectation_incident.snoozed.v1`, `external_event.client_log.failure.v1`, `external_event.client_log.partial_failure.v1`, `external_event.client_log.skipped.v1`, `external_event.client_log.success.v1`, `pending_work_event.failure.v1`, `pending_work_event.partial_failure.v1`, `pending_work_event.skipped.v1`, `pending_work_event.success.v1`, `siem_http_destination_event.failure.v1`, `siem_http_destination_event.partial_failure.v1`, `siem_http_destination_event.skipped.v1`, `siem_http_destination_event.success.v1`, `sso_event.ldap_login.failure.v1`, `sso_event.ldap_login.partial_failure.v1`, `sso_event.ldap_login.skipped.v1`, `sso_event.ldap_login.success.v1`, `sso_event.ldap_sync.failure.v1`, `sso_event.ldap_sync.partial_failure.v1`, `sso_event.ldap_sync.skipped.v1`, `sso_event.ldap_sync.success.v1`, `sso_event.saml_login.failure.v1`, `sso_event.saml_login.partial_failure.v1`, `sso_event.saml_login.skipped.v1`, `sso_event.saml_login.success.v1`, `sync_run.failure.v1`, `sync_run.partial_failure.v1`, `sync_run.skipped.v1`, `sync_run.success.v1`, `user_security_event.lockout.v1`
    # @option params [Hash] filter Conditions on event fields that an event must meet to be delivered, keyed by dot-notation field path. All conditions must match.
    # @option params [Hash] delivery_policy Event Subscription delivery policy. Overrides retry settings from each Event Target's delivery policy.
    # @option params [Array<Integer>] event_target_ids Event Target IDs this subscription sends to.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: event_channel_id must be an Integer") if !params[:event_channel_id].nil? and !params[:event_channel_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: apply_to_all_workspaces must be a single value, not #{params[:apply_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:apply_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subject must be an String") if !params[:subject].nil? and !params[:subject].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: message must be an String") if !params[:message].nil? and !params[:message].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: message_only must be a single value, not #{params[:message_only].class}") if [ Array, Hash ].any? { |klass| params[:message_only].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: enabled must be a single value, not #{params[:enabled].class}") if [ Array, Hash ].any? { |klass| params[:enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: event_types must be an Array") if !params[:event_types].nil? and !params[:event_types].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: delivery_policy must be an Hash") if !params[:delivery_policy].nil? and !params[:delivery_policy].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: event_target_ids must be an Array") if !params[:event_target_ids].nil? and !params[:event_target_ids].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/event_subscriptions/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("EventSubscription") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Event Subscription
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

      response, options = Api.send_request("/event_subscriptions/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = EventSubscription.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Event Subscriptions
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `name`, `enabled`, `event_channel_id` or `workspace_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `enabled`, `event_channel_id` or `workspace_id`. Valid field combinations are `[ enabled, event_channel_id ]`, `[ workspace_id, enabled ]`, `[ workspace_id, event_channel_id ]` or `[ workspace_id, enabled, event_channel_id ]`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)

      list_options = options.dup
      List.new(EventSubscription, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/event_subscriptions", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Event Subscription
    #
    # @param id [Integer] Event Subscription ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::EventSubscription] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/event_subscriptions/#{params[:id]}", :get, params, options) { |reply| reply.require_object("EventSubscription") }
      EventSubscription.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Event Subscription
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] event_channel_id Event Channel ID
    # @option params [Integer] workspace_id Workspace ID. 0 means the default workspace or site-wide.
    # @option params [Boolean] apply_to_all_workspaces If true, this default-workspace subscription applies to events from all workspaces.
    # @option params [String] name Required. Event Subscription name.
    # @option params [String] subject Custom subject line to use for notification emails.
    # @option params [String] message Custom message to include in notification emails.
    # @option params [Boolean] message_only If true, notification email bodies contain only the custom message, omitting event details and the review button. Requires a custom message, defaults to false, and does not affect non-email targets.
    # @option params [Boolean] enabled Whether this Event Subscription can dispatch events.
    # @option params [Array<String>] event_types Event type strings matched by this subscription. Blank means all event types. Valid values: `automation_run.canceled.v1`, `automation_run.failure.v1`, `automation_run.failure_will_retry.v1`, `automation_run.partial_failure.v1`, `automation_run.partial_failure_will_retry.v1`, `automation_run.skipped.v1`, `automation_run.success.v1`, `expectation_evaluation.invalid.v1`, `expectation_evaluation.late.v1`, `expectation_evaluation.missing.v1`, `expectation_evaluation.success.v1`, `expectation_incident.acknowledged.v1`, `expectation_incident.open.v1`, `expectation_incident.resolved.v1`, `expectation_incident.snoozed.v1`, `external_event.client_log.failure.v1`, `external_event.client_log.partial_failure.v1`, `external_event.client_log.skipped.v1`, `external_event.client_log.success.v1`, `pending_work_event.failure.v1`, `pending_work_event.partial_failure.v1`, `pending_work_event.skipped.v1`, `pending_work_event.success.v1`, `siem_http_destination_event.failure.v1`, `siem_http_destination_event.partial_failure.v1`, `siem_http_destination_event.skipped.v1`, `siem_http_destination_event.success.v1`, `sso_event.ldap_login.failure.v1`, `sso_event.ldap_login.partial_failure.v1`, `sso_event.ldap_login.skipped.v1`, `sso_event.ldap_login.success.v1`, `sso_event.ldap_sync.failure.v1`, `sso_event.ldap_sync.partial_failure.v1`, `sso_event.ldap_sync.skipped.v1`, `sso_event.ldap_sync.success.v1`, `sso_event.saml_login.failure.v1`, `sso_event.saml_login.partial_failure.v1`, `sso_event.saml_login.skipped.v1`, `sso_event.saml_login.success.v1`, `sync_run.failure.v1`, `sync_run.partial_failure.v1`, `sync_run.skipped.v1`, `sync_run.success.v1`, `user_security_event.lockout.v1`
    # @option params [Hash] filter Conditions on event fields that an event must meet to be delivered, keyed by dot-notation field path. All conditions must match.
    # @option params [Hash] delivery_policy Event Subscription delivery policy. Overrides retry settings from each Event Target's delivery policy.
    # @option params [Array<Integer>] event_target_ids Event Target IDs this subscription sends to.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::EventSubscription] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: event_channel_id must be an Integer") if !params[:event_channel_id].nil? and !params[:event_channel_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: apply_to_all_workspaces must be a single value, not #{params[:apply_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:apply_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subject must be an String") if !params[:subject].nil? and !params[:subject].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: message must be an String") if !params[:message].nil? and !params[:message].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: message_only must be a single value, not #{params[:message_only].class}") if [ Array, Hash ].any? { |klass| params[:message_only].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: enabled must be a single value, not #{params[:enabled].class}") if [ Array, Hash ].any? { |klass| params[:enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: event_types must be an Array") if !params[:event_types].nil? and !params[:event_types].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: delivery_policy must be an Hash") if !params[:delivery_policy].nil? and !params[:delivery_policy].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: event_target_ids must be an Array") if !params[:event_target_ids].nil? and !params[:event_target_ids].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: name") if params[:name].nil?

      response, options = Api.send_request("/event_subscriptions", :post, params, options) { |reply| reply.require_object("EventSubscription") }
      EventSubscription.new(response.data, options)
    end

    # Update Event Subscription
    #
    # @param id [Integer] Event Subscription ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] event_channel_id Event Channel ID
    # @option params [Integer] workspace_id Workspace ID. 0 means the default workspace or site-wide.
    # @option params [Boolean] apply_to_all_workspaces If true, this default-workspace subscription applies to events from all workspaces.
    # @option params [String] name Event Subscription name.
    # @option params [String] subject Custom subject line to use for notification emails.
    # @option params [String] message Custom message to include in notification emails.
    # @option params [Boolean] message_only If true, notification email bodies contain only the custom message, omitting event details and the review button. Requires a custom message, defaults to false, and does not affect non-email targets.
    # @option params [Boolean] enabled Whether this Event Subscription can dispatch events.
    # @option params [Array<String>] event_types Event type strings matched by this subscription. Blank means all event types. Valid values: `automation_run.canceled.v1`, `automation_run.failure.v1`, `automation_run.failure_will_retry.v1`, `automation_run.partial_failure.v1`, `automation_run.partial_failure_will_retry.v1`, `automation_run.skipped.v1`, `automation_run.success.v1`, `expectation_evaluation.invalid.v1`, `expectation_evaluation.late.v1`, `expectation_evaluation.missing.v1`, `expectation_evaluation.success.v1`, `expectation_incident.acknowledged.v1`, `expectation_incident.open.v1`, `expectation_incident.resolved.v1`, `expectation_incident.snoozed.v1`, `external_event.client_log.failure.v1`, `external_event.client_log.partial_failure.v1`, `external_event.client_log.skipped.v1`, `external_event.client_log.success.v1`, `pending_work_event.failure.v1`, `pending_work_event.partial_failure.v1`, `pending_work_event.skipped.v1`, `pending_work_event.success.v1`, `siem_http_destination_event.failure.v1`, `siem_http_destination_event.partial_failure.v1`, `siem_http_destination_event.skipped.v1`, `siem_http_destination_event.success.v1`, `sso_event.ldap_login.failure.v1`, `sso_event.ldap_login.partial_failure.v1`, `sso_event.ldap_login.skipped.v1`, `sso_event.ldap_login.success.v1`, `sso_event.ldap_sync.failure.v1`, `sso_event.ldap_sync.partial_failure.v1`, `sso_event.ldap_sync.skipped.v1`, `sso_event.ldap_sync.success.v1`, `sso_event.saml_login.failure.v1`, `sso_event.saml_login.partial_failure.v1`, `sso_event.saml_login.skipped.v1`, `sso_event.saml_login.success.v1`, `sync_run.failure.v1`, `sync_run.partial_failure.v1`, `sync_run.skipped.v1`, `sync_run.success.v1`, `user_security_event.lockout.v1`
    # @option params [Hash] filter Conditions on event fields that an event must meet to be delivered, keyed by dot-notation field path. All conditions must match.
    # @option params [Hash] delivery_policy Event Subscription delivery policy. Overrides retry settings from each Event Target's delivery policy.
    # @option params [Array<Integer>] event_target_ids Event Target IDs this subscription sends to.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::EventSubscription] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: event_channel_id must be an Integer") if !params[:event_channel_id].nil? and !params[:event_channel_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: apply_to_all_workspaces must be a single value, not #{params[:apply_to_all_workspaces].class}") if [ Array, Hash ].any? { |klass| params[:apply_to_all_workspaces].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: name must be an String") if !params[:name].nil? and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subject must be an String") if !params[:subject].nil? and !params[:subject].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: message must be an String") if !params[:message].nil? and !params[:message].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: message_only must be a single value, not #{params[:message_only].class}") if [ Array, Hash ].any? { |klass| params[:message_only].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: enabled must be a single value, not #{params[:enabled].class}") if [ Array, Hash ].any? { |klass| params[:enabled].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: event_types must be an Array") if !params[:event_types].nil? and !params[:event_types].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: delivery_policy must be an Hash") if !params[:delivery_policy].nil? and !params[:delivery_policy].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: event_target_ids must be an Array") if !params[:event_target_ids].nil? and !params[:event_target_ids].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/event_subscriptions/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("EventSubscription") }
      EventSubscription.new(response.data, options)
    end

    # Delete Event Subscription
    #
    # @param id [Integer] Event Subscription ID.
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

      Api.send_request("/event_subscriptions/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
