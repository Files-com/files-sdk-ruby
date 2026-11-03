# frozen_string_literal: true

module Files
  module Transfer
    # Lets another thread stop an adaptive transfer. cancel and pause stop new requests at once; the transfer then
    # waits for the requests already in flight, releases the memory and connections it holds and raises
    # CancelledError or PausedError. The first of the two wins, and a Control stays stopped: resume with a new one.
    class Control
      def initialize
        @lock = Mutex.new
        @state = :running
        @listeners = []
      end

      def cancel
        change(:cancelled)
      end

      def pause
        change(:paused)
      end

      def cancelled?
        @state == :cancelled
      end

      def paused?
        @state == :paused
      end

      # :running, :cancelled or :paused.
      attr_reader :state

      # A listener's wake is called after each change, so jobs waiting on this control notice it at once.
      def subscribe(listener)
        @lock.synchronize { @listeners << listener }
      end

      def unsubscribe(listener)
        @lock.synchronize { @listeners.delete(listener) }
      end

      private def change(state)
        listeners = @lock.synchronize do
          return false unless @state == :running

          @state = state
          @listeners.dup
        end
        listeners.each(&:wake)
        true
      end
    end

    # What an adaptive transfer may use. The transfer: option takes these as a Hash, true for all the defaults, an
    # Options or a Job that several transfers share.
    #
    # concurrency:: :automatic (the default) tunes the requests in flight from what the link sustains; an Integer from
    #               1 to 256 keeps exactly that many.
    # startup:: With :automatic, :default starts an upload to cloud storage with one request and grows while each
    #           step pays off; :aggressive starts at 32. Downloads and direct destinations ignore it.
    # max_concurrency:: With :automatic, the most requests in flight, from 1 to 256. The default is 64 for cloud
    #                   storage and downloads and 16 for direct destinations, which it can only lower.
    # buffer_bytes:: The most bytes held in memory at once for parts waiting to be sent or written, at least 65,536.
    #                The default is 256 MiB.
    # max_files:: How many files a shared Job transfers at once; more wait their turn. The default is 4.
    # control:: A Control that cancels or pauses the transfer.
    class Options
      MAX_CONCURRENCY = 256
      DEFAULT_BUFFER_BYTES = 256 * 1024 * 1024
      MIN_BUFFER_BYTES = 64 * 1024
      DEFAULT_MAX_FILES = 4
      KEYS = %i[concurrency startup max_concurrency buffer_bytes max_files control].freeze
      STARTUPS = %i[default aggressive].freeze

      attr_reader :concurrency, :startup, :max_concurrency, :buffer_bytes, :max_files, :control

      def self.from(value)
        case value
        when Options then value
        when true then new
        when Hash
          unknown = value.keys - KEYS
          raise InvalidParameterError, "Bad parameter: transfer does not take #{unknown.map(&:inspect).join(', ')}" unless unknown.empty?

          new(**value)
        else
          raise InvalidParameterError, "Bad parameter: transfer must be true, a Hash of transfer options, a Files::Transfer::Options or a Files::Transfer::Job"
        end
      end

      def initialize(concurrency: :automatic, startup: :default, max_concurrency: nil, buffer_bytes: DEFAULT_BUFFER_BYTES, max_files: DEFAULT_MAX_FILES, control: nil)
        @concurrency = concurrency
        @startup = startup
        @max_concurrency = max_concurrency
        @buffer_bytes = buffer_bytes
        @max_files = max_files
        @control = control
        validate
        freeze
      end

      def automatic?
        @concurrency == :automatic
      end

      def to_h
        KEYS.to_h { |key| [ key, public_send(key) ] }
      end

      private def validate
        raise InvalidParameterError, "Bad parameter: transfer concurrency must be :automatic or an Integer from 1 to #{MAX_CONCURRENCY}" unless automatic? || concurrency_count?(@concurrency)
        raise InvalidParameterError, "Bad parameter: transfer startup must be :default or :aggressive" unless STARTUPS.include?(@startup)
        raise InvalidParameterError, "Bad parameter: transfer startup applies only to automatic concurrency" if !automatic? && @startup != :default
        raise InvalidParameterError, "Bad parameter: transfer max_concurrency must be an Integer from 1 to #{MAX_CONCURRENCY}, with automatic concurrency" unless @max_concurrency.nil? || (automatic? && concurrency_count?(@max_concurrency))
        raise InvalidParameterError, "Bad parameter: transfer buffer_bytes must be an Integer of at least #{MIN_BUFFER_BYTES}" unless @buffer_bytes.is_a?(Integer) && @buffer_bytes >= MIN_BUFFER_BYTES
        raise InvalidParameterError, "Bad parameter: transfer max_files must be a positive Integer" unless @max_files.is_a?(Integer) && @max_files.positive?
        raise InvalidParameterError, "Bad parameter: transfer control must be a Files::Transfer::Control" unless @control.nil? || @control.is_a?(Control)
      end

      private def concurrency_count?(value)
        value.is_a?(Integer) && value.between?(1, MAX_CONCURRENCY)
      end
    end
  end
end
