# frozen_string_literal: true

require "cgi"
require "faraday"
require "json"
require "logger"
require "openssl"
require "rbconfig"
require "securerandom"
require "set"
require "socket"
require "uri"
require "addressable/uri"
require "concurrent/promise"

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

require "files.com/clients/account_line_item"
require "files.com/clients/action"
require "files.com/clients/action_notification_export"
require "files.com/clients/action_notification_export_result"
require "files.com/clients/action_webhook_failure"
require "files.com/clients/api_key"
require "files.com/clients/app"
require "files.com/clients/as2_key"
require "files.com/clients/auto"
require "files.com/clients/automation"
require "files.com/clients/bandwidth_snapshot"
require "files.com/clients/behavior"
require "files.com/clients/bundle"
require "files.com/clients/bundle_download"
require "files.com/clients/bundle_recipient"
require "files.com/clients/bundle_registration"
require "files.com/clients/clickwrap"
require "files.com/clients/dns_record"
require "files.com/clients/errors"
require "files.com/clients/external_event"
require "files.com/clients/file"
require "files.com/clients/file_action"
require "files.com/clients/file_comment"
require "files.com/clients/file_comment_reaction"
require "files.com/clients/file_migration"
require "files.com/clients/file_upload_part"
require "files.com/clients/folder"
require "files.com/clients/form_field"
require "files.com/clients/form_field_set"
require "files.com/clients/group"
require "files.com/clients/group_user"
require "files.com/clients/history"
require "files.com/clients/history_export"
require "files.com/clients/history_export_result"
require "files.com/clients/image"
require "files.com/clients/inbox_recipient"
require "files.com/clients/inbox_registration"
require "files.com/clients/inbox_upload"
require "files.com/clients/invoice"
require "files.com/clients/invoice_line_item"
require "files.com/clients/ip_address"
require "files.com/clients/lock"
require "files.com/clients/message"
require "files.com/clients/message_comment"
require "files.com/clients/message_comment_reaction"
require "files.com/clients/message_reaction"
require "files.com/clients/notification"
require "files.com/clients/payment"
require "files.com/clients/payment_line_item"
require "files.com/clients/permission"
require "files.com/clients/preview"
require "files.com/clients/project"
require "files.com/clients/public_ip_address"
require "files.com/clients/public_key"
require "files.com/clients/remote_server"
require "files.com/clients/request"
require "files.com/clients/session"
require "files.com/clients/settings_change"
require "files.com/clients/site"
require "files.com/clients/sso_strategy"
require "files.com/clients/status"
require "files.com/clients/style"
require "files.com/clients/sync_job"
require "files.com/clients/usage_daily_snapshot"
require "files.com/clients/usage_snapshot"
require "files.com/clients/user"
require "files.com/clients/user_cipher_use"
require "files.com/clients/user_request"
require "files.com/clients/webhook_test"

require "files.com/models/dir"
require "files.com/models/file_utils"

module Files
  @api_key = nil
  @app_info = nil
  @base_url = "https://app.files.com"
  @log_level = nil
  @logger = nil
  @proxy = nil
  @session_id = nil

  @max_network_retries = 3
  @max_network_retry_delay = 2
  @initial_network_retry_delay = 0.5

  @open_timeout = 30
  @read_timeout = 80

  class << self
    attr_accessor :api_key, :base_url, :initial_network_retry_delay, :max_network_retry_delay, :open_timeout, :read_timeout, :proxy, :session_id
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
    if val == "debug"
      val = LEVEL_DEBUG
    elsif val == "info"
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
