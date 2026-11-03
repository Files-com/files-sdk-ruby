require "socket"

# A loopback HTTP server for transfer specs. It answers each connection with
# one canned response, written byte for byte, so a spec controls exactly the
# framing a storage provider sends, including bodies that end early. Every
# request it receives is recorded, with its method and body.
#
# With concurrent: true it answers each connection on its own thread, so a spec
# can see requests that are really in flight at once: each Request records how
# many were (itself included) when it arrived, and peak_in_flight the most at
# any time. A request counts as in flight from when it has been read until its
# response is written.
class TransferServer
  Request = Struct.new(:target, :headers, :http_method, :body, :in_flight)

  # How long close waits for each concurrent connection still being answered.
  SHUTDOWN_SECONDS = 5

  attr_reader :requests

  def self.response(status, headers = {}, body = "")
    head = [ "HTTP/1.1 #{status}", *headers.map { |name, value| "#{name}: #{value}" }, "Connection: close" ]
    "#{head.join("\r\n")}\r\n\r\n".b + body.b
  end

  # The block receives each client socket once its request has been read, and
  # the connection closes when the block returns. With concurrent: true it
  # receives the Request instead and returns the response to write: a String,
  # or an Array of Strings written in turn and callables called between them,
  # such as a sleep that holds a body back after its headers.
  def initialize(concurrent: false, &respond)
    @respond = respond
    @concurrent = concurrent
    @requests = []
    @lock = Mutex.new
    @changed = ConditionVariable.new
    @in_flight = 0
    @peak = 0
    @handlers = []
    @listener = TCPServer.new("127.0.0.1", 0)
    @thread = Thread.new { serve }
  end

  def url(target)
    "http://127.0.0.1:#{@listener.addr[1]}#{target}"
  end

  def peak_in_flight
    @lock.synchronize { @peak }
  end

  # Waits until at least count requests have been in flight at once, for at
  # most timeout seconds, and returns whether they were.
  def wait_for_peak(count, timeout: 5)
    deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + timeout
    @lock.synchronize do
      until @peak >= count
        remaining = deadline - Process.clock_gettime(Process::CLOCK_MONOTONIC)
        return false unless remaining.positive?

        @changed.wait(@lock, remaining)
      end
      true
    end
  end

  # Waits until at least count requests have arrived at a concurrent server, for
  # at most timeout seconds, and returns whether they did.
  def wait_for_requests(count, timeout: 5)
    deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + timeout
    @lock.synchronize do
      until @requests.size >= count
        remaining = deadline - Process.clock_gettime(Process::CLOCK_MONOTONIC)
        return false unless remaining.positive?

        @changed.wait(@lock, remaining)
      end
      true
    end
  end

  # Stops accepting connections and returns once the server has stopped
  # writing. A concurrent connection still being answered after
  # SHUTDOWN_SECONDS is stopped.
  def close
    @listener.close
    @thread.join
    handlers = @lock.synchronize { @handlers.dup }
    handlers.each { |handler| handler.join(SHUTDOWN_SECONDS) || handler.kill }
  end

  private

  def serve
    loop do
      client = @listener.accept
      if @concurrent
        @lock.synchronize { @handlers << Thread.new(client) { |connection| answer(connection) } }
      else
        answer_serially(client)
      end
    end
  rescue IOError, Errno::EBADF
    nil # The listener was closed.
  end

  def answer_serially(client)
    request = read_request(client)
    return unless request

    @requests << request
    @respond.call(client)
  rescue Errno::EPIPE, Errno::ECONNRESET
    nil # The client stopped reading, which some specs do on purpose.
  ensure
    client.close
  end

  def answer(client)
    request = read_request(client)
    return unless request

    @lock.synchronize do
      @in_flight += 1
      @peak = [ @peak, @in_flight ].max
      request.in_flight = @in_flight
      @requests << request
      @changed.broadcast
    end
    begin
      response = @respond.call(request)
    ensure
      @lock.synchronize do
        @in_flight -= 1
        @changed.broadcast
      end
    end
    Array(response).each { |piece| piece.respond_to?(:call) ? piece.call : client.write(piece) }
  rescue Errno::EPIPE, Errno::ECONNRESET, IOError
    nil # The client stopped reading or the server is closing.
  ensure
    client.close
  end

  def read_request(client)
    line = client.gets("\r\n")
    return unless line

    method, target = line.split
    headers = {}
    while (header = client.gets("\r\n")) && header != "\r\n"
      name, value = header.chomp("\r\n").split(": ", 2)
      headers[name.downcase] = value
    end
    length = headers["content-length"].to_i
    body = length.positive? ? client.read(length).to_s : ""
    Request.new(target, headers, method, body.b)
  end
end
