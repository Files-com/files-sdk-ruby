require "socket"

# A loopback HTTP server for transfer specs. It answers each connection with
# one canned response, written byte for byte, so a spec controls exactly the
# framing a storage provider sends, including bodies that end early. Every
# request it receives is recorded.
class TransferServer
  Request = Struct.new(:target, :headers)

  attr_reader :requests

  def self.response(status, headers = {}, body = "")
    head = [ "HTTP/1.1 #{status}", *headers.map { |name, value| "#{name}: #{value}" }, "Connection: close" ]
    "#{head.join("\r\n")}\r\n\r\n".b + body.b
  end

  # The block receives each client socket once its request has been read, and
  # the connection closes when the block returns.
  def initialize(&respond)
    @respond = respond
    @requests = []
    @listener = TCPServer.new("127.0.0.1", 0)
    @thread = Thread.new { serve }
  end

  def url(target)
    "http://127.0.0.1:#{@listener.addr[1]}#{target}"
  end

  def close
    @listener.close
    @thread.join
  end

  private

  def serve
    loop do
      client = @listener.accept
      @requests << read_request(client)
      @respond.call(client)
    rescue Errno::EPIPE, Errno::ECONNRESET
      next # The client stopped reading, which some specs do on purpose.
    ensure
      client&.close
    end
  rescue IOError, Errno::EBADF
    nil # The listener was closed.
  end

  def read_request(client)
    target = client.gets("\r\n").split[1]
    headers = {}
    while (line = client.gets("\r\n")) && line != "\r\n"
      name, value = line.chomp("\r\n").split(": ", 2)
      headers[name.downcase] = value
    end
    Request.new(target, headers)
  end
end
