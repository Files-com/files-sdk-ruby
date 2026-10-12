# frozen_string_literal: true

module Files
  module Util
    OPTS = Set[:api_key, :base_url, :client, :region_http_pairs, :session_id, :workspace_id].freeze
    COLOR_CODES = {
      black:   0, light_black:   60,
      red:     1, light_red:     61,
      green:   2, light_green:   62,
      yellow:  3, light_yellow:  63,
      blue:    4, light_blue:    64,
      magenta: 5, light_magenta: 65,
      cyan:    6, light_cyan:    66,
      white:   7, light_white:   67,
      default: 9,
    }.freeze

    def self.colorize(val, color, isatty)
      return val unless isatty

      mode = 0 # default
      foreground = 30 + COLOR_CODES.fetch(color)
      background = 40 + COLOR_CODES.fetch(:default)

      "\033[#{mode};#{foreground};#{background}m#{val}\033[0m"
    end

    def self.level_name(level)
      case level
      when LEVEL_DEBUG then "debug"
      when LEVEL_ERROR then "error"
      when LEVEL_INFO  then "info"
      else level
      end
    end

    # Where log messages go: to +logger+ when there is one, which then filters by its own level, and otherwise to
    # standard output or error at +log_level+ and above. A nil +log_level+ without a logger logs nothing.
    LogSettings = Struct.new(:logger, :log_level)

    # The library-wide Files.logger and Files.log_level, read when each message is logged.
    def self.global_log_settings
      LogSettings.new(Files.logger, Files.log_level)
    end

    # The same values Files.log_level= accepts: nil, a level constant, or "debug" or "info".
    def self.normalize_log_level(val)
      val = { "debug" => LEVEL_DEBUG, "info" => LEVEL_INFO }.fetch(val, val)
      if !val.nil? && ![ LEVEL_DEBUG, LEVEL_ERROR, LEVEL_INFO ].include?(val)
        raise ArgumentError,
              "log_level should only be set to `nil`, `debug` or `info`"
      end
      val
    end

    # The http:// origin +value+ names, written as http://, its lowercase host and a port only when it is not 80, or
    # nil when +value+ is not a plain http:// origin: a host name or IP address with an empty or "/" path and no
    # credentials, query, fragment, spaces or backslashes.
    def self.http_origin(value)
      return unless value.is_a?(String) && !value.match?(/[[:space:][:cntrl:]\\]/) && value.match?(/\Ahttp:\/\/[^\/?#@]+\/?\z/i)

      uri = Addressable::URI.parse(value)
      host = uri.normalized_host.to_s
      port = uri.port || 80
      return unless port.between?(1, 65_535) && host.match?(/\A(\[[0-9a-f:.]+\]|[a-z0-9]([a-z0-9.-]*[a-z0-9])?)\z/)

      port == 80 ? "http://#{host}" : "http://#{host}:#{port}"
    rescue Addressable::URI::InvalidURIError, ArgumentError
      nil
    end

    # A frozen copy of +pairs+ for Files.region_http_pairs= and the region_http_pairs option of a Files::ApiClient or a
    # request, made of new Arrays and Strings, so the caller's are neither kept nor changed. Raises ArgumentError unless
    # +pairs+ is an Array of [source, destination] Arrays of two origins already written the way http_origin writes them.
    def self.checked_region_http_pairs(pairs)
      message = "region_http_pairs should be an Array of [source, destination] Arrays of http:// origins, each with a lowercase host, a port only when it is not 80 and no path"
      raise ArgumentError, message unless pairs.is_a?(Array)

      pairs.map do |pair|
        origins = pair.is_a?(Array) ? pair.map { |origin| http_origin(origin) } : []
        raise ArgumentError, message unless origins.length == 2 && origins.all? && origins == pair

        origins.each(&:freeze).freeze
      end.freeze
    end

    def self.log_error(message, data = {}, settings = global_log_settings)
      if !settings.logger.nil? ||
         (!settings.log_level.nil? && settings.log_level <= Files::LEVEL_ERROR)
        log_internal(message, data, color: :cyan, level: Files::LEVEL_ERROR,
                                    logger: settings.logger, out: $stderr
        )
      end
    end

    def self.log_info(message, data = {}, settings = global_log_settings)
      if !settings.logger.nil? ||
         (!settings.log_level.nil? && settings.log_level <= Files::LEVEL_INFO)
        log_internal(message, data, color: :cyan, level: Files::LEVEL_INFO,
                                    logger: settings.logger, out: $stdout
        )
      end
    end

    def self.log_debug(message, data = {}, settings = global_log_settings)
      if !settings.logger.nil? ||
         (!settings.log_level.nil? && settings.log_level <= Files::LEVEL_DEBUG)
        log_internal(message, data, color: :blue, level: Files::LEVEL_DEBUG,
                                    logger: settings.logger, out: $stdout
        )
      end
    end

    def self.log_internal(message, data = {}, color: nil, level: nil,
                          logger: nil, out: nil)
      data_str = data.compact.map do |(k, v)|
        format("%<key>s=%<value>s",
               key: colorize(k, color, logger.nil? && !out.nil? && out.isatty),
               value: v
              )
      end.join(" ")

      if !logger.nil?
        # the library's log levels are mapped to the same values as the
        # standard library's logger
        logger.log(level,
                   format("message=%<message>s %<data_str>s",
                          message: message,
                          data_str: data_str
                         )
                  )
      elsif out.isatty
        out.puts format("%<level>s %<message>s %<data_str>s",
                        level: colorize(level_name(level)[0, 4].upcase,
                                        color, out.isatty
                        ),
                        message: message,
                        data_str: data_str
                       )
      else
        out.puts format("message=%<message>s level=%<level>s %<data_str>s",
                        message: message,
                        level: level_name(level),
                        data_str: data_str
                       )
      end
    end

    def self.check_api_key!(key)
      raise TypeError, "api_key must be a string" unless key.is_a?(String)

      key
    end
  end
end
