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

    def close
      raise @with_error if @with_error

      super
      read_io.content_length_promise.try_set(nil)
      read_io.ready_promise.try_set(true)
    end

    def error!
      raise read_io.with_error if read_io.with_error
    end

    def do_set_error(e)
      read_io.with_error = e
    end

    protected

    attr_accessor :content_length, :with_error

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
  end
end
