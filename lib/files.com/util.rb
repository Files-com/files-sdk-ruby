# frozen_string_literal: true

module Files
  module Util
    OPTS = Set[:api_key, :client, :session_id].freeze
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

    def self.log_error(message, data = {})
      if !Files.logger.nil? ||
         (!Files.log_level.nil? && Files.log_level <= Files::LEVEL_ERROR)
        log_internal(message, data, color: :cyan, level: Files::LEVEL_ERROR,
                                    logger: Files.logger, out: $stderr
        )
      end
    end

    def self.log_info(message, data = {})
      if !Files.logger.nil? ||
         (!Files.log_level.nil? && Files.log_level <= Files::LEVEL_INFO)
        log_internal(message, data, color: :cyan, level: Files::LEVEL_INFO,
                                    logger: Files.logger, out: $stdout
        )
      end
    end

    def self.log_debug(message, data = {})
      if !Files.logger.nil? ||
         (!Files.log_level.nil? && Files.log_level <= Files::LEVEL_DEBUG)
        log_internal(message, data, color: :blue, level: Files::LEVEL_DEBUG,
                                    logger: Files.logger, out: $stdout
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
