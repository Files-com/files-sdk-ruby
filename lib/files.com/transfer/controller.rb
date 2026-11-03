# frozen_string_literal: true

module Files
  module Transfer
    # Decides how many requests to one destination may be in flight at once, from those requests' own completions.
    #
    # It measures in windows. A window closes once it has accepted at least max(window attempts, limit) attempts and
    # lasted at least their mean duration, and is judged only when its requests on the network averaged at least 75% of
    # the limit, so a transfer short of work, or waiting on the API, its source, admission or memory, teaches it
    # nothing. A window's throughput is its accepted bytes over its wall time; its latency L is its attempts' summed
    # durations over those bytes; Lmin is the lowest L of any window; and with I requests on the network on average,
    # its queue estimate is Q = I * (1 - Lmin / L). An accepted attempt counts in the window it finishes in, whichever
    # epoch it was sent in, except during a throttle's cooldown.
    #
    # A policy with a warm start begins below its start. Its first judged window warms the connection and its next sets
    # the baseline. From a baseline that is not already queued it probes upward, adding ceil(n / 2) to n, or 1 after a
    # rest. The attempts in flight once the raised target first fills are the probe's cohort, known by their sequence
    # numbers; the probe is judged by the first window opened after the last of them ends, however it ended, or by the
    # window then closing once max(window attempts, target) answers have arrived since the raise, whichever comes
    # first. It is kept when that window's throughput reaches the baseline's times 1 + 0.5 * d / n and its warm queue
    # estimate, I * (1 - reference median / its median), stays under d / 2, and the next probe follows. Medians are of
    # each accepted attempt's duration per byte, so windows whose attempts carry different sizes compare alike, and the
    # reference median is the fastest judged at the target the probe came from (at a baseline's own target, for a
    # baseline). A rejected probe returns to n and rests HOLD_WINDOWS + GROWTH_INTERVAL_WINDOWS judged windows of
    # ordinary size, as a queued baseline does; the last of them is the next baseline. Warming goes on so below the
    # start: it ends there, or at once on a judged window of 96 MiB/s or more. A failure or throttle in any epoch
    # abandons the probe and starts the rest again, at whatever target its shrink left, down to one. The warming window
    # and the windows before a cohort settles close after target answers; a baseline's or a probe's window after the
    # answers the sampling rule below asks for, though one at 96 MiB/s closes after target answers.
    #
    # After that, each judged window grows the limit by the growth step (1 at or above soft) as a probe, keeps a probe
    # whose window beats the one before by 1%, and gives it up after two windows that do not, holding a window. Q at
    # queue_suppress stops growth, and at queue_backoff shrinks the limit by 8%, not below the latency floor.
    #
    # An attempt counts against the limit from when it is admitted (admit), but is on the network, and measured, only
    # from when the transport starts sending it (sending) until it is answered (answered): an upload's attempt as its
    # response headers arrive, a download's once its whole body has arrived and been checked. Waiting for a worker,
    # reading a part's bytes before the send, writing to the destination and settling the outcome afterwards are not
    # network time. Each attempt carries the epoch it was sent in, and every change of limit starts a new one. A failure
    # shrinks the limit by 35% and a throttle by 10%, only for an attempt from the current epoch; every throttle also
    # starts or extends a cooldown, during which completions are not measured, and restarts measurement, but only a
    # change of limit starts a new epoch, so a throttle from an older one leaves the newer attempts' failures counting.
    # A throttle's Retry-After holds its destination back through the job (Holds), whatever controller its requests
    # use. A fixed policy never changes its limit. Its methods lock the controller, so any thread may call them.
    class Controller
      Attempt = Struct.new(:sequence, :epoch, :started_at, :ended_at)
      MAX_DECISIONS = 256
      MAX_SAMPLES = 1024

      attr_reader :policy

      def initialize(policy, clock: Clock)
        @policy = policy
        @clock = clock
        @lock = Mutex.new
        @limit = policy.initial
        @phase = if policy.fixed?
                   :fixed
                 elsif policy.warm?
                   :warm
                 else
                   :ordinary
                 end
        # While warming: :warming, :baseline, :settling (a probe's cohort is still running), :probing or :resting.
        @stage = :warming
        @epoch = 0
        @sequence = 0
        @admitted = 0
        @inflight = 0
        # Sequence numbers of the attempts admitted and not yet finished.
        @outstanding = {}
        @cohort = nil
        @answers = 0
        @warm_spread = 0.0
        @warm_degrees = 0
        @warm_medians = {}
        @cooldown_until = nil
        @latency_min = nil
        @decisions = []
        @warm_target = 2
        @warm_probe = nil
        @rest_windows = 0
        @rested = false
        @probe = nil
        @hold_windows = 0
        @judged_windows = 0
        @ineligible_windows = 0
        now = @clock.now
        reset_window(now)
        record(now, :start, @limit)
      end

      def limit
        @lock.synchronize { @limit }
      end

      # Attempts on the network now: from the start of their send until they are answered (see answered).
      def inflight
        @lock.synchronize { @inflight }
      end

      # Attempts admitted and not yet finished, sent or not: what the limit bounds.
      def admitted
        @lock.synchronize { @admitted }
      end

      def phase
        @lock.synchronize { @phase }
      end

      # Its decisions, oldest first and at most the last 256, each a frozen Hash of :at (its clock's seconds),
      # :phase, :from, :to and :reason.
      def decisions
        @lock.synchronize { @decisions.dup }
      end

      # Its policy, phase, limit, attempts admitted, attempts on the network (inflight) and epoch, with how many
      # measurement windows it judged and how many it closed without judging because too few requests were on the
      # network (judged_windows and ineligible_windows).
      def snapshot
        @lock.synchronize do
          { policy: @policy.name, phase: @phase, limit: @limit, admitted: @admitted, inflight: @inflight, epoch: @epoch,
            judged_windows: @judged_windows, ineligible_windows: @ineligible_windows }
        end
      end

      # Counts an attempt against the limit from now, before it is sent, with the next sequence number; sending,
      # answered and finish_attempt take what it returns.
      def admit
        @lock.synchronize do
          @admitted += 1
          attempt = Attempt.new(@sequence += 1)
          @outstanding[attempt.sequence] = true
          note_cohort
          attempt
        end
      end

      # As the transport starts sending attempt, connection setup included: it is in flight, in the current epoch, from
      # now.
      def sending(attempt)
        @lock.synchronize do
          return if attempt.started_at

          now = @clock.now
          advance(now)
          @inflight += 1
          attempt.epoch = @epoch
          attempt.started_at = now
        end
      end

      # As attempt is answered, an upload's as its response headers arrive and a download's once its whole body has
      # arrived and been checked: it is no longer on the network from now. Only the first call counts.
      def answered(attempt)
        @lock.synchronize { answer(attempt, @clock.now) }
      end

      # Admits an attempt and starts sending it at once.
      def start_attempt
        attempt = admit
        sending(attempt)
        attempt
      end

      # outcome is :success, with the bytes the attempt carried; :failure, for an error worth retrying; :throttle, for
      # a 429 or 503, with its Retry-After seconds; or :ignored, for what says nothing about capacity, such as a
      # cancellation, a refused or expired request or the caller's source or callback failing. An attempt never sent
      # teaches nothing, but every attempt ending counts toward settling a probe's cohort. Returns the limit.
      def finish_attempt(attempt, outcome, bytes: 0, retry_after: nil)
        @lock.synchronize do
          now = @clock.now
          answer(attempt, now)
          advance(now)
          @admitted -= 1
          @outstanding.delete(attempt.sequence)
          if attempt.started_at
            case outcome
            when :success then measure(attempt, now, bytes)
            when :failure then failed(attempt, now)
            when :throttle then throttled(attempt, now, retry_after)
            end
          end
          settle_cohort(attempt, now)
          @limit
        end
      end

      private

      def answer(attempt, now)
        return unless attempt.started_at && attempt.ended_at.nil?

        advance(now)
        @inflight -= 1
        attempt.ended_at = now
      end

      # Adds the time since the last event to the window's requests-in-flight integral. A window restarts when a
      # cooldown ends, and nothing accumulates during one.
      def advance(now)
        if @cooldown_until
          return if now < @cooldown_until

          reset_window(@cooldown_until)
          @cooldown_until = nil
        end
        @window[:busy] += @inflight * (now - @window[:last_change])
        @window[:last_change] = now
      end

      def reset_window(now)
        @window = { started_at: now, last_change: now, busy: 0.0, attempts: 0, bytes: 0, durations: 0.0, samples: [] }
      end

      # An accepted attempt, in the current window whichever epoch it was sent in, unless a cooldown is running.
      def measure(attempt, now, bytes)
        return if @phase == :fixed || @cooldown_until

        window = @window
        duration = attempt.ended_at - attempt.started_at
        window[:attempts] += 1
        window[:bytes] += bytes
        window[:durations] += duration
        window[:samples] << (duration / bytes) if bytes.positive? && window[:samples].size < MAX_SAMPLES
        answered_since_raise
        elapsed = now - window[:started_at]
        return unless elapsed >= window[:durations] / window[:attempts]
        return unless window[:attempts] >= window_target || fast_window?(window, elapsed)

        close_window(now)
      end

      # A warm window already at 96 MiB/s or more closes once target answers have arrived, without more samples.
      def fast_window?(window, elapsed)
        @phase == :warm && window[:attempts] >= @limit && elapsed.positive? && window[:bytes] / elapsed >= Policy::FAST_LINK_BYTES_PER_SECOND
      end

      # The answers a window needs: max(window attempts, limit), except while warming: the limit for the warming window
      # and the windows before a probe's cohort settles, and what the sampling rule asks for, at least the limit, for a
      # baseline's or a probe's window. A rest's windows are of the ordinary size.
      def window_target
        ordinary = [ @policy.window_attempts, @limit ].max
        return ordinary unless @phase == :warm

        case @stage
        when :baseline, :probing then [ @limit, @warm_target ].max
        when :resting then ordinary
        else @limit
        end
      end

      def close_window(now)
        window = @window
        elapsed = now - window[:started_at]
        reset_window(now)
        return unless elapsed.positive?

        stats = {
          inflight: window[:busy] / elapsed,
          throughput: window[:bytes] / elapsed,
          latency: window[:bytes].positive? ? window[:durations] / window[:bytes] : nil,
          samples: window[:samples]
        }
        latency = stats[:latency]
        @latency_min = latency if !latency.nil? && latency.positive? && (@latency_min.nil? || latency < @latency_min)
        if stats[:inflight] < Policy::ELIGIBLE_OCCUPANCY * @limit
          @ineligible_windows += 1
          record(now, :ineligible, @limit)
        elsif @phase == :warm
          @judged_windows += 1
          judge_warm(now, stats)
        else
          @judged_windows += 1
          judge(now, stats)
        end
      end

      # A judged warm window. The fast-link check comes first, whatever the window was for.
      def judge_warm(now, stats)
        note_warm(stats[:samples]) unless @stage == :settling
        return promote(now) if stats[:throughput] >= Policy::FAST_LINK_BYTES_PER_SECOND

        case @stage
        when :warming
          @stage = :baseline
          @warm_target = required_samples(@limit, [ next_added, 1 ].max)
          record(now, :warm_connection, @limit)
        when :settling then record(now, :warm_settling, @limit)
        when :baseline then rest_or_probe(now, stats)
        when :probing then judge_probe(now, stats)
        else
          @rest_windows -= 1
          @rest_windows.positive? ? record(now, :rest, @limit) : rest_or_probe(now, stats)
        end
      end

      def promote(now)
        @warm_probe = nil
        @cohort = nil
        @phase = :ordinary
        change(now, [ @policy.start, @limit ].max, :fast_link)
      end

      # From a judged baseline, or the last window of a rest: rests again when that window's own warm queue estimate is
      # already at least half what the next probe would add, and otherwise raises the target by that much.
      def rest_or_probe(now, stats)
        added = next_added
        return finish_warm(now, :warm_complete) unless added.positive?
        return rest(now, :warm_queued) if warm_queue(@limit, stats) >= 0.5 * added

        @warm_probe = { from: @limit, added: added, reference: stats }
        @warm_target = required_samples(@limit, added)
        @stage = :settling
        @cohort = nil
        @answers = 0
        change(now, @limit + added, :warm_probe)
        note_cohort
      end

      # The window judging a probe: the raise is kept, and the next probe follows, when its throughput beats the
      # baseline's by half the share of attempts added and its warm queue estimate stays under d / 2; otherwise the
      # target goes back to where the probe came from, to rest.
      def judge_probe(now, stats)
        probe = @warm_probe
        return rest_or_probe(now, stats) unless probe

        @warm_probe = nil
        required = probe[:reference][:throughput] * (1 + (0.5 * probe[:added] / probe[:from]))
        if stats[:throughput] >= required && warm_queue(probe[:from], stats, probe[:reference]) < 0.5 * probe[:added]
          @rested = false
          return finish_warm(now, :warm_complete) if @limit >= @policy.start

          rest_or_probe(now, stats)
        else
          change(now, probe[:from], :warm_reject)
          rest(now)
        end
      end

      # Rests HOLD_WINDOWS + GROWTH_INTERVAL_WINDOWS judged windows of ordinary size; the probe after it adds one.
      def rest(now, reason = nil)
        @stage = :resting
        @rest_windows = Policy::HOLD_WINDOWS + Policy::GROWTH_INTERVAL_WINDOWS
        @rested = true
        @warm_probe = nil
        @cohort = nil
        record(now, reason, @limit) if reason
      end

      # What the next warm probe adds: half the target, rounded up, or one after a rest, never past the start.
      def next_added
        [ @rested ? 1 : (@limit / 2.0).ceil, @policy.start - @limit ].min
      end

      def finish_warm(now, reason)
        @phase = :ordinary
        record(now, reason, @limit)
      end

      # The attempts in flight when a probe's raised target first fills are its cohort, by their sequence numbers.
      def note_cohort
        return unless @phase == :warm && @stage == :settling && @cohort.nil? && @admitted >= @limit

        @cohort = @outstanding.keys.to_set
      end

      # Once every attempt of a probe's cohort has ended, however it ended, the window opened then judges the probe.
      def settle_cohort(attempt, now)
        return unless @cohort&.delete?(attempt.sequence) && @cohort&.empty?

        @cohort = nil
        return unless @phase == :warm && @stage == :settling

        @stage = :probing
        reset_window(now)
        record(now, :warm_settled, @limit)
      end

      # An accepted answer since a probe's raise: once max(window attempts, target) of them have arrived, the window
      # then closing judges the probe, whether its cohort has settled or not.
      def answered_since_raise
        return unless @phase == :warm && @stage == :settling

        @answers += 1
        return if @answers < [ @policy.window_attempts, @limit ].max

        @stage = :probing
        @cohort = nil
      end

      # A judged warm window's samples, each an accepted attempt's duration over its bytes: the fastest median at its
      # target, and their squared deviations from their mean, relative to its square, with their degrees of freedom.
      def note_warm(samples)
        median = median(samples)
        best = @warm_medians[@limit]
        @warm_medians[@limit] = median if !median.nil? && median.positive? && (best.nil? || median < best)
        return if samples.size < 2

        mean = samples.sum / samples.size
        return unless mean.positive?

        @warm_spread += samples.sum { |sample| ((sample / mean) - 1)**2 }
        @warm_degrees += samples.size - 1
      end

      # I * (1 - reference median / current median duration per byte): how much of a window's concurrency queued,
      # against the fastest median judged at target, or reference's when none was.
      def warm_queue(target, stats, reference = nil)
        before = @warm_medians[target] || (reference && median(reference[:samples]))
        after = median(stats[:samples])
        return 0.0 unless before&.positive? && after&.positive?

        stats[:inflight] * (1 - (before / after))
      end

      def median(samples)
        sorted = samples.sort
        return if sorted.empty?

        middle = sorted.size / 2
        sorted.size.odd? ? sorted[middle] : (sorted[middle - 1] + sorted[middle]) / 2.0
      end

      # How many attempts the probe window needs to tell a gain of 0.5 * d / n from noise. With S the relative squared
      # deviations note_warm summed over every judged warm window so far, this one included, and f their degrees of
      # freedom, a = 2 / (9f) and h = 1 - a - 2 * sqrt(a), v = S / (f * h^3) bounds their variance from above (no
      # bound when h is not positive), and the probe at its raised target r = n + d needs
      # max(2, ceil(2 * v * (r * 2 / (0.5d))^2)), at most the window attempts; two without any spread or freedom.
      def required_samples(from, added)
        return 2 if @warm_degrees < 1 || !@warm_spread.positive? || !added.positive?

        a = 2.0 / (9 * @warm_degrees)
        h = 1 - a - (2 * Math.sqrt(a))
        return @policy.window_attempts unless h.positive?

        variance = @warm_spread / (@warm_degrees * (h**3))
        raised = from + added
        (2 * variance * (((raised * 2.0) / (0.5 * added))**2)).ceil.clamp(2, @policy.window_attempts)
      end

      def judge(now, stats)
        queue = queue_estimate(stats)
        probe = @probe
        if queue >= @policy.queue_backoff
          @probe = nil
          shrink(now, Policy::LATENCY_SHRINK, @policy.latency_floor, :queue_backoff)
        elsif probe
          if queue < @policy.queue_suppress && stats[:throughput] >= probe[:baseline] * (1 + Policy::PROBE_GAIN)
            @probe = nil
            grow(now, stats, :probe_earned)
          elsif queue < @policy.queue_suppress && (probe[:misses] += 1) < Policy::PROBE_WINDOWS
            record(now, :probe_miss, @limit)
          else
            @probe = nil
            @hold_windows = Policy::HOLD_WINDOWS
            change(now, [ probe[:from], [ @policy.rejected_floor, @limit ].min ].max, :probe_rejected)
          end
        elsif queue >= @policy.queue_suppress
          record(now, :queue_suppress, @limit)
        elsif @hold_windows.positive?
          @hold_windows -= 1
          record(now, :hold, @limit)
        else
          grow(now, stats, :probe)
        end
      end

      def queue_estimate(stats)
        latency = stats[:latency]
        return 0.0 unless latency&.positive? && @latency_min

        stats[:inflight] * (1 - (@latency_min / latency))
      end

      def grow(now, stats, reason)
        return record(now, reason == :probe ? :at_max : reason, @limit) if @limit >= @policy.max

        step = @limit < @policy.soft ? @policy.growth_step : 1
        @probe = { from: @limit, baseline: stats[:throughput], misses: 0 }
        change(now, [ @limit + step, @policy.max ].min, reason)
      end

      # Shrinks the limit by share, to no less than floor (or the limit, when that is lower) and by at least one.
      # Returns whether it changed.
      def shrink(now, share, floor, reason)
        target = [ (@limit * (1 - share)).floor, @limit - 1 ].min
        target = [ target, [ floor, @limit ].min, 1 ].max
        return false if target >= @limit

        change(now, target, reason)
        true
      end

      # A failure shrinks the limit only for an attempt from the current epoch; while warming, down to one, and in any
      # epoch it abandons the probe and starts the rest again.
      def failed(attempt, now)
        return if @phase == :fixed
        return warm_interrupted(now, attempt.epoch == @epoch && shrink(now, Policy::FAILURE_SHRINK, 1, :failure)) if @phase == :warm
        return unless attempt.epoch == @epoch

        @probe = nil
        shrink(now, Policy::FAILURE_SHRINK, @policy.min, :failure)
      end

      # A throttle shrinks the limit only for an attempt from the current epoch (while warming, down to one), which starts
      # a new epoch. Every throttle, in any epoch, starts or extends a cooldown and restarts measurement; one that changed
      # no limit keeps the epoch, so attempts sent since the last change still count their failures. While warming, in
      # any epoch, it abandons the probe and rests again. A fixed policy learns nothing from it.
      def throttled(attempt, now, retry_after)
        return if @phase == :fixed

        cooldown = now + [ Policy::THROTTLE_COOLDOWN, retry_after.to_f ].max
        @cooldown_until = [ @cooldown_until || cooldown, cooldown ].max
        current = attempt.epoch == @epoch
        @probe = nil if current
        shrunk = current && shrink(now, Policy::THROTTLE_SHRINK, @phase == :warm ? 1 : @policy.min, :throttle)
        unless shrunk
          reset_window(now)
          record(now, :throttle_cooldown, @limit)
        end
        rest(now) if @phase == :warm
      end

      # A failure while warming, in any epoch: the probe is abandoned without being judged, and the rest starts again,
      # at whatever target the failure left.
      def warm_interrupted(now, shrunk)
        reset_window(now) unless shrunk
        rest(now, shrunk ? nil : :warm_interrupted)
      end

      def change(now, to, reason)
        from = @limit
        if to != from
          @limit = to
          @epoch += 1
          reset_window(now)
        end
        record(now, reason, from)
      end

      def record(now, reason, from)
        @decisions.shift if @decisions.size >= MAX_DECISIONS
        @decisions << { at: now, phase: @phase, from: from, to: @limit, reason: reason }.freeze
        nil
      end
    end
  end
end
