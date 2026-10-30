require "spec_helper"
require "stringio"
require_relative "../support/stubbed_api"
require_relative "../support/transfer_server"

RSpec.describe Files::File, "native helpers" do
  include StubbedApi

  let(:requests) { [] }
  let(:metadata) { { path: "report.txt", size: 42, mtime: "2026-10-28T12:00:00Z", type: "file", permissions: "rwd" } }
  let(:client) {
    stubbed_api_client do |stub|
      stub.get("/api/rest/v1/file_actions/metadata/report.txt") do |env|
        requests << [ env.url.path, env.request_headers["X-FilesAPI-Key"] ]
        json_response(200, metadata)
      end
    end
  }
  let(:servers) { [] }
  let(:gate) { Queue.new }

  before do
    # An unexpected API route fails in the test adapter instead of reaching Files.com.
    allow(Files::ApiClient).to receive(:default_conn).and_return(stubbed_api_client.conn)
  end

  around do |example|
    previous = [ Files.api_key, Files.max_network_retries, Thread.current[:files_api_client] ]
    Files.api_key = "native-helper-fixture-key"
    Files.max_network_retries = 0
    example.run
  ensure
    gate.close
    servers.each(&:close)
    Files.api_key, Files.max_network_retries, Thread.current[:files_api_client] = previous
  end

  def active_client(client)
    previous = Thread.current[:files_api_client]
    Thread.current[:files_api_client] = client
    yield
  ensure
    Thread.current[:files_api_client] = previous
  end

  def transfer(body, declared_bytes: body.bytesize, wait: false)
    server = TransferServer.new do |socket|
      socket.write(TransferServer.response("200 OK", { "Content-Length" => declared_bytes }, body))
      gate.pop if wait
    end
    servers << server
    api = stubbed_api_client do |stub|
      stub.get("/api/rest/v1/files/report.txt") { json_response(200, { path: "report.txt", download_uri: server.url("/content") }) }
    end
    # The default API client can be created in the download thread. Only its connection is replaced.
    allow(Files::ApiClient).to receive(:default_conn).and_return(api.conn)
    api
  end

  it "fetches fresh stat and lstat metadata with the instance's request client" do
    file = described_class.new({ path: "report.txt", size: 0 }, { client: client, api_key: "record-fixture-key" })

    first = file.stat
    metadata[:size] = 84
    second = file.lstat

    expect([ first.size, second.size, second.mtime, second.permissions ]).to eq([ 42, 84, "2026-10-28T12:00:00Z", "rwd" ])
    expect(file.size).to eq(0)
    expect(requests).to eq(Array.new(2) { [ "/api/rest/v1/file_actions/metadata/report.txt", "record-fixture-key" ] })
  end

  it "uses metadata for class stat/lstat and the API's r flag for readability" do
    active_client(client) do
      expect([ described_class.stat("report.txt").size, described_class.lstat("report.txt").size ]).to eq([ 42, 42 ])
      { "r" => true, "rwd" => true, "w" => false, "l" => false, "" => false, nil => false }.each do |permissions, readable|
        metadata[:permissions] = permissions
        expect(described_class.readable?("report.txt")).to eq(readable)
      end
    end
  end

  it "preserves metadata API failures instead of treating them as unreadable files" do
    refused = stubbed_api_client do |stub|
      stub.get("/api/rest/v1/file_actions/metadata/report.txt") { json_response(403, { type: "permission-denied", message: "Metadata refused" }) }
    end

    active_client(refused) do
      expect { described_class.stat("report.txt") }.to raise_error(Files::Error) { |error| expect(error.http_status).to eq(403) }
      expect { described_class.readable?("report.txt") }.to raise_error(Files::Error) { |error| expect(error.http_status).to eq(403) }
    end
  end

  it "reads the remaining lines with native keyword options without closing the caller's reader" do
    api = transfer("skip\nalpha\nbeta\n")
    file = described_class.new("report.txt", { client: api })
    reader = file.read_io

    expect(file.gets).to eq("skip\n")
    expect(file.readlines(chomp: true)).to eq([ "alpha", "beta" ])
    expect(file.readlines).to eq([])
    expect(reader).not_to be_closed
  ensure
    reader&.close
  end

  it "supports class readlines separators and limits and closes the reader it opens" do
    body = "alpha|beta|"
    transfer(body)
    recording_file = Class.new(described_class) do
      class << self
        attr_accessor :opened_file
      end

      def initialize(*args)
        super
        self.class.opened_file = self
      end
    end

    expect(recording_file.readlines("report.txt", "|", 3, chomp: true)).to eq(StringIO.new(body).readlines("|", 3, chomp: true))
    expect(recording_file.opened_file.read_io).to be_closed
  end

  it "raises a download failure after receiving partial lines instead of returning partial success" do
    body = "first line\npartial"
    api = transfer(body, declared_bytes: body.bytesize + 10, wait: true)
    file = described_class.new("report.txt", { client: api })
    reader = file.read_io
    gate << true

    expect { file.readlines }.to raise_error(EOFError)
    expect(reader).not_to be_closed
  ensure
    reader&.close
  end
end
