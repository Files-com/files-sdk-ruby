#!/usr/bin/env ruby

$stderr.reopen $stdout

require 'rubygems'
require 'bundler'
require 'fileutils'
require 'socket'
require 'timeout'

Bundler.require(:default)

require 'active_support'
require 'active_support/core_ext'

configure do
  set :port, 4041
end

before do
  content_type :json
end

require "app/account_line_item_endpoints"
require "app/action_endpoints"
require "app/api_key_endpoints"
require "app/as2_key_endpoints"
require "app/auto_endpoints"
require "app/automation_endpoints"
require "app/behavior_endpoints"
require "app/bundle_endpoints"
require "app/dns_record_endpoints"
require "app/errors_endpoints"
require "app/file_endpoints"
require "app/file_action_endpoints"
require "app/file_comment_endpoints"
require "app/file_comment_reaction_endpoints"
require "app/file_part_upload_endpoints"
require "app/folder_endpoints"
require "app/group_endpoints"
require "app/group_user_endpoints"
require "app/history_endpoints"
require "app/history_export_endpoints"
require "app/image_endpoints"
require "app/invoice_endpoints"
require "app/invoice_line_item_endpoints"
require "app/ip_address_endpoints"
require "app/lock_endpoints"
require "app/message_endpoints"
require "app/message_comment_endpoints"
require "app/message_comment_reaction_endpoints"
require "app/message_reaction_endpoints"
require "app/notification_endpoints"
require "app/payment_endpoints"
require "app/payment_line_item_endpoints"
require "app/permission_endpoints"
require "app/preview_endpoints"
require "app/project_endpoints"
require "app/public_key_endpoints"
require "app/remote_server_endpoints"
require "app/request_endpoints"
require "app/session_endpoints"
require "app/site_endpoints"
require "app/sso_strategy_endpoints"
require "app/status_endpoints"
require "app/style_endpoints"
require "app/usage_daily_snapshot_endpoints"
require "app/usage_snapshot_endpoints"
require "app/user_endpoints"
require "app/user_cipher_use_endpoints"
