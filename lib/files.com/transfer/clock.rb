# frozen_string_literal: true

module Files
  module Transfer
    # Seconds on the monotonic clock, which changes to the system time never move. Measurements, retry delays and
    # cooldowns use it; only a signed URL's expiry, which storage states in wall-clock time, is compared with Time.now.
    # Anything with the same now method can stand in for it, as a test's controlled clock does.
    module Clock
      def self.now
        Process.clock_gettime(Process::CLOCK_MONOTONIC)
      end
    end
  end
end
