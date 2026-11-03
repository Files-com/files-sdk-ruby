# frozen_string_literal: true

module Files
  module Transfer
    # Where a paused transfer stopped, for Files::File.resume_upload or Files::File.resume_download in the same process.
    #
    # It holds no credentials, signed URLs, API options or API response fields; resuming takes the options again. It
    # records, frozen, what it must find unchanged: an upload's local file (device, inode, size and modification
    # time), its reference, the upload parameters it began with (only mkdir_parents, with_rename and size), a
    # fingerprint of each part's instructions (a SHA-256 digest of their method, headers, size and retry rules, never
    # their URL) and the parts storage acknowledged; a download's destination (a local file's device and inode, or the
    # caller's IO object itself), the number of bytes written to it with a SHA-256 digest of them, and the remote
    # file's version. Resuming refuses with CheckpointError, before it sends, writes or truncates anything, when any of
    # them changed; a renewed part whose instructions differ stops the upload, and a download stops with
    # VersionChangedError when storage no longer has that version.
    #
    # One resume at a time holds it. Once that resume has checked the local file or destination and starts its
    # transfer, the checkpoint is spent for good, however the transfer ends: a pause then gives a new checkpoint. Only a
    # resume refused before it started, as above, or paused or cancelled before its turn or before it finished those
    # checks, leaves it usable. It cannot be dumped or resumed in another process.
    class Checkpoint
      # One resume's hold on a checkpoint, which only that resume's transfer has. start! spends the checkpoint.
      class Lease
        def initialize
          @started = false
        end

        def start!
          @started = true
        end

        def started?
          @started
        end
      end
      private_constant :Lease

      attr_reader :direction, :path, :local_path, :total_bytes, :completed_bytes, :source, :sink, :version, :state

      # The identity of an opened local file, from its stat: [device, inode], with size and modification time unless
      # contents is false.
      def self.identity(stat, contents: true)
        contents ? [ stat.dev, stat.ino, stat.size, stat.mtime.to_r ] : [ stat.dev, stat.ino ]
      end

      # A frozen copy of value's Hashes, Arrays and Strings, all the way down. Anything else, such as a caller's IO, is
      # kept as it is.
      def self.frozen(value)
        case value
        when Hash then value.to_h { |key, item| [ frozen(key), frozen(item) ] }.freeze
        when Array then value.map { |item| frozen(item) }.freeze
        when String then value.frozen? ? value : value.dup.freeze
        else value
        end
      end

      def initialize(direction:, path:, total_bytes:, completed_bytes:, local_path: nil, source: nil, sink: nil, version: nil, state: {})
        @process = Process.pid
        @direction = direction
        @path = path.dup.freeze
        @local_path = local_path&.dup&.freeze
        @total_bytes = total_bytes
        @completed_bytes = completed_bytes
        @source = Checkpoint.frozen(source)
        @sink = Checkpoint.frozen(sink)
        @version = version&.dup&.freeze
        @state = Checkpoint.frozen(state)
        @hold_lock = Mutex.new
        @hold = [ :ready ]
        freeze
      end

      # Raises CheckpointError unless this checkpoint can resume a transfer in direction (:upload or :download).
      def verify!(direction)
        raise CheckpointError, "Bad parameter: a transfer checkpoint resumes only in the process that paused it" unless @process == Process.pid
        raise CheckpointError, "Bad parameter: this checkpoint resumes #{@direction == :upload ? 'an upload' : 'a download'}" unless @direction == direction
      end

      # Runs the block, which resumes the transfer in direction, as the one resume holding this checkpoint, and returns
      # what it returns. The block gets the resume's lease and calls its start! once its checks pass, before it sends,
      # writes or truncates anything; from then on the checkpoint is spent, whatever happens. Raises CheckpointError as
      # verify! does, while another resume holds it, and once it is spent.
      def resuming(direction)
        verify!(direction)
        lease = Lease.new
        @hold_lock.synchronize do
          case @hold[0]
          when Lease then raise CheckpointError, "Bad parameter: another resume is already using this checkpoint"
          when :spent then raise CheckpointError, "Bad parameter: this checkpoint has already been used to resume its transfer; resume from the checkpoint its own pause gave"
          end
          @hold[0] = lease
        end
        begin
          yield lease
        ensure
          @hold_lock.synchronize { @hold[0] = lease.started? ? :spent : :ready }
        end
      end

      def inspect
        "#<#{self.class.name} #{@direction} #{@path.inspect} #{@completed_bytes} of #{@total_bytes.inspect} bytes>"
      end

      def to_s
        inspect
      end

      def marshal_dump
        raise TypeError, "a Files::Transfer::Checkpoint resumes only in the process that paused it, so it cannot be dumped"
      end
    end
  end
end
