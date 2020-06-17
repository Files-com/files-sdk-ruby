module Files
  class SizableIO < IO
    def self.pipe
      r, w = super

      w.instance_variable_set(:@read_io, r)

      [r, w]
    end

    def size
      read_io.content_length_promise.wait.value
    end

    def fulfill_content_length(length)
      read_io.content_length = length
      read_io.content_length_promise.execute
    end

    protected

    attr_accessor :content_length

    def content_length_promise
      @content_length_promise ||= Concurrent::Promise.new { content_length }
    end

    def read_io
      @read_io || self
    end
  end
end