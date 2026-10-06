require "English"

module Files
  class SizableIO < IO
    def self.pipe
      r, w = super

      w.instance_variable_set(:@read_io, r)

      [ r, w ]
    end

    def size
      read_io.content_length_promise.wait.value
    end

    def wait!(timeout = nil)
      read_io.ready_promise.wait(timeout)
      error!
      self
    end

    def fulfill_content_length(length)
      read_io.content_length = length
      read_io.content_length_promise.execute
    end

    def ready!
      read_io.ready_promise.execute
    end

    # Closing always releases the pipe. A reader then raises a download failure
    # that no read has reported, so a caller using IO.copy_stream or another
    # native read cannot mistake a failed download for a finished one. It never
    # raises over an exception that is already propagating, and a failure that
    # starts after the caller chose to close, such as the download no longer
    # being able to write to the pipe, is not reported. Only the reader raises;
    # the writer's close is the producer's cleanup.
    def close
      unreported_failure = with_error if read_io? && !failure_reported
      super
      read_io.content_length_promise.try_set(nil)
      read_io.ready_promise.try_set(true)
      report_failure(unreported_failure) if unreported_failure && $ERROR_INFO.nil?
    end

    def error!
      report_failure(read_io.with_error) if read_io.with_error
    end

    def do_set_error(e)
      read_io.with_error = e
    end

    # A failed download reaches the reader as an ordinary end of file, so these
    # reads and eof? raise the download's failure instead, no later than they
    # reach the end.
    def read(...)
      data = super(...)
      error!
      data
    end

    def gets(...)
      line = super(...)
      error!
      line
    end

    def readline(...)
      super(...)
    rescue EOFError
      error!
      raise
    end

    def readpartial(...)
      super(...)
    rescue EOFError
      error!
      raise
    end

    def each_line(...)
      return enum_for(:each_line, ...) unless block_given?

      super(...)
      error!
      self
    end
    alias each each_line

    def eof?
      at_end = super
      error! if at_end
      at_end
    end
    alias eof eof?

    protected

    attr_accessor :content_length, :with_error, :failure_reported

    def content_length_promise
      @content_length_promise ||= Concurrent::Promise.new { content_length }
    end

    def ready_promise
      @ready_promise ||= Concurrent::Promise.new { true }
    end

    def read_io
      @read_io || self
    end

    def read_io?
      read_io == self
    end

    private

    def report_failure(failure)
      read_io.failure_reported = true
      raise failure
    end
  end
end
