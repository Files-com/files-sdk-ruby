# frozen_string_literal: true

module Files
  # Adaptive transfers: uploads and downloads that send their parts concurrently and tune how many are in flight to
  # what the link sustains, within the limits the caller sets. They are opt-in, through the transfer: option of
  # Files::File.upload_file, Files::File.upload_io (with a known size), #upload_file, #download_file and
  # #download_content (see docs/file.md); without it every transfer works as it always has.
  module Transfer
    # Raised by a transfer whose Control was cancelled, once the requests it had in flight have settled. Nothing is
    # finalized after it.
    class CancelledError < Error
      def initialize(message = "The transfer was cancelled")
        super
      end
    end

    # Raised by a transfer whose Control was paused, once the requests it had in flight have settled. checkpoint
    # resumes it in this process with Files::File.resume_upload or Files::File.resume_download; it is nil when what was
    # transferred cannot be continued: a transfer paused before it started, an upload from a caller's stream, which
    # cannot be read again, or a download into a caller's IO that can neither start over nor report where its bytes
    # began. A resume paused before its turn, or before it finished checking the local file or destination, gives back
    # the checkpoint it was given, still usable.
    class PausedError < Error
      attr_reader :checkpoint

      def initialize(checkpoint = nil, message = "The transfer was paused")
        super(message)
        @checkpoint = checkpoint
      end
    end

    # A part needs more memory than the transfer's buffer_bytes allows. It is raised before anything is read for that
    # part, so raise buffer_bytes or transfer without transfer:. An adaptive download through a caller's client raises
    # it, before it sends a content request or writes anything, when the client's adapter is not one it relies on to
    # stream a response
    # through Faraday's on_data (Faraday's net_http or net_http_persistent), and refuses with it a 2xx response such an
    # adapter still read whole.
    class BufferLimitError < InvalidParameterError; end

    # The remote file changed while it was downloading: storage refused a range for the version the download began
    # with, or answered with another version.
    class VersionChangedError < Error
      def initialize(message = "The remote file changed during the download")
        super
      end
    end

    # A response that came from the Files.com web app rather than file storage, such as a sign-in page. Nothing from
    # it is written.
    class FrontendResponseError < Error
      def initialize(message = "The transfer was answered by the Files.com web app instead of file storage")
        super
      end
    end

    # The local file being uploaded changed or ended early while its parts were being sent, or a caller's stream ended
    # before the size it was given. The upload is not finalized.
    class SourceChangedError < Error
      def initialize(message = "The local file changed during the upload")
        super
      end
    end

    # A checkpoint that cannot resume: it came from another process, another resume is using it, a resume already
    # started from it, or the local file, the destination (including the bytes already written to it, which must be
    # read back to be checked) or the remote file is no longer the one it was taken from. Nothing is sent, written or
    # truncated before it is raised.
    class CheckpointError < InvalidParameterError; end

    # A request that failed before a whole response arrived. retryable? is false for a TLS failure, which repeating
    # cannot fix. Coordinators raise original (downloads) or an APIConnectionError (uploads) in its place, as the
    # transfers without transfer: do.
    class NetworkFailure < StandardError
      attr_reader :original

      def initialize(original, retryable: true)
        super("Transfer request failed (#{original.class})")
        @original = original
        @retryable = retryable
      end

      def retryable?
        @retryable
      end
    end

    # Carries an error from the caller's source or destination through the transport unchanged, so it is never taken
    # for a network failure and retried.
    class Passthrough < StandardError
      attr_reader :error

      def initialize(error)
        super("Transfer source or destination failed (#{error.class})")
        @error = error
      end
    end

    private_constant :NetworkFailure, :Passthrough
  end
end
