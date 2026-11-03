require "spec_helper"

# The real controller and policies, driven by a clock the examples move by hand. Every attempt starts and finishes at
# a time the example chooses; nothing in the controller is stubbed.
RSpec.describe Files::Transfer::Controller do
  let(:mib) { 1024 * 1024 }
  let(:clock) do
    Class.new do
      attr_reader :now

      def initialize
        @now = 0.0
      end

      def advance(seconds)
        @now += seconds
      end
    end.new
  end

  def controller(policy)
    described_class.new(policy, clock: clock)
  end

  def storage(startup = :default, **options)
    Files::Transfer::Policy.storage_upload(startup: startup, **options)
  end

  # Starts count attempts at once, lets seconds pass and finishes each with bytes.
  def round(controller, seconds:, bytes: mib, count: controller.limit)
    attempts = Array.new(count) { controller.start_attempt }
    clock.advance(seconds)
    attempts.each { |attempt| controller.finish_attempt(attempt, :success, bytes: bytes) }
  end

  def reasons(controller)
    controller.decisions.map { |decision| decision[:reason] }
  end

  describe "starting" do
    it "starts an upload to cloud storage at one request by default and at 32 when aggressive" do
      expect([ controller(storage(:default)).limit, controller(storage(:default)).phase ]).to eq([ 1, :warm ])
      expect([ controller(storage(:aggressive)).limit, controller(storage(:aggressive)).phase ]).to eq([ 32, :ordinary ])
    end

    it "starts direct destinations at 4 and downloads at 32, without a warm start" do
      direct = controller(Files::Transfer::Policy.direct_upload)
      download = controller(Files::Transfer::Policy.download)

      expect([ direct.limit, direct.phase, direct.policy.max ]).to eq([ 4, :ordinary, 16 ])
      expect([ download.limit, download.phase, download.policy.max ]).to eq([ 32, :ordinary, 64 ])
    end

    it "lets the caller's max_concurrency cap every start and maximum" do
      expect(controller(storage(:aggressive, max_concurrency: 8)).limit).to eq(8)
      expect(controller(Files::Transfer::Policy.direct_upload(max_concurrency: 2)).limit).to eq(2)
      expect(Files::Transfer::Policy.direct_upload(max_concurrency: 200).max).to eq(16)
      expect(storage(max_concurrency: 200).max).to eq(200)
    end
  end

  describe "the warm start" do
    it "warms the connection with its first window, takes its second as the baseline and probes upward while each step pays off" do
      warm = controller(storage)
      round(warm, seconds: 0.25)
      expect([ warm.limit, reasons(warm) ]).to eq([ 1, %i[start warm_connection] ])

      2.times { round(warm, seconds: 0.25) } # the baseline, one request at a time: 4 MiB/s
      expect(warm.limit).to eq(2)

      round(warm, seconds: 0.25) # the round that filled the raised limit ends
      expect(warm.limit).to eq(2)
      round(warm, seconds: 0.25) # two at once: 8 MiB/s, at least 4 * (1 + 0.5 * 1 / 1)
      expect(warm.limit).to eq(3)
      expect(reasons(warm)).to eq(%i[start warm_connection warm_probe warm_settling warm_settled warm_probe])
    end

    it "judges a probe once every attempt that filled its raised limit has ended, or once enough answers came without one" do
      warm = controller(storage)
      3.times { round(warm, seconds: 0.25) }
      first, slow = Array.new(2) { warm.start_attempt } # they fill the raised limit of two
      clock.advance(0.25)
      warm.finish_attempt(first, :success, bytes: mib)
      # While the slow one is still out, one more attempt at a time keeps the two the limit allows on the network.
      round(warm, seconds: 0.125, count: 1) # a later, quicker answer closes a window, but the slow one is still out
      expect([ warm.limit, reasons(warm).last ]).to eq([ 2, :warm_settling ])

      13.times { round(warm, seconds: 0.125, count: 1) } # fifteen answers since the raise
      expect([ warm.limit, warm.admitted ]).to eq([ 2, 1 ])
      round(warm, seconds: 0.125, count: 1) # sixteen, at 8 MiB/s: the window then closing judges the probe
      expect(warm.limit).to eq(3)
      warm.finish_attempt(slow, :success, bytes: mib)
    end

    it "returns after a probe that does not pay off, rests two windows of ordinary size and probes again by one" do
      warm = controller(storage)
      4.times { round(warm, seconds: 0.25) } # warmed, the baseline, raised to two and settled
      round(warm, seconds: 0.5) # two at once, each twice as slow: no gain
      expect(warm.limit).to eq(1)

      16.times { round(warm, seconds: 0.25) } # one rest window of sixteen answers
      expect([ warm.limit, reasons(warm).last ]).to eq([ 1, :rest ])
      16.times { round(warm, seconds: 0.25) } # the last rest window is the next baseline
      expect(warm.limit).to eq(2)
      expect(reasons(warm)).to eq(%i[start warm_connection warm_probe warm_settling warm_settled warm_reject rest warm_probe])
    end

    it "keeps warming below its start after a second rejected probe" do
      warm = controller(storage)
      4.times { round(warm, seconds: 0.25) }
      round(warm, seconds: 0.5)
      32.times { round(warm, seconds: 0.25) }
      round(warm, seconds: 0.25)
      round(warm, seconds: 0.5) # no gain again

      expect([ warm.limit, warm.phase ]).to eq([ 1, :warm ])
      expect(reasons(warm).last(2)).to eq(%i[warm_settled warm_reject])
    end

    it "rests instead of probing when its baseline already queues" do
      warm = controller(storage)
      round(warm, seconds: 0.25)
      2.times { round(warm, seconds: 0.75) } # each answer three times slower than the warming one
      expect([ warm.limit, reasons(warm).last ]).to eq([ 1, :warm_queued ])

      32.times { round(warm, seconds: 0.25) } # two rest windows of sixteen answers
      expect(warm.limit).to eq(2)
      expect(reasons(warm).last(3)).to eq(%i[warm_queued rest warm_probe])
    end

    it "abandons a probe after a failure in any epoch and rests where the failure left it, still warming" do
      current = controller(storage)
      3.times { round(current, seconds: 0.25) }
      failing, other = Array.new(2) { current.start_attempt } # sent at the raised limit
      current.finish_attempt(failing, :failure)
      current.finish_attempt(other, :success, bytes: mib)
      expect([ current.limit, current.phase, reasons(current).last ]).to eq([ 1, :warm, :failure ])

      stale = controller(storage)
      round(stale, seconds: 0.25)
      early = stale.start_attempt # sent at the baseline's limit, in its epoch
      2.times { round(stale, seconds: 0.25) }
      expect(stale.limit).to eq(2)
      stale.finish_attempt(early, :failure)
      expect([ stale.limit, stale.phase, reasons(stale).last ]).to eq([ 2, :warm, :warm_interrupted ])
    end

    it "asks a probe for more answers when its baseline's rates varied" do
      warm = controller(storage)
      round(warm, seconds: 0.25)
      round(warm, seconds: 0.25)
      round(warm, seconds: 0.5)
      expect(warm.limit).to eq(2)

      round(warm, seconds: 0.25) # the raised round settles
      7.times { round(warm, seconds: 0.25) } # fourteen of the sixteen answers it needs
      expect(warm.limit).to eq(2)
      round(warm, seconds: 0.25)
      expect(warm.limit).to eq(3)
    end

    it "goes straight to 32 from its first window on a link of at least 96 MiB/s" do
      warm = controller(storage)
      round(warm, seconds: 0.5, bytes: 64 * mib)

      expect([ warm.limit, warm.phase ]).to eq([ 32, :ordinary ])
      expect(reasons(warm)).to eq(%i[start fast_link])
    end

    it "keeps a probe whose larger parts take longer but less time per byte" do
      warm = controller(storage)
      3.times { round(warm, seconds: 1.0, bytes: 4 * mib) } # one 4 MiB part a second
      expect(warm.limit).to eq(2)

      2.times { round(warm, seconds: 2.0, bytes: 16 * mib) } # the raised round settles; then two 16 MiB parts, each two seconds
      expect(warm.limit).to eq(3)
      expect(reasons(warm)).to eq(%i[start warm_connection warm_probe warm_settling warm_settled warm_probe])
    end

    it "decides for parts of varying sizes as for equal parts at the same speed per byte" do
      decide = lambda do |sizes|
        warm = controller(storage)
        sizes.each { |size| round(warm, seconds: size * 0.25, bytes: size * mib) }
        [ warm.limit, reasons(warm) ]
      end

      expect(decide.call([ 1, 1, 4, 2, 3, 1, 2 ])).to eq(decide.call([ 1, 1, 1, 1, 1, 1, 1 ]))
      expect(decide.call([ 1, 1, 1, 1, 1, 1, 1 ]))
        .to eq([ 5, %i[start warm_connection warm_probe warm_settling warm_settled warm_probe warm_settling warm_settled warm_probe] ])
    end

    it "sizes a probe's window from the variation of every judged warm window, at its raised target" do
      warm = controller(storage)
      3.times { round(warm, seconds: 0.25) }
      round(warm, seconds: 0.25) # the raised round settles
      expect(warm.limit).to eq(2)

      first, second = Array.new(2) { warm.start_attempt }
      clock.advance(0.2)
      warm.finish_attempt(first, :success, bytes: mib)
      clock.advance(0.006)
      warm.finish_attempt(second, :success, bytes: mib)
      expect(warm.limit).to eq(3)

      # S = 2 * (0.003 / 0.203)^2 over f = 2 degrees bounds v; at its raised target 3, d = 1, the probe needs
      # ceil(2 * v * (3 * 2 / 0.5)^2) = 6 answers, where the target it came from would have asked for 3.
      round(warm, seconds: 0.2) # the raised round settles
      round(warm, seconds: 0.2)
      expect(warm.limit).to eq(3)
      round(warm, seconds: 0.2)
      expect(warm.limit).to eq(5)
    end
  end

  describe "measurement" do
    it "counts an attempt against the limit from its admission, but as network time only from its send to its answer" do
      warm = controller(storage)
      2.times do
        attempt = warm.admit
        expect([ warm.admitted, warm.inflight ]).to eq([ 1, 0 ])
        clock.advance(4.0) # waiting for a worker and reading the part
        warm.sending(attempt)
        expect(warm.inflight).to eq(1)
        clock.advance(0.25)
        warm.answered(attempt)
        clock.advance(3.0) # settling the outcome and the caller's callbacks
        warm.finish_attempt(attempt, :success, bytes: mib)
        expect([ warm.admitted, warm.inflight ]).to eq([ 0, 0 ])
      end

      # Each warming window, of one answer, was on the network for 0.25 of 7.25 seconds: far too little to judge.
      expect([ warm.limit, reasons(warm) ]).to eq([ 1, %i[start ineligible ineligible] ])
    end
  end

  describe "after the warm start" do
    it "keeps probes that gain 1%, by one at and above soft" do
      steady = controller(storage(:aggressive))
      3.times { round(steady, seconds: 1.0) }

      expect(steady.limit).to eq(35)
      expect(reasons(steady)).to eq(%i[start probe probe_earned probe_earned])
    end

    it "grows by two below soft" do
      steady = controller(storage(:aggressive))
      steady.finish_attempt(steady.start_attempt, :failure)
      round(steady, seconds: 1.0)

      expect(steady.limit).to eq(22)
    end

    it "gives a probe up after two windows that do not gain, then holds a window" do
      steady = controller(storage(:aggressive))
      round(steady, seconds: 1.0) # 32 MiB/s
      2.times { round(steady, seconds: 33.0 / 32) } # still 32 MiB/s with 33 in flight
      expect(steady.limit).to eq(32)

      round(steady, seconds: 1.0)
      expect(steady.limit).to eq(32)
      round(steady, seconds: 1.0)
      expect(steady.limit).to eq(33)
      expect(reasons(steady)).to eq(%i[start probe probe_miss probe_rejected hold probe])
    end

    it "gives a probe up and stops growing while the queue estimate is at least 20" do
      steady = controller(storage(:aggressive))
      round(steady, seconds: 1.0)
      round(steady, seconds: 3.0) # Q = 33 * (1 - 1 / 3)
      round(steady, seconds: 3.0) # Q = 32 * (1 - 1 / 3)

      expect(steady.limit).to eq(32)
      expect(reasons(steady).last(2)).to eq(%i[probe_rejected queue_suppress])
    end

    it "shrinks by 8% when the queue estimate reaches 34" do
      steady = controller(storage(:aggressive))
      6.times { round(steady, seconds: 1.0) }
      expect(steady.limit).to eq(38)

      round(steady, seconds: 20.0) # Q = 38 * (1 - 1 / 20)
      expect(steady.limit).to eq(34)
      expect(reasons(steady).last).to eq(:queue_backoff)
    end

    it "judges no window whose requests in flight averaged under 75% of the limit" do
      steady = controller(storage(:aggressive))
      4.times { round(steady, seconds: 1.0, count: 8) }

      expect(steady.limit).to eq(32)
      expect(reasons(steady)).to eq(%i[start ineligible])
    end
  end

  describe "failures and throttles" do
    it "shrinks by 35% once an epoch, never below the minimum" do
      shrinking = controller(storage(:aggressive))
      first, second = Array.new(2) { shrinking.start_attempt }
      shrinking.finish_attempt(first, :failure)
      shrinking.finish_attempt(second, :failure) # started before the change
      expect(shrinking.limit).to eq(20)

      limits = Array.new(5) { shrinking.finish_attempt(shrinking.start_attempt, :failure) }
      expect(limits).to eq([ 13, 8, 5, 4, 4 ])
    end

    it "shrinks by 10% for a throttle from the current epoch and measures nothing until its cooldown ends" do
      throttled = controller(storage(:aggressive))
      first, second = Array.new(2) { throttled.start_attempt }
      throttled.finish_attempt(first, :throttle)
      throttled.finish_attempt(second, :throttle)
      expect(throttled.limit).to eq(28)
      expect(reasons(throttled)).to eq(%i[start throttle throttle_cooldown])

      round(throttled, seconds: 0.5) # completes within the cooldown
      expect(reasons(throttled).last).to eq(:throttle_cooldown)

      clock.advance(0.5)
      round(throttled, seconds: 1.0)
      expect(throttled.limit).to eq(30)
      expect(reasons(throttled).last).to eq(:probe)
    end

    it "learns nothing from an ignored outcome, and a fixed policy nothing at all" do
      steady = controller(storage(:aggressive))
      steady.finish_attempt(steady.start_attempt, :ignored)
      expect(reasons(steady)).to eq(%i[start])

      fixed = controller(Files::Transfer::Policy.fixed(3))
      fixed.finish_attempt(fixed.start_attempt, :failure)
      fixed.finish_attempt(fixed.start_attempt, :throttle, retry_after: 5)
      5.times { round(fixed, seconds: 1.0) }
      expect(fixed.limit).to eq(3)
      expect(reasons(fixed)).to eq(%i[start])
    end

    it "counts a success sent before a failure's shrink in the window after it" do
      steady = controller(storage(:aggressive))
      early = steady.start_attempt
      steady.finish_attempt(steady.start_attempt, :failure) # 32 to 20, in a new epoch
      later = Array.new(19) { steady.start_attempt }
      clock.advance(1.0)
      ([ early ] + later).each { |attempt| steady.finish_attempt(attempt, :success, bytes: mib) }

      # Twenty answers, the early one included, close the window at the new limit, which then grows.
      expect(steady.limit).to eq(22)
      expect(reasons(steady)).to eq(%i[start failure probe])
    end

    it "keeps the current epoch through a stale throttle, so a later attempt's failure still shrinks the limit once" do
      steady = controller(storage(:aggressive))
      first, stale = Array.new(2) { steady.start_attempt }
      steady.finish_attempt(first, :throttle) # 32 to 28, in a new epoch
      later = steady.start_attempt
      steady.finish_attempt(stale, :throttle, retry_after: 2) # sent before that change: restarts measurement, shrinks nothing
      expect(steady.limit).to eq(28)

      steady.finish_attempt(later, :failure) # sent after it: 28 to 18
      expect(steady.limit).to eq(18)
      expect(reasons(steady)).to eq(%i[start throttle throttle_cooldown failure])
    end

    it "holds a destination back until a throttle's Retry-After, which a later one extends but never shortens, whichever request met it" do
      holds = Files::Transfer::Holds.new(clock: clock)
      destination = Files::Transfer::Holds.destination("https://storage.example.test/parts/1?X-Amz-Signature=fixture")
      expect(Files::Transfer::Holds.destination("https://Storage.example.test:443/objects/2")).to eq(destination)

      holds.hold(destination, 5)
      expect(holds.deadline(destination)).to eq(5.0)
      clock.advance(1.0)
      holds.hold(destination, 2)
      expect(holds.deadline(destination)).to eq(5.0)
      holds.hold(destination, 8)
      holds.hold(destination, 0) # a throttle without a Retry-After holds nothing back
      expect(holds.deadline(destination)).to eq(9.0)
      expect(holds.to_h).to eq({ "https://storage.example.test:443" => 8.0 })
      expect(holds.deadline(Files::Transfer::Holds.destination("https://other.example.test/parts/1"))).to be_nil
      clock.advance(8.0)
      expect(holds.deadline(destination)).to be_nil
    end
  end
end
