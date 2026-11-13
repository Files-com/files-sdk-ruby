require "spec_helper"
require "logger"
require "stringio"
require "tmpdir"
require_relative "../support/stubbed_api"
require_relative "../support/transfer_server"

# Adaptive uploads against real loopback servers: one plays the Files.com API, which the SDK's own client calls on the
# caller's thread, and one plays storage, which the job's own connections send parts to. Every overlap, cap, retry and
# renewal below is what the SDK did over those sockets; only the servers' answers are scripted.
RSpec.describe Files::File, "adaptive uploads" do
  include StubbedApi

  # 48 bytes: twelve 4-byte parts.
  let(:data) { (0...48).map { |index| (97 + (index % 26)).chr }.join }
  let(:servers) { [] }

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

  after { servers.each(&:close) }

  def json(status, data)
    body = JSON.generate(data)
    TransferServer.response("#{status} OK", { "Content-Type" => "application/json", "Content-Length" => body.bytesize }, body)
  end

  def acknowledged(number)
    TransferServer.response("200 OK", { "ETag" => "\"etag-#{number}\"", "Content-Length" => 0 })
  end

  # Storage for the parts. With hold, each part waits until that many have been in flight at once (at most five
  # seconds); each is answered by part, or 200 with an ETag.
  def storage_server(hold: nil, part: nil)
    store = TransferServer.new(concurrent: true) do |request|
      store.wait_for_peak(hold) if hold
      number = part_number(request)
      part ? part.call(number, request) : acknowledged(number)
    end
    servers << store
    store
  end

  # The API, made Files.base_url, for uploads to the names in names. begin_upload grants the parts asked for,
  # partsize bytes each, at /parts/<number> on store, with what grant adds (its params name the upload's "path"); the
  # end of the upload is answered 201, once finish, when given, returns for its name, or with what end_answer returns,
  # when given, for the request and how many end requests there have been (1 for the first).
  def api_server(store, partsize: 4, names: %w[report.bin], grant: ->(_number, _params) { {} }, finish: nil, end_answer: nil)
    api = TransferServer.new(concurrent: true) do |request|
      path = request.target.split("?").first
      begun = path[/\A\/api\/rest\/v1\/file_actions\/begin_upload\/(.+)\z/, 1]
      ended = path[/\A\/api\/rest\/v1\/files\/(.+)\z/, 1]
      if names.include?(begun)
        params = Faraday::Utils.parse_nested_query(request.body).merge("path" => begun)
        first = Integer(params.fetch("part"))
        json(200, (first...(first + Integer(params.fetch("parts")))).map { |number|
          { part_number: number, partsize: partsize, ref: "upload-ref", http_method: "PUT", upload_uri: store.url("/parts/#{number}") }.merge(grant.call(number, params))
        }
        )
      elsif names.include?(ended)
        finish&.call(ended)
        next json(201, { path: ended, type: "file" }) unless end_answer

        end_answer.call(request, api.requests.count { |sent| sent.target.start_with?("/api/rest/v1/files/") })
      else
        TransferServer.response("404 Not Found", { "Content-Length" => 0 })
      end
    end
    servers << api
    Files.base_url = api.url("")
    api
  end

  def part_number(request)
    Integer(request.target.split("?").first.split("/").last)
  end

  def parts_sent(store)
    store.requests.select { |request| request.http_method == "PUT" }
  end

  def begins(api)
    api.requests.select { |request| request.target.start_with?("/api/rest/v1/file_actions/begin_upload/") }
       .map { |request| Faraday::Utils.parse_nested_query(request.body) }
  end

  def ends(api)
    api.requests.select { |request| request.target.start_with?("/api/rest/v1/files/") }.map { |request| Faraday::Utils.parse_nested_query(request.body) }
  end

  def with_local_file(content)
    Dir.mktmpdir do |dir|
      path = File.join(dir, "report.bin")
      File.binwrite(path, content)
      yield path
    end
  end

  def upload(path, options = {}, **keywords)
    described_class.upload_file(path, "report.bin", options, **keywords)
  end

  describe "concurrency" do
    it "sends parts at once, never more than a fixed concurrency, and reports each on the caller's thread once" do
      store = storage_server(hold: 4)
      api = api_server(store)
      reports = []
      threads = []

      with_local_file(data) do |path|
        upload(path, progress: ->(report) { (reports << report) && (threads << Thread.current) }, transfer: { concurrency: 4 })
      end

      expect(store.peak_in_flight).to eq(4)
      expect(parts_sent(store).map { |request| [ part_number(request), request.body ] }.sort)
        .to eq((1..12).map { |number| [ number, data.byteslice((number - 1) * 4, 4) ] })
      expect(reports.map { |report| report[:part_number] }.sort).to eq((1..12).to_a)
      expect(reports.map { |report| report[:acknowledged_bytes] }).to eq((1..12).map { |count| count * 4 })
      expect(reports.map { |report| [ report[:total_bytes], report[:part_bytes] ] }.uniq).to eq([ [ 48, 4 ] ])
      expect(threads.uniq).to eq([ Thread.current ])
      expect(begins(api).map { |params| params.values_at("parts", "with_direct_connection_info") }.uniq).to eq([ %w[5 true] ])
      expect(ends(api).first["etags"].map { |etag| [ etag["part"], etag["etag"] ] }).to eq((1..12).map { |number| [ number.to_s, "\"etag-#{number}\"" ] })
    end

    it "starts aggressive uploads at 32 parts in flight" do
      store = storage_server(hold: 32)
      api_server(store)

      with_local_file(data * 4) { |path| upload(path, transfer: { startup: :aggressive }) }

      expect(store.peak_in_flight).to eq(32)
      expect(parts_sent(store).size).to eq(48)
    end

    it "starts default uploads with one part alone" do
      store = storage_server
      api_server(store)

      with_local_file(data) { |path| upload(path, transfer: true) }

      expect(parts_sent(store).first(2).map(&:in_flight)).to eq([ 1, 1 ])
      expect(parts_sent(store).size).to eq(12)
    end

    it "sends one part at a time when the instructions say parallel_parts: false" do
      store = storage_server
      api_server(store, grant: ->(_number, _params) { { parallel_parts: false } })

      with_local_file(data) { |path| upload(path, transfer: { concurrency: 4 }) }

      expect(store.peak_in_flight).to eq(1)
    end

    it "shares one controller and what it learned between the files of a job" do
      store = storage_server
      api_server(store)

      Files::Transfer::Job.open(startup: :aggressive) do |job|
        2.times { with_local_file(data) { |path| upload(path, transfer: job) } }

        controllers = job.diagnostics[:controllers]
        expect(controllers.map { |controller| controller[:key] }).to eq([ [ :upload, :storage, "127.0.0.1" ] ])
        expect(controllers.first[:decisions].count { |decision| decision[:reason] == :start }).to eq(1)
        expect(job.held_bytes).to eq(0)
      end
      expect(parts_sent(store).size).to eq(24)
    end

    it "uses the direct policy for a valid direct_connection_info, and the storage policy otherwise" do
      direct = { version: 1, server_name: "agent.example.test", addresses: [ "192.0.2.1" ], direct_uri: "https://agent.example.test",
                 ca_pem: "-----BEGIN CERTIFICATE-----\nfixture\n-----END CERTIFICATE-----\n" }
      store = storage_server
      [ [ direct, :direct ], [ direct.merge(version: 2), :storage ] ].each do |info, policy|
        api_server(store, grant: ->(_number, _params) { { direct_connection_info: info } })
        Files::Transfer::Job.open do |job|
          with_local_file(data) { |path| upload(path, transfer: job) }

          controller = job.diagnostics[:controllers].first
          expect(controller[:policy]).to eq(policy)
          expect(controller[:decisions].first[:to]).to eq(policy == :direct ? 4 : 1)
        end
      end
    end

    it "keeps a caller's own client for the parts, one at a time, and says so" do
      requests = []
      client = stubbed_api_client do |stub|
        stub.post("/api/rest/v1/file_actions/begin_upload/report.bin") do |env|
          params = Faraday::Utils.parse_nested_query(env.body)
          requests << [ :begin ]
          first = Integer(params.fetch("part"))
          json_response(200, (first...(first + 5)).map { |number|
            { part_number: number, partsize: 4, ref: "upload-ref", http_method: "PUT", upload_uri: "https://storage.example.test/parts/#{number}" }
          }
          )
        end
        stub.put(/\A\/parts\/\d+\z/) do |env|
          number = Integer(env.url.path.split("/").last)
          requests << [ :part, number, env.body ]
          [ 200, { "ETag" => "\"etag-#{number}\"" }, "" ]
        end
        stub.post("/api/rest/v1/files/report.bin") do |_env|
          requests << [ :end ]
          json_response(201, { path: "report.bin", type: "file" })
        end
      end

      Files::Transfer::Job.open(concurrency: 8) do |job|
        with_local_file("abcdefghij") { |path| upload(path, { client: client }, transfer: job) }

        expect(job.diagnostics[:notes]).to include(a_string_including("one request at a time"))
        expect(job.diagnostics[:controllers].map { |controller| controller.values_at(:policy, :limit) }).to eq([ [ :fixed, 1 ] ])
      end
      expect(requests).to eq([ [ :begin ], [ :part, 1, "abcd" ], [ :part, 2, "efgh" ], [ :part, 3, "ij" ], [ :end ] ])
    end

    it "sends each part through a caller's client's own remote_request and logger once, retrying only as the transfer" do
      Files.max_network_retries = 1
      sent = Hash.new(0)
      stubs = Faraday::Adapter::Test::Stubs.new
      stubs.post("/api/rest/v1/file_actions/begin_upload/report.bin") do |env|
        first = Integer(Faraday::Utils.parse_nested_query(env.body).fetch("part"))
        [ 200, { "Content-Type" => "application/json" }, JSON.generate((first...(first + 5)).map { |number|
          { part_number: number, partsize: 4, ref: "upload-ref", http_method: "PUT", upload_uri: "https://storage.example.test/parts/#{number}" }
        }
                                                                      ) ]
      end
      stubs.put(/\A\/parts\/\d+\z/) do |env|
        number = Integer(env.url.path.split("/").last)
        count = (sent[number] += 1)
        number == 2 && count == 1 ? [ 500, {}, "" ] : [ 200, { "ETag" => "\"etag-#{number}\"" }, "" ]
      end
      stubs.post("/api/rest/v1/files/report.bin") { |_env| [ 201, { "Content-Type" => "application/json" }, JSON.generate({ path: "report.bin" }) ] }
      # The client hands the API its params as a Hash; this connection form-encodes them, as the SDK's own does.
      conn = Faraday.new do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::RaiseError
        builder.adapter :test, stubs
      end
      log = StringIO.new
      hooked = Class.new(Files::ApiClient) do
        def hooks
          @hooks ||= []
        end

        def remote_request(method, url, headers = {}, body = nil, &block)
          hooks << [ method, URI(url).path ]
          super
        end
      end
      client = hooked.new(conn, logger: Logger.new(log))

      with_local_file("abcdefghij") { |path| upload(path, { client: client }, transfer: { concurrency: 4 }) }

      expect(sent).to eq({ 1 => 1, 2 => 2, 3 => 1 })
      expect(client.hooks.sort).to eq([ [ :put, "/parts/1" ], [ :put, "/parts/2" ], [ :put, "/parts/2" ], [ :put, "/parts/3" ] ])
      expect(log.string).to include("[transfer]")
    end

    it "sends through the SDK's own kind of connection when its TLS or adapter settings were changed, keeping them" do
      store = storage_server
      api_server(store)
      configured = []
      hooked = Files::ApiClient.build_default_conn
      hooked.adapter(:net_http) { |http| configured << http.port }
      restricted = Files::ApiClient.build_default_conn
      restricted.ssl.min_version = :TLS1_2

      [ hooked, restricted ].each do |conn|
        Files::Transfer::Job.open(concurrency: 4) do |job|
          with_local_file(data.byteslice(0, 8)) { |path| upload(path, { client: Files::ApiClient.new(conn) }, transfer: job) }

          expect(job.diagnostics[:notes]).to include(a_string_including("one request at a time"))
        end
      end
      expect(configured).to include(URI(store.url("")).port)
      expect(parts_sent(store).size).to eq(4)
    end

    it "keeps every transfer of a job within one request limit, across destinations" do
      direct = { version: 1, server_name: "agent.example.test", addresses: [ "192.0.2.1" ], direct_uri: "https://agent.example.test",
                 ca_pem: "-----BEGIN CERTIFICATE-----\nfixture\n-----END CERTIFICATE-----\n" }
      store = storage_server(hold: 3)
      api_server(store, names: %w[report.bin other.bin], grant: ->(_number, params) { params["path"] == "other.bin" ? { direct_connection_info: direct } : {} })

      Files::Transfer::Job.open(startup: :aggressive, max_concurrency: 3, max_files: 2) do |job|
        with_local_file(data) do |path|
          %w[report.bin other.bin].map { |name| Thread.new { described_class.upload_file(path, name, {}, transfer: job) } }.each(&:join)
        end

        diagnostics = job.diagnostics
        expect(diagnostics[:controllers].map { |controller| controller[:policy] }.sort).to eq(%i[direct storage])
        expect(diagnostics.values_at(:request_limit, :requests, :accepted_bytes)).to eq([ 3, 0, 96 ])
      end
      expect(store.peak_in_flight).to eq(3)
      expect(parts_sent(store).size).to eq(24)
    end

    it "wakes a transfer waiting for buffer bytes as soon as another settles them, not only when it finishes" do
      Files.max_network_retries = 1
      lock = Mutex.new
      failed = false
      finishing = Queue.new
      # report.bin is one 32 KiB part, answered 500 once and then, a moment later, acknowledged; other.bin is a 32 KiB
      # part acknowledged at once, then a 64 KiB part that needs the whole 64 KiB budget.
      store = storage_server(part: lambda { |number, request|
        first = request.body.start_with?("a")
        next TransferServer.response("500 Internal Server Error", { "Content-Length" => 0 }) if lock.synchronize { first && !failed && (failed = true) }

        sleep 0.3 if first
        acknowledged(number)
      }
                            )
      # report.bin's end waits, so it cannot finish and wake everything that way.
      api_server(store, names: %w[report.bin other.bin], grant: ->(number, _params) { { partsize: number == 1 ? 32_768 : 65_536 } },
                        finish: ->(name) { finishing.pop if name == "report.bin" }
      )

      Dir.mktmpdir do |dir|
        paths = { "report.bin" => "a" * 32_768, "other.bin" => "b" * 98_304 }.map { |name, content| File.join(dir, name).tap { |path| File.binwrite(path, content) } }
        Files::Transfer::Job.open(concurrency: 2, buffer_bytes: 65_536, max_files: 2) do |job|
          retried, waiting = paths.map { |path| Thread.new { described_class.upload_file(path, File.basename(path), {}, transfer: job) } }

          expect(waiting.join(10)).to be_truthy
          finishing << :go
          expect(retried.join(10)).to be_truthy
          expect(job.held_bytes).to eq(0)
        end
      end
      expect(parts_sent(store).size).to eq(4)
    end

    it "keeps the origin, credentials, client, workspace, options and request settings it began with, whatever a callback changes" do
      store = storage_server
      api = api_server(store)
      options = { base_url: +api.url("") }
      unusable = Files::ApiClient.new(Faraday.new { |builder| builder.adapter :test, Faraday::Adapter::Test::Stubs.new })
      settings = [ Files.default_headers, Files.language, Files.app_info, Files.read_timeout ]
      Files.default_headers = { "X-Fixture-Default" => +"first" }
      changed = lambda do |_report|
        options[:base_url].replace("http://127.0.0.1:1")
        options[:session_id] = "mutated-session"
        Files.default_headers["X-Fixture-Default"].replace("mutated")
        Files.default_headers = { "X-Fixture-Default" => "changed" }
        Files.language = "changed"
        Files.app_info = { name: "changed" }
        Files.read_timeout = 0.001
        Files.base_url = "http://127.0.0.1:1"
        Files.session_id = "changed-session"
        Files.api_key = "changed-api-key"
        Files.workspace_id = 9
        Thread.current[:files_api_client] = unusable
      end

      begin
        with_local_file(data.byteslice(0, 24)) { |path| upload(path, options, progress: changed, transfer: { concurrency: 1 }) }
      ensure
        Thread.current[:files_api_client] = nil
        Files.default_headers, Files.language, Files.app_info = settings
        Files.read_timeout = settings.last
      end

      expect(begins(api).size).to eq(2)
      expect(api.requests.map { |request| request.headers.values_at("x-filesapi-auth", "x-filesapi-key", "x-files-workspace-id", "x-fixture-default", "accept-language") }.uniq)
        .to eq([ [ "fixture-session", nil, "7", "first", nil ] ])
      expect(api.requests.map { |request| request.headers["user-agent"] }.grep(/changed/)).to be_empty
      expect(ends(api).size).to eq(1)
    end

    it "keeps the regional origin its first grant moved it to, and only that, for every later request" do
      original_pairs = Files.region_http_pairs
      # A regional continuation consumes one retry from this API request's shared budget.
      Files.max_network_retries = 1
      store = storage_server
      regional = api_server(store)
      home = TransferServer.new(concurrent: true) do |_request|
        body = JSON.generate({ error: "Lockout region mismatch", type: "not-authenticated/lockout-region-mismatch", data: { host: regional.url("").delete_prefix("http://") } })
        TransferServer.response("403 Forbidden", { "Content-Type" => "application/json", "Content-Length" => body.bytesize }, body)
      end
      servers << home
      Files.region_http_pairs = [ [ home.url(""), regional.url("") ] ]
      Files.base_url = home.url("")
      moved = lambda do |_report|
        Files.base_url = "http://127.0.0.1:1"
        Files.region_http_pairs = []
      end

      begin
        with_local_file(data.byteslice(0, 24)) { |path| upload(path, progress: moved, transfer: { concurrency: 1 }) }
      ensure
        Files.region_http_pairs = original_pairs
      end

      expect(home.requests.size).to eq(1)
      expect(begins(regional).size).to eq(2)
      expect(ends(regional).size).to eq(1)
    end

    it "keeps the region policy and handler it began with for a move a later request meets" do
      originals = [ Files.region_http_pairs, Files.region_policy, Files.region_handler ]
      Files.max_network_retries = 1
      store = storage_server
      third = api_server(store)
      mismatch = lambda do |target|
        body = JSON.generate({ error: "Lockout region mismatch", type: "not-authenticated/lockout-region-mismatch", data: { host: target.url("").delete_prefix("http://") } })
        TransferServer.response("403 Forbidden", { "Content-Type" => "application/json", "Content-Length" => body.bytesize }, body)
      end
      # The regional origin grants the parts, then moves the upload's end on to a third origin.
      regional = TransferServer.new(concurrent: true) do |request|
        next mismatch.call(third) unless request.target.start_with?("/api/rest/v1/file_actions/begin_upload/")

        first = Integer(Faraday::Utils.parse_nested_query(request.body).fetch("part"))
        json(200, (first...(first + 5)).map { |number|
          { part_number: number, partsize: 4, ref: "upload-ref", http_method: "PUT", upload_uri: store.url("/parts/#{number}") }
        }
        )
      end
      home = TransferServer.new(concurrent: true) { |_request| mismatch.call(regional) }
      servers.push(regional, home)
      approved = []
      Files.region_http_pairs = [ [ home.url(""), regional.url("") ], [ regional.url(""), third.url("") ] ]
      Files.region_handler = lambda do |event|
        approved << event[:target_origin]
        true
      end
      Files.base_url = home.url("")
      changed = lambda do |_report|
        Files.region_policy = :disabled
        Files.region_handler = ->(_event) { raise "the region handler changed" }
      end

      begin
        with_local_file(data.byteslice(0, 8)) { |path| upload(path, progress: changed, transfer: { concurrency: 1 }) }
      ensure
        Files.region_http_pairs, Files.region_policy, Files.region_handler = originals
      end

      expect(approved).to eq([ regional.url(""), third.url("") ])
      expect(begins(regional).size).to eq(1)
      expect(ends(third).size).to eq(1)
    end

    [ { transfer: { concurrency: 2 } }, {} ].each do |keywords|
      it "uploads a record #{keywords.empty? ? 'one part at a time' : 'adaptively'} to its own path with its own options, leaving the caller's file open" do
        store = storage_server
        api = api_server(store)
        record = described_class.new({ path: "report.bin", size: 999, download_uri: "https://storage.example.test/report.bin?X-Amz-Signature=secret",
                                       mkdir_parents: true }, { session_id: "record-session" }
        )

        Dir.mktmpdir do |dir|
          local_path = File.join(dir, "local.bin")
          File.binwrite(local_path, data.byteslice(0, 8))
          File.open(local_path, "rb") do |local|
            record.upload_file(local, **keywords)
            expect(local).not_to be_closed
          end
        end

        expect(begins(api).map { |params| params.values_at("mkdir_parents", "size") }.uniq).to eq([ %w[true 8] ])
        expect(api.requests.map { |request| request.headers["x-filesapi-auth"] }.uniq).to eq([ "record-session" ])
        expect(api.requests.map(&:body).join).not_to include("secret")
        expect(ends(api).size).to eq(1)
        expect(parts_sent(store).map { |request| [ part_number(request), request.body ] }.sort).to eq([ [ 1, "abcd" ], [ 2, "efgh" ] ])
      end
    end

    it "uploads exactly size bytes of a caller's stream, however short its reads and though they reuse one String, retrying a part with the same bytes" do
      Files.max_network_retries = 1
      lock = Mutex.new
      attempts = Hash.new(0)
      store = storage_server(hold: 2, part: lambda { |number, _request|
        count = lock.synchronize { attempts[number] += 1 }
        number == 2 && count == 1 ? TransferServer.response("500 Internal Server Error", { "Content-Length" => 0 }) : acknowledged(number)
      }
      )
      api = api_server(store)
      source = StringIO.new("#{data}tail")
      buffer = +""
      stream = Object.new
      # Every read gives back the same String with its bytes replaced, as a wrapper with one buffer of its own does, both
      # within a part and across the parts read ahead of their sends.
      stream.define_singleton_method(:read) { |length| buffer.replace(source.read([ length, 3 ].min)) }
      reports = []

      described_class.upload_io(stream, "report.bin", {}, size: 48, progress: ->(report) { reports << report }, transfer: { concurrency: 4 })

      expect(store.peak_in_flight).to be >= 2
      expect(parts_sent(store).map { |request| [ part_number(request), request.body ] }.uniq.sort)
        .to eq((1..12).map { |number| [ number, data.byteslice((number - 1) * 4, 4) ] })
      expect(attempts[2]).to eq(2)
      expect(source.pos).to eq(48)
      expect(source).not_to be_closed
      expect(buffer).not_to be_frozen
      expect(reports.map { |report| report[:total_bytes] }.uniq).to eq([ 48 ])
      expect(ends(api).first.values_at("size")).to eq([ "48" ])
    end

    it "stops a stream that ends before its size, without ending the upload" do
      store = storage_server
      api = api_server(store)

      expect { described_class.upload_io(StringIO.new(data.byteslice(0, 10)), "report.bin", {}, size: 12, transfer: { concurrency: 1 }) }
        .to raise_error(Files::Transfer::SourceChangedError)
      # The three parts granted at once were read, in order, before any was sent.
      expect(parts_sent(store)).to be_empty
      expect(ends(api)).to be_empty
    end

    it "never holds more of a caller's stream than buffer_bytes, even while an earlier part renews its URL" do
      lock = Mutex.new
      acknowledged_bytes = 0
      store = storage_server(part: lambda { |number, request|
        lock.synchronize { acknowledged_bytes += request.body.bytesize }
        acknowledged(number)
      }
                            )
      # Part 1's first grant has already expired, so it renews before it is sent while the parts after it wait.
      api = api_server(store, partsize: 32_768, grant: lambda { |number, params|
        number == 1 && params["parts"] == "5" ? { upload_uri: store.url("/parts/1?X-Amz-Date=20000101T000000Z&X-Amz-Expires=60") } : {}
      }
      )
      content = Random.new(3).bytes(6 * 32_768)
      source = StringIO.new(content)
      most_unacknowledged = 0
      stream = Object.new
      stream.define_singleton_method(:read) do |length|
        chunk = source.read([ length, 5000 ].min)
        lock.synchronize { most_unacknowledged = [ most_unacknowledged, source.pos - acknowledged_bytes ].max }
        chunk
      end

      Files::Transfer::Job.open(concurrency: 4, buffer_bytes: 65_536) do |job|
        described_class.upload_io(stream, "report.bin", {}, size: content.bytesize, transfer: job)
        expect(job.held_bytes).to eq(0)
      end

      expect(most_unacknowledged).to be <= 65_536
      expect(parts_sent(store).map { |request| [ part_number(request), request.body ] }.sort)
        .to eq((1..6).map { |number| [ number, content.byteslice((number - 1) * 32_768, 32_768) ] })
      expect(begins(api).map { |params| params.values_at("part", "parts") }).to include(%w[1 1])
    end

    it "gives a failed stream's buffer back only with its bytes, while another transfer of the job goes on" do
      store = storage_server(part: lambda { |number, request|
        next TransferServer.response("501 Not Implemented", { "Content-Length" => 0 }) if number == 2 && request.body.start_with?("s")

        acknowledged(number)
      }
                            )
      api = api_server(store, partsize: 16_384, names: %w[report.bin other.bin])
      reports = []

      Files::Transfer::Job.open(concurrency: 2, buffer_bytes: 65_536, max_files: 2) do |job|
        with_local_file("f" * 65_536) do |path|
          failing = Thread.new { described_class.upload_io(StringIO.new("s" * 65_536), "other.bin", {}, size: 65_536, transfer: job) }
          described_class.upload_file(path, "report.bin", {}, progress: ->(report) { reports << report }, transfer: job)

          expect { failing.join(10) }.to raise_error(Files::APIError) { |error| expect(error.http_status).to eq(501) }
        end
        expect(job.held_bytes).to eq(0)
        # The job also counted what storage acknowledged of the other transfer, at least the part before its refusal.
        expect(job.diagnostics[:accepted_bytes]).to be >= 65_536 + 16_384
      end
      expect(ends(api).map { |params| params["size"] }).to eq([ "65536" ])
      # report.bin's progress counts its own parts alone.
      expect(reports.map { |report| report[:acknowledged_bytes] }).to eq([ 16_384, 32_768, 49_152, 65_536 ])
    end

    it "reports a transfer of a shared job by its own parts and the seconds since its own call began, while the job also counts another's" do
      clock = controlled_clock
      other_started = Queue.new
      other_finished = Queue.new
      # report.bin's first part is answered only once other.bin, begun as that part reached storage, has finished. Each
      # of report.bin's parts takes two seconds of the example's clock, and other.bin's none.
      store = storage_server(part: lambda { |number, request|
        next acknowledged(number) unless request.body.start_with?("f")

        if number == 1
          other_started << :go
          other_finished.pop
        end
        clock.now += 2
        acknowledged(number)
      }
                            )
      # report.bin sends one part at a time, which leaves the job's other request for other.bin.
      api_server(store, names: %w[report.bin other.bin], grant: ->(_number, params) { params["path"] == "report.bin" ? { parallel_parts: false } : {} })
      control = Files::Transfer::Control.new
      reports = []
      counted = []
      other_failure = nil

      Files::Transfer::Job.open(concurrency: 2, control: control) do |job|
        # report.bin's upload begins a minute after the job.
        clock.now += 60
        progress = lambda do |report|
          reports << report
          counted << job.diagnostics.values_at(:accepted_bytes, :elapsed_seconds)
        end
        # other.bin's caller uploads only once storage says go, keeps what it raises, and however it ends lets go the
        # storage answer waiting for it.
        other = Thread.new do
          described_class.upload_io(StringIO.new("s" * 8), "other.bin", {}, size: 8, transfer: job) if other_started.pop == :go
        rescue StandardError => e
          other_failure = e
        ensure
          other_finished << :done
        end
        begin
          with_local_file("f" * 8) { |path| described_class.upload_file(path, "report.bin", {}, progress: progress, transfer: job) }
        ensure
          # However report.bin's upload ended, even before storage said go, other.bin's caller is let go, its upload
          # cancelled, which one that finished ignores, and the caller joined before the job closes and the clock's stub
          # and the servers go. None of it needs the clock to move: the cancellation wakes the upload at once, and the
          # job, with nothing left running, closes without waiting out its deadline. What the caller raised is kept, so
          # report.bin's own failure stays the one reported.
          other_started << :stop
          control.cancel
          other.join
        end
        raise other_failure if other_failure
      end

      # As each report came, the job had counted other.bin's 8 bytes as well, over the minute before report.bin began;
      # the reports count only report.bin's own, 4 every 2 seconds since its own call began.
      expect(counted).to eq([ [ 12, 62.0 ], [ 16, 64.0 ] ])
      expect(reports.map { |report| report.values_at(:part_number, :acknowledged_bytes, :elapsed_seconds, :bytes_per_second) })
        .to eq([ [ 1, 4, 2.0, 2.0 ], [ 2, 8, 4.0, 2.0 ] ])
    end

    it "holds a stream part read in pieces with the slice it is sent through, and one a single read gave whole with its own bytes alone" do
      job = nil
      source = nil
      sending = []
      store = storage_server(part: lambda { |number, _request|
        sending << [ job.held_bytes, source.pos ]
        acknowledged(number)
      }
                            )
      api_server(store, partsize: 65_536)
      content = Random.new(17).bytes(2 * 65_536)
      source = StringIO.new(content)
      reads = 0
      stream = Object.new
      # The first part comes in two reads, each longer than a send's slice of it; the second in one.
      stream.define_singleton_method(:read) { |length| source.read((reads += 1) == 1 ? 40_000 : length) }

      Files::Transfer::Job.open(concurrency: 1, buffer_bytes: 131_072) do |opened|
        job = opened
        described_class.upload_io(stream, "report.bin", {}, size: content.bytesize, transfer: job)
        expect(job.held_bytes).to eq(0)
      end

      # The first part held its 64 KiB and a 64 KiB slice, the whole budget, so the second was read only once storage
      # had it; the second then held only its own 64 KiB.
      expect(sending).to eq([ [ 131_072, 65_536 ], [ 65_536, 131_072 ] ])
      expect(parts_sent(store).map { |request| [ part_number(request), request.body ] }.sort)
        .to eq([ [ 1, content.byteslice(0, 65_536) ], [ 2, content.byteslice(65_536, 65_536) ] ])
    end

    it "refuses, before reading anything, a stream part a caller's client could not take as one String within buffer_bytes, and holds one that fits by its own bytes once read" do
      sent = []
      held = []
      job = nil
      client = lambda do |partsize|
        stubbed_api_client do |stub|
          stub.post("/api/rest/v1/file_actions/begin_upload/report.bin") do |env|
            first = Integer(Faraday::Utils.parse_nested_query(env.body).fetch("part"))
            json_response(200, (first...(first + 5)).map { |number|
              { part_number: number, partsize: partsize, ref: "upload-ref", http_method: "PUT", upload_uri: "https://storage.example.test/parts/#{number}" }
            }
            )
          end
          stub.put(/\A\/parts\/\d+\z/) do |env|
            sent << env.body
            held << job&.held_bytes
            [ 200, { "ETag" => "\"etag-#{sent.size}\"" }, "" ]
          end
          stub.post("/api/rest/v1/files/report.bin") { |_env| json_response(201, { path: "report.bin", type: "file" }) }
        end
      end
      content = Random.new(13).bytes(40_000)

      # Copying a 40,000-byte part read in pieces into one String could need 80,000 bytes of a 64 KiB budget.
      large = StringIO.new(content)
      expect { described_class.upload_io(large, "report.bin", { client: client.call(40_000) }, size: content.bytesize, transfer: { buffer_bytes: 65_536 }) }
        .to raise_error(Files::Transfer::BufferLimitError)
      expect(large.pos).to eq(0)
      expect(sent).to be_empty

      source = StringIO.new(content)
      stream = Object.new
      stream.define_singleton_method(:read) { |length| source.read([ length, 5000 ].min) }
      Files::Transfer::Job.open(buffer_bytes: 65_536) do |opened|
        job = opened
        described_class.upload_io(stream, "report.bin", { client: client.call(20_000) }, size: content.bytesize, transfer: job)
      end
      # Each 20,000-byte part, read in pieces, reserved 40,000 bytes to be copied into one String and then held its own
      # 20,000, so both were read before the first was sent.
      expect(held).to eq([ 40_000, 20_000 ])
      expect(sent).to eq([ content.byteslice(0, 20_000), content.byteslice(20_000, 20_000) ])
    end
  end

  # Stands a clock the example moves by hand in for the monotonic clock, on every thread. It stands still, so even a
  # retry's delay passes only as the example, or a server answering for it, moves it, and it starts far from zero, so
  # the seconds since a call began never equal its reading.
  def controlled_clock
    clock = Struct.new(:now).new(1000.0)
    allow(Files::Transfer::Clock).to receive(:now) { clock.now }
    clock
  end

  describe "acknowledgement and retries" do
    it "refuses a success without an ETag, reporting nothing and not ending the upload" do
      store = storage_server(part: ->(_number, _request) { TransferServer.response("200 OK", { "Content-Length" => 0 }) })
      api = api_server(store)
      reports = []

      with_local_file(data) do |path|
        expect { upload(path, progress: ->(report) { reports << report }, transfer: { concurrency: 1 }) }
          .to raise_error(Files::APIError, "Transfer response did not acknowledge the part") { |error| expect(error.http_status).to eq(200) }
      end
      expect(reports).to be_empty
      expect(parts_sent(store).size).to eq(1)
      expect(ends(api)).to be_empty
    end

    it "retries a part answered 500 with exactly its bytes, and reports it once" do
      Files.max_network_retries = 2
      clock = controlled_clock
      lock = Mutex.new
      attempts = Hash.new(0)
      # Storage refuses part 2 at once the first time, and takes two seconds of the example's clock to acknowledge a part.
      store = storage_server(part: lambda { |number, _request|
        count = lock.synchronize { attempts[number] += 1 }
        next TransferServer.response("500 Internal Server Error", { "Content-Length" => 0 }) if number == 2 && count == 1

        clock.now += 2
        acknowledged(number)
      }
                            )
      api = api_server(store)
      control = Files::Transfer::Control.new
      reports = []
      failure = nil

      with_local_file(data.byteslice(0, 12)) do |path|
        # Part 2's retry delay passes only as part 3's acknowledgement moves the clock, so an upload that held part 3 back
        # behind it would stall: it gets ten seconds on a thread of its own, which keeps what the upload raised.
        uploading = Thread.new do
          upload(path, progress: ->(report) { reports << report }, transfer: { concurrency: 1, control: control })
        rescue StandardError => e
          failure = e
        end
        expect(uploading.join(10)).to be_truthy
      ensure
        # However the wait ended, the upload is cancelled, which one that finished ignores, and its caller joined before
        # the file, the clock's stub and the servers go. None of it needs the clock to move: the cancellation wakes the
        # upload at once, and its own job, with nothing left running, closes without waiting out its deadline. A wait
        # that failed stays the failure reported, not the cancellation the caller then met.
        control.cancel
        uploading&.join
      end
      raise failure if failure

      # A part waiting out its retry delay does not hold back the parts after it.
      expect(parts_sent(store).map { |request| [ request.target, request.body ] }.sort).to eq([ %w[/parts/1 abcd], %w[/parts/2 efgh], %w[/parts/2 efgh], %w[/parts/3 ijkl] ])
      expect(reports.map { |report| report[:part_number] }.sort).to eq([ 1, 2, 3 ])
      expect(reports.map { |report| report[:acknowledged_bytes] }).to eq([ 4, 8, 12 ])
      # Each report also gives the file's and the part's sizes, the seconds since the call began and the bytes storage
      # acknowledged over them: a part's 4 every 2 seconds, the retried part's once.
      expect(reports.map { |report| report.values_at(:total_bytes, :part_bytes, :elapsed_seconds, :bytes_per_second) })
        .to eq([ [ 12, 4, 2.0, 2.0 ], [ 12, 4, 4.0, 2.0 ], [ 12, 4, 6.0, 2.0 ] ])
      expect(ends(api).first["etags"].map { |etag| etag["part"] }).to eq(%w[1 2 3])
    end

    [
      [ "the instructions say retry_parts: false", ->(_number, _params) { { retry_parts: false } }, 500 ],
      [ "storage answers 501", ->(_number, _params) { {} }, 501 ]
    ].each do |reason, grant, status|
      it "does not retry a part when #{reason}" do
        Files.max_network_retries = 2
        store = storage_server(part: ->(_number, _request) { TransferServer.response("#{status} Failed", { "Content-Length" => 0 }) })
        api = api_server(store, grant: grant)

        with_local_file(data) do |path|
          expect { upload(path, transfer: { concurrency: 1 }) }
            .to raise_error(Files::APIError, "Transfer request failed") { |error| expect(error.http_status).to eq(status) }
        end
        expect(parts_sent(store).size).to eq(1)
        expect(ends(api)).to be_empty
      end
    end

    it "renews an expired signed URL before sending, keeping the reference, part and size" do
      store = storage_server
      expired = ->(number, params) { params["parts"] == "5" ? { upload_uri: store.url("/parts/#{number}?X-Amz-Date=20000101T000000Z&X-Amz-Expires=60") } : {} }
      api = api_server(store, grant: expired)

      with_local_file(data.byteslice(0, 12)) { |path| upload(path, transfer: { concurrency: 1 }) }

      expect(begins(api).drop(1).map { |params| params.values_at("part", "parts", "ref") }).to eq([ %w[1 1 upload-ref], %w[2 1 upload-ref], %w[3 1 upload-ref] ])
      expect(parts_sent(store).map(&:target)).to eq(%w[/parts/1 /parts/2 /parts/3])
      expect(ends(api).size).to eq(1)
    end

    it "refuses a renewal that changes the part's size, sending nothing for it" do
      store = storage_server
      renewal = lambda do |number, params|
        params["parts"] == "5" ? { upload_uri: store.url("/parts/#{number}?X-Amz-Date=20000101T000000Z&X-Amz-Expires=60") } : { partsize: 5 }
      end
      api = api_server(store, grant: renewal)

      with_local_file(data.byteslice(0, 12)) do |path|
        expect { upload(path, transfer: { concurrency: 1 }) }.to raise_error(Files::APIError, "The renewed upload instructions changed")
      end
      expect(parts_sent(store)).to be_empty
      expect(ends(api)).to be_empty
    end

    it "stops without sending a part whose renewals still give an expired URL" do
      store = storage_server
      api = api_server(store, grant: ->(number, _params) { { upload_uri: store.url("/parts/#{number}?X-Amz-Date=20000101T000000Z&X-Amz-Expires=60") } })

      with_local_file(data.byteslice(0, 4)) do |path|
        expect { upload(path, transfer: { concurrency: 1 }) }.to raise_error(Files::APIError) { |error| expect(error.http_status).to eq(403) }
      end
      expect(parts_sent(store)).to be_empty
      expect(begins(api).size).to eq(3)
      expect(ends(api)).to be_empty
    end

    it "does not send a retry_parts: false part again when its URL expired while it was in flight" do
      Files.max_network_retries = 2
      store = storage_server(part: lambda { |_number, _request|
        sleep 1.2
        TransferServer.response("403 Forbidden", { "Content-Length" => 0 })
      }
                            )
      api = api_server(store, grant: ->(_number, _params) { { retry_parts: false, expires: (Time.now + 6).utc.iso8601 } })

      with_local_file(data.byteslice(0, 4)) do |path|
        expect { upload(path, transfer: { concurrency: 1 }) }.to raise_error(Files::APIError) { |error| expect(error.http_status).to eq(403) }
      end
      expect(parts_sent(store).size).to eq(1)
      expect(begins(api).size).to eq(1)
    end

    it "waits out a Retry-After longer than a minute, which a cancellation still ends at once" do
      Files.max_network_retries = 1
      store = storage_server(part: ->(_number, _request) { TransferServer.response("429 Too Many Requests", { "Retry-After" => "120", "Content-Length" => 0 }) })
      api = api_server(store)
      control = Files::Transfer::Control.new
      canceller = Thread.new do
        store.wait_for_requests(1)
        sleep 0.5
        control.cancel
      end
      started = Process.clock_gettime(Process::CLOCK_MONOTONIC)

      with_local_file(data.byteslice(0, 4)) do |path|
        expect { upload(path, transfer: { concurrency: 1, control: control }) }.to raise_error(Files::Transfer::CancelledError)
      end
      canceller.join

      expect(Process.clock_gettime(Process::CLOCK_MONOTONIC) - started).to be < 5
      expect(parts_sent(store).size).to eq(1)
      expect(ends(api)).to be_empty
      retry_after = Files::Transfer::StorageRetry
      expect(retry_after.classify(429, { "retry-after" => [ "120" ] }, "")).to eq([ :throttle, 120.0 ])
      now = Time.now
      expect(retry_after.retry_after((now + 300).httpdate, now: now)).to be_within(1).of(300)
      expect(retry_after.classify(503, { "retry-after" => [ "9" * 400 ] }, "")).to eq([ :refuse ])
    end

    it "holds every new part and retry back until a throttle's Retry-After has passed" do
      Files.max_network_retries = 1
      lock = Mutex.new
      arrivals = []
      store = storage_server(part: lambda { |number, _request|
        first = lock.synchronize do
          arrivals << Process.clock_gettime(Process::CLOCK_MONOTONIC)
          arrivals.size == 1
        end
        first ? TransferServer.response("429 Too Many Requests", { "Retry-After" => "1", "Content-Length" => 0 }) : acknowledged(number)
      }
                            )
      api = api_server(store)

      with_local_file(data.byteslice(0, 12)) { |path| upload(path, transfer: { concurrency: 1 }) }

      # The throttled first part, then, a second later at the earliest, its retry and the two parts after it.
      expect(arrivals.size).to eq(4)
      expect(arrivals.drop(1).map { |at| at - arrivals.first }).to all(be >= 0.9)
      expect(ends(api).size).to eq(1)
    end

    [
      [ %(<?xml version="1.0" encoding="UTF-8"?>\n<Error><Code>RequestTimeout</Code><Message>Idle</Message></Error>\n), 2 ],
      [ "<Error><Code>AccessDenied</Code><Message><Code>RequestTimeout</Code></Message></Error>", 1 ],
      [ "<Error><Code>RequestTimeout</Code><Broken></Error>", 1 ],
      [ "<!DOCTYPE Error><Error><Code>RequestTimeout</Code></Error>", 1 ],
      [ %(<Error xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Code>RequestTimeout</Code></Error>), 1 ],
      [ "<Error><Code>RequestTimeout</Code><Code>RequestTimeout</Code></Error>", 1 ],
      [ %(<Error><Code xmlns="urn:not-s3">RequestTimeout</Code></Error>), 1 ],
      [ %(<Error x="1" x="2"><Code>RequestTimeout</Code></Error>), 1 ],
      # A valid RequestTimeout padded to 64 KiB, then one byte more that the transport keeps no part of.
      [ "#{'<Error><Code>RequestTimeout</Code></Error>'.ljust(65_536)}x", 1 ]
    ].each do |body, sends|
      it "#{sends == 2 ? 'retries' : 'does not retry'} a 400 whose body is #{body.lines.last.strip[0, 40].inspect}" do
        Files.max_network_retries = 1
        lock = Mutex.new
        answered = 0
        store = storage_server(part: lambda { |number, _request|
          first = lock.synchronize { (answered += 1) == 1 }
          first ? TransferServer.response("400 Bad Request", { "Content-Length" => body.bytesize }, body) : acknowledged(number)
        }
                              )
        api = api_server(store)

        with_local_file(data.byteslice(0, 4)) do |path|
          if sends == 2
            upload(path, transfer: { concurrency: 1 })
          else
            expect { upload(path, transfer: { concurrency: 1 }) }.to raise_error(Files::APIError) { |error| expect(error.http_status).to eq(400) }
          end
        end
        expect(parts_sent(store).size).to eq(sends)
        expect(ends(api).size).to eq(sends - 1)
      end
    end

    # Storage's word that a part's URL, which states no expiry, has expired: the first answer to the part.
    expired = "<Error><Code>AccessDenied</Code><Message>Request has expired</Message></Error>"
    [
      [ "S3's Request has expired", 403, %(<?xml version="1.0" encoding="UTF-8"?>\n#{expired}), :renews ],
      [ "ExpiredToken", 400, "<Error><Code>ExpiredToken</Code><Message>The provided token has expired.</Message></Error>", :renews ],
      [ "Azure's expired signature", 403, "<Error><Code>AuthenticationFailed</Code><AuthenticationErrorDetail>SIGNATURE NOT VALID IN THE SPECIFIED TIME FRAME</AuthenticationErrorDetail></Error>", :renews ],
      [ "upload_request_expired", 403, '{"type":"upload_request_expired","http-code":403}', :renews ],
      [ "download_request_expired", 400, '{"type":"download_request_expired"}', :renews ],
      [ "an expiry in the first 4 KiB of a body past 64 KiB", 403, expired.ljust(70_000), :renews ],
      [ "an expiry past the first 4 KiB", 403, "#{' ' * 4096}#{expired}", :refuses ],
      [ "upload_request_expired past 4 KiB", 403, '{"type":"upload_request_expired"}'.ljust(4097), :refuses ],
      [ "AccessDenied", 403, "<Error><Code>AccessDenied</Code><Message>Access Denied</Message></Error>", :refuses ],
      [ "SignatureDoesNotMatch", 403, "<Error><Code>SignatureDoesNotMatch</Code><Message>The signature has expired or does not match</Message></Error>", :refuses ],
      [ "another Files.com error", 403, '{"type":"not-authorized/expired","error":"Upload request expired"}', :refuses ],
      # JSON is judged by its type alone, never by an expiry's words inside it, even when it is not well formed.
      [ "another JSON type saying Request has expired", 403, '{"type":"not_authorized","error":"Request has expired"}', :refuses ],
      [ "another JSON type holding ExpiredToken", 400, '{"type":"other","data":"<Code>ExpiredToken</Code>"}', :refuses ],
      [ "a JSON array saying Request has expired", 403, '[{"Message":"Request has expired"}]', :refuses ],
      [ "a JSON string saying Request has expired", 403, '"Request has expired"', :refuses ],
      [ "malformed JSON saying Request has expired", 403, '  {"error":"Request has expired"', :refuses ],
      [ "an expiry on a success", 200, expired, :acknowledged ],
      [ "an expiry for a part that may not be retried", 403, expired, :refuses, { retry_parts: false } ]
    ].each do |name, status, body, outcome, grant = {}|
      it "#{outcome == :renews ? 'renews' : 'does not renew'} a part's URL when storage answers #{name}" do
        Files.max_network_retries = 1
        lock = Mutex.new
        answered = 0
        headers = { "Content-Length" => body.bytesize }
        headers["ETag"] = "\"etag-1\"" if status == 200
        store = storage_server(part: lambda { |number, _request|
          first = lock.synchronize { (answered += 1) == 1 }
          first ? TransferServer.response("#{status} Answer", headers, body) : acknowledged(number)
        }
                              )
        api = api_server(store, grant: ->(_number, _params) { grant })

        with_local_file(data.byteslice(0, 4)) do |path|
          if outcome == :refuses
            expect { upload(path, transfer: { concurrency: 1 }) }.to raise_error(Files::APIError) { |error| expect(error.http_status).to eq(status) }
          else
            upload(path, transfer: { concurrency: 1 })
          end
        end
        sends = outcome == :renews ? 2 : 1
        expect(parts_sent(store).map(&:body)).to eq([ data.byteslice(0, 4) ] * sends)
        expect(begins(api).size).to eq(sends)
        expect(begins(api).drop(1).map { |params| params.values_at("part", "parts", "ref") }).to eq([ %w[1 1 upload-ref] ] * (sends - 1))
        expect(ends(api).size).to eq(outcome == :refuses ? 0 : 1)
      end
    end
  end

  describe "stopping" do
    it "raises the progress callback's own error, with no part admitted and nothing ended after it" do
      store = storage_server
      api = api_server(store)
      stopped = StandardError.new("stopped by the caller")

      with_local_file(data) do |path|
        expect { upload(path, progress: ->(_report) { raise stopped }, transfer: { concurrency: 1 }) }
          .to raise_error(StandardError) { |error| expect(error).to equal(stopped) }
      end
      expect(parts_sent(store).size).to eq(1)
      expect(ends(api)).to be_empty
    end

    it "admits nothing after a cancel and releases what it held" do
      store = storage_server
      api = api_server(store)
      control = Files::Transfer::Control.new

      Files::Transfer::Job.open(concurrency: 1, control: control) do |job|
        with_local_file(data) do |path|
          expect { upload(path, progress: ->(_report) { control.cancel }, transfer: job) }.to raise_error(Files::Transfer::CancelledError)
        end
        expect(job.held_bytes).to eq(0)
      end
      expect(parts_sent(store).size).to eq(1)
      expect(ends(api)).to be_empty
    end

    it "stops before the next part when the local file changes, without ending the upload" do
      changed = nil
      store = storage_server(part: lambda { |number, _request|
        changed&.call
        acknowledged(number)
      }
                            )
      api = api_server(store)

      with_local_file(data) do |path|
        changed = -> { File.binwrite(path, "ab") }
        expect { upload(path, transfer: { concurrency: 1 }) }.to raise_error(Files::Transfer::SourceChangedError)
      end
      expect(parts_sent(store).size).to eq(1)
      expect(ends(api)).to be_empty
    end

    it "pauses with a checkpoint that resumes only the parts not yet acknowledged" do
      clock = controlled_clock
      seconds_per_part = 0
      # Storage takes seconds_per_part of the example's clock to acknowledge a part: none before the pause, two after it.
      store = storage_server(part: lambda { |number, _request|
        clock.now += seconds_per_part
        acknowledged(number)
      }
                            )
      api = api_server(store)
      control = Files::Transfer::Control.new
      paused_reports = []
      reports = []

      with_local_file(data.byteslice(0, 12)) do |path|
        paused = nil
        pause = lambda do |report|
          paused_reports << report
          control.pause
        end
        expect { upload(path, progress: pause, transfer: { concurrency: 1, control: control }) }
          .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        checkpoint = paused.checkpoint
        expect([ checkpoint.direction, checkpoint.completed_bytes, checkpoint.total_bytes ]).to eq([ :upload, 4, 12 ])
        expect(checkpoint.inspect).not_to include("upload-ref", "/parts/", "fixture")
        expect { Marshal.dump(checkpoint) }.to raise_error(TypeError)
        expect(ends(api)).to be_empty

        # The upload resumes an hour after its pause.
        clock.now += 3600
        seconds_per_part = 2
        described_class.resume_upload(checkpoint, {}, progress: ->(report) { reports << report }, transfer: { concurrency: 1 })
      end

      expect(parts_sent(store).map(&:target)).to eq(%w[/parts/1 /parts/2 /parts/3])
      expect(reports.map { |report| report.values_at(:part_number, :acknowledged_bytes) }).to eq([ [ 2, 8 ], [ 3, 12 ] ])
      # No time had passed when the paused call's part was acknowledged, so its rate was zero. The resume's seconds start
      # with the resume, not the paused call, and its rate counts only the 8 bytes it acknowledged, 4 every 2 seconds,
      # though its acknowledged_bytes include the checkpoint's 4.
      expect(paused_reports.map { |report| report.values_at(:acknowledged_bytes, :elapsed_seconds, :bytes_per_second) }).to eq([ [ 4, 0.0, 0.0 ] ])
      expect(reports.map { |report| report.values_at(:elapsed_seconds, :bytes_per_second) }).to eq([ [ 2.0, 2.0 ], [ 4.0, 2.0 ] ])
      expect(begins(api).drop(1).map { |params| params.values_at("part", "parts", "ref") }).to eq([ %w[2 1 upload-ref], %w[3 1 upload-ref] ])
      expect(ends(api).first["etags"].map { |etag| etag["part"] }).to eq(%w[1 2 3])
    end

    it "refuses to resume from a checkpoint whose local file changed" do
      store = storage_server
      api_server(store)
      control = Files::Transfer::Control.new

      with_local_file(data.byteslice(0, 12)) do |path|
        paused = nil
        expect { upload(path, progress: ->(_report) { control.pause }, transfer: { concurrency: 1, control: control }) }
          .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        File.binwrite(path, "a different file")

        expect { described_class.resume_upload(paused.checkpoint, {}) }.to raise_error(Files::Transfer::CheckpointError)
      end
      expect(parts_sent(store).size).to eq(1)
    end

    it "raises a failure that came before a cancellation, not the cancellation" do
      store = storage_server(part: lambda { |number, _request|
        number == 2 ? TransferServer.response("501 Not Implemented", { "Content-Length" => 0 }) : acknowledged(number)
      }
                            )
      api = api_server(store)
      control = Files::Transfer::Control.new
      # The first report holds the caller's thread until part 2's refusal is back, then cancels.
      cancel_late = lambda do |_report|
        store.wait_for_requests(2)
        sleep 0.5
        control.cancel
      end

      with_local_file(data.byteslice(0, 8)) do |path|
        expect { upload(path, progress: cancel_late, transfer: { concurrency: 2, control: control }) }
          .to raise_error(Files::APIError) { |error| expect(error.http_status).to eq(501) }
      end
      expect(ends(api)).to be_empty
    end

    it "raises a part's failure that came back before the caller's own callback failed" do
      store = storage_server(part: lambda { |number, _request|
        number == 2 ? TransferServer.response("501 Not Implemented", { "Content-Length" => 0 }) : acknowledged(number)
      }
                            )
      api = api_server(store)
      callback_failure = StandardError.new("the caller's callback failed later")
      # The first report holds the caller's thread until part 2's refusal is back, then fails itself.
      fail_late = lambda do |_report|
        store.wait_for_requests(2)
        sleep 0.5
        raise callback_failure
      end

      with_local_file(data.byteslice(0, 8)) do |path|
        expect { upload(path, progress: fail_late, transfer: { concurrency: 2 }) }
          .to raise_error(Files::APIError) { |error| expect(error.http_status).to eq(501) }
      end
      expect(ends(api)).to be_empty
    end

    it "opens nothing before it has a file slot and is still running, and gives no checkpoint for a pause while its file opens" do
      store = storage_server
      api = api_server(store)
      control = Files::Transfer::Control.new
      control.pause

      expect { upload("/nonexistent/report.bin", transfer: { control: control }) }
        .to raise_error(Files::Transfer::PausedError) { |error| expect(error.checkpoint).to be_nil }
      expect(api.requests).to be_empty

      # Opening the file pauses the upload and then fails: the pause came first, with nothing opened to resume.
      opening = Files::Transfer::Control.new
      path = Object.new
      path.define_singleton_method(:to_path) do
        opening.pause
        "/nonexistent/report.bin"
      end
      job = Files::Transfer::Job.new(control: opening)
      expect { described_class.upload_file(path, "report.bin", {}, transfer: job) }
        .to raise_error(Files::Transfer::PausedError) { |error| expect(error.checkpoint).to be_nil }
      expect(job.diagnostics.values_at(:requests, :held_bytes)).to eq([ 0, 0 ])
      expect(job.close).to be(true)
      expect(api.requests).to be_empty
      expect(store.requests).to be_empty
    end

    it "lets one resume hold a checkpoint at a time, and none use it once one has started" do
      control = Files::Transfer::Control.new
      holding = Queue.new
      held = false
      store = storage_server(part: lambda { |number, _request|
        control.pause if number == 1
        holding.pop if number == 2 && held
        acknowledged(number)
      }
                            )
      api = api_server(store)

      with_local_file(data.byteslice(0, 12)) do |path|
        paused = nil
        expect { upload(path, transfer: { concurrency: 1, control: control }) }.to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        checkpoint = paused.checkpoint
        expect(checkpoint).not_to respond_to(:claim!, :release!)

        held = true
        first = Thread.new { described_class.resume_upload(checkpoint, {}, transfer: { concurrency: 1 }) }
        store.wait_for_requests(2)
        expect { described_class.resume_upload(checkpoint, {}) }.to raise_error(Files::Transfer::CheckpointError, /another resume/)
        holding << :go
        first.join(10)
        expect { described_class.resume_upload(checkpoint, {}) }.to raise_error(Files::Transfer::CheckpointError, /already been used/)
      end
      expect(parts_sent(store).map(&:target)).to eq(%w[/parts/1 /parts/2 /parts/3])
      expect(ends(api).size).to eq(1)
    end

    it "keeps only safe upload state in a checkpoint, and refuses a resumed part whose instructions changed" do
      control = Files::Transfer::Control.new
      store = storage_server(part: lambda { |number, _request|
        control.pause if number == 1
        acknowledged(number)
      }
                            )
      headers = { "x-amz-checksum-crc32" => "first" }
      api = api_server(store, grant: ->(_number, _params) { { headers: headers } })
      record = described_class.new({ path: "report.bin", size: 999, download_uri: "https://storage.example.test/report.bin?X-Amz-Signature=secret",
                                     mkdir_parents: true, nested: { deep: "response field" } }, { session_id: "record-session" }
      )

      with_local_file(data.byteslice(0, 12)) do |path|
        paused = nil
        File.open(path, "rb") do |local|
          expect { record.upload_file(local, transfer: { concurrency: 1, control: control }) }.to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        end
        checkpoint = paused.checkpoint
        everything = [ checkpoint.state, checkpoint.source, checkpoint.sink, checkpoint.inspect ].inspect
        expect(everything).not_to include("secret", "Signature", "response field", "record-session", "/parts/", "first")
        expect(checkpoint.state[:params]).to eq({ mkdir_parents: true, size: 12 })
        expect(checkpoint.state).to be_frozen
        expect(checkpoint.state[:layout]).to all(be_frozen)

        headers = { "x-amz-checksum-crc32" => "changed" }
        expect { described_class.resume_upload(checkpoint, { session_id: "record-session" }, transfer: { concurrency: 1 }) }
          .to raise_error(Files::APIError, "The renewed upload instructions changed")
        # That resume started, so its failure spent the checkpoint.
        headers = { "x-amz-checksum-crc32" => "first" }
        expect { described_class.resume_upload(checkpoint, { session_id: "record-session" }) }.to raise_error(Files::Transfer::CheckpointError, /already been used/)
      end
      expect(parts_sent(store).size).to eq(1)
      expect(ends(api)).to be_empty
    end

    it "does not report a job closed while a transfer's request is still in flight" do
      gate = Queue.new
      store = storage_server(part: lambda { |number, _request|
        gate.pop
        acknowledged(number)
      }
                            )
      api_server(store)
      job = Files::Transfer::Job.new(concurrency: 1)
      failure = nil
      uploader = nil

      with_local_file(data.byteslice(0, 4)) do |path|
        uploader = Thread.new do
          upload(path, transfer: job)
        rescue StandardError => e
          failure = e
        end
        store.wait_for_requests(1)

        expect { job.close }.to raise_error(Files::Error, /still running/)
        gate << :go
        uploader.join(10)
      end
      expect(failure).to be_a(Files::Error)
      expect(job.close).to be(true)
    end
  end

  describe "while Files.com completes the upload" do
    # Answers the first end requests pending for upload-ref, each with the progress in progresses (nil leaves it out),
    # and every later one with the File.
    def pending_then_file(*progresses)
      lambda do |_request, count|
        next json(202, { status: "pending", ref: "upload-ref", progress: progresses[count - 1] }.compact) if count <= progresses.size

        json(201, { path: "report.bin", type: "file", size: 8 })
      end
    end

    it "sends its final request again after each pending answer, with the context it began with, and reports each answer on the caller's thread" do
      store = storage_server
      api = api_server(store, end_answer: pending_then_file(nil, 42))
      reports = []
      threads = []
      settings = [ Files.default_headers, Files.language ]
      Files.default_headers = { "X-Fixture-Default" => "first" }
      progress = lambda do |report|
        reports << report
        threads << Thread.current
        next unless report[:finalizing]

        Files.default_headers = { "X-Fixture-Default" => "changed" }
        Files.language = "changed"
        Files.base_url = "http://127.0.0.1:1"
        Files.session_id = "changed-session"
        Files.workspace_id = 9
      end

      file = begin
        with_local_file(data.byteslice(0, 8)) { |path| upload(path, progress: progress, transfer: { concurrency: 1 }) }
      ensure
        Files.default_headers, Files.language = settings
      end

      expect([ file.path, file.size ]).to eq([ "report.bin", 8 ])
      last_part = reports[1]
      expect(last_part.values_at(:total_bytes, :acknowledged_bytes, :part_number)).to eq([ 8, 8, 2 ])
      expect(reports.drop(2)).to eq([ nil, 42 ].map { |percent| last_part.merge(part_bytes: 0, finalizing: true, finalization_progress: percent) })
      expect(threads.uniq).to eq([ Thread.current ])
      expect(ends(api).size).to eq(3)
      expect(ends(api).uniq.size).to eq(1)
      expect(ends(api).first).to include("action" => "end", "async_finalize" => "true", "ref" => "upload-ref", "size" => "8")
      finalizes = api.requests.select { |request| request.target.start_with?("/api/rest/v1/files/") }
      expect(finalizes.map { |request| request.headers.values_at("x-filesapi-auth", "x-filesapi-key", "x-files-workspace-id", "x-fixture-default", "accept-language", "user-agent") }.uniq.size).to eq(1)
      expect(finalizes.first.headers.values_at("x-filesapi-auth", "x-files-workspace-id", "x-fixture-default")).to eq([ "fixture-session", "7", "first" ])
    end

    it "stops waiting at once for a cancellation after a pending answer, sending nothing more" do
      store = storage_server
      control = Files::Transfer::Control.new
      answered = Queue.new
      api = api_server(store, end_answer: lambda { |_request, _count|
        answered << :pending
        json(202, { status: "pending", ref: "upload-ref" })
      }
      )
      cancelled_at = nil
      canceller = Thread.new do
        answered.pop
        sleep 0.2
        cancelled_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        control.cancel
      end

      Files::Transfer::Job.open(concurrency: 1, control: control) do |job|
        with_local_file(data.byteslice(0, 8)) do |path|
          expect { upload(path, transfer: job) }.to raise_error(Files::Transfer::CancelledError, /Files.com may still complete it/)
        end
        expect(Process.clock_gettime(Process::CLOCK_MONOTONIC) - cancelled_at).to be < 0.5
        expect(job.held_bytes).to eq(0)
      end
      canceller.join
      expect(ends(api).size).to eq(1)
    end

    it "pauses after a pending answer without a checkpoint, sending nothing more" do
      store = storage_server
      api = api_server(store, end_answer: pending_then_file(nil))
      control = Files::Transfer::Control.new

      with_local_file(data.byteslice(0, 8)) do |path|
        expect { upload(path, progress: ->(report) { control.pause if report[:finalizing] }, transfer: { concurrency: 1, control: control }) }
          .to raise_error(Files::Transfer::PausedError) { |error|
            expect(error.checkpoint).to be_nil
            expect(error.message).to include("Files.com may still complete it")
          }
      end
      expect(ends(api).size).to eq(1)
    end

    it "raises the progress callback's own error from a finalizing report, sending nothing more" do
      store = storage_server
      api = api_server(store, end_answer: pending_then_file(nil))
      stopped = StandardError.new("stopped while Files.com completes the upload")

      with_local_file(data.byteslice(0, 8)) do |path|
        expect { upload(path, progress: ->(report) { raise stopped if report[:finalizing] }, transfer: { concurrency: 1 }) }
          .to raise_error(StandardError) { |error| expect(error).to equal(stopped) }
      end
      expect(ends(api).size).to eq(1)
    end
  end

  describe "limits" do
    it "refuses a part larger than buffer_bytes before reading or sending it" do
      requests = []
      client = stubbed_api_client do |stub|
        stub.post("/api/rest/v1/file_actions/begin_upload/report.bin") do |_env|
          requests << :begin
          json_response(200, [ { part_number: 1, partsize: 100_000, ref: "upload-ref", http_method: "PUT", upload_uri: "https://storage.example.test/parts/1" } ])
        end
        stub.put(/\A\/parts\/\d+\z/) { |_env| (requests << :part) && [ 200, { "ETag" => "\"etag\"" }, "" ] }
      end

      with_local_file("x" * 150_000) do |path|
        expect { upload(path, { client: client }, transfer: { buffer_bytes: 65_536 }) }.to raise_error(Files::Transfer::BufferLimitError)
      end
      expect(requests).to eq([ :begin ])
    end

    it "refuses invalid transfer options before sending anything" do
      store = storage_server
      api = api_server(store)
      invalid = [ { concurrency: 0 }, { concurrency: 257 }, { concurrency: 2, startup: :aggressive }, { max_concurrency: 0 }, { concurrency: 2, max_concurrency: 4 },
                  { buffer_bytes: 1024 }, { max_files: 0 }, { control: Object.new }, { unknown: true }, "fast" ]

      with_local_file(data) do |path|
        invalid.each { |options| expect { upload(path, transfer: options) }.to raise_error(Files::InvalidParameterError) }
      end
      expect(api.requests).to be_empty
    end
  end

  # Parts an upload sizes itself, for an ordinary multipart upload straight to Amazon S3. A caller's client carries them
  # here, so the API and S3 answer through Faraday's test adapter: the client's own remote_request keeps each part's URL,
  # headers and body exactly as the transfer hands them over, and the adapter keeps each part as it reaches it.
  describe "part sizes for Amazon S3" do
    let(:mib) { 1024 * 1024 }
    # 17 MiB and 3 bytes, no two parts alike.
    let(:content) { Random.new(17).bytes((17 * mib) + 3) }
    let(:signed_at) { Time.now.utc.strftime("%Y%m%dT%H%M%SZ") }
    let(:sent) { [] }
    let(:delivered) { [] }
    let(:begun) { [] }
    let(:api_targets) { [] }
    let(:ended) { [] }

    # A presigned UploadPart URL as S3 gives one, for upload_id at host (and, for a path-style URL, the bucket after
    # it), signing signed, with what tail adds before its signature. expired dates it long ago.
    def s3_url(number, host: "reports.s3.us-east-1.amazonaws.com", upload_id: "s3-upload-1", signed: "host", tail: "", expired: false)
      "https://#{host}/uploads/report.bin?partNumber=#{number}&uploadId=#{upload_id}&X-Amz-Algorithm=AWS4-HMAC-SHA256" \
        "&X-Amz-Credential=AKIDFIXTURE%2F#{signed_at[0, 8]}%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=#{expired ? '20000101T000000Z' : signed_at}" \
        "&X-Amz-Expires=#{expired ? 60 : 3600}&X-Amz-SignedHeaders=#{signed}#{tail}&X-Amz-Signature=#{'5d' * 32}"
    end

    # The API's answer for part number of an upload to S3, recommending hint bytes for each part, with changes.
    def s3_grant(number, hint: 5 * mib, **changes)
      { part_number: number, partsize: hint, next_partsize: hint, available_parts: 10_000, ref: "upload-ref", http_method: "PUT", action: "put/write",
        parallel_parts: true, retry_parts: true, headers: {}, parameters: {}, send: { partsize: "required-header Content-Length", partdata: "body" },
        upload_uri: s3_url(number) }.merge(changes)
    end

    # A caller's client playing the API and S3 for report.bin. begin_upload gives grant's answer for each part asked for;
    # S3 answers a part 500 when refuse says so for that attempt, and otherwise acknowledges it with an ETag naming it.
    # begun keeps each begin_upload's part and parts, api_targets the URL each API request reached the adapter at,
    # ended each end's params, sent each part as the transfer hands it to the client's remote_request (its URL, headers
    # and body), and delivered each part as it reached the adapter (its URL, Content-Length and body).
    def s3_client(grant: ->(number, _params) { s3_grant(number) }, refuse: ->(_number, _attempt) { false })
      begun_log = begun
      api_log = api_targets
      ended_log = ended
      sent_log = sent
      delivered_log = delivered
      attempts = Hash.new(0)
      client = stubbed_api_client do |stub|
        stub.post("/api/rest/v1/file_actions/begin_upload/report.bin") do |env|
          params = Faraday::Utils.parse_nested_query(env.body)
          begun_log << params.values_at("part", "parts")
          api_log << env.url.to_s
          first = Integer(params.fetch("part"))
          json_response(200, (first...(first + Integer(params.fetch("parts")))).map { |number| grant.call(number, params) })
        end
        stub.put(/\/uploads\/report\.bin\z/) do |env|
          delivered_log << [ env.url.to_s, env.request_headers["Content-Length"], env.body ]
          number = URI.decode_www_form(env.url.query).to_h.fetch("partNumber")
          refuse.call(number, attempts[number] += 1) ? [ 500, {}, "" ] : [ 200, { "ETag" => "\"etag-#{number}\"" }, "" ]
        end
        stub.post("/api/rest/v1/files/report.bin") do |env|
          api_log << env.url.to_s
          ended_log << Faraday::Utils.parse_nested_query(env.body)
          json_response(201, { path: "report.bin", type: "file" })
        end
      end
      client.define_singleton_method(:remote_request) do |verb, url, headers = {}, body = nil, &block|
        sent_log << [ url, headers.dup, body ]
        super(verb, url, headers, body, &block)
      end
      client
    end

    # Each part sent: its URL, its Content-Length and a digest of its body.
    def parts_sent_to_s3
      sent.map { |url, headers, body| [ url, headers["Content-Length"], Digest::SHA256.hexdigest(body) ] }
    end

    # Each part as it reached the adapter: its URL, its Content-Length and a digest of its body.
    def parts_delivered_to_s3
      delivered.map { |url, length, body| [ url, length, Digest::SHA256.hexdigest(body) ] }
    end

    # bytes as a part sent to url should be.
    def part_of(url, bytes)
      [ url, bytes.bytesize.to_s, Digest::SHA256.hexdigest(bytes) ]
    end

    def numbers_sent
      sent.map { |url, _, _| URI.decode_www_form(URI.parse(url).query).to_h["partNumber"] }
    end

    def upload_with(client, bytes, **keywords)
      with_local_file(bytes) { |path| upload(path, { client: client }, **keywords) }
    end

    it "sizes the parts itself, sending each one's exact bytes and Content-Length to the URL the API gave, as given" do
      reports = []
      # The URLs the API gives, which a signature covers as they are, name partNumber and uploadId before the SigV4
      # parameters, and escape their session token's plus sign and equals sign in lowercase and its tilde too, where
      # Faraday's own encoding would sort the parameters and escape them its own way. The client's connection has a
      # parameter of its own, which its API requests carry and the parts must not.
      signed = ->(number) { s3_url(number, tail: "&X-Amz-Security-Token=Fixture%2btoken%7E%3d") }
      client = s3_client(grant: ->(number, _params) { s3_grant(number, upload_uri: signed.call(number)) })
      client.conn.params["fixture"] = "connection"

      upload_with(client, content, progress: ->(report) { reports << report }, transfer: true)

      # The API recommended 5 MiB parts; the upload sent 8 MiB ones, and the rest, each reaching the adapter at the URL
      # the API gave, character for character, with exactly its bytes and their Content-Length.
      expected = [ part_of(signed.call(1), content.byteslice(0, 8 * mib)), part_of(signed.call(2), content.byteslice(8 * mib, 8 * mib)),
                   part_of(signed.call(3), content.byteslice(16 * mib, 8 * mib)) ]
      expect(parts_sent_to_s3.sort).to eq(expected)
      expect(parts_delivered_to_s3.sort).to eq(expected)
      expect(sent.map { |_, headers, _| headers.keys.sort }.uniq).to eq([ %w[Content-Length Content-Type] ])
      expect(api_targets.map { |url| URI.parse(url).query }.uniq).to eq([ "fixture=connection" ])
      expect(reports.map { |report| report.values_at(:part_number, :part_bytes) }.sort).to eq([ [ 1, 8 * mib ], [ 2, 8 * mib ], [ 3, mib + 3 ] ])
      expect(begun).to eq([ %w[1 5] ])
      expect(ended.map { |params| params["size"] }).to eq([ content.bytesize.to_s ])
      expect(ended.first["etags"].map { |etag| etag.values_at("part", "etag") }).to eq((1..3).map { |number| [ number.to_s, "\"etag-#{number}\"" ] })
    end

    it "refuses, before reading anything, a declared-size stream no plan in its available parts could send within buffer_bytes" do
      reads = []
      stream = Object.new
      stream.define_singleton_method(:read) do |length|
        reads << length
        nil
      end
      # One part is available for 1 GiB and a byte, more than the SDK's own largest part. Through a caller's client a
      # stream's part needs twice its size, so 16 MiB of buffer_bytes holds parts of 8 MiB at most: the API's 5 MiB parts
      # would fit, but could no more send the file in one part than any other plan.
      client = s3_client(grant: ->(number, _params) { s3_grant(number, available_parts: 1) })

      expect { described_class.upload_io(stream, "report.bin", { client: client }, size: (1024 * mib) + 1, transfer: { buffer_bytes: 16 * mib }) }
        .to raise_error(Files::Transfer::BufferLimitError)
      expect(reads).to be_empty
      expect([ sent, delivered, ended ]).to all(be_empty)
      expect(begun).to eq([ %w[1 5] ])
    end

    it "keeps each part's offset and size through later answers, renewals and retries recommending other sizes" do
      Files.max_network_retries = 1
      bytes = Random.new(26).bytes((26 * mib) + 3)
      # The first answer recommends 6 MiB, with part 2's URL already expired; its renewal recommends 9 MiB, and the
      # answer for part 6 on, 7 MiB. S3 refuses part 3's first attempt.
      grant = lambda do |number, params|
        if params["parts"] == "1"
          s3_grant(number, hint: 9 * mib)
        elsif params["part"] == "1"
          s3_grant(number, hint: 6 * mib, upload_uri: s3_url(number, expired: number == 2))
        else
          s3_grant(number, hint: 7 * mib)
        end
      end
      client = s3_client(grant: grant, refuse: ->(number, attempt) { number == "3" && attempt == 1 })

      # Through a caller's client a part is read whole, so buffer_bytes of 5 MiB holds parts of 5 MiB at most.
      upload_with(client, bytes, transfer: { buffer_bytes: 5 * mib })

      planned = (1..6).map { |number| part_of(s3_url(number), bytes.byteslice((number - 1) * 5 * mib, 5 * mib)) }
      expect(parts_sent_to_s3.sort).to eq((planned + [ planned[2] ]).sort)
      expect(begun.sort).to eq([ %w[1 5], %w[2 1], %w[6 5] ])
      expect(ended.first["etags"].map { |etag| etag["part"] }).to eq(%w[1 2 3 4 5 6])
    end

    it "refuses a plan whose parts buffer_bytes cannot hold before sending anything" do
      expect { upload_with(s3_client, content, transfer: { buffer_bytes: 4 * mib }) }.to raise_error(Files::Transfer::BufferLimitError)
      expect(sent).to be_empty
      expect(begun).to eq([ %w[1 5] ])
      expect(ended).to be_empty
    end

    it "stops before sending a later part that is for another S3 upload" do
      bytes = Random.new(26).bytes((26 * mib) + 3)
      client = s3_client(grant: lambda { |number, params|
        params["part"] == "1" ? s3_grant(number) : s3_grant(number, upload_uri: s3_url(number, upload_id: "s3-upload-2"))
      }
                        )

      expect { upload_with(client, bytes, transfer: { buffer_bytes: 5 * mib }) }
        .to raise_error(Files::APIError, "The upload instructions changed during the upload")
      expect(begun.last).to eq(%w[6 5])
      expect(numbers_sent).not_to include("6")
      expect(ended).to be_empty
    end

    it "refuses a renewal whose URL newly signs the part's length, sending nothing for that part" do
      grant = lambda do |number, params|
        if params["parts"] == "1"
          s3_grant(number, upload_uri: s3_url(number, signed: "content-length%3Bhost"))
        else
          s3_grant(number, upload_uri: s3_url(number, expired: number == 2))
        end
      end

      expect { upload_with(s3_client(grant: grant), content, transfer: true) }.to raise_error(Files::APIError, "The renewed upload instructions changed")
      expect(begun).to include(%w[2 1])
      expect(numbers_sent).not_to include("2")
      expect(ended).to be_empty
    end

    it "pauses with a checkpoint keeping the planned parts and only a digest of the S3 upload, and resumes them whatever the API recommends" do
      control = Files::Transfer::Control.new
      hint = 5 * mib
      client = s3_client(grant: ->(number, _params) { s3_grant(number, hint: hint) })

      with_local_file(content) do |path|
        paused = nil
        expect { upload(path, { client: client }, progress: ->(_report) { control.pause }, transfer: { control: control }) }
          .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        checkpoint = paused.checkpoint
        expect(checkpoint.completed_bytes).to eq(8 * mib)
        expect(checkpoint.state[:plan]).to match(mode: :local, route: a_string_matching(/\Asha256:\h{64}\z/), partsize: 8 * mib)
        expect(checkpoint.state[:layout].map { |part| part.first(4) })
          .to eq([ [ 1, 0, 8 * mib, 8 * mib ], [ 2, 8 * mib, 8 * mib, 8 * mib ], [ 3, 16 * mib, mib + 3, 8 * mib ] ])
        expect([ checkpoint.state, checkpoint.inspect ].inspect).not_to include("s3-upload-1", "amazonaws", "X-Amz", "AKIDFIXTURE", "uploads/")

        # The renewals of the resumed parts recommend 6 MiB.
        hint = 6 * mib
        described_class.resume_upload(checkpoint, { client: client }, transfer: true)
      end

      expect(parts_sent_to_s3.sort).to eq([ part_of(s3_url(1), content.byteslice(0, 8 * mib)), part_of(s3_url(2), content.byteslice(8 * mib, 8 * mib)),
                                            part_of(s3_url(3), content.byteslice(16 * mib, 8 * mib)) ]
                                         )
      expect(begun.drop(1)).to eq([ %w[2 1], %w[3 1] ])
      expect(ended.first["etags"].map { |etag| etag["part"] }).to eq(%w[1 2 3])
    end

    # A 10-byte file the API would send in parts of 4 bytes, and an upload sizing its own parts in one.
    direct = { version: 1, server_name: "agent.example.test", addresses: [ "192.0.2.1" ], direct_uri: "https://agent.example.test",
               ca_pem: "-----BEGIN CERTIFICATE-----\nfixture\n-----END CERTIFICATE-----\n" }
    [
      [ "a regional endpoint", ->(_number) { {} }, %w[abcdefghij] ],
      [ "the global endpoint", ->(number) { { upload_uri: s3_url(number, host: "reports.s3.amazonaws.com") } }, %w[abcdefghij] ],
      [ "a dashed regional endpoint", ->(number) { { upload_uri: s3_url(number, host: "reports.s3-us-west-2.amazonaws.com") } }, %w[abcdefghij] ],
      [ "a dual-stack endpoint", ->(number) { { upload_uri: s3_url(number, host: "reports.s3.dualstack.eu-central-1.amazonaws.com") } }, %w[abcdefghij] ],
      [ "a path-style URL", ->(number) { { upload_uri: s3_url(number, host: "s3.us-east-1.amazonaws.com/reports") } }, %w[abcdefghij] ],
      [ "an endpoint in China", ->(number) { { upload_uri: s3_url(number, host: "reports.s3.cn-north-1.amazonaws.com.cn") } }, %w[abcdefghij] ],
      [ "parts that may not go at once", ->(_number) { { parallel_parts: false } }, %w[abcdefghij] ],
      [ "an S3-compatible service", ->(number) { { upload_uri: s3_url(number, host: "reports.storage.example.test") } }, %w[abcd efgh ij] ],
      [ "a host that only resembles S3's", ->(number) { { upload_uri: s3_url(number, host: "reports.s3.us-east-1.amazonaws.com.example.test") } }, %w[abcd efgh ij] ],
      [ "an accelerate endpoint", ->(number) { { upload_uri: s3_url(number, host: "reports.s3-accelerate.amazonaws.com") } }, %w[abcd efgh ij] ],
      [ "a FIPS endpoint", ->(number) { { upload_uri: s3_url(number, host: "reports.s3-fips.us-east-1.amazonaws.com") } }, %w[abcd efgh ij] ],
      [ "plain HTTP", ->(number) { { upload_uri: s3_url(number).sub("https://", "http://") } }, %w[abcd efgh ij] ],
      [ "a port of its own", ->(number) { { upload_uri: s3_url(number).sub(".amazonaws.com/", ".amazonaws.com:8443/") } }, %w[abcd efgh ij] ],
      [ "a signed Content-Length", ->(number) { { upload_uri: s3_url(number, signed: "content-length%3Bhost") } }, %w[abcd efgh ij] ],
      [ "a checksum in the URL", ->(number) { { upload_uri: s3_url(number, tail: "&x-amz-checksum-crc32=AAAAAA%3D%3D") } }, %w[abcd efgh ij] ],
      [ "a header to send", ->(_number) { { headers: { "x-amz-checksum-crc32" => "AAAAAA==" } } }, %w[abcd efgh ij] ],
      [ "parameters to send", ->(_number) { { parameters: { "acl" => "private" } } }, %w[abcd efgh ij] ],
      [ "a direct connection", ->(_number) { { direct_connection_info: direct } }, %w[abcd efgh ij] ],
      [ "another upload for a later part", ->(number) { number == 2 ? { upload_uri: s3_url(number, upload_id: "s3-upload-2") } : {} }, %w[abcd efgh ij] ]
    ].each do |form, change, bodies|
      it "#{bodies.size == 1 ? 'sizes the parts itself' : 'leaves the part sizes to the API'} for #{form}, however parallel" do
        answer = ->(number) { s3_grant(number, hint: 4, **instance_exec(number, &change)) }

        upload_with(s3_client(grant: ->(number, _params) { answer.call(number) }), "abcdefghij", transfer: true)

        expect(parts_sent_to_s3.sort).to eq(bodies.each_with_index.map { |body, index| part_of(answer.call(index + 1)[:upload_uri], body) }.sort)
        expect(ended.size).to eq(1)
      end
    end

    # A file of 1 GiB and a byte with one part available needs a part larger than the SDK's own largest, and through a
    # caller's client 16 MiB of buffer_bytes could not hold the API's part either. The file is sparse, and each answer
    # pauses the upload before it is given, so no part is admitted and nothing of the file is read or sent.
    it "keeps a plan it refused out of the checkpoint of a pause that came first, and resumes choosing the sizes afresh, whatever plan it paused with" do
      control = Files::Transfer::Control.new
      size = (1024 * mib) + 1
      answer = ->(number) { s3_grant(number, available_parts: 1) }
      client = s3_client(grant: lambda { |number, _params|
        control.pause
        answer.call(number)
      }
                        )

      Dir.mktmpdir do |dir|
        path = File.join(dir, "report.bin")
        File.open(path, "wb") { |file| file.truncate(size) }
        identity = Files::Transfer::Checkpoint.identity(File.stat(path))
        paused = nil

        expect { upload(path, { client: client }, transfer: { buffer_bytes: 16 * mib, control: control }) }
          .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        checkpoint = paused.checkpoint
        expect([ checkpoint.local_path, checkpoint.source, checkpoint.completed_bytes, checkpoint.total_bytes ]).to eq([ path, identity, 0, size ])
        expect(checkpoint.state.values_at(:plan, :ref, :layout)).to eq([ { mode: :api }, nil, [] ])

        # Resumed, the upload is answered with 10,000 parts available, which it plans 8 MiB parts in, but with no usable
        # reference: the pause, which came first, is raised in place of its refusal, with a checkpoint keeping that plan
        # but no reference and no parts.
        control = Files::Transfer::Control.new
        answer = ->(number) { s3_grant(number, ref: "") }
        expect { described_class.resume_upload(checkpoint, { client: client }, transfer: { buffer_bytes: 16 * mib, control: control }) }
          .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        checkpoint = paused.checkpoint
        expect(checkpoint.state.values_at(:plan, :ref, :layout))
          .to match([ { mode: :local, route: a_string_matching(/\Asha256:\h{64}\z/), partsize: 8 * mib }, nil, [] ])

        # Resumed with room for one part of the whole file, which the refused size would have planned, and one part
        # available again, the upload chooses afresh, keeping neither the route nor the size it paused with: it leaves
        # the sizes to the API, within the SDK's own largest part, until its first answer pauses it again.
        control = Files::Transfer::Control.new
        answer = ->(number) { s3_grant(number, available_parts: 1) }
        expect { described_class.resume_upload(checkpoint, { client: client }, transfer: { buffer_bytes: 2 * size, control: control }) }
          .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        resumed = paused.checkpoint
        expect([ resumed.local_path, resumed.source, resumed.completed_bytes ]).to eq([ path, identity, 0 ])
        expect(resumed.state.values_at(:plan, :ref)).to eq([ { mode: :api }, "upload-ref" ])
        expect(resumed.state[:layout].map { |part| part[2] }).to eq([ 5 * mib ] * 5)
      end
      expect([ sent, delivered, ended ]).to all(be_empty)
      expect(begun).to eq([ %w[1 5] ] * 3)
    end

    # An upload resumed from a checkpoint paused before any reference chooses its plan afresh: when the answer it then
    # gets is not for S3 at all, it keeps no route of the plan it paused with, and sends the parts as the API sizes them.
    it "keeps no route a resume's fresh answer does not give" do
      control = Files::Transfer::Control.new
      compatible = ->(number) { s3_url(number, host: "reports.storage.example.test") }
      # The first answer, which the pause beats, gives no usable reference; the resume's is for an S3-compatible service.
      answer = ->(number) { s3_grant(number, hint: 4, ref: "") }
      client = s3_client(grant: lambda { |number, _params|
        control&.pause
        answer.call(number)
      }
                        )

      with_local_file("abcdefghij") do |path|
        paused = nil
        expect { upload(path, { client: client }, transfer: { control: control }) }.to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        expect(paused.checkpoint.state.values_at(:plan, :ref, :layout))
          .to match([ { mode: :local, route: a_string_matching(/\Asha256:\h{64}\z/), partsize: 8 * mib }, nil, [] ])

        control = nil
        answer = ->(number) { s3_grant(number, hint: 4, upload_uri: compatible.call(number)) }
        described_class.resume_upload(paused.checkpoint, { client: client }, transfer: true)
      end

      expect(parts_sent_to_s3.sort).to eq([ part_of(compatible.call(1), "abcd"), part_of(compatible.call(2), "efgh"), part_of(compatible.call(3), "ij") ].sort)
      expect(begun).to eq([ %w[1 5] ] * 2)
      expect(ended.map { |params| params["size"] }).to eq([ "10" ])
    end

    # Files far larger than any example could send, planned by the SDK's own limits.
    it "plans within the SDK's own limits, and not at all beyond them" do
      plan = Files::Transfer::UploadPlan
      gib = 1024 * mib
      tib = 1024 * gib
      unlimited = Float::INFINITY

      expect([ plan::MIN_PART_BYTES, plan::MAX_PART_BYTES, plan::MAX_PARTS, plan::MAX_FILE_BYTES ]).to eq([ 5 * mib, gib, 10_000, 5 * tib ])
      expect([ plan.part_size(content.bytesize, 10_000, unlimited), plan.part_size(content.bytesize, nil, unlimited) ]).to eq([ 8 * mib, 8 * mib ])
      # Only two parts available, or 100 GiB in 10,000 parts, take larger parts, in whole MiB; more than 10,000 available
      # parts count as 10,000.
      expect(plan.part_size(content.bytesize, 2, unlimited)).to eq(9 * mib)
      expect([ plan.part_size(100 * gib, 10_000, unlimited), plan.part_size(100 * gib, 20_000, unlimited) ]).to eq([ 11 * mib, 11 * mib ])
      expect([ plan.part_size(5 * tib, 10_000, unlimited), plan.part_size(100 * gib, 100, unlimited) ]).to eq([ 525 * mib, gib ])
      expect([ plan.part_size((5 * tib) + 1, 10_000, unlimited), plan.part_size((100 * gib) + 1, 100, unlimited) ]).to eq([ nil, nil ])
      # Unless buffer_bytes could not hold the API's parts either: such a file is refused, with no size at all.
      expect { plan.part_size((100 * gib) + 1, 100, 8 * mib) }.to raise_error(Files::Transfer::BufferLimitError)
      # A part buffer_bytes can hold, but never under 5 MiB unless the file is one part.
      expect([ plan.part_size(content.bytesize, 10_000, 6 * mib), plan.part_size(content.bytesize, 10_000, 4 * mib) ]).to eq([ 6 * mib, 5 * mib ])
      expect(plan.part_size(3 * mib, 10_000, mib)).to eq(3 * mib)
    end
  end
end
