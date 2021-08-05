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

require "files.com/models/account_line_item"
require "files.com/models/action"
require "files.com/models/action_notification_export"
require "files.com/models/action_notification_export_result"
require "files.com/models/action_webhook_failure"
require "files.com/models/api_key"
require "files.com/models/app"
require "files.com/models/as2_key"
require "files.com/models/auto"
require "files.com/models/automation"
require "files.com/models/bandwidth_snapshot"
require "files.com/models/behavior"
require "files.com/models/bundle"
require "files.com/models/bundle_download"
require "files.com/models/bundle_recipient"
require "files.com/models/bundle_registration"
require "files.com/models/clickwrap"
require "files.com/models/dns_record"
require "files.com/models/errors"
require "files.com/models/external_event"
require "files.com/models/file"
require "files.com/models/file_action"
require "files.com/models/file_comment"
require "files.com/models/file_comment_reaction"
require "files.com/models/file_migration"
require "files.com/models/file_upload_part"
require "files.com/models/folder"
require "files.com/models/form_field"
require "files.com/models/form_field_set"
require "files.com/models/group"
require "files.com/models/group_user"
require "files.com/models/history"
require "files.com/models/history_export"
require "files.com/models/history_export_result"
require "files.com/models/image"
require "files.com/models/inbox_recipient"
require "files.com/models/inbox_registration"
require "files.com/models/inbox_upload"
require "files.com/models/invoice"
require "files.com/models/invoice_line_item"
require "files.com/models/ip_address"
require "files.com/models/lock"
require "files.com/models/message"
require "files.com/models/message_comment"
require "files.com/models/message_comment_reaction"
require "files.com/models/message_reaction"
require "files.com/models/notification"
require "files.com/models/payment"
require "files.com/models/payment_line_item"
require "files.com/models/permission"
require "files.com/models/preview"
require "files.com/models/project"
require "files.com/models/public_ip_address"
require "files.com/models/public_key"
require "files.com/models/remote_server"
require "files.com/models/request"
require "files.com/models/session"
require "files.com/models/settings_change"
require "files.com/models/site"
require "files.com/models/sso_strategy"
require "files.com/models/status"
require "files.com/models/style"
require "files.com/models/sync_job"
require "files.com/models/usage_daily_snapshot"
require "files.com/models/usage_snapshot"
require "files.com/models/user"
require "files.com/models/user_cipher_use"
require "files.com/models/user_request"
require "files.com/models/webhook_test"

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
