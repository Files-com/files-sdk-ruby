# frozen_string_literal: true

module Files
  module Transfer
    # The bytes a job may hold in memory at once, for parts waiting to be sent or written. A part reserves its bytes
    # before anything is read for it, keeps them through its retries and gives them back once it is acknowledged,
    # written, abandoned or stopped. A part larger than the whole budget is refused before it reads anything, even when
    # nothing else is held. Its methods run under the job's lock.
    class ByteBudget
      Reservation = Struct.new(:bytes, :released)

      attr_reader :limit, :held

      def initialize(limit)
        @limit = limit
        @held = 0
      end

      def check!(bytes)
        return if bytes <= @limit

        raise BufferLimitError, "A #{bytes}-byte part needs more memory than the transfer's buffer_bytes of #{@limit}"
      end

      def available?(bytes)
        check!(bytes)
        @held + bytes <= @limit
      end

      def reserve(bytes)
        raise ArgumentError, "the transfer buffer cannot hold #{bytes} more bytes" unless available?(bytes)

        @held += bytes
        Reservation.new(bytes, false)
      end

      # Gives back what reservation holds, once however often it is called.
      def release(reservation)
        return if reservation.nil? || reservation.released

        reservation.released = true
        @held -= reservation.bytes
      end

      # Gives back all but bytes of what reservation holds, which holds bytes from then on. Nothing changes for a
      # reservation released already or holding no more than bytes.
      def shrink(reservation, bytes)
        return if reservation.nil? || reservation.released || bytes >= reservation.bytes

        @held -= reservation.bytes - bytes
        reservation.bytes = bytes
      end
    end

    # How many files a job transfers at once. Its methods run under the job's lock.
    class FileSlots
      attr_reader :limit, :used

      def initialize(limit)
        @limit = limit
        @used = 0
      end

      def take
        return false if @used >= @limit

        @used += 1
        true
      end

      def give
        @used -= 1 if @used.positive?
      end
    end

    # How many content requests a job has in flight at once, across all its transfers and destinations: heads, whole
    # responses, parts and ranges alike. A request holds its permit from just before it is sent until its response is
    # read or it fails, never while it waits to be retried. Its methods run under the job's lock.
    class RequestPermits < FileSlots; end

    # How long each destination is held back after a throttle: no new content request or retry of a job's, from any of
    # its transfers and through whichever transport or controller, goes to it until the latest Retry-After any of them
    # got from it has passed. A later Retry-After can extend that, never shorten it, and requests already sent finish. A
    # destination is an origin: its scheme, host and port. Its methods run under the job's lock.
    class Holds
      # The destination url names, or nil when it names none.
      def self.destination(url)
        uri = ::URI.parse(url.to_s)
        [ uri.scheme.to_s.downcase, uri.host.downcase, uri.port ].freeze if uri.host
      rescue ::URI::InvalidURIError
        nil
      end

      def initialize(clock: Clock)
        @clock = clock
        @until = {}
      end

      # Holds destination back for seconds from now, unless it already is for longer.
      def hold(destination, seconds)
        return unless destination && seconds.to_f.positive?

        deadline = @clock.now + seconds.to_f
        @until[destination] = [ @until[destination] || deadline, deadline ].max
      end

      # The monotonic time until which destination is held back, or nil once that has passed.
      def deadline(destination)
        deadline = @until[destination]
        return deadline if deadline && deadline > @clock.now

        @until.delete(destination)
        nil
      end

      # Each destination held back now, as its origin, with the seconds left.
      def to_h
        now = @clock.now
        @until.select { |_, deadline| deadline > now }.to_h { |(scheme, host, port), deadline| [ "#{scheme}://#{host}:#{port}", deadline - now ] }
      end
    end
  end
end
