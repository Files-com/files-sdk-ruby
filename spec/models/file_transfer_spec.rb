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
  # tenth fails, so an upload that never ends stops. grant, given a begin_upload's parameters, adds to each part it
  # grants; raise_errors: false gives a connection that returns error responses.
  def upload_api(requests, partsize:, part_response: nil, grant: ->(_params) { {} }, raise_errors: true)
    stubbed_api_client(raise_errors: raise_errors) do |stub|
      stub.post("/api/rest/v1/file_actions/begin_upload/report.bin") do |env|
        params = Faraday::Utils.parse_nested_query(env.body)
        requests << [ :begin, params, env.request_headers ]
        raise "The upload planned more than ten parts" if requests.count { |kind, *| kind == :begin } > 10

        first = Integer(params.fetch("part"))
        json_response(200, (first...(first + Integer(params.fetch("parts")))).map do |number|
          { part_number: number, partsize: partsize, ref: "upload-ref", http_method: "PUT", upload_uri: "https://storage.example.test/parts/#{number}" }.merge(grant.call(params))
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

  # Storage that answers its first requests with refusals, in turn, and then with the payload, or the range asked for;
  # and the API, made Files.base_url, whose every lookup of report.bin gives that storage's URL again, renewed.
  def expiring_storage(*refusals)
    remaining = refusals.dup
    store = TransferServer.new(concurrent: true) do |request|
      next remaining.shift unless remaining.empty?
      next fixed_length(payload) unless (range = request.headers["range"])

      first, last = range.delete_prefix("bytes=").split("-").map(&:to_i)
      body = payload.byteslice(first..last)
      response("206 Partial Content", { "Content-Range" => "bytes #{first}-#{last}/#{payload.bytesize}", "Content-Length" => body.bytesize }, body)
    end
    api = TransferServer.new(concurrent: true) do |_request|
      body = JSON.generate(path: "report.bin", type: "file", download_uri: store.url("/objects/report.bin?renewed=1"))
      response("200 OK", { "Content-Type" => "application/json", "Content-Length" => body.bytesize }, body)
    end
    servers.push(store, api)
    Files.base_url = api.url("")
    [ store, api ]
  end

  def storage_refusal(message)
    body = "<Error><Code>AccessDenied</Code><Message>#{message}</Message></Error>"
    response("403 Forbidden", { "Content-Type" => "application/xml", "Content-Length" => body.bytesize }, body)
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

    it "refuses a part answered with a non-success status it returns, before ending the upload, when no progress is given" do
      requests = []
      client = upload_api(requests, partsize: 4, part_response: ->(_number) { [ 302, {}, "" ] })

      with_local_file("abcdefghij") do |path|
        expect { described_class.upload_file(path, "report.bin", { client: client }) }
          .to raise_error(Files::APIError, "Transfer request failed") { |error|
            expect(error.http_status).to eq(302)
            expect(error.full_message).not_to include("storage.example.test")
          }
      end
      expect(requests.map(&:first)).to eq(%i[begin part])
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

    # Part 1's answers before it is acknowledged, Files.max_network_retries, what the first and the renewed instructions
    # add, and the requests for part 1 and begin_upload, with the error when the upload fails. A renewal asks for the same
    # part of the same upload and sends the same bytes; part 1's is a renewal, not a new upload.
    expired = [ 403, { "Content-Type" => "application/xml" }, "<Error><Code>AccessDenied</Code><Message>Request has expired</Message></Error>" ]
    denied = [ 403, { "Content-Type" => "application/xml" }, "<Error><Code>AccessDenied</Code><Message>Access Denied</Message></Error>" ]
    failed = [ 500, {}, "" ]
    [
      [ "renews a part's URL storage says expired", [ expired ], 3, {}, {}, 2, 2, nil ],
      [ "renews it at most twice", [ expired ] * 3, 3, {}, {}, 3, 3, Files::APIConnectionError ],
      [ "counts a renewal as one of the retries a failed send also takes", [ expired, failed ], 1, {}, {}, 2, 2, Files::APIConnectionError ],
      [ "does not renew it without a retry left", [ expired ], 0, {}, {}, 1, 1, Files::APIConnectionError ],
      [ "does not renew a part whose instructions say retry_parts: false", [ expired ], 3, { retry_parts: false }, {}, 1, 1, Files::APIConnectionError ],
      [ "stops before renewed instructions that say retry_parts: false", [ expired ], 3, {}, { retry_parts: false }, 1, 2, Files::APIError ],
      [ "stops before renewed instructions for another size", [ expired ], 3, {}, { partsize: 5 }, 1, 2, Files::APIError ],
      [ "stops before renewed instructions that send the part another way", [ expired ], 3, {}, { parameters: { "acl" => "private" }, send: { "file" => "file" } }, 1, 2, Files::APIError ],
      [ "does not renew another denial", [ denied ], 3, {}, {}, 1, 1, Files::APIConnectionError ]
    ].each do |name, answers, retries, first, renewed, sends, begins, error|
      it name do
        Files.max_network_retries = retries
        requests = []
        remaining = answers.dup
        part_response = ->(number) { number == 1 && remaining.any? ? remaining.shift : [ 200, { "ETag" => "\"etag-#{number}\"" }, "" ] }
        client = upload_api(requests, partsize: 4, part_response: part_response, grant: ->(params) { params["parts"] == "1" ? renewed : first })

        with_local_file("abcdefghij") do |path|
          if error
            expect { described_class.upload_file(path, "report.bin", { client: client }) }.to raise_error(error)
          else
            described_class.upload_file(path, "report.bin", { client: client })
          end
        end
        expect(parts_sent(requests).select { |number, _| number == 1 }).to eq([ [ 1, "abcd" ] ] * sends)
        planned = requests.select { |kind, *| kind == :begin }.map { |_, params| params.values_at("part", "parts", "ref") }
        expect(planned.select { |part, *| part == "1" }).to eq([ [ "1", "5", nil ], *([ %w[1 1 upload-ref] ] * (begins - 1)) ])
        ended = requests.select { |kind, *| kind == :end }
        expect(ended.map { |_, params| params["etags"].map { |etag| etag["part"] } }).to eq(error ? [] : [ %w[1 2 3] ])
      end
    end

    it "renews a part's URL through a client whose connection returns refusals" do
      Files.max_network_retries = 1
      requests = []
      answers = [ [ 403, { "Content-Type" => "application/json" }, '{"type":"upload_request_expired"}' ] ]
      client = upload_api(requests, partsize: 4, raise_errors: false, part_response: ->(number) { answers.shift || [ 200, { "ETag" => "\"etag-#{number}\"" }, "" ] })

      with_local_file("abcd") { |path| described_class.upload_file(path, "report.bin", { client: client }) }

      expect(parts_sent(requests)).to eq([ [ 1, "abcd" ], [ 1, "abcd" ] ])
      expect(requests.map(&:first)).to eq(%i[begin part begin part end])
    end
  end

  describe ".upload_io" do
    it "uploads a stream without a size one part at a time, to its end, and ends the upload with what it read" do
      requests = []
      reader = short_reader("abcdefghij", max_read: 3)

      described_class.upload_io(reader, "report.bin", { client: upload_api(requests, partsize: 4) }, transfer: true)

      expect(parts_sent(requests)).to eq([ [ 1, "abcd" ], [ 2, "efgh" ], [ 3, "ij" ] ])
      expect(requests.last[0..1]).to match([ :end, hash_including("action" => "end", "size" => "10") ])
    end

    it "refuses a size that is not a non-negative Integer before sending anything" do
      requests = []

      expect { described_class.upload_io(StringIO.new("ab"), "report.bin", { client: upload_api(requests, partsize: 4) }, size: -1, transfer: true) }
        .to raise_error(Files::InvalidParameterError)
      expect(requests).to be_empty
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

    it "fetches the same range again from a URL renewed by its path when storage says the URL expired, writing none of the refusal" do
      Files.max_network_retries = 3
      store, api = expiring_storage(storage_refusal("Request has expired"))

      remote_file(store).download_content(sink, range: [ 100, 199 ])

      expect(sink.string).to eq(payload.byteslice(100, 100))
      expect(sink).not_to be_closed
      expect(store.requests.map { |request| [ request.target.include?("renewed=1"), request.headers["range"] ] }).to eq([ [ false, "bytes=100-199" ], [ true, "bytes=100-199" ] ])
      expect(api.requests.size).to eq(1)
    end

    # A 403 with body, declaring declared bytes of it, which can be more than it sends before the connection closes.
    refused = lambda do |body, declared: body.bytesize|
      type = body.start_with?("{") ? "application/json" : "application/xml"
      TransferServer.response("403 Forbidden", { "Content-Type" => type, "Content-Length" => declared }, body)
    end
    expired_text = "<Error><Code>AccessDenied</Code><Message>Request has expired</Message></Error>"
    expired_json = '{"type":"download_request_expired"}'

    [
      [ "complete Files.com JSON", refused.call(expired_json) ],
      [ "provider text cut short of its Content-Length", refused.call(expired_text, declared: expired_text.bytesize + 16) ]
    ].each do |name, refusal|
      it "renews the URL storage refused with #{name}" do
        Files.max_network_retries = 1
        store, api = expiring_storage(refusal)

        remote_file(store).download_content(sink)

        expect([ sink.string, store.requests.size, api.requests.size ]).to eq([ payload, 2, 1 ])
      end
    end

    # Files.max_network_retries, storage's refusals, the record's path, and the requests for the file and its URL.
    [
      [ "renews the URL at most twice", 3, [ refused.call(expired_text) ] * 3, "report.bin", 3, 2 ],
      [ "does not renew the URL without a retry left", 0, [ refused.call(expired_text) ], "report.bin", 1, 0 ],
      [ "does not renew a file's URL without its path", 3, [ refused.call(expired_text) ], nil, 1, 0 ],
      [ "does not renew the URL for another denial", 3, [ refused.call(expired_text.sub("Request has expired", "Access Denied")) ], "report.bin", 1, 0 ],
      [ "does not renew the URL for Files.com JSON cut short of its Content-Length", 3, [ refused.call(expired_json, declared: expired_json.bytesize + 16) ], "report.bin", 1, 0 ]
    ].each do |name, retries, refusals, path, sends, lookups|
      it "#{name}, raising the refusal and closing the IO with nothing written" do
        Files.max_network_retries = retries
        store, api = expiring_storage(*refusals)

        expect { described_class.new(path: path, download_uri: store.url(signed_target)).download_content(sink) }.to raise_error(Net::HTTPClientException, '403 "Forbidden"')
        expect([ store.requests.size, api.requests.size, sink.string, sink.closed? ]).to eq([ sends, lookups, "", true ])
      end
    end

    # Through a download_client whose connection returns refusals: Files.max_network_retries, the refusals, and the
    # requests for the file and its URL.
    [
      [ "without a retry left", 0, [ refused.call(expired_json) ], 1, 0 ],
      [ "once its renewals are spent", 3, [ refused.call(expired_json) ] * 3, 3, 2 ],
      [ "for another denial", 3, [ refused.call(expired_text.sub("Request has expired", "Access Denied")) ], 1, 0 ]
    ].each do |name, retries, refusals, sends, lookups|
      it "raises a refusal a download_client returns #{name}, closing the IO with nothing written" do
        Files.max_network_retries = retries
        store, api = expiring_storage(*refusals)
        connection = Files::ApiClient.build_default_conn
        connection.builder.delete(Faraday::Response::RaiseError)
        Thread.current[:files_api_client_download_client] = Files::ApiClient.new(connection)

        expect { remote_file(store).download_content(sink) }.to raise_error(Files::APIError, "Transfer request failed") { |error| expect(error.http_status).to eq(403) }
        expect([ store.requests.size, api.requests.size, sink.string, sink.closed? ]).to eq([ sends, lookups, "", true ])
      ensure
        Thread.current[:files_api_client_download_client] = nil
      end
    end

    [ true, false ].each do |raise_errors|
      it "renews the URL through a download_client whose connection #{raise_errors ? 'raises' : 'returns'} the refusal" do
        Files.max_network_retries = 1
        json = '{"type":"download_request_expired"}'
        store, api = expiring_storage(response("403 Forbidden", { "Content-Type" => "application/json", "Content-Length" => json.bytesize }, json))
        connection = Files::ApiClient.build_default_conn
        connection.builder.delete(Faraday::Response::RaiseError) unless raise_errors
        Thread.current[:files_api_client_download_client] = Files::ApiClient.new(connection)

        remote_file(store).download_content(sink)

        expect([ sink.string, store.requests.size, api.requests.size ]).to eq([ payload, 2, 1 ])
      ensure
        Thread.current[:files_api_client_download_client] = nil
      end
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

    it "refuses a response from the Files.com web app before writing any of it, and closes the caller's IO" do
      page = "<html>Sign in</html>"
      server = serve(response("200 OK", { "X-Files-Frontend-App" => "true", "Content-Length" => page.bytesize }, page))

      expect { remote_file(server).download_content(sink) }.to raise_error(Files::Transfer::FrontendResponseError) { |error|
        expect(error.full_message).not_to include("/objects/", "X-Amz", "fixture-signature")
      }
      expect(sink.string).to be_empty
      expect(sink).to be_closed
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
    it "preserves UTF-8 character reads when UTF-8 encoding defaults are set" do
      original_encodings = [ Encoding.default_external, Encoding.default_internal ]
      Encoding.default_external = Encoding::UTF_8
      Encoding.default_internal = Encoding::UTF_8
      text = "caf\u00e9\r\n\u65e5\u672c"
      server = serve(fixed_length(text.b))
      reader = remote_file(server).read_io

      expect(reader.each_char.to_a).to eq(text.each_char.to_a)
    ensure
      begin
        reader&.close
      ensure
        Encoding.default_external, Encoding.default_internal = original_encodings
      end
    end

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

    it "refuses transfer: and progress: before it opens a pipe or starts a download" do
      requests = []
      server = serve { |_client| requests << :download }
      file = remote_file(server)
      pipes = open_pipes.size

      expect { file.read_io(transfer: true) }.to raise_error(Files::InvalidParameterError, /read_io cannot transfer adaptively/)
      expect { file.read_io(progress: ->(_report) {}) }.to raise_error(Files::InvalidParameterError)
      expect(open_pipes.size).to be <= pipes
      expect(server.requests).to be_empty
      expect(requests).to be_empty
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

    it "reads a file whose URL storage said expired from the URL renewed for it" do
      Files.max_network_retries = 1
      store, api = expiring_storage(storage_refusal("Request has expired"))

      reader = remote_file(store).read_io

      expect(reader.read.b).to eq(payload)
      expect([ store.requests.size, api.requests.size ]).to eq([ 2, 1 ])
    ensure
      reader&.close
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
