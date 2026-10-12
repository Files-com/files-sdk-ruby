# frozen_string_literal: true

require "cgi"
require "faraday"
require 'faraday/multipart' unless defined? Faraday::Request::Multipart
require "json"
require "logger"
require "openssl"
require "rbconfig"
require "rbconfig/sizeof"
require "securerandom"
require "set"
require "socket"
require "uri"
require "addressable/uri"
require "concurrent/promise"

require 'faraday/net_http_persistent'
require 'net/http/persistent'

$LOAD_PATH.push __dir__

require "files.com/version"

require "files.com/sizable_io"
require "files.com/api"
require "files.com/api_client"
require "files.com/errors"
require "files.com/response"
require "files.com/system_profiler"
require "files.com/util"
require "files.com/list"
require "files.com/uri"
require "files.com/path_util"

require "files.com/models/account_line_item"
require "files.com/models/action"
require "files.com/models/action_log"
require "files.com/models/action_notification_export"
require "files.com/models/action_notification_export_result"
require "files.com/models/agent_node"
require "files.com/models/agent_node_connection"
require "files.com/models/agent_node_instance"
require "files.com/models/agent_push_update"
require "files.com/models/ai_assistant_personality"
require "files.com/models/ai_task"
require "files.com/models/api_key"
require "files.com/models/api_request_log"
require "files.com/models/app"
require "files.com/models/as2_incoming_message"
require "files.com/models/as2_outgoing_message"
require "files.com/models/as2_partner"
require "files.com/models/as2_station"
require "files.com/models/auto"
require "files.com/models/automation"
require "files.com/models/automation_authoring_schema"
require "files.com/models/automation_execution_node"
require "files.com/models/automation_log"
require "files.com/models/automation_run"
require "files.com/models/bandwidth_snapshot"
require "files.com/models/behavior"
require "files.com/models/bundle"
require "files.com/models/bundle_action"
require "files.com/models/bundle_download"
require "files.com/models/bundle_notification"
require "files.com/models/bundle_path"
require "files.com/models/bundle_recipient"
require "files.com/models/bundle_registration"
require "files.com/models/chat_message"
require "files.com/models/chat_session"
require "files.com/models/child_site_management_policy"
require "files.com/models/clickwrap"
require "files.com/models/custom_domain"
require "files.com/models/desktop_configuration_profile"
require "files.com/models/direct_connection_info"
require "files.com/models/dns_record"
require "files.com/models/email_incoming_message"
require "files.com/models/email_log"
require "files.com/models/errors"
require "files.com/models/event_channel"
require "files.com/models/event_delivery_attempt"
require "files.com/models/event_record"
require "files.com/models/event_subscription"
require "files.com/models/event_target"
require "files.com/models/exavault_api_request_log"
require "files.com/models/expectation"
require "files.com/models/expectation_evaluation"
require "files.com/models/expectation_incident"
require "files.com/models/external_event"
require "files.com/models/file"
require "files.com/models/file_action"
require "files.com/models/file_comment"
require "files.com/models/file_comment_reaction"
require "files.com/models/file_migration"
require "files.com/models/file_migration_log"
require "files.com/models/file_upload_part"
require "files.com/models/folder"
require "files.com/models/form_field"
require "files.com/models/form_field_set"
require "files.com/models/ftp_action_log"
require "files.com/models/gpg_key"
require "files.com/models/group"
require "files.com/models/group_user"
require "files.com/models/history"
require "files.com/models/history_export"
require "files.com/models/history_export_result"
require "files.com/models/holiday_calendar"
require "files.com/models/holiday_region"
require "files.com/models/image"
require "files.com/models/inbound_s3_log"
require "files.com/models/inbox_recipient"
require "files.com/models/inbox_registration"
require "files.com/models/inbox_upload"
require "files.com/models/integration_centric_profile"
require "files.com/models/invoice"
require "files.com/models/invoice_line_item"
require "files.com/models/ip_address"
require "files.com/models/key_lifecycle_rule"
require "files.com/models/lock"
require "files.com/models/metadata_category"
require "files.com/models/notification"
require "files.com/models/outbound_connection_log"
require "files.com/models/partner"
require "files.com/models/partner_channel"
require "files.com/models/partner_channel_template"
require "files.com/models/partner_connection"
require "files.com/models/partner_site"
require "files.com/models/partner_site_request"
require "files.com/models/payment"
require "files.com/models/payment_line_item"
require "files.com/models/pending_work_event"
require "files.com/models/permission"
require "files.com/models/preview"
require "files.com/models/public_hosting_request_log"
require "files.com/models/public_ip_address"
require "files.com/models/public_key"
require "files.com/models/remote_bandwidth_snapshot"
require "files.com/models/remote_mount_backend"
require "files.com/models/remote_server"
require "files.com/models/remote_server_configuration_file"
require "files.com/models/remote_server_credential"
require "files.com/models/request"
require "files.com/models/restore"
require "files.com/models/schedule"
require "files.com/models/scheduled_export"
require "files.com/models/scim_log"
require "files.com/models/secret"
require "files.com/models/session"
require "files.com/models/settings_change"
require "files.com/models/sftp_action_log"
require "files.com/models/sftp_host_key"
require "files.com/models/share_group"
require "files.com/models/share_group_member"
require "files.com/models/siem_http_destination"
require "files.com/models/siem_http_destination_event"
require "files.com/models/site"
require "files.com/models/site_subdomain_redirect"
require "files.com/models/snapshot"
require "files.com/models/sso_event"
require "files.com/models/sso_strategy"
require "files.com/models/status"
require "files.com/models/style"
require "files.com/models/sync"
require "files.com/models/sync_log"
require "files.com/models/sync_run"
require "files.com/models/sync_run_live_transfer"
require "files.com/models/usage_by_top_level_dir"
require "files.com/models/usage_daily_snapshot"
require "files.com/models/usage_snapshot"
require "files.com/models/user"
require "files.com/models/user_additional_email_recipient"
require "files.com/models/user_cipher_use"
require "files.com/models/user_lifecycle_rule"
require "files.com/models/user_request"
require "files.com/models/user_security_event"
require "files.com/models/user_sftp_client_use"
require "files.com/models/web_dav_action_log"
require "files.com/models/webhook_test"
require "files.com/models/workspace"
require "files.com/models/zip_list_entry"

require "files.com/models/dir"
require "files.com/models/file_utils"

module Files
  @api_key = nil
  @app_info = nil
  @base_url = "https://app.files.com"
  @language = nil
  @log_level = nil
  @logger = nil
  @proxy = nil
  @region_handler = nil
  @region_http_pairs = [].freeze
  @region_policy = :automatic
  @session_id = nil
  @workspace_id = nil
  @default_headers = nil

  @max_network_retries = 3
  @max_network_retry_delay = 2
  @initial_network_retry_delay = 0.5

  @open_timeout = 30
  @read_timeout = 60

  class << self
    attr_accessor :api_key, :base_url, :default_headers, :initial_network_retry_delay, :language, :max_network_retry_delay, :proxy, :session_id, :workspace_id
    attr_reader :open_timeout, :read_timeout, :region_handler, :region_http_pairs, :region_policy
  end

  # map to the same values as the standard library's logger
  LEVEL_DEBUG = Logger::DEBUG
  LEVEL_ERROR = Logger::ERROR
  LEVEL_INFO = Logger::INFO

  # When set prompts the library to log some extra information to $stdout and
  # $stderr about what it's doing. For example, it'll produce information about
  # requests, responses, and errors that are received. Valid log levels are
  # `debug` and `info`, with `debug` being a little more verbose in places.
  #
  # Use of this configuration is only useful when `.logger` is _not_ set. When
  # it is, the decision what levels to print is entirely deferred to the logger.
  def self.log_level
    @log_level
  end

  def self.log_level=(val)
    # Backwards compatibility for values that we briefly allowed
    case val
    when "debug"
      val = LEVEL_DEBUG
    when "info"
      val = LEVEL_INFO
    end

    if !val.nil? && ![ LEVEL_DEBUG, LEVEL_ERROR, LEVEL_INFO ].include?(val)
      raise ArgumentError,
            "log_level should only be set to `nil`, `debug` or `info`"
    end
    @log_level = val
  end

  # Sets a logger to which logging output will be sent. The logger should
  # support the same interface as the `Logger` class that's part of Ruby's
  # standard library (hint, anything in `Rails.logger` will likely be
  # suitable).
  #
  # If `.logger` is set, the value of `.log_level` is ignored. The decision on
  # what levels to print is entirely deferred to the logger.
  def self.logger
    @logger
  end

  def self.logger=(val)
    @logger = val
  end

  def self.max_network_retries
    @max_network_retries
  end

  def self.max_network_retries=(val)
    @max_network_retries = val.to_i
  end

  # Net::HTTP hands each timeout to Ruby to wait on. CRuby converts it to the
  # platform's time_t and raises RangeError for more seconds than that holds,
  # partway through a request it may already have sent. JRuby takes any number.
  MAX_TIMEOUT = RUBY_PLATFORM == "java" ? Float::INFINITY : (2**((8 * RbConfig::SIZEOF["time_t"]) - 1)) - 1
  private_constant :MAX_TIMEOUT

  def self.open_timeout=(seconds)
    @open_timeout = checked_timeout("open_timeout", seconds)
  end

  def self.read_timeout=(seconds)
    @read_timeout = checked_timeout("read_timeout", seconds)
  end

  private_class_method def self.checked_timeout(name, seconds)
    return seconds if seconds.nil? || (seconds.is_a?(Numeric) && seconds.real? && seconds >= 0 && seconds <= MAX_TIMEOUT)

    raise ArgumentError, "#{name} should be nil or a number of seconds from 0 to #{MAX_TIMEOUT}"
  end

  # What a request does when the API answers that the site must be reached through another origin, such as its
  # region or its custom domain (Files::LockoutRegionMismatchError, with that origin in data[:host]).
  #
  # :automatic (the default) sends the same request once more to that origin, within the same retry count, and keeps
  # using it for the records and pages the request returns. Other requests still start at Files.base_url. It does so
  # only for an error that came over verified HTTPS from the configured base URL through the SDK's own connection, and
  # only to an https:// origin on a DNS name at port 443 that is not a local or Files.com development name, unless
  # region_handler approves another. The only exception is plain HTTP from the source to the destination of a
  # region_http_pairs pair. :disabled raises the error instead, so you can update your own settings and retry.
  def self.region_policy=(policy)
    raise ArgumentError, "region_policy should be :automatic or :disabled" unless %i[automatic disabled].include?(policy)

    @region_policy = policy
  end

  # Pairs of http:// origins, each letting a lockout region mismatch move a request from the first to the second over
  # plain HTTP, for your own local development servers only. Plain HTTP is intentionally insecure: it sends the API key
  # or session unencrypted to whatever answers, and a pair is your explicit choice, never a verified or trusted origin.
  # Each pair is [source, destination], such as [["http://localhost:3000", "http://site.localhost:3000"]].
  #
  # With region_policy :automatic, a request to the source (Files.base_url, or the request's own base_url) that gets
  # the error with data[:host] naming the destination, as that full http:// origin or as its bare host (with its port
  # when it is not 80), is sent once more to the destination, within the same retry count, and the records and pages
  # it returns keep using it. region_handler, when set, is still asked first and can decline. Nothing else continues
  # over plain HTTP, a request to an https:// origin never does, and :disabled still raises the error.
  #
  # Write each origin as http://, a lowercase host name or IP address, a port only when it is not 80 and no path.
  # The default, [], allows none. The SDK keeps a frozen copy, so changing the Arrays or Strings you passed has no
  # effect. Each request fixes its pairs before it starts: its own region_http_pairs option if it has one, otherwise
  # those of a Files::ApiClient created with its own region_http_pairs, otherwise this setting. The records and pages
  # it returns keep those pairs in their options, so their own requests use them even after this setting changes;
  # other requests use the setting as it is when they start.
  def self.region_http_pairs=(pairs)
    @region_http_pairs = Util.checked_region_http_pairs(pairs)
  end

  # An optional object with a call method that decides each move to another origin. It receives a frozen Hash with
  # :reason (:lockout_region_mismatch), :original_origin, :target_origin and :approval_required (true for an IP
  # address, a localhost, .local, files.test or filesrails.test name, a name without a dot or a port other than 443).
  # It returns true to continue at the target origin; another https:// origin in the same form (lowercase host, a port
  # only when it is not 443, no path) to continue there instead, which the SDK checks like the target; or false or nil
  # to raise the error. An error it raises stops the request. It cannot make a request continue from an error the SDK
  # does not trust. For a move between region_http_pairs origins, :approval_required is false, since the pair already
  # allows it, and another origin it returns must be a destination paired with the same source, written as in the pairs.
  def self.region_handler=(handler)
    raise ArgumentError, "region_handler should be nil or respond to call" unless handler.nil? || handler.respond_to?(:call)

    @region_handler = handler
  end

  def self.session=(session)
    session.save unless session.id
    self.session_id = session.id
  end

  # Sets some basic information about the running application that's sent along
  # with API requests.
  #
  # Takes a name and optional  partner program ID, plugin URL, and version.
  def self.set_app_info(name, partner_id: nil, url: nil, version: nil)
    @app_info = {
      name: name,
      partner_id: partner_id,
      url: url,
      version: version,
    }
  end

  def self.app_info
    @app_info
  end

  def self.app_info=(info)
    @app_info = info
  end
end
