require "spec_helper"
require "stringio"
require "tmpdir"
require "zlib"
require_relative "../support/stubbed_api"
require_relative "../support/transfer_server"

RSpec.describe Files::File, "transfers" do
  include StubbedApi

  # 22,528 bytes that include every byte value, so text handling would show.
  let(:payload) { (0..255).map(&:chr).join.b * 88 }
  let(:signed_target) { "/objects/report.bin?X-Amz-Credential=fixture%2Fcredential&X-Amz-Signature=fixture-signature" }
  let(:sink) { StringIO.new("".b) }
  let(:servers) { [] }
  # A fixture server that pops this waits until the example closes it.
  let(:server_gate) { Queue.new }

  around do |example|
    original = [ Files.api_key, Files.base_url, Files.max_network_retries, Files.session_id, Files.workspace_id ]
    Files.api_key = "fixture-api-key"
    Files.max_network_retries = 0
    Files.session_id = "fixture-session"
    Files.workspace_id = 7
    example.run
  ensure
    Files.api_key, Files.base_url, Files.max_network_retries, Files.session_id, Files.workspace_id = original
  end

  after do
    server_gate.close
    servers.each(&:close)
  end

  def serve(response = nil, &respond)
    respond ||= ->(client) { client.write(response) }
    TransferServer.new(&respond).tap { |server| servers << server }
  end

  def remote_file(server)
    described_class.new(path: "report.bin", download_uri: server.url(signed_target))
  end

  def response(...)
    TransferServer.response(...)
  end

  def fixed_length(body, declared_bytes: body.bytesize)
    response("200 OK", { "Content-Length" => declared_bytes }, body)
  end

  # A body in chunked transfer coding. An incomplete one stops before the final
  # zero-length chunk, as when the connection drops.
  def chunked(*chunks, complete: true)
    encoded = chunks.map { |chunk| "#{chunk.bytesize.to_s(16)}\r\n#{chunk}\r\n" }.join
    complete ? "#{encoded}0\r\n\r\n" : encoded
  end

  # The API and storage an upload sends through: the SDK's own connection with Faraday test stubs. Each begin_upload of
  # report.bin grants the parts it asks for, partsize bytes each, at https://storage.example.test/parts/<number>; each
  # part request is answered by part_response (200 with an ETag unless given), and the end of the upload with 201.
  # requests keeps every request in order, with its parameters or body and its headers. A planning request past the
  # tenth fails, so an upload that never ends stops.
  def upload_api(requests, partsize:, part_response: nil)
    stubbed_api_client do |stub|
      stub.post("/api/rest/v1/file_actions/begin_upload/report.bin") do |env|
        params = Faraday::Utils.parse_nested_query(env.body)
        requests << [ :begin, params, env.request_headers ]
        raise "The upload planned more than ten parts" if requests.count { |kind, *| kind == :begin } > 10

        first = Integer(params.fetch("part"))
        json_response(200, (first...(first + Integer(params.fetch("parts")))).map do |number|
          { part_number: number, partsize: partsize, ref: "upload-ref", http_method: "PUT", upload_uri: "https://storage.example.test/parts/#{number}" }
        end
        )
      end
      stub.put(/\A\/parts\/\d+\z/) do |env|
        number = Integer(env.url.path.split("/").last)
        requests << [ :part, number, env.body, env.request_headers ]
        part_response ? part_response.call(number) : [ 200, { "ETag" => "\"etag-#{number}\"" }, "" ]
      end
      stub.post("/api/rest/v1/files/report.bin") do |env|
        requests << [ :end, Faraday::Utils.parse_nested_query(env.body), env.request_headers ]
        json_response(201, { path: "report.bin", type: "file" })
      end
    end
  end

  def parts_sent(requests)
    requests.select { |kind, *| kind == :part }.map { |_, number, body| [ number, body ] }
  end

  # A source that has only read, eof? and close: it gives its data at most max_read bytes a read, then, at its end,
  # end_read (nil or an empty string). From stall_at on, every read gives an empty string although eof? is false. It
  # refuses its hundred-and-first read, so a loop that never ends stops.
  def short_reader(data, max_read:, end_read: nil, stall_at: nil)
    offset = 0
    reads = 0
    Object.new.tap do |reader|
      reader.define_singleton_method(:read) do |length = nil, _outbuf = nil|
        raise "The source was read more than a hundred times" if (reads += 1) > 100
        next "" if stall_at && offset >= stall_at
        next end_read if offset >= data.bytesize

        data.byteslice(offset, [ max_read, length || max_read ].min).tap { |chunk| offset += chunk.bytesize }
      end
      reader.define_singleton_method(:eof?) { offset >= data.bytesize }
      reader.define_singleton_method(:close) { nil }
    end
  end

  # Runs block with the path of a new local file holding data.
  def with_local_file(data)
    Dir.mktmpdir do |dir|
      path = File.join(dir, "report.bin")
      File.binwrite(path, data)
      yield path
    end
  end

  describe ".upload_chunks" do
    it "fills each granted part from as many short reads as it takes" do
      requests = []
      described_class.upload_chunks(short_reader("abcdefghij", max_read: 3), "report.bin", { client: upload_api(requests, partsize: 4) })

      expect(parts_sent(requests)).to eq([ [ 1, "abcd" ], [ 2, "efgh" ], [ 3, "ij" ] ])
    end

    it "ends a part at the source's end when its last read gives an empty string" do
      requests = []
      described_class.upload_chunks(short_reader("abcdefghij", max_read: 4, end_read: ""), "report.bin", { client: upload_api(requests, partsize: 4) })

      expect(parts_sent(requests)).to eq([ [ 1, "abcd" ], [ 2, "efgh" ], [ 3, "ij" ] ])
    end

    it "refuses a source that gives nothing before its end, before sending that part" do
      requests = []
      reader = short_reader("abcdefghij", max_read: 4, stall_at: 4)

      expect { described_class.upload_chunks(reader, "report.bin", { client: upload_api(requests, partsize: 4) }) }
        .to raise_error(Files::InvalidParameterError, "The upload source returned no bytes before its end")
      expect(parts_sent(requests)).to eq([ [ 1, "abcd" ] ])
    end

    it "lets a read's own error through, sending nothing after it" do
      requests = []
      read_error = IOError.new("the source failed")
      reader = short_reader("abcdefghij", max_read: 4)
      first_read = reader.method(:read)
      reads = 0
      reader.define_singleton_method(:read) { |*args| (reads += 1) == 2 ? raise(read_error) : first_read.call(*args) }

      expect { described_class.upload_chunks(reader, "report.bin", { client: upload_api(requests, partsize: 4) }) }.to raise_error(IOError) { |error| expect(error).to equal(read_error) }
      expect(parts_sent(requests)).to eq([ [ 1, "abcd" ] ])
    end

    it "reports each acknowledged part to progress, with an unknown total and this call's acknowledged bytes" do
      requests = []
      reports = []
      described_class.upload_chunks(short_reader("abcdefghij", max_read: 3), "report.bin", { client: upload_api(requests, partsize: 4) }, progress: ->(report) { reports << report })

      expect(reports).to eq([
        { total_bytes: nil, acknowledged_bytes: 4, part_number: 1, part_bytes: 4 },
        { total_bytes: nil, acknowledged_bytes: 8, part_number: 2, part_bytes: 4 },
        { total_bytes: nil, acknowledged_bytes: 10, part_number: 3, part_bytes: 2 }
      ]
                           )
    end
  end

  describe ".upload_file" do
    it "raises the filesystem error when the local source does not exist" do
      Dir.mktmpdir do |dir|
        missing_path = File.join(dir, "missing.bin")

        expect { described_class.upload_file(missing_path, "report.bin") }.to raise_error(Errno::ENOENT)
      end
    end

    it "uploads an empty file as one empty part" do
      requests = []
      with_local_file("") { |path| described_class.upload_file(path, "report.bin", { client: upload_api(requests, partsize: 4) }) }

      expect(parts_sent(requests)).to eq([ [ 1, "" ] ])
      expect(requests.last[0..1]).to match([ :end, hash_including("action" => "end", "size" => "0") ])
    end

    it "reports progress with the local file's size as its total, whatever size its planning parameters carry, and sends progress in no request" do
      requests = []
      reports = []
      with_local_file("abcdefghij") do |path|
        described_class.upload_file(path, "report.bin", { client: upload_api(requests, partsize: 4) }, params: { size: 999 }, progress: ->(report) { reports << report })
      end

      expect(requests.first[1]["size"]).to eq("999")
      expect(reports).to eq([
        { total_bytes: 10, acknowledged_bytes: 4, part_number: 1, part_bytes: 4 },
        { total_bytes: 10, acknowledged_bytes: 8, part_number: 2, part_bytes: 4 },
        { total_bytes: 10, acknowledged_bytes: 10, part_number: 3, part_bytes: 2 }
      ]
                           )
      requests.each do |_kind, sent, *, headers|
        expect(headers.keys.map(&:downcase)).not_to include("progress")
        expect(sent.keys).not_to include("progress") if sent.is_a?(Hash)
      end
    end

    it "refuses a part answered with a non-success status it returns, before reporting or ending the upload, when progress is given" do
      requests = []
      reports = []
      client = upload_api(requests, partsize: 4, part_response: ->(_number) { [ 302, {}, "" ] })

      with_local_file("abcdefghij") do |path|
        expect { described_class.upload_file(path, "report.bin", { client: client }, progress: ->(report) { reports << report }) }
          .to raise_error(Files::APIError, "Transfer request failed") { |error|
            expect(error.http_status).to eq(302)
            expect(error.full_message).not_to include("storage.example.test")
          }
      end
      expect(reports).to be_empty
      expect(requests.map(&:first)).to eq(%i[begin part])
    end

    it "uploads as before when a part's non-success status is returned and no progress is given" do
      requests = []
      client = upload_api(requests, partsize: 4, part_response: ->(_number) { [ 302, {}, "" ] })

      with_local_file("abcdefghij") { |path| described_class.upload_file(path, "report.bin", { client: client }) }

      expect(requests.map(&:first)).to eq(%i[begin part begin part begin part end])
    end

    it "stops at a part answered 500, reporting nothing and not ending the upload" do
      requests = []
      reports = []
      client = upload_api(requests, partsize: 4, part_response: ->(_number) { [ 500, {}, "" ] })

      with_local_file("abcdefghij") do |path|
        expect { described_class.upload_file(path, "report.bin", { client: client }, progress: ->(report) { reports << report }) }.to raise_error(Files::APIConnectionError)
      end
      expect(reports).to be_empty
      expect(requests.map(&:first)).to eq(%i[begin part])
    end

    it "ends the upload where its progress callback raises, with nothing planned, sent or ended after it, and closes its own file" do
      requests = []
      cancelled = StandardError.new("cancelled")
      with_local_file("abcdefghij") do |path|
        expect { described_class.upload_file(path, "report.bin", { client: upload_api(requests, partsize: 4) }, progress: ->(_report) { raise cancelled }) }
          .to raise_error(StandardError) { |error| expect(error).to equal(cancelled) }
        expect(ObjectSpace.each_object(::File).select { |file| !file.closed? && file.path == path }).to be_empty
      end
      expect(requests.map(&:first)).to eq(%i[begin part])
    end
  end

  describe "#download_content" do
    def download(raw_response, range: [])
      server = serve(raw_response)
      remote_file(server).download_content(sink, range: range)
      server
    end

    it "writes a fixed-length body exactly and leaves the caller's IO open" do
      download(fixed_length(payload))

      expect(sink.string).to eq(payload)
      expect(sink).not_to be_closed
    end

    it "writes a gzip body decompressed, although Content-Length counts compressed bytes" do
      zipped = Zlib.gzip(payload)

      download(response("200 OK", { "Content-Encoding" => "gzip", "Content-Length" => zipped.bytesize }, zipped))

      expect(sink.string).to eq(payload)
    end

    it "writes the requested range of a partial-content response" do
      part = payload.byteslice(4, 8)

      server = download(response("206 Partial Content", { "Content-Range" => "bytes 4-11/#{payload.bytesize}", "Content-Length" => 8 }, part), range: [ 4, 11 ])

      expect(sink.string).to eq(part)
      expect(server.requests.map { |request| request.headers["range"] }).to eq([ "bytes=4-11" ])
    end

    it "writes a gzip-encoded range exactly as sent, without decompressing it" do
      part = Zlib.gzip(payload).byteslice(0, 50)

      download(response("206 Partial Content", { "Content-Encoding" => "gzip", "Content-Range" => "bytes 0-49/451", "Content-Length" => 50 }, part), range: [ 0, 49 ])

      expect(sink.string).to eq(part)
    end

    it "writes a chunked body" do
      download(response("200 OK", { "Transfer-Encoding" => "chunked" }, chunked(payload.byteslice(0, 4096), payload.byteslice(4096..))))

      expect(sink.string).to eq(payload)
    end

    it "writes a body that ends when the server closes the connection" do
      download(response("200 OK", {}, payload))

      expect(sink.string).to eq(payload)
    end

    it "accepts an empty body" do
      download(fixed_length(""))

      expect(sink.string).to be_empty
      expect(sink).not_to be_closed
    end

    it "requests the signed URL exactly as issued, without Files.com credentials" do
      server = download(fixed_length(payload))

      expect(server.requests.map(&:target)).to eq([ signed_target ])
      expect(server.requests.first.headers.keys).not_to include("authorization", "x-filesapi-key", "x-filesapi-auth", "x-files-workspace-id")
    end

    it "raises EOFError when a fixed-length body ends early and leaves the caller's IO open for a retry" do
      server = serve(fixed_length(payload.byteslice(0, 4096), declared_bytes: payload.bytesize))

      expect { remote_file(server).download_content(sink) }.to raise_error(EOFError, "Transfer response ended after 4096 of 22528 bytes")
      expect(server.requests.size).to eq(1)
      expect(sink).not_to be_closed
    end

    it "raises EOFError when a partial-content body ends early" do
      server = serve(response("206 Partial Content", { "Content-Range" => "bytes 4-11/#{payload.bytesize}", "Content-Length" => 8 }, payload.byteslice(4, 4)))

      expect { remote_file(server).download_content(sink, range: [ 4, 11 ]) }.to raise_error(EOFError, "Transfer response ended after 4 of 8 bytes")
    end

    it "raises EOFError when a gzip-encoded range ends early, since Net::HTTP passes ranges through as sent" do
      part = Zlib.gzip(payload).byteslice(0, 50)
      server = serve(response("206 Partial Content", { "Content-Encoding" => "gzip", "Content-Range" => "bytes 0-49/451", "Content-Length" => 50 }, part.byteslice(0, 25)))

      expect { remote_file(server).download_content(sink, range: [ 0, 49 ]) }.to raise_error(EOFError, "Transfer response ended after 25 of 50 bytes")
    end

    it "raises EOFError when an identity-encoded body ends early" do
      server = serve(response("200 OK", { "Content-Encoding" => "identity", "Content-Length" => payload.bytesize }, payload.byteslice(0, 4096)))

      expect { remote_file(server).download_content(sink) }.to raise_error(EOFError, "Transfer response ended after 4096 of 22528 bytes")
    end

    it "raises EOFError when a chunked body ends early, without requesting and writing it again" do
      first_chunk = payload.byteslice(0, 4096)
      server = serve(response("200 OK", { "Transfer-Encoding" => "chunked" }, chunked(first_chunk, complete: false)))

      expect { remote_file(server).download_content(sink) }.to raise_error(EOFError)
      expect(server.requests.size).to eq(1)
      expect(sink.string).to eq(first_chunk)
    end

    it "raises for a refused transfer with an empty body and closes the caller's IO, without revealing the signed URL" do
      server = serve(response("503 Service Unavailable", { "Content-Length" => 0 }))

      expect { remote_file(server).download_content(sink) }.to raise_error(Net::HTTPFatalError, '503 "Service Unavailable"') { |error|
        expect(error.full_message).not_to include("/objects/", "X-Amz", "fixture-signature")
      }
      expect(sink).to be_closed
    end

    it "does not write a refused transfer's error body" do
      error_body = "<Error>Expired</Error>"
      server = serve(response("403 Forbidden", { "Content-Length" => error_body.bytesize }, error_body))

      expect { remote_file(server).download_content(sink) }.to raise_error(Net::HTTPClientException, '403 "Forbidden"')
      expect(sink.string).to be_empty
    end

    it "raises the caller IO's own write error, even when closing that IO fails too" do
      write_error = IOError.new("destination is full")
      failing_sink = Class.new(StringIO) do
        define_method(:<<) { |_bytes| raise write_error }

        def close
          super
          raise IOError, "close failed too"
        end
      end.new
      server = serve(fixed_length(payload))

      expect { remote_file(server).download_content(failing_sink) }.to raise_error(IOError) { |error| expect(error).to equal(write_error) }
      expect(failing_sink).to be_closed
      expect(server.requests.size).to eq(1)
    end
  end

  describe "#download_file" do
    it "raises when the body ends early and closes the local file it created" do
      server = serve(fixed_length(payload.byteslice(0, 4096), declared_bytes: payload.bytesize))

      Dir.mktmpdir do |dir|
        local_path = File.join(dir, "report.bin")

        expect { remote_file(server).download_file(local_path) }.to raise_error(EOFError)
        expect(ObjectSpace.each_object(File).select { |file| file.path == local_path }).to all(be_closed)
      end
    end
  end

  describe "#read_io" do
    def open_pipes
      ObjectSpace.each_object(Files::SizableIO).reject(&:closed?)
    end

    # Returns a file whose read_io has received the first 4096 of 22,528 bytes.
    # The connection then drops, or later when the example closes server_gate,
    # so the download fails while the caller is reading.
    def file_whose_download_fails_later(drop_connection: true)
      server = serve do |client|
        client.write(fixed_length(payload.byteslice(0, 4096), declared_bytes: payload.bytesize))
        server_gate.pop
      end
      file = remote_file(server)
      file.read_io
      server_gate.close if drop_connection
      file
    end

    {
      "read" => ->(reader) { reader.read },
      "read(n) until eof?" => ->(reader) { reader.read(1024) until reader.eof? },
      "gets" => ->(reader) { nil while reader.gets },
      "readline" => ->(reader) { loop { reader.readline } },
      "readpartial" => ->(reader) { loop { reader.readpartial(1024) } },
      "each_line" => ->(reader) { reader.each_line.to_a },
      "each" => ->(reader) { reader.each(&:itself) },
    }.each do |reading, read_to_end|
      it "raises a download failure that happens after reading began through #{reading}, then closes quietly" do
        reader = file_whose_download_fails_later.read_io

        expect { read_to_end.call(reader) }.to raise_error(EOFError, "Transfer response ended after 4096 of 22528 bytes")
        expect { reader.close }.not_to raise_error
        expect(reader).to be_closed
      end
    end

    it "raises from eof? a failure that happens after the last full read" do
      reader = file_whose_download_fails_later(drop_connection: false).read_io
      expect(reader.read(4096).bytesize).to eq(4096)
      server_gate.close

      expect { reader.eof? }.to raise_error(EOFError, "Transfer response ended after 4096 of 22528 bytes")
      expect { reader.close }.not_to raise_error
    end

    it "raises a download failure that happens after reading began from Files::File#read" do
      file = file_whose_download_fails_later

      expect { file.read }.to raise_error(EOFError, "Transfer response ended after 4096 of 22528 bytes")
    ensure
      file&.read_io&.close
    end

    it "raises from close a failure that IO.copy_stream read past" do
      reader = file_whose_download_fails_later.read_io

      Dir.mktmpdir do |dir|
        copied_bytes = File.open(File.join(dir, "report.bin"), "wb") { |copy| IO.copy_stream(reader, copy) }
        expect(copied_bytes).to eq(4096)
      end
      expect { reader.close }.to raise_error(EOFError, "Transfer response ended after 4096 of 22528 bytes")
      expect(reader).to be_closed
    end

    it "raises from close a refusal that arrives after read_io stops waiting, releasing the pipe" do
      server = serve do |client|
        server_gate.pop
        client.write(response("403 Forbidden", { "Content-Length" => 7 }, "refused"))
      end
      pipes_before = open_pipes
      reader = remote_file(server).read_io # returns after its five-second wait for the first bytes
      server_gate.close

      nil while reader.getbyte

      expect { reader.close }.to raise_error(Net::HTTPClientException, '403 "Forbidden"') { |close_error|
        expect { reader.error! }.to raise_error(Net::HTTPClientException) { |stored_error| expect(stored_error).to equal(close_error) }
      }
      expect(open_pipes - pipes_before).to be_empty
    end

    it "does not let close replace an exception the caller is already raising" do
      reader = file_whose_download_fails_later.read_io
      callers_error = RuntimeError.new("caller failed")

      expect {
        begin
          nil while reader.getbyte
          raise callers_error
        ensure
          reader.close
        end
      }.to raise_error(RuntimeError) { |error| expect(error).to equal(callers_error) }
      expect(reader).to be_closed
    end

    it "stops downloading once the caller closes the reader" do
      body_bytes = 32 * 1024 * 1024 # far more than socket and pipe buffers hold
      block = ("x" * 65_536).b
      sent_everything = false
      server = serve do |client|
        client.write(response("200 OK", { "Content-Length" => body_bytes }))
        (body_bytes / block.bytesize).times { client.write(block) }
        sent_everything = true
      end

      reader = remote_file(server).read_io
      reader.read(1024)
      reader.close
      server.close # returns once the server has stopped writing

      expect(sent_everything).to be(false)
    end

    it "raises a refused transfer and closes the pipe it created" do
      server = serve(response("403 Forbidden", { "Content-Length" => 0 }))
      pipes_before = open_pipes

      expect { remote_file(server).read_io }.to raise_error(Net::HTTPClientException, '403 "Forbidden"')
      expect(open_pipes - pipes_before).to be_empty
    end

    it "raises a failed metadata lookup instead of returning an empty reader" do
      not_found = { error: "Not Found", 'http-code': 404, type: "not-found" }.to_json
      server = serve(response("404 Not Found", { "Content-Type" => "application/json", "Content-Length" => not_found.bytesize }, not_found))
      Files.base_url = server.url("")

      expect { described_class.new(path: "report.bin").read_io }.to raise_error(Files::NotFoundError)
    end
  end
end
