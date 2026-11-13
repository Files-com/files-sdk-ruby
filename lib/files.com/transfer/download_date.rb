# frozen_string_literal: true

require "time"

module Files
  module Transfer
    # A best-effort HTTP date precondition for one download, never a strong version or checkpoint identity.
    class DownloadDate
      def self.enabled(options = {}, override = nil)
        value = override.nil? ? options.fetch(:check_download_modification_time) { Files::File.client(options).check_download_modification_time } : override
        raise Files::InvalidParameterError, "check_download_modification_time must be a boolean" unless value.equal?(true) || value.equal?(false)

        value
      end

      def initialize(enabled: true)
        @enabled = enabled
      end

      def header
        @enabled ? @baseline&.httpdate : nil
      end

      # A valid newer date refuses the response before any body reaches its destination. Missing or invalid metadata
      # stays compatible. HTTP-date has one-second precision; an earlier or equal date passes, as the server permits.
      def accept?(value)
        return true unless @enabled

        modified = Time.httpdate(value).utc if value.is_a?(String)
        return true unless modified

        day = value.include?(",") ? value.split(", ", 2).last.to_i : value[8, 2].to_i
        clock = value[/[0-9]{2}:[0-9]{2}:[0-9]{2}/]
        return true unless modified.day == day && clock == modified.strftime("%H:%M:%S") && value[0, 3] == modified.httpdate[0, 3]
        return false if @baseline && modified > @baseline

        @baseline ||= modified
        true
      rescue ArgumentError
        true
      end
    end
  end
end
