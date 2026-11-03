# frozen_string_literal: true

module Files
  module Transfer
    # The numbers a Controller works within for one kind of destination. Every count is capped at max, so a caller's
    # max_concurrency, or a fixed concurrency, always dominates.
    class Policy
      MIB = 1024 * 1024
      # A warm-start window at least this fast ends an upload's warm start at the start concurrency.
      FAST_LINK_BYTES_PER_SECOND = 96 * MIB
      # A window is judged only when its requests in flight averaged at least this share of the limit.
      ELIGIBLE_OCCUPANCY = 0.75
      # A failure, a throttle and a growing queue shrink the limit by these shares, once per epoch.
      FAILURE_SHRINK = 0.35
      THROTTLE_SHRINK = 0.10
      LATENCY_SHRINK = 0.08
      # A probe is kept when a window's throughput beats the one before it by this share, and given up after this many
      # windows that do not; the limit then holds for HOLD_WINDOWS windows.
      PROBE_GAIN = 0.01
      PROBE_WINDOWS = 2
      HOLD_WINDOWS = 1
      # After a rejected warm-start probe, the windows to rest before probing again by one.
      GROWTH_INTERVAL_WINDOWS = 1
      WARM_REJECTIONS = 2
      # Seconds after a throttle, or its Retry-After when longer, during which completions are not measured.
      THROTTLE_COOLDOWN = 1.0
      DOWNLOAD_RANGE_BYTES = 8 * MIB
      # Parts asked for in one begin_upload.
      UPLOAD_BATCH_PARTS = 5
      # The most requests cloud storage and downloads have in flight, and a job across all its transfers, unless the
      # caller's max_concurrency or fixed concurrency says otherwise.
      DEFAULT_MAX = 64

      attr_reader :name, :initial, :start, :min, :soft, :max, :window_attempts, :growth_step, :queue_suppress, :queue_backoff, :latency_floor, :rejected_floor

      # Cloud storage, such as S3. :default starts at one request and warms up toward 32; :aggressive starts at 32.
      def self.storage_upload(startup: :default, max_concurrency: nil)
        new(name: :storage, initial: startup == :aggressive ? 32 : 1, start: 32, min: 4, soft: 32, max: max_concurrency || DEFAULT_MAX,
            growth_step: 2, queue_suppress: 20, queue_backoff: 34, latency_floor: 12, rejected_floor: 12, warm: startup == :default
        )
      end

      # A destination the API reports a direct connection for, such as an agent. Its queue thresholds are cloud
      # storage's 20 and 34, scaled to its maximum of 16.
      def self.direct_upload(max_concurrency: nil)
        new(name: :direct, initial: 4, start: 4, min: 1, soft: 16, max: [ 16, max_concurrency || 16 ].min,
            growth_step: 1, queue_suppress: 5, queue_backoff: 9, latency_floor: 1, rejected_floor: 1
        )
      end

      def self.download(max_concurrency: nil)
        new(name: :download, initial: 32, start: 32, min: 4, soft: 32, max: max_concurrency || DEFAULT_MAX,
            growth_step: 2, queue_suppress: 20, queue_backoff: 34, latency_floor: 12, rejected_floor: 12
        )
      end

      def self.fixed(concurrency)
        new(name: :fixed, initial: concurrency, start: concurrency, min: concurrency, soft: concurrency, max: concurrency,
            growth_step: 0, queue_suppress: concurrency, queue_backoff: concurrency, latency_floor: concurrency, rejected_floor: concurrency, fixed: true
        )
      end

      def initialize(name:, initial:, start:, min:, soft:, max:, growth_step:, queue_suppress:, queue_backoff:, latency_floor:, rejected_floor:,
                     window_attempts: 16, warm: false, fixed: false)
        @name = name
        @max = max
        @initial = [ initial, max ].min
        @start = [ start, max ].min
        @min = [ min, max ].min
        @soft = [ soft, max ].min
        @window_attempts = window_attempts
        @growth_step = growth_step
        @queue_suppress = queue_suppress
        @queue_backoff = queue_backoff
        @latency_floor = [ latency_floor, max ].min
        @rejected_floor = [ rejected_floor, max ].min
        @warm = warm && @initial < @start
        @fixed = fixed
        freeze
      end

      def warm?
        @warm
      end

      def fixed?
        @fixed
      end
    end
  end
end
